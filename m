Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25313D57CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhGZKMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhGZKMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:12:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76E5760462;
        Mon, 26 Jul 2021 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627296799;
        bh=mqK0ivD+8a81SnWbLPQUYrBBrdHLb4JCmxmQd9KxO00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYfjldICpUoQZ1mD+1Klfc/usX6bGuGSm+wzHB5lOwkago7EkO9P3BMr2LuJLeixx
         V7nKYbJqwfJeq0ffGdpZBrSoOo73NMlDsHks4RyLRj1XzklK8odATinKXDFUBRfgnB
         OPrU/HYoIYaZoGyc2RtG4JyVTUwaQiyrsMwjiWJY=
Date:   Mon, 26 Jul 2021 12:53:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        djeffery@redhat.com, loberman@redhat.com,
        stern@rowland.harvard.edu, stable-commits@vger.kernel.org
Subject: Re: Patch "usb: ehci: Prevent missed ehci interrupts with
 edge-triggered MSI" has been added to the 5.10-stable tree
Message-ID: <YP6UHGhMdIwJXmEt@kroah.com>
References: <1627287666108120@kroah.com>
 <YP6I0AIFn0rZgqEd@smile.fi.intel.com>
 <YP6L1apXSmsb+C7b@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP6L1apXSmsb+C7b@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:17:57PM +0200, Greg KH wrote:
> On Mon, Jul 26, 2021 at 01:05:04PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 26, 2021 at 10:21:06AM +0200, gregkh@linuxfoundation.org wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     usb: ehci: Prevent missed ehci interrupts with edge-triggered MSI
> > > 
> > > to the 5.10-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      usb-ehci-prevent-missed-ehci-interrupts-with-edge-triggered-msi.patch
> > > and it can be found in the queue-5.10 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > 
> > > From 0b60557230adfdeb8164e0b342ac9cd469a75759 Mon Sep 17 00:00:00 2001
> > > From: David Jeffery <djeffery@redhat.com>
> > > Date: Thu, 15 Jul 2021 17:37:44 -0400
> > > Subject: usb: ehci: Prevent missed ehci interrupts with edge-triggered MSI
> > > 
> > > From: David Jeffery <djeffery@redhat.com>
> > > 
> > > commit 0b60557230adfdeb8164e0b342ac9cd469a75759 upstream.
> > > 
> > > When MSI is used by the ehci-hcd driver, it can cause lost interrupts which
> > > results in EHCI only continuing to work due to a polling fallback. But the
> > > reliance of polling drastically reduces performance of any I/O through EHCI.
> > > 
> > > Interrupts are lost as the EHCI interrupt handler does not safely handle
> > > edge-triggered interrupts. It fails to ensure all interrupt status bits are
> > > cleared, which works with level-triggered interrupts but not the
> > > edge-triggered interrupts typical from using MSI.
> > > 
> > > To fix this problem, check if the driver may have raced with the hardware
> > > setting additional interrupt status bits and clear status until it is in a
> > > stable state.
> > > 
> > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > > Tested-by: Laurence Oberman <loberman@redhat.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > Link: https://lore.kernel.org/r/20210715213744.GA44506@redhat
> > > Cc: stable <stable@vger.kernel.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/usb/host/ehci-hcd.c |   17 +++++++++++++----
> > >  1 file changed, 13 insertions(+), 4 deletions(-)
> > > 
> > > --- a/drivers/usb/host/ehci-hcd.c
> > > +++ b/drivers/usb/host/ehci-hcd.c
> > > @@ -703,7 +703,8 @@ EXPORT_SYMBOL_GPL(ehci_setup);
> > >  static irqreturn_t ehci_irq (struct usb_hcd *hcd)
> > >  {
> > >  	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
> > > -	u32			status, masked_status, pcd_status = 0, cmd;
> > > +	u32			status, current_status, masked_status, pcd_status = 0;
> > > +	u32			cmd;
> > >  	int			bh;
> > >  	unsigned long		flags;
> > >  
> > > @@ -715,10 +716,12 @@ static irqreturn_t ehci_irq (struct usb_
> > >  	 */
> > >  	spin_lock_irqsave(&ehci->lock, flags);
> > >  
> > > -	status = ehci_readl(ehci, &ehci->regs->status);
> > > +	status = 0;
> > > +	current_status = ehci_readl(ehci, &ehci->regs->status);
> > > +restart:
> > >  
> > >  	/* e.g. cardbus physical eject */
> > > -	if (status == ~(u32) 0) {
> > > +	if (current_status == ~(u32) 0) {
> > >  		ehci_dbg (ehci, "device removed\n");
> > >  		goto dead;
> > >  	}
> > 
> > I'm wondering if we should do the same here as in the original patch, i.e.
> > 
> >     status |= current_status;
> 
> Ugh, my fault, I missed this in the backport, thanks!  I'll go fix that
> up...

Should now be fixed up, thanks for catching this.

greg k-h
