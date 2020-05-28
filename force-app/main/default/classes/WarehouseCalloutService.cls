public with sharing class WarehouseCalloutService {
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Inventory');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Object> equipmentList = (List< Object>)JSON.deserializeUntyped(response.getBody());
        List<Product2> partList = new List<Product2>();
        for(Object equipment : equipmentList) {
            Map<String, Object> equipmentMap = (Map<String, Object>)equipment;
            Product2 part = new Product2(
                Name = String.valueOf(equipmentMap.get('name')),
                Replacement_Part__c = Boolean.valueOf(Equipment_Settings__c.getValues('EQUIPMENT_REPLACEMENT_PART_TRUE').Value__c),
                Cost__c = Decimal.valueOf(String.valueOf(equipmentMap.get('cost'))),
                Current_Inventory__c = Integer.valueOf(equipmentMap.get('quantity')),
                Lifespan_Months__c = Integer.valueOf(equipmentMap.get('lifespan')),
                Maintenance_Cycle__c = Integer.valueOf(equipmentMap.get('maintenanceperiod')),
                Warehouse_SKU__c = String.valueOf(equipmentMap.get('sku'))
            );
            partList.add(part);

        }

        upsert partList;
    }
}