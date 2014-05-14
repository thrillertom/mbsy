require 'spec_helper'

describe Mbsy::Ambassador do
  let(:response) { double(:response) }
  before { allow(Mbsy::Ambassador).to receive(:call).and_return(response) }

  describe '.find' do
    it 'raises ArgumentError when missing email param' do
      expect { Mbsy::Ambassador.find }.to raise_error(ArgumentError, 'You must include :email')
      expect(Mbsy::Ambassador).to_not have_received(:call)
    end

    it 'calls #call' do
      expect(Mbsy::Ambassador.find(email: 'a@example.com')).to eq response
      expect(Mbsy::Ambassador).to have_received(:call).with('get', email: 'a@example.com')
    end
  end

  describe '.all' do
    it 'calls #call' do
      expect(Mbsy::Ambassador.all(is_active: 1)).to eq response
      expect(Mbsy::Ambassador).to have_received(:call).with('all', is_active: 1)
    end
  end

  describe '.stats' do
    it 'raises ArgumentError when missing email' do
      expect { Mbsy::Ambassador.stats }.to raise_error(ArgumentError, 'You must include :email')
      expect(Mbsy::Ambassador).to_not have_received(:call)
    end

    it 'calls #call' do
      expect(Mbsy::Ambassador.stats(email: 'a@example.com')).to eq response
      expect(Mbsy::Ambassador).to have_received(:call).with('stats', email: 'a@example.com')
    end
  end
end
