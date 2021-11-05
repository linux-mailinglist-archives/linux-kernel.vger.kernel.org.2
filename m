Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D31A4460DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhKEIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhKEIwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:52:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09F1D61186;
        Fri,  5 Nov 2021 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636102196;
        bh=Yj0767vkpCyVX0rhrVBDGVMu6UTpTPqHKO12eacfBJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRAy5R74foZxfME7ku+VJn7tusv2n1lSEjCh7UatDq/2P2ucx8OZ5MG1/8e22CtS8
         DWwVXnkjky42ctvPN/ZAfVEmqzWfhE83Ei+Ips8WOXbfE032Nnl6HLQiwqhZlTk0jz
         dwv4MYEfnBAQodxQc556B1ZmIW6YBKso59iykbqs=
Date:   Fri, 5 Nov 2021 09:49:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Haimin Zhang <tcs.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH 1/2] USB: array-index-out-of-bounds in
 ehci_brcm_hub_control
Message-ID: <YYTwMTbYPpBE8817@kroah.com>
References: <20211105083250.29464-1-tcs_kernel@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105083250.29464-1-tcs_kernel@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 04:32:50PM +0800, Haimin Zhang wrote:
> There isn't enough check parameter `wIndex` in the function
> `ehci_brcm_hub_control`;due to the size of array `port_status`
> is 15, so it may lead to out of bounds.

Odd use of ';'

And have you seen this get out of bounds?  If so, how?


> 
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> Reported-by: TCS Robot <tcs_robot@tencent.com>

Signed-off-by goes below the reported-by lines.

And why are these 2 patches not "threaded" properly in email.  How did
you send them?

Also, your "From" line does not match your signed-off-by line, so I
could not take these at all even if this was ok.

> ---
>  drivers/usb/host/ehci-brcm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
> index d3626bfa966b..a1e3290e5459 100644
> --- a/drivers/usb/host/ehci-brcm.c
> +++ b/drivers/usb/host/ehci-brcm.c
> @@ -62,8 +62,11 @@ static int ehci_brcm_hub_control(
>  	u32 __iomem	*status_reg;
>  	unsigned long flags;
>  	int retval, irq_disabled = 0;
> +	u32 temp;
>  
> -	status_reg = &ehci->regs->port_status[(wIndex & 0xff) - 1];
> +	temp = (wIndex & 0xff) - 1;
> +	if (temp < ports)
> +		status_reg = &ehci->regs->port_status[temp];

What if the test fails?  Should you do something about that?  status_reg
is now uninitialized, doesn't the code fail now?

How did you test this?

thanks,

greg k-h
