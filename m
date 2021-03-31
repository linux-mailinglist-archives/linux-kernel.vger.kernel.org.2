Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F1E3507AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhCaT4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:56:07 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48721 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236256AbhCaTzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:55:41 -0400
Received: (qmail 1028965 invoked by uid 1000); 31 Mar 2021 15:55:39 -0400
Date:   Wed, 31 Mar 2021 15:55:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: >20 KB URBs + EHCI = bad performance due to stalls
Message-ID: <20210331195539.GA1027699@rowland.harvard.edu>
References: <6f5be7a5-bf82-e857-5c81-322f2886099a@maciej.szmigiero.name>
 <20210329152201.GA933773@rowland.harvard.edu>
 <2c99b46a-3643-c22a-9aae-024565222794@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c99b46a-3643-c22a-9aae-024565222794@maciej.szmigiero.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 08:20:56PM +0200, Maciej S. Szmigiero wrote:
> On 29.03.2021 17:22, Alan Stern wrote:
> > On Sat, Mar 27, 2021 at 04:55:20PM +0100, Maciej S. Szmigiero wrote:
> > > Hi,
> > > 
> > > Is there any specific reason that URBs without URB_SHORT_NOT_OK flag that
> > > span multiple EHCI qTDs have Alternate Next qTD pointer set to the dummy
> > > qTD in their every qTD besides the last one (instead of to the first qTD
> > > of the next URB to that endpoint)?
> > 
> > Quick answer: I don't know.  I can't think of any good reason.  This
> > code was all written a long time ago.  Maybe the issue was overlooked
> > or the details were misunderstood.
> 
> I've dug out the original EHCI driver, that landed in 2.5.2:
> https://marc.info/?l=linux-usb-devel&m=100875066109269&w=2
> https://marc.info/?l=linux-usb-devel&m=100982880716373&w=2
> 
> It already had the following qTD setup code, roughly similar to what
> the current one does:
> > /* previous urb allows short rx? maybe optimize. */
> > if (!(last_qtd->urb->transfer_flags & USB_DISABLE_SPD)
> > 		&& (epnum & 0x10)) {
> > 	// only the last QTD for now
> > 	last_qtd->hw_alt_next = hw_next;
> 
> The "for now" language seems to suggest that ultimately other-than-last
> qTDs were supposed to be set not to stall the queue, too.
> Just the code to handle this case was never written.

Probably it just slipped out of the developer's mind.

> It seems to me though, this should be possible with relatively few
> changes to the code:
> qh_append_tds() will need to patch these other-than-last qTDs
> hw_alt_next pointer to point to the (new) dummy qTD (instead of just
> pointing the last submitted qTD hw_next to it and adding the remaining
> qTDs verbatim to the qH qTD list).

Right.

> Then qh_completions() will need few changes:
> *
> >  } else if (IS_SHORT_READ (token)
> > 	      && !(qtd->hw_alt_next
> >           	   & EHCI_LIST_END(ehci))) {
> This branch will need to be modified not to mark the queue as stopped
> and request its unlinking when such type of short qTD was processed.

This would be a good place to introduce a macro.  For example:

	} else if (IS_SHORT_READ(token) && 
			EHCI_PTR_IS_SET(qtd->hw_alt_next)) {

or something similar.

> * The ACTIVE bit should be treated as unset on any qTD following the
> one that hits the above condition until a qTD for a different URB is
> encountered.
> Otherwise the unprocessed remaining qTDs from that short URB will be
> considered pending active qTDs and the code will wait forever for their
> processing,

The treatment shouldn't be exactly the same as if ACTIVE is clear.  The 
following qTDs can be removed from the list and deallocated immediately, 
since the hardware won't look at them.  And they shouldn't affect the 
URB's status.

> * The code that patches the previous qTD hw_next pointer when removing a
> qTD that isn't currently at the qH will need changing to also patch
> hw_alt_next pointers of the qTDs belonging to the previous URB in case
> the previous URB was one of these short-read-ok ones.

Yes.  Awkward but necessary.

Although I know nothing at all about the USB API in Windows, I suspect 
that it manages to avoid this awkwardness entirely by not allowing URBs 
in the middle of the queue to be unlinked.  Or perhaps allowing it only 
for endpoint 0.  I've often wished Linux's API had been written that 
way.

> That's was my quick assessment what is required to handle these
> transactions effectively in the EHCI driver.
> 
> I suspect, however, there may be some corner cases involving
> non-ordinary qTD unlinking which might need fixing, too (like caused
> by usb_unlink_urb(), system suspend or HC removal).
> But I am not sure about this since I don't know this code well.

Those shouldn't present any difficulty.  There are inherently easier to 
handle because the QH won't be actively running when they occur.

> > > This causes that endpoint queue to stall in case of a short read that
> > > does not reach the last qTD (I guess this condition persists until an
> > > URB is (re)submitted to that endpoint, but I am not sure here).
> > 
> > It persists until the driver cleans up the queue.
> 
> I guess by "the driver" you mean the host controller driver, not the USB
> device driver.

Yes, I meant ehci-hcd.

> > > Looking at OHCI and UHCI host controller drivers the equivalent
> > > limits seem to be different there (8 KB and 2 KB), while I don't
> > > see any specific limit in the XHCI case.
> > 
> > I'd have to review the details of ohci-hcd and uhci-hcd to make
> > sure.  In principle, the queue isn't supposed to stop merely because
> > of a short transfer unless URB_SHORT_NOT_OK is set.  However, the UHCI
> > hardware in particular may offer no other way to handle a short transfer.
> 
> Here I think it is lesser of an issue due to sheer slowness of these
> devices.
> 
> So even if an URB needs some extra processing time the device should
> still be able to maintain that 12 Mbps.
> But I might be wrong here for USB devices with super-small on-chip
> FIFOs.
> 
> > > Because of that variance in the URB buffer limit it seems strange
> > > to me that this should be managed by a particular USB device driver
> > > rather than by the host controller driver, because this would mean
> > > every such driver would need to either use the lowest common
> > > denominator for the URB buffer size (which is very small) or
> > > hardcode the limit for every host controller that the device can
> > > be connected to, which seems a bit inefficient.
> > 
> > I don't understand what you're saying in this paragraph.  What do you
> > think USB device drivers are supposed to be managing?  The URB buffer
> > size?
> 
> Yes, I've meant the URB "transfer_buffer_length".
> 
> > They should set that field without regard to the type of host
> > controller in use.
> 
> That's what I had on mind by saying that it seems strange to me that
> the URB buffer size should be managed by a particular USB device driver
> depending on the host controller in use.
> 
> > In short, the behavior you observed is a bug, resulting in a loss of
> > throughput (though not in any loss of data).  It needs to be fixed.
> > 
> > If you would like to write and submit a patch, that would be great.
> > Otherwise, I'll try to find time to work on it.
> 
> Unfortunately, I doubt I will be able to work on this in coming weeks
> due to time constraints, I'm sorry :(

All right, then I'll work on it when time permits.

> > I would appreciate any effort you could make toward checking the code
> > in qh_completions(); I suspect that the checks it does involving
> > EHCI_LIST_END may not be right.  At the very least, they should be
> > encapsulated in a macro so that they are easier to understand.
> 
> I've went through the (short) URB linking and unlinking code
> (including qh_completions()) and I haven't found anything suspicious
> there, besides one thing that's actually on the URB *linking* path:
> in qh_append_tds() the dummy qTD that is the last qTD in that
> endpoint queue is being overwritten using an assignment operator.
> 
> While both this dummy qTD and the source qTD that overwrites it have
> the HALT bit set it looks a bit uncomfortable to me to see a qTD that
> the HC might just be fetching (while trying to advance the queue) being
> overwritten.

I agree.  But there's no way around it; if you're going to change the 
contents of the qTD queue while the QH is running, at some point you 
have to overwrite something that the controller might be accessing 
concurrently.

> Like, is C standard giving guarantees that no intermediate values are
> being written to a struct when that struct is a target of an assignment
> operator?

THe C standard doesn't say anything like that, but the kernel does 
generally rely on such behavior.  However, it wouldn't hurt to mark this 
special case by using WRITE_ONCE.

> But apparently this doesn't cause trouble, so I guess in practice
> this works okay.

Yes, it does.

Alan Stern
