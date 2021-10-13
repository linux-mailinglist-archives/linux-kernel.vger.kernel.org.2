Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C875742C218
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhJMOI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:08:27 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54745 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230347AbhJMOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:08:26 -0400
Received: (qmail 893839 invoked by uid 1000); 13 Oct 2021 10:06:22 -0400
Date:   Wed, 13 Oct 2021 10:06:22 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v6] usb: ohci: disable start-of-frame interrupt in
 ohci_rh_suspend
Message-ID: <20211013140622.GA893308@rowland.harvard.edu>
References: <1634095928-29639-1-git-send-email-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634095928-29639-1-git-send-email-zhuyinbo@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:32:08AM +0800, Yinbo Zhu wrote:
> While going into S3 or S4 suspend, an OHCI host controller can
> generate interrupt requests if the INTR_SF enable flag is set.  The
> interrupt handler routine isn't prepared for this and it doesn't turn
> off the flag, causing an interrupt storm.
> 
> To fix this problem, make ohci_rh_suspend() always disable INTR_SF
> interrupts after processing the done list and the ED unlinks but
> before the controller goes into the suspended (non-UsbOperational)
> state.  There's no reason to leave the flag enabled, since a
> suspended controller doesn't generate Start-of-Frame packets.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> Change in v6:
> 		1. Rework the commit log information.
> 		2. Move the key change code after ohci_work in 
> 		   ohci_rh_suspend.
> 
> 
>  drivers/usb/host/ohci-hub.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
> index f474f2f..90cee19 100644
> --- a/drivers/usb/host/ohci-hub.c
> +++ b/drivers/usb/host/ohci-hub.c
> @@ -91,6 +91,9 @@ static int ohci_rh_suspend (struct ohci_hcd *ohci, int autostop)
>  	update_done_list(ohci);
>  	ohci_work(ohci);
>  
> +	/* All ED unlinks should be finished, no need for SOF interrupts */
> +	ohci_writel(ohci, OHCI_INTR_SF, &ohci->regs->intrdisable);
> +
>  	/*
>  	 * Some controllers don't handle "global" suspend properly if
>  	 * there are unsuspended ports.  For these controllers, put all
> -- 
> 1.8.3.1
> 
