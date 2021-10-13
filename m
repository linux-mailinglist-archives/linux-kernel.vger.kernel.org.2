Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97D742BF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhJMMFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhJMMFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:05:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E007560EB4;
        Wed, 13 Oct 2021 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634126600;
        bh=6Lpra3ez8JWIpg3SdW3vfWuYRu+xZGQ3by9f1A53ShY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TE077WFAvKOf+ldex8I6AHVm2qgh3cbckzUT+koRTwIjsEVpPaAJSCb9hDWVT3kGg
         N3pqSyHto9aPTY6jsNFiYrduG8CjwfYXLjRtOmjltNttVgW+YNea6MgbXHM5s1KZw8
         CXIQHzIA/7Q2QmKbnje49x5Io7JBxUvsqGdbXXSg=
Date:   Wed, 13 Oct 2021 14:03:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [RFC] usb: gadget: avoid unusual inline assembly
Message-ID: <YWbLBot7RZoycGf3@kroah.com>
References: <20210927123830.1278953-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927123830.1278953-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 02:38:20PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang does not understand the "mrc%?" syntax:
> 
> drivers/usb/gadget/udc/pxa25x_udc.c:2330:11: error: invalid % escape in inline assembly string
> 
> I don't understand it either, but removing the %? here gets it to build.
> This is probably wrong and someone else should do a proper patch.
> 
> Any suggestions?
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/gadget/udc/pxa25x_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
> index a09ec1d826b2..52cdfd8212d6 100644
> --- a/drivers/usb/gadget/udc/pxa25x_udc.c
> +++ b/drivers/usb/gadget/udc/pxa25x_udc.c
> @@ -2325,7 +2325,7 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
>  	pr_info("%s: version %s\n", driver_name, DRIVER_VERSION);
>  
>  	/* insist on Intel/ARM/XScale */
> -	asm("mrc%? p15, 0, %0, c0, c0" : "=r" (chiprev));
> +	asm("mrc p15, 0, %0, c0, c0" : "=r" (chiprev));
>  	if ((chiprev & CP15R0_VENDOR_MASK) != CP15R0_XSCALE_VALUE) {
>  		pr_err("%s: not XScale!\n", driver_name);
>  		return -ENODEV;
> -- 
> 2.29.2
> 

Given that no one had any objections, I'll queue this up and see what
breaks :)

thanks,

greg k-h
