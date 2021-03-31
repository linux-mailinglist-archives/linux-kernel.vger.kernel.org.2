Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5353508FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhCaVWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:22:06 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:58542 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhCaVVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:21:38 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.93.0.4)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1lRiHQ-0006Uu-27; Wed, 31 Mar 2021 23:21:36 +0200
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <6f5be7a5-bf82-e857-5c81-322f2886099a@maciej.szmigiero.name>
 <20210329152201.GA933773@rowland.harvard.edu>
 <2c99b46a-3643-c22a-9aae-024565222794@maciej.szmigiero.name>
 <20210331195539.GA1027699@rowland.harvard.edu>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: >20 KB URBs + EHCI = bad performance due to stalls
Message-ID: <e3a7efbc-6f72-d276-2f86-f2a783e73f6d@maciej.szmigiero.name>
Date:   Wed, 31 Mar 2021 23:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331195539.GA1027699@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.2021 21:55, Alan Stern wrote:
> On Wed, Mar 31, 2021 at 08:20:56PM +0200, Maciej S. Szmigiero wrote:
>> On 29.03.2021 17:22, Alan Stern wrote:
>>> On Sat, Mar 27, 2021 at 04:55:20PM +0100, Maciej S. Szmigiero wrote:
>>>> Hi,
>>>>
>>>> Is there any specific reason that URBs without URB_SHORT_NOT_OK flag that
>>>> span multiple EHCI qTDs have Alternate Next qTD pointer set to the dummy
>>>> qTD in their every qTD besides the last one (instead of to the first qTD
>>>> of the next URB to that endpoint)?
>>>
>>> Quick answer: I don't know.  I can't think of any good reason.  This
>>> code was all written a long time ago.  Maybe the issue was overlooked
>>> or the details were misunderstood.
>>
>> I've dug out the original EHCI driver, that landed in 2.5.2:
>> https://marc.info/?l=linux-usb-devel&m=100875066109269&w=2
>> https://marc.info/?l=linux-usb-devel&m=100982880716373&w=2
>>
>> It already had the following qTD setup code, roughly similar to what
>> the current one does:
>>> /* previous urb allows short rx? maybe optimize. */
>>> if (!(last_qtd->urb->transfer_flags & USB_DISABLE_SPD)
>>> 		&& (epnum & 0x10)) {
>>> 	// only the last QTD for now
>>> 	last_qtd->hw_alt_next = hw_next;
>>
>> The "for now" language seems to suggest that ultimately other-than-last
>> qTDs were supposed to be set not to stall the queue, too.
>> Just the code to handle this case was never written.
> 
> Probably it just slipped out of the developer's mind.
> 
>> It seems to me though, this should be possible with relatively few
>> changes to the code:
>> qh_append_tds() will need to patch these other-than-last qTDs
>> hw_alt_next pointer to point to the (new) dummy qTD (instead of just
>> pointing the last submitted qTD hw_next to it and adding the remaining
>> qTDs verbatim to the qH qTD list).
> 
> Right.
> 
>> Then qh_completions() will need few changes:
>> *
>>>   } else if (IS_SHORT_READ (token)
>>> 	      && !(qtd->hw_alt_next
>>>            	   & EHCI_LIST_END(ehci))) {
>> This branch will need to be modified not to mark the queue as stopped
>> and request its unlinking when such type of short qTD was processed.
> 
> This would be a good place to introduce a macro.  For example:
> 
> 	} else if (IS_SHORT_READ(token) &&
> 			EHCI_PTR_IS_SET(qtd->hw_alt_next)) {
> 
> or something similar.

I agree, this certainly looks more readable.

>> * The ACTIVE bit should be treated as unset on any qTD following the
>> one that hits the above condition until a qTD for a different URB is
>> encountered.
>> Otherwise the unprocessed remaining qTDs from that short URB will be
>> considered pending active qTDs and the code will wait forever for their
>> processing,
> 
> The treatment shouldn't be exactly the same as if ACTIVE is clear.  The
> following qTDs can be removed from the list and deallocated immediately,
> since the hardware won't look at them.  And they shouldn't affect the
> URB's status.

 From my understanding of qh_completions() if these "remaining" qTDs from
a short read are treated as !ACTIVE then none of the conditions in
!ACTIVE branch will hit: they don't have DBE or HALT set and they aren't
queue-stopping short read qTDs (I am assuming here that the
aforementioned qtd->hw_alt_next condition will be changed to exclude
them).

So the qTD processing loop will reach "if (last_status == -EINPROGRESS)",
this will be false since previous qTD (that one that has actually
partially completed) had already set the last_status to -EREMOTEIO.
Then the code will delete this qTD from qTD list and go to the next qTD
(either next "remaining" qTD from that URB or from a different URB).

Once a qTD from a different URB is encountered the special treatment of
ACTIVE qTDs as !ACTIVE has to end.

>> * The code that patches the previous qTD hw_next pointer when removing a
>> qTD that isn't currently at the qH will need changing to also patch
>> hw_alt_next pointers of the qTDs belonging to the previous URB in case
>> the previous URB was one of these short-read-ok ones.
> 
> Yes.  Awkward but necessary.
> 
> Although I know nothing at all about the USB API in Windows, I suspect
> that it manages to avoid this awkwardness entirely by not allowing URBs
> in the middle of the queue to be unlinked.  Or perhaps allowing it only
> for endpoint 0.  I've often wished Linux's API had been written that
> way.

According to Microsoft docs every IRP that might remain queued for an
indefinite interval has to have a cancel handler.
URBs are submitted wrapped in IRPs, so at least in theory it should be
possible to cancel them.
But I don't know how it works in practice.

I also remember getting "warning: guest updated active QH" often when
launching Windows VMs in QEMU.
That does not seem like a good sign, but it might ultimately be a
deficiency in QEMU EHCI HC emulation, not Windows.

In Linux at least we could (theoretically) change the API and modify
all the client drivers.
But I think the benefit is not worth the cost at that point.

>> That's was my quick assessment what is required to handle these
>> transactions effectively in the EHCI driver.
>>
>> I suspect, however, there may be some corner cases involving
>> non-ordinary qTD unlinking which might need fixing, too (like caused
>> by usb_unlink_urb(), system suspend or HC removal).
>> But I am not sure about this since I don't know this code well.
> 
> Those shouldn't present any difficulty.  There are inherently easier to
> handle because the QH won't be actively running when they occur.

I've meant that these can exercise a different code path than ordinary
unlink so one has to check this, too.

(...)
>> That's what I had on mind by saying that it seems strange to me that
>> the URB buffer size should be managed by a particular USB device driver
>> depending on the host controller in use.
>>
>>> In short, the behavior you observed is a bug, resulting in a loss of
>>> throughput (though not in any loss of data).  It needs to be fixed.
>>>
>>> If you would like to write and submit a patch, that would be great.
>>> Otherwise, I'll try to find time to work on it.
>>
>> Unfortunately, I doubt I will be able to work on this in coming weeks
>> due to time constraints, I'm sorry :(
> 
> All right, then I'll work on it when time permits.

That's great, thanks.

>>> I would appreciate any effort you could make toward checking the code
>>> in qh_completions(); I suspect that the checks it does involving
>>> EHCI_LIST_END may not be right.  At the very least, they should be
>>> encapsulated in a macro so that they are easier to understand.
>>
>> I've went through the (short) URB linking and unlinking code
>> (including qh_completions()) and I haven't found anything suspicious
>> there, besides one thing that's actually on the URB *linking* path:
>> in qh_append_tds() the dummy qTD that is the last qTD in that
>> endpoint queue is being overwritten using an assignment operator.
>>
>> While both this dummy qTD and the source qTD that overwrites it have
>> the HALT bit set it looks a bit uncomfortable to me to see a qTD that
>> the HC might just be fetching (while trying to advance the queue) being
>> overwritten.
> 
> I agree.  But there's no way around it; if you're going to change the
> contents of the qTD queue while the QH is running, at some point you
> have to overwrite something that the controller might be accessing
> concurrently.

I agree, that's a bit unfortunate.

Unless one unlinks the qH temporarily (but as we have observed that's
rather slow) or disables the async list for a moment (probably slow,
too, and impacts other endpoints).

>> Like, is C standard giving guarantees that no intermediate values are
>> being written to a struct when that struct is a target of an assignment
>> operator?
> 
> THe C standard doesn't say anything like that, but the kernel does
> generally rely on such behavior. 

I see, thanks.

> However, it wouldn't hurt to mark this
> special case by using WRITE_ONCE.

I think WRITE_ONCE() at least to the hw_token would make a lot of sense
here.

>> But apparently this doesn't cause trouble, so I guess in practice
>> this works okay.
> 
> Yes, it does.
> 
> Alan Stern
> 

Thanks,
Maciej

