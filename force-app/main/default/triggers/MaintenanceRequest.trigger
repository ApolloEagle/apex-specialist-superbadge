trigger MaintenanceRequest on Case (after update) {
    MaintenanceRequestHandler.createMaintenanceRequest(Trigger.new);
}