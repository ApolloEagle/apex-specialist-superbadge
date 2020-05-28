public with sharing class MaintenanceRequestHandler {
    public static void createMaintenanceRequest(List<Case> requestList) {
        List<Case> requestToCreate = new List<Case>();
        for(Case request : requestList) {
            if(request.Status == Maintenance_Request_Settings__c.getValues('MAINTENANCE_REQUEST_STATUS_CLOSED').Value__c
                && (request.Type == Maintenance_Request_Settings__c.getValues('MAINTENANCE_REQUEST_TYPE_ROUTINE').Value__c
                || request.Type == Maintenance_Request_Settings__c.getValues('MAINTENANCE_REQUEST_TYPE_REPAIR').Value__c)) {
                    Case newRequest = new Case(
                        Status = Maintenance_Request_Settings__c.getValues('MAINTENANCE_REQUEST_STATUS_NEW').Value__c,
                        Type = Maintenance_Request_Settings__c.getValues('MAINTENANCE_REQUEST_TYPE_ROUTINE').Value__c,
                        Vehicle__c = request.Vehicle__c,
                        Equipment__c = request.Equipment__c,
                        Subject = Maintenance_Request_Settings__c.getValues('MAINTENANCE_REQUEST_SUBJECT_ROUTINE').Value__c,
                        Date_Reported__c = System.today()
                    );

                    requestToCreate.add(newRequest);
            }
        }

        insert requestToCreate;
    }
}