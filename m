Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F40350632
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhCaSVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:21:47 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:46310 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234442AbhCaSVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:21:10 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.93.0.4)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1lRfSg-0005s2-49; Wed, 31 Mar 2021 20:21:02 +0200
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <6f5be7a5-bf82-e857-5c81-322f2886099a@maciej.szmigiero.name>
 <20210329152201.GA933773@rowland.harvard.edu>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: >20 KB URBs + EHCI = bad performance due to stalls
Message-ID: <2c99b46a-3643-c22a-9aae-024565222794@maciej.szmigiero.name>
Date:   Wed, 31 Mar 2021 20:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210329152201.GA933773@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.2021 17:22, Alan Stern wrote:
> On Sat, Mar 27, 2021 at 04:55:20PM +0100, Maciej S. Szmigiero wrote:
>> Hi,
>>
>> Is there any specific reason that URBs without URB_SHORT_NOT_OK flag that
>> span multiple EHCI qTDs have Alternate Next qTD pointer set to the dummy
>> qTD in their every qTD besides the last one (instead of to the first qTD
>> of the next URB to that endpoint)?
> 
> Quick answer: I don't know.  I can't think of any good reason.  This
> code was all written a long time ago.  Maybe the issue was overlooked
> or the details were misunderstood.

I've dug out the original EHCI driver, that landed in 2.5.2:
https://marc.info/?l=linux-usb-devel&m=100875066109269&w=2
https://marc.info/?l=linux-usb-devel&m=100982880716373&w=2

It already had the following qTD setup code, roughly similar to what
the current one does:
> /* previous urb allows short rx? maybe optimize. */
> if (!(last_qtd->urb->transfer_flags & USB_DISABLE_SPD)
> 		&& (epnum & 0x10)) {
>	// only the last QTD for now
>	last_qtd->hw_alt_next = hw_next;

The "for now" language seems to suggest that ultimately other-than-last
qTDs were supposed to be set not to stall the queue, too.
Just the code to handle this case was never written.

It seems to me though, this should be possible with relatively few
changes to the code:
qh_append_tds() will need to patch these other-than-last qTDs
hw_alt_next pointer to point to the (new) dummy qTD (instead of just
pointing the last submitted qTD hw_next to it and adding the remaining
qTDs verbatim to the qH qTD list).

Then qh_completions() will need few changes:
*
>  } else if (IS_SHORT_READ (token)
>	      && !(qtd->hw_alt_next
>           	   & EHCI_LIST_END(ehci))) {
This branch will need to be modified not to mark the queue as stopped
and request its unlinking when such type of short qTD was processed.

* The ACTIVE bit should be treated as unset on any qTD following the
one that hits the above condition until a qTD for a different URB is
encountered.
Otherwise the unprocessed remaining qTDs from that short URB will be
considered pending active qTDs and the code will wait forever for their
processing,

* The code that patches the previous qTD hw_next pointer when removing a
qTD that isn't currently at the qH will need changing to also patch
hw_alt_next pointers of the qTDs belonging to the previous URB in case
the previous URB was one of these short-read-ok ones.

That's was my quick assessment what is required to handle these
transactions effectively in the EHCI driver.

I suspect, however, there may be some corner cases involving
non-ordinary qTD unlinking which might need fixing, too (like caused
by usb_unlink_urb(), system suspend or HC removal).
But I am not sure about this since I don't know this code well.

> 
>> This causes that endpoint queue to stall in case of a short read that
>> does not reach the last qTD (I guess this condition persists until an
>> URB is (re)submitted to that endpoint, but I am not sure here).
> 
> It persists until the driver cleans up the queue.

I guess by "the driver" you mean the host controller driver, not the USB
device driver.

As far as I can see from the code in case of a short read the whole qH
for that endpoint is going to be unlinked.

Which in turn requires observing two Async Advance interrupts.
EHCI spec says that in the worst case each such interrupt will be
generated after two async list traversals.

Only then the qH is going to be re-linked with the remaining URBs (qTDs).

Although it does not seem like this all would take a lot of time when
the bus is otherwise idle the delays are actually enough to cause a drop
of 100+ Mbps in throughput for me.

If one assumes that the device has a 32 KB on-chip buffer (don't know
that for sure, but I assume that the maximum URB size the driver used
was based on that size) then a drop of 100+ Mbps would mean a delay
on the order of 2 msecs in servicing that endpoint.

By the way, it seems that others were getting even worse throughput
from a r8152 device.
People at https://bugzilla.kernel.org/show_bug.cgi?id=205923 report
getting only around 60 Mbps.

It looks like that the URB buffer size in the r8152 driver was now
reduced to 16 KB to work around this issue.

>> One of affected drivers here is drivers/net/usb/r8152.c.
>>
>> If I simply reduce its per-URB transfer buffer to 20 KB (the maximum
>> that fits in a well-aligned qTD) the RX rate increases from around
>> 100 Mbps to 200+ Mbps (on an ICH8M controller):
> 
>> The driver default is to use 32 KB buffers (which span two qTDs),
>> but the device rarely fully fills the first qTD resulting in
>> repetitive stalls and more than halving the performance.
>>
>> As far as I can see, the relevant code in
>> drivers/usb/host/ehci-q.c::qh_urb_transaction() predates the git era.
> 
> Like I said, a long time ago.
> 
>> The comment in that function before setting the Alternate Next qTD
>> pointer:
>>> /*
>>>   * short reads advance to a "magic" dummy instead of the next
>>>   * qtd ... that forces the queue to stop, for manual cleanup.
>>>   * (this will usually be overridden later.)
>>>   */
>>
>> ...suggests the idea was to override that pointer when
>> URB_SHORT_NOT_OK is not set, but this is actually done only for
>> the last qTD from the URB (also, that's the only one that ends
>> with interrupt flag set).
> 
> The hw_alt_next field should be updated for all the qTDs in the URB.
> Failure to this was probably an oversight.  Or maybe the omission was
> to simplify the procedure for cleaning up the queue after a short
> transfer.

Might be, as I have said above, the cleanup procedure will also need
changes to handle these short qTDs.

>> Looking at OHCI and UHCI host controller drivers the equivalent
>> limits seem to be different there (8 KB and 2 KB), while I don't
>> see any specific limit in the XHCI case.
> 
> I'd have to review the details of ohci-hcd and uhci-hcd to make
> sure.  In principle, the queue isn't supposed to stop merely because
> of a short transfer unless URB_SHORT_NOT_OK is set.  However, the UHCI
> hardware in particular may offer no other way to handle a short transfer.

Here I think it is lesser of an issue due to sheer slowness of these
devices.

So even if an URB needs some extra processing time the device should
still be able to maintain that 12 Mbps.
But I might be wrong here for USB devices with super-small on-chip
FIFOs.

>> Because of that variance in the URB buffer limit it seems strange
>> to me that this should be managed by a particular USB device driver
>> rather than by the host controller driver, because this would mean
>> every such driver would need to either use the lowest common
>> denominator for the URB buffer size (which is very small) or
>> hardcode the limit for every host controller that the device can
>> be connected to, which seems a bit inefficient.
> 
> I don't understand what you're saying in this paragraph.  What do you
> think USB device drivers are supposed to be managing?  The URB buffer
> size?  

Yes, I've meant the URB "transfer_buffer_length".

> They should set that field without regard to the type of host
> controller in use.

That's what I had on mind by saying that it seems strange to me that
the URB buffer size should be managed by a particular USB device driver
depending on the host controller in use.

> In short, the behavior you observed is a bug, resulting in a loss of
> throughput (though not in any loss of data).  It needs to be fixed.
> 
> If you would like to write and submit a patch, that would be great.
> Otherwise, I'll try to find time to work on it.

Unfortunately, I doubt I will be able to work on this in coming weeks
due to time constraints, I'm sorry :(

> I would appreciate any effort you could make toward checking the code
> in qh_completions(); I suspect that the checks it does involving
> EHCI_LIST_END may not be right.  At the very least, they should be
> encapsulated in a macro so that they are easier to understand.

I've went through the (short) URB linking and unlinking code
(including qh_completions()) and I haven't found anything suspicious
there, besides one thing that's actually on the URB *linking* path:
in qh_append_tds() the dummy qTD that is the last qTD in that
endpoint queue is being overwritten using an assignment operator.

While both this dummy qTD and the source qTD that overwrites it have
the HALT bit set it looks a bit uncomfortable to me to see a qTD that
the HC might just be fetching (while trying to advance the queue) being
overwritten.

Like, is C standard giving guarantees that no intermediate values are
being written to a struct when that struct is a target of an assignment
operator?

But apparently this doesn't cause trouble, so I guess in practice
this works okay.

> Alan Stern
> 

Thanks,
Maciej
