import { LightningElement, track, wire } from 'lwc';
import { CurrentPageReference, NavigationMixin } from 'lightning/navigation';
import PropertyObject from '@salesforce/schema/Property__c';
import NameField from '@salesforce/schema/Property__c.Name'
import PetsField from '@salesforce/schema/Property__c.Pets_Allowed__c'
import StateField from '@salesforce/schema/Property__c.State__c'
import StreetField from '@salesforce/schema/Property__c.Street_Address__c'
import ZipCodeField from '@salesforce/schema/Property__c.Zip_Code__c'
import DescriptionField from '@salesforce/schema/Property__c.Description__c'
import CityField from '@salesforce/schema/Property__c.City__c'

export default class ethanPropDetailExample extends NavigationMixin(LightningElement) {

    @track
    currentPageReference;

    

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
    }

    
    recordId; 

    connectedCallback() {
        this.recordId = this.currentPageReference?.state?.c__recordId;
    }

    objectApiName = PropertyObject;

    numberOfBaths = NameField;

    numberOfBedrooms = PetsField;

    hasGarage = DescriptionField;
}