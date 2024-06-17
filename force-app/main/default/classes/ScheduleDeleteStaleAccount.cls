global class scheduleDeleteStaleAccount implements Schedulable {
    global void execute(SchedulableContext sc) {
        BatchDeleteStaleAccount deleteStaleAccounts = new BatchDeleteStaleAccount();
        Database.executeBatch(deleteStaleAccounts);
    }
}