MarketOffer = {}
MarketOffer.__index = MarketOffer

local OFFER_TIMESTAMP = 1
local OFFER_COUNTER = 2

MarketOffer.new = function(offerId, action, item, amount, price, playerName, state)
  local offer = {
    id = {},
    action = nil,
    item = 0,
    amount = 0,
    price = 0,
    player = '',
    state = 0
  }

  if not offerId or type(offerId) ~= 'table'  then
    g_logger.error('MarketOffer.new - invalid offer id provided.')
  end
  offer.id = offerId

  action = tonumber(action)
  if action ~= MarketAction.Buy and action ~= MarketAction.Sell then
    g_logger.error('MarketOffer.new - invalid action provided.')
  end
  offer.action = action

  if not item then
    g_logger.error('MarketOffer.new - invalid item provided.')
  end
  offer.item = item

  offer.amount = amount
  offer.price = price
  offer.player = playerName

  state = tonumber(state)
  if state ~= MarketOfferState.Active and state ~= MarketOfferState.Cancelled
    and state ~= MarketOfferState.Expired and state ~= MarketOfferState.Accepted then
    g_logger.error('MarketOffer.new - invalid state provided.')
  end
  offer.state = state

  setmetatable(offer, MarketOffer)
  return offer
end

function MarketOffer:isEqual(id)
  return self.id[OFFER_TIMESTAMP] == id[OFFER_TIMESTAMP] and self.id[OFFER_COUNTER] == id[OFFER_COUNTER]
end

function MarketOffer:isLessThan(id)
  return self.id[OFFER_TIMESTAMP] <= id[OFFER_TIMESTAMP] and self.id[OFFER_COUNTER] < id[OFFER_COUNTER]
end

function MarketOffer:isNull()
  return table.empty(self.id)
end

-- Sets/Gets

function MarketOffer:setId(id)
  if not id or type(id) ~= 'table'  then
    g_logger.error('MarketOffer.setId - invalid id provided.')
  end
  self.id = id
end

function MarketOffer:getId()
  return self.id
end

function MarketOffer:setAction(action)
  if not action or type(action) ~= 'number'  then
    g_logger.error('MarketOffer.setItem - invalid action id provided.')
  end
  self.action = action
end

function MarketOffer:getAction()
  return self.action
end

function MarketOffer:setItem(item)
  if not item or type(item) ~= 'userdata'  then
    g_logger.error('MarketOffer.setItem - invalid item id provided.')
  end
  self.item = item
end

function MarketOffer:getItem()
  return self.item
end

function MarketOffer:setAmount(amount)
  if not amount or type(amount) ~= 'number'  then
    g_logger.error('MarketOffer.setAmount - invalid amount provided.')
  end
  self.amount = amount
end

function MarketOffer:getAmount()
  return self.amount
end

function MarketOffer:setPrice(price)
  if not price or type(price) ~= 'number'  then
    g_logger.error('MarketOffer.setPrice - invalid price provided.')
  end
  self.price = price
end

function MarketOffer:getPrice()
  return self.price
end

function MarketOffer:setPlayer(player)
  if not player or type(player) ~= 'number'  then
    g_logger.error('MarketOffer.setPlayer - invalid player provided.')
  end
  self.player = player
end

function MarketOffer:getPlayer()
  return self.player
end

function MarketOffer:setState(state)
  if not state or type(state) ~= 'number'  then
    g_logger.error('MarketOffer.setState - invalid state provided.')
  end
  self.state = state
end

function MarketOffer:getState()
  return self.state
end

function MarketOffer:getTimeStamp()
  if table.empty(self.id)  or #self.id < OFFER_TIMESTAMP then
    return
  end
  return self.id[OFFER_TIMESTAMP]
end

function MarketOffer:getCounter()
  if table.empty(self.id) or #self.id < OFFER_COUNTER then
    return
  end
  return self.id[OFFER_COUNTER]
end