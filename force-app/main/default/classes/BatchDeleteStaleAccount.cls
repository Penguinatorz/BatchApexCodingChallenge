public class BatchDeleteStaleAccount implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name, (SELECT Id, Name, CloseDate FROM Opportunities) FROM Account');
        }
    public void execute(Database.BatchableContext bc, List<Account> records){
        // process each batch of records
        List<Account> accDelete = new List<Account>();
        for(Account acc : records)
        {
            List<Opportunity> oppList = new List<Opportunity>();
            List<Opportunity> oppDelete = new List<Opportunity>();
            for(Opportunity Opp : acc.Opportunities){
                If(Opp.CloseDate < (Date.Today() - 180)){
                    oppDelete.add(opp);
                }else {
                    oppList.add(opp);
                }
            }
            if (oppDelete.Size() >= 1 && oppList.isEmpty()) {
                accDelete.add(acc);
            }
        }
        delete accDelete;
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}