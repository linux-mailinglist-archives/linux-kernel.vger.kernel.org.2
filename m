Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A401C34D3B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhC2PW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:22:29 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59289 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231233AbhC2PWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:22:03 -0400
Received: (qmail 936342 invoked by uid 1000); 29 Mar 2021 11:22:01 -0400
Date:   Mon, 29 Mar 2021 11:22:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: >20 KB URBs + EHCI = bad performance due to stalls
Message-ID: <20210329152201.GA933773@rowland.harvard.edu>
References: <6f5be7a5-bf82-e857-5c81-322f2886099a@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f5be7a5-bf82-e857-5c81-322f2886099a@maciej.szmigiero.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 04:55:20PM +0100, Maciej S. Szmigiero wrote:
> Hi,
> 
> Is there any specific reason that URBs without URB_SHORT_NOT_OK flag that
> span multiple EHCI qTDs have Alternate Next qTD pointer set to the dummy
> qTD in their every qTD besides the last one (instead of to the first qTD
> of the next URB to that endpoint)?

Quick answer: I don't know.  I can't think of any good reason.  This
code was all written a long time ago.  Maybe the issue was overlooked
or the details were misunderstood.

> This causes that endpoint queue to stall in case of a short read that
> does not reach the last qTD (I guess this condition persists until an
> URB is (re)submitted to that endpoint, but I am not sure here).

It persists until the driver cleans up the queue.

> One of affected drivers here is drivers/net/usb/r8152.c.
> 
> If I simply reduce its per-URB transfer buffer to 20 KB (the maximum
> that fits in a well-aligned qTD) the RX rate increases from around
> 100 Mbps to 200+ Mbps (on an ICH8M controller):

> The driver default is to use 32 KB buffers (which span two qTDs),
> but the device rarely fully fills the first qTD resulting in
> repetitive stalls and more than halving the performance.
> 
> As far as I can see, the relevant code in
> drivers/usb/host/ehci-q.c::qh_urb_transaction() predates the git era.

Like I said, a long time ago.

> The comment in that function before setting the Alternate Next qTD
> pointer:
> > /*
> >  * short reads advance to a "magic" dummy instead of the next
> >  * qtd ... that forces the queue to stop, for manual cleanup.
> >  * (this will usually be overridden later.)
> >  */
> 
> ...suggests the idea was to override that pointer when
> URB_SHORT_NOT_OK is not set, but this is actually done only for
> the last qTD from the URB (also, that's the only one that ends
> with interrupt flag set).

The hw_alt_next field should be updated for all the qTDs in the URB.
Failure to this was probably an oversight.  Or maybe the omission was
to simplify the procedure for cleaning up the queue after a short
transfer.

> Looking at OHCI and UHCI host controller drivers the equivalent
> limits seem to be different there (8 KB and 2 KB), while I don't
> see any specific limit in the XHCI case.

I'd have to review the details of ohci-hcd and uhci-hcd to make
sure.  In principle, the queue isn't supposed to stop merely because
of a short transfer unless URB_SHORT_NOT_OK is set.  However, the UHCI
hardware in particular may offer no other way to handle a short transfer.

> Because of that variance in the URB buffer limit it seems strange
> to me that this should be managed by a particular USB device driver
> rather than by the host controller driver, because this would mean
> every such driver would need to either use the lowest common
> denominator for the URB buffer size (which is very small) or
> hardcode the limit for every host controller that the device can
> be connected to, which seems a bit inefficient.

I don't understand what you're saying in this paragraph.  What do you
think USB device drivers are supposed to be managing?  The URB buffer
size?  They should set that field without regard to the type of host
controller in use.

In short, the behavior you observed is a bug, resulting in a loss of
throughput (though not in any loss of data).  It needs to be fixed.

If you would like to write and submit a patch, that would be great.
Otherwise, I'll try to find time to work on it.

I would appreciate any effort you could make toward checking the code
in qh_completions(); I suspect that the checks it does involving
EHCI_LIST_END may not be right.  At the very least, they should be
encapsulated in a macro so that they are easier to understand.

Alan Stern
