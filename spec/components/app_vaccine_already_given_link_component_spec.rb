# frozen_string_literal: true

describe AppVaccineAlreadyGivenLinkComponent do
  subject(:rendered) { render_inline(component) }

  let(:authorised) { true }
  let(:team) { create(:team, :with_generic_clinic, programmes: [programme]) }
  let(:session) { create(:session, :today, team:, programmes: [programme]) }
  let(:patient) { build(:patient, id: 123) }

  let(:component) do
    described_class.new(programme:, patient:, session:)
  end

  before do
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(Pundit::Authorization).to receive(:policy).and_return(
      instance_double(
        VaccinationRecordPolicy,
        record_already_vaccinated?: authorised,
      )
    )
    # rubocop:enable RSpec/AnyInstance
  end

  context "on the MMR programme" do
    let(:programme) { Programme.mmr }

    context "when authorised" do
      it { should have_link("Record 1st dose as already given") }
    end

    context "when NOT authorised" do
      let(:authorised) { false }

      it { should_not have_link }
    end
  end

  context "on the flu programme" do
    let(:programme) { Programme.flu }

    context "when authorised" do
      it { should have_link("Record as already vaccinated") }
    end

    context "when NOT authorised" do
      let(:authorised) { false }

      it { should_not have_link }
    end
  end
end
