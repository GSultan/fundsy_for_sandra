require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  describe '#new' do     ######add a pound before describing new actions
    it 'renders the new template' do
      # this mimicks making a GET request to the CampaignsController
      get :new
      expect(response).to render_template(:new) #render_template is a matcher
      #that is specific to rspec-rails
    end
    it 'instantiates a new campaign object' do
      get :new
      #assigns(:campaign) will test for an instance variable: @campaign
      #be_a_new(Campaign) will match that the instance variable is of class
                                #Campaign and it's a non-persisted object
      expect(assigns(:campaign)).to be_a_new(Campaign)
    end
  end
  describe '#create' do
    context 'with valid params' do
      def valid_request
        post :create, params: { campaign: attributes_for(:campaign)}

      end
      it 'saves a record to the DB' do
        count_before = Campaign.count
        valid_request
        count_after = Campaign.count
        expect(count_after).to eq(count_before + 1)
      end
      it 'redirects to the campaign show page' do
        valid_request
        expect(response).to redirect_to(campaign_path(Campaign.last))
      end
    end
    context 'with invalid params' do
      def invalid_request
        post :create, params: { campaign: attributes_for(:campaign, title:nil)}
      end
      it 'doesn\'nt save a record to the DB' do
      count_before = Campaign.count
      invalid_request
      count_after = Campaign.count
      expect(count_after).to eq(count_before)
      end
      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end

    end
  end
# rspec spec/controllers/campaigns_controller_spec.rb:5

  describe '#show' do
    it 'renders the show template' do
      campaign = create(:campaign)
      get :show, params: {id: campaign.id}
      expect(response).to render_template(:show)
    end
    it 'sets an instance variable with the campaign whose id is passed' do
      campaign = create(:campaign)
      get :show, params: {id: campaign.id}
      expect(assigns(:campaign)).to eq(campaign)
    end
  end
end
