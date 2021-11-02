Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7E44319B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 16:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhKBP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 11:28:09 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33087 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234502AbhKBP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:28:04 -0400
Received: (qmail 1490824 invoked by uid 1000); 2 Nov 2021 11:25:27 -0400
Date:   Tue, 2 Nov 2021 11:25:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Haimin Zhang <tcs.kernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH] USB:  array-index-out-of-bounds in ehci_brcm_hub_control
Message-ID: <20211102152527.GC1490038@rowland.harvard.edu>
References: <20211102074446.87107-1-tcs_kernel@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102074446.87107-1-tcs_kernel@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 03:44:46PM +0800, Haimin Zhang wrote:
> There isn't enough check parameter `wIndex` in the function 
> `ehci_brcm_hub_control`;due to the size of array `port_status`
> is 15, so it may lead to out of bounds.
> 
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> Reported-by: TCS Robot <tcs_robot@tencent.com>
> ---
>  drivers/usb/host/ehci-brcm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
> index d3626bfa966b..4ca3eb9fcda9 100644
> --- a/drivers/usb/host/ehci-brcm.c
> +++ b/drivers/usb/host/ehci-brcm.c
> @@ -63,7 +63,8 @@ static int ehci_brcm_hub_control(
>  	unsigned long flags;
>  	int retval, irq_disabled = 0;
>  
> -	status_reg = &ehci->regs->port_status[(wIndex & 0xff) - 1];
> +	if (wIndex && wIndex <= ports)
> +		status_reg = &ehci->regs->port_status[(wIndex & 0xff) - 1];

This isn't quite right because it won't work properly if the upper byte 
of wIndex is nonzero.  You should do something like:

	u32 temp;

	temp = (wIndex & 0xff) - 1;
	if (temp < ports)
		status_reg = &ehci->regs->port_status[temp];

Alan Stern
