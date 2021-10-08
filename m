Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E302426CBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhJHO2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:28:41 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51023 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230434AbhJHO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:28:36 -0400
Received: (qmail 721833 invoked by uid 1000); 8 Oct 2021 10:26:39 -0400
Date:   Fri, 8 Oct 2021 10:26:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v3] usb: ohci: add check for host controller functional
 states
Message-ID: <20211008142639.GA721194@rowland.harvard.edu>
References: <1633677970-10619-1-git-send-email-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633677970-10619-1-git-send-email-zhuyinbo@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 03:26:10PM +0800, Yinbo Zhu wrote:
> The usb states of ohci controller include UsbOperational, UsbReset,
> UsbSuspend and UsbResume. Among them, only the UsbOperational state
> supports launching the start of frame for host controller according
> the ohci protocol spec, but in S3/S4 press test procedure, it may

Nobody reading this will know what "S3/S4 press test procedure" means.  
You have to explain it, or use a different name that people will 
understand.

> happen that the start of frame was launched in other usb states and
> cause ohci works abnormally then kernel will allways report rcu
> call trace. This patch was to add check for host controller
> functional states and if it is not UsbOperational state that need
> set INTR_SF in intrdisable register to ensure SOF Token generation
> was been disabled.

This doesn't make sense.  You already mentioned that only the 
UsbOperational state supports sending start-of-frame packets.  So if the 
controller is in a different state then it won't send these packets, 
whether INTR_SF is enabled or not.

What problem are you really trying to solve?

> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v3:
> 		Rework the commit information.
> 		Move the patch code change to lower down position in ohci_irq.
> 
> 
>  drivers/usb/host/ohci-hcd.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 1f5e693..87aa9bb 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -879,7 +879,8 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>  {
>  	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
>  	struct ohci_regs __iomem *regs = ohci->regs;
> -	int			ints;
> +	int			ints, ctl;
> +

Extra blank line not needed.

>  
>  	/* Read interrupt status (and flush pending writes).  We ignore the
>  	 * optimization of checking the LSB of hcca->done_head; it doesn't
> @@ -969,9 +970,15 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>  	 * when there's still unlinking to be done (next frame).
>  	 */
>  	ohci_work(ohci);
> -	if ((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
> -			&& ohci->rh_state == OHCI_RH_RUNNING)
> +
> +	ctl = ohci_readl(ohci, &regs->control);
> +

Blank lines not needed.

> +	if (((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
> +			&& ohci->rh_state == OHCI_RH_RUNNING) ||
> +			((ctl & OHCI_CTRL_HCFS) != OHCI_USB_OPER)) {
>  		ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);
> +		(void)ohci_readl(ohci, &regs->intrdisable);
> +	}

This is definitely wrong.  You must not turn off SF interrupts when 
ed_rm_list is non-NULL.  If you do, the driver will not be able to 
finish unlinking URBs.

Alan Stern
