@isTest
private class BatchDeleteStaleAccountTest {

    @testSetup
    static void setup() {
        List<Opportunity> oppList = new List<Opportunity>();
        List<Account> accList = new List<Account>();
        for (Integer i=0; i<10;i++)
        {
            accList.add(new Account(name = 'Account ' + i));
        }
        insert accList;

        for (Account acc : [SELECT Id FROM Account])
        {
            oppList.add(new Opportunity(Name = 'Opportunity', CloseDate = (Date.Today()-360), 
            StageName = 'Prospecting', AccountId = acc.Id));
        }

        for(Account acc : [SELECT Id FROM Account LIMIT 1])
        {
            oppList.add(new Opportunity(Name = 'Opportunity', CloseDate = (Date.Today()), 
            StageName = 'Prospecting', AccountId = acc.Id));
        }

        insert oppList;
    }

    @isTest
    static void testBatch(){
        Test.startTest();
        BatchDeleteStaleAccount deleteStaleAcc = new BatchDeleteStaleAccount();
        Id batchId = Database.executeBatch(deleteStaleAcc);
        Test.stopTest();

        System.assertEquals(1, [SELECT Id, Name FROM Account].Size());
    }
}