Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F10313203
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhBHMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:16:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233445AbhBHL55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:57:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7998064E6E;
        Mon,  8 Feb 2021 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612785430;
        bh=UjSCVRlYlYz5lJ+/E0HItPpS4FLAKsZx0Wymr8k4yKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIbb+I40rvFB55fGxIaXy3dbufJPL7HvcyTfsLxGSqKTns8yKOg6qeUEGqHbQbrK8
         l6QH9Oj0PFRYMhIfIj3QETw/ca49Lk8iiD5GzHn5Wu0F0RpD4hhI2/CKI8MmNnr+xZ
         YrRl6YwidC94NQSe3TZhVPHpslVJIB1XdhuVfc4c=
Date:   Mon, 8 Feb 2021 12:57:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     taehyun cho <taehyun.cho@samsung.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Message-ID: <YCEnE4/Pf8P/CCID@kroah.com>
References: <taehyuncho>
 <CGME20210208114447epcas2p3507f22a555355ac7710c5ca220853e0e@epcas2p3.samsung.com>
 <20210208114538.134766-1-taehyun.cho@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208114538.134766-1-taehyun.cho@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 08:45:38PM +0900, taehyun cho wrote:
> 'ARCH_EXYNOS' is no more used.

I do not understand this sentance.  I see it used in many places in the
kernel tree still, is it being removed?

And if so, as of what commit is this true?

> 'USB_DWC3_EXYNOS' is glue layer
> which can be used with Synopsys DWC3 controller on Exynos SoCs.
> 'USB_DWC3_EXYNOS' can be used from Exynos5 to Exynos9.

This is fine, but the help text doesn't show this, why not put that
information there?

> 
> Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
> ---
>  drivers/usb/dwc3/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 2133acf8ee69..dc2f92ac8ef6 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -67,10 +67,10 @@ config USB_DWC3_OMAP
>  
>  config USB_DWC3_EXYNOS
>  	tristate "Samsung Exynos Platform"
> -	depends on (ARCH_EXYNOS || COMPILE_TEST) && OF
> +	depends on (USB_DWC3 || COMPILE_TEST) && OF
>  	default USB_DWC3
>  	help
> -	  Recent Exynos5 SoCs ship with one DesignWare Core USB3 IP inside,
> +	  Exynos SoCs chip with one DesignWare Core USB3 IP inside,

This does not make much sense anymore, can you reword it?

thanks,

greg k-h
