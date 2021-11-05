Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538EC4460ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhKEIy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhKEIyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:54:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EB1761245;
        Fri,  5 Nov 2021 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636102336;
        bh=tLq4vqpRI+b9CyNwNzXtcwMluJjPlrKEK5QQz35I6xA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDvvuJB1Xn4A3267nPe3+WwFjpQN0W3lz+TD9eGEv9gamS7iDFne71ZezRz4g4WjA
         dI9RbILJlkgSWiCVhH3P5oISq6hJrKAGlEgQfT98tCrJ4wsBRFifUuhp/zD+lkAeI8
         SueiwQuGgS6ML7uRHE5L8FzXGXcEFs1ujkSXH0A8=
Date:   Fri, 5 Nov 2021 09:52:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Haimin Zhang <tcs.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH 2/2] USB: ehci_brcm_hub_control: replace wIndex-1 with
 temp
Message-ID: <YYTwveXGgNKXCfpk@kroah.com>
References: <20211105083357.29715-1-tcs_kernel@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105083357.29715-1-tcs_kernel@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 04:33:57PM +0800, Haimin Zhang wrote:
> In function `ehci_brcm_hub_control`, like following code,  
> it filters out the case where the upper byte of wIndex is nonzero, 
> so it need be replaced with temp.

I do not understand this text, can you try to reword it?

And you have trailing whitespace.

And why use `?

> ```

What is this for?  Changelog comments are not in markdown format.

> 	if ((typeReq == GetPortStatus) &&
> 	    (wIndex && wIndex <= ports) &&       // need to be replaced

What does this comment mean?

> 	    ehci->reset_done[wIndex-1] &&
> 	    time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
> 	    (ehci_readl(ehci, status_reg) & PORT_RESUME)) {
> ```
> 
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> Reported-by: TCS Robot <tcs_robot@tencent.com>

Again, lines need to be in different order, and your from: line is not
correct.

Also, you need an individual email address, not a group email alias for
your contributions.  We work with individuals, not groups.



> ---
>  drivers/usb/host/ehci-brcm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
> index a1e3290e5459..efcfca162126 100644
> --- a/drivers/usb/host/ehci-brcm.c
> +++ b/drivers/usb/host/ehci-brcm.c
> @@ -73,9 +73,9 @@ static int ehci_brcm_hub_control(
>  	 * of RESUME
>  	 */
>  	if ((typeReq == GetPortStatus) &&
> -	    (wIndex && wIndex <= ports) &&
> -	    ehci->reset_done[wIndex-1] &&
> -	    time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
> +	    (temp < ports) &&

Where did temp come from?

thanks,

greg k-h
