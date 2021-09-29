Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7241C79F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344900AbhI2PBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:01:12 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36035 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1344938AbhI2PA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:00:57 -0400
Received: (qmail 429369 invoked by uid 1000); 29 Sep 2021 10:59:05 -0400
Date:   Wed, 29 Sep 2021 10:59:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v2] usb: ohci: add check for start frame in host
 controller functional states
Message-ID: <20210929145905.GA428239@rowland.harvard.edu>
References: <1632910167-23554-1-git-send-email-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632910167-23554-1-git-send-email-zhuyinbo@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 06:09:27PM +0800, Yinbo Zhu wrote:
> The pm states of ohci controller include UsbOperational, UsbReset, UsbSuspend

Those aren't really PM states.  The specification calls them "USB 
states".

> , and UsbResume. Among them, only the UsbOperational state supports launching
--^

This comma should come directly after the word "launching", with no 
space in between.

> the start frame for host controller according the ohci protocol spec, but in
> S3/S4 press test procedure, it may happen that the start frame was launched

What is the S3/S4 press test?  I don't recall hearing of it before.

> in other pm states and cause ohci works abnormally then kernel will allways
> report rcu CallTrace. This patch was to add check for start frame in host
> controller functional states for fixing above issue.

The patch doesn't check for start of frames, that is, it doesn't check 
the INTR_SF bit in the intrstatus register.  Instead it checks whether 
controller is in the UsbOperational state.  And the patch also sets 
INTR_SF in the intrdisable register -- you do not mention this in the 
description.

> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v2:
> 		Revise the punctuation.	
> 
>  drivers/usb/host/ohci-hcd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 1f5e693..f0aeae5 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -881,6 +881,13 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>  	struct ohci_regs __iomem *regs = ohci->regs;
>  	int			ints;
>  
> +	ints = ohci_readl(ohci, &regs->control);
> +
> +	if ((ints & OHCI_CTRL_HCFS) != OHCI_USB_OPER) {
> +		ohci_writel(ohci, OHCI_INTR_SF, &regs->intrdisable);
> +		(void)ohci_readl(ohci, &regs->intrdisable);
> +	}

The driver is already supposed to prevent this problem by writing the 
OHCI_INTR_SF flag to the intrdisable register when start-of-frame 
interrupts aren't needed.  Maybe what you should do is change this code 
lower down in ohci_irq():

	if ((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
			&& ohci->rh_state == OHCI_RH_RUNNING)
		ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);

by getting rid of the test for OHCI_RH_RUNNING.

Alan Stern

> +
>  	/* Read interrupt status (and flush pending writes).  We ignore the
>  	 * optimization of checking the LSB of hcca->done_head; it doesn't
>  	 * work on all systems (edge triggering for OHCI can be a factor).
> -- 
> 1.8.3.1
> 
