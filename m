Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0453DA04B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhG2JdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235260AbhG2Jc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:32:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1121361052;
        Thu, 29 Jul 2021 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627551175;
        bh=JuJA50JqDCkg8F9U4K0AUSFD4NR8BUFnw4OZQNi4sWM=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Ry8neo+AuNIQtwYnTVSUrqbYYldMEHpXiRno+WoUUIz58lVybCBwrp8+wczAslBCY
         b2yKkliUIh4PlgrfXKwCXZgBhhkZsILk34HzTNziAO1lzNbSiOwLLyJVA2TOVg5Sef
         czvF3XfBRr8CAYf2TKOTAJZbyC0SC/eKaav6PS30LNet1bXiKYTFyV2zs8R99aVvOG
         PwuRqC6dFG9YcfxtIxVjzB4WOft6s6UK911fMk2lJDAxP7hGAGsQbx12tP+133kbkV
         7BADvANKBW37Nk1HvNcjkhOa56CTsfRwJV1SYzzvihlTg04VZgtwamkhZok+XgxA67
         PQpNTJUG5a7YQ==
References: <1627543994-20327-1-git-send-email-wcheng@codeaurora.org>
 <87zgu5v8om.fsf@kernel.org>
 <4e06452a-080f-a2be-ab88-9ac992740ee0@codeaurora.org>
User-agent: mu4e 1.6.0; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Use list_replace_init() before
 traversing lists
Date:   Thu, 29 Jul 2021 12:31:59 +0300
In-reply-to: <4e06452a-080f-a2be-ab88-9ac992740ee0@codeaurora.org>
Message-ID: <87fsvxsbwc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Wesley Cheng <wcheng@codeaurora.org> writes:
>>> The list_for_each_entry_safe() macro saves the current item (n) and
>>> the item after (n+1), so that n can be safely removed without
>>> corrupting the list.  However, when traversing the list and removing
>>> items using gadget giveback, the DWC3 lock is briefly released,
>>> allowing other routines to execute.  There is a situation where, while
>>> items are being removed from the cancelled_list using
>>> dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
>>> routine is running in parallel (due to UDC unbind).  As the cleanup
>>> routine removes n, and the pullup disable removes n+1, once the
>>> cleanup retakes the DWC3 lock, it references a request who was already
>>> removed/handled.  With list debug enabled, this leads to a panic.
>>> Ensure all instances of the macro are replaced where gadget giveback
>>> is used.
>>>
>>> Example call stack:
>>>
>>> Thread#1:
>>> __dwc3_gadget_ep_set_halt() - CLEAR HALT
>>>   -> dwc3_gadget_ep_cleanup_cancelled_requests()
>>>     ->list_for_each_entry_safe()
>>>     ->dwc3_gadget_giveback(n)
>>>       ->dwc3_gadget_del_and_unmap_request()- n deleted[cancelled_list]
>>>       ->spin_unlock
>>>       ->Thread#2 executes
>>>       ...
>>>     ->dwc3_gadget_giveback(n+1)
>>>       ->Already removed!
>>>
>>> Thread#2:
>>> dwc3_gadget_pullup()
>>>   ->waiting for dwc3 spin_lock
>>>   ...
>>>   ->Thread#1 released lock
>>>   ->dwc3_stop_active_transfers()
>>>     ->dwc3_remove_requests()
>>>       ->fetches n+1 item from cancelled_list (n removed by Thread#1)
>>>       ->dwc3_gadget_giveback()
>>>         ->dwc3_gadget_del_and_unmap_request()- n+1
>>> deleted[cancelled_list]
>>>         ->spin_unlock
>>>
>>> Fix this condition by utilizing list_replace_init(), and traversing
>>> through a local copy of the current elements in the endpoint lists.
>>> This will also set the parent list as empty, so if another thread is
>>> also looping through the list, it will be empty on the next iteration.
>>>
>>> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>
>>> ---
>>> Previous patchset:
>>> https://lore.kernel.org/linux-usb/1620716636-12422-1-git-send-email-wcheng@codeaurora.org/
>>> ---
>>>  drivers/usb/dwc3/gadget.c | 18 ++++++++++++++++--
>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index a29a4ca..3ce6ed9 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -1926,9 +1926,13 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
>>>  {
>>>  	struct dwc3_request		*req;
>>>  	struct dwc3_request		*tmp;
>>> +	struct list_head		local;
>>>  	struct dwc3			*dwc = dep->dwc;
>>>  
>>> -	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
>>> +restart:
>>> +	list_replace_init(&dep->cancelled_list, &local);
>> 
>> hmm, if the lock is held and IRQs disabled when this runs, then no other
>> threads will be able to append requests to the list which makes the
>> "restart" label unnecessary, no?
>
> We do still call dwc3_gadget_giveback() which would release the lock
> briefly, so if there was another thread waiting on dwc->lock, it would
> be able to add additional items to that list.
>
>> 
>> I wonder if we should release the lock and reenable interrupts after
>> replacing the head. The problem is that
>> dwc3_gadget_ep_cleanup_cancelled_requests() can run from the IRQ
>> handler.
>> 
>
> We would also need to consider that some of the APIs being called in
> these situations would also have the assumption that the dwc->lock is
> held, ie dwc3_gadget_giveback()

yeah, good point. I think we're good to integrate this, unless Alan can
shed some light on some particular possible race scenario we may have
missed.

In any case:

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
