Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64EC39CE75
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 11:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFFJyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 05:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhFFJy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 05:54:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF0E1613EF;
        Sun,  6 Jun 2021 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622973158;
        bh=Gjk0qZh0da89+gS4Qa7y0ibkcEYby77/2TNDuAQLRYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AqeBxPQtMZ1qDMQgOBKP5mqJe5dYoT95eknNXOAGVq810UShccNxkeKvYtN/l65GO
         sPpYACRnte4h2y1eYu5qNUNJ4KcZplBMTnPNEv54P1Ehf+a36+rZe+blD0y4FtTx9E
         2eqGNrbdHruIbMAX0aTW5hxgtsKBlKkgeCj1dcjY=
Date:   Sun, 6 Jun 2021 11:52:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] usb: dwc3: support 64 bit DMA in platform driver
Message-ID: <YLya4UG3nFBv798l@kroah.com>
References: <20210606093629.69786-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606093629.69786-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 11:36:29AM +0200, Sven Peter wrote:
> Currently, the dwc3 platform driver does not explicitly ask for
> a DMA mask. This makes it fall back to the default 32-bit mask which
> breaks the driver on systems that only have RAM starting above the
> first 4G like the Apple M1 SoC.
> 
> Fix this by using the same logic already present in xhci-plat.c:
> First, try to set a coherent dma mask for 64-bit, and then attempt
> again with a 32-bit mask if this fails.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> 
> I have taken the code directly from the xhci-plat.c driver so
> I think this change should be fairly low risk.
> Unfortunately I only have the Apple M1 to test this on but here
> the driver still works with the iommu enabled which limits the
> address space to 32 bit. It also enables to use this with the iommu
> in bypass mode which requires 64 bit addresses.
> 
> I believe this has been working fine so far since the dwc3 driver
> only uses a few very small buffers in host mode which might still
> fit within the first 4G of address space on many devices. The
> majority of DMA buffers are allocated inside the xhci driver which
> will already call dma_set_mask_and_coherent.
> 
> Best,
> 
> Sven
> 
>  drivers/usb/dwc3/core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index b6e53d8212cd..ef6bb6aaffd8 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1545,6 +1545,21 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	dwc3_get_properties(dwc);
>  
> +	/* Try to set 64-bit DMA first */
> +	if (WARN_ON(!dwc->sysdev->dma_mask))

This will cause systems to reboot if they have panic-on-warn set.  Are
you sure you want that to happen?

I know you copied this from xhci-plat, but let's not duplicate bugs
please :)

thnaks,

greg k-h
