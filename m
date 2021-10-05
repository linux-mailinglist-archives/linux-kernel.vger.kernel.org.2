Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24845422488
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhJELGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233449AbhJELGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:06:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98AC5611F0;
        Tue,  5 Oct 2021 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633431867;
        bh=zeGBNsog1olkIZ1fVKAxVZmcBFpEUAytVPA7H52jY7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXBrKoaf/qaTtR5tbgysF5rd4ayDtHJateJtB7ljp3Pr9R0WCwFYRxJbh2qxi1g0K
         ubPd12/AKqvKP6kt5/fzigwPr3TqpHsvtgcWEeXVIFmgaGWQgTlf888JORG0hRGPlA
         W8BpObNbBL678AbKFC/lPIxyvw/Av5cExiYHsaZ8=
Date:   Tue, 5 Oct 2021 13:04:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     Ferry Toth <fntoth@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v1 1/1] usb: dwc3: gadget: Revert "set gadgets parent to
 the right controller"
Message-ID: <YVwxORtF1aQDsT08@kroah.com>
References: <20211004141839.49079-1-andriy.shevchenko@linux.intel.com>
 <7019ca3e-f076-e65b-f207-c23a379ade29@gmail.com>
 <20211005085100.GB17524@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005085100.GB17524@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 10:51:00AM +0200, Michael Grzeschik wrote:
> On Mon, Oct 04, 2021 at 10:35:57PM +0200, Ferry Toth wrote:
> > Hi,
> > 
> > Op 04-10-2021 om 16:18 schreef Andy Shevchenko:
> > > The commit c6e23b89a95d ("usb: dwc3: gadget: set gadgets parent to the right
> > > controller") changed the device for the UDC and broke the user space scripts
> > > that instantiate the USB gadget(s) via ConfigFS.
> > 
> > I confirm this regression on Intel Edison since at least 5.15-rc2 while
> > in 5.14.0 it was working fine.
> > 
> > This patch resolves the issue as tested on 5.15-rc4.
> > 
> > Tested-by: Ferry Toth<fntoth@gmail.com>
> 
> NACK! Why should we resolv an issue by reverting it to solve not working
> userspace. We already have this patch as a solution for solving a deeper
> Problem, regarding the allocator addressing the right device.
> 
> > > Revert it for now until the better solution will be proposed.
> 
> So, I think fixing the userspace would be the right fix, not changing
> the kernel. Otherwise we should find a proper solution.

We only really have one rule in Linux kernel development:

	If a kernel change breaks userspace, the kernel change needs to
	be reverted.

Go fix up the userspace tools first, ensure everyone has updated, and
then we can consider taking the change back into the kernel tree.

thanks,

greg k-h
