Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5293144F8ED
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 17:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhKNQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNQOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:14:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6904C061746;
        Sun, 14 Nov 2021 08:11:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z10so34026461edc.11;
        Sun, 14 Nov 2021 08:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GlrIz2XL8Ja5lgRNQzY0XRtjPUO6b3By7ewIDKftUC8=;
        b=YhNycIpD8hxTTS//0/u6ORWZGAm5S44sK97I2dU6zHqXAfUVGVFGJJZSRXFxMOOISp
         cJ8JC9HbdtY+CqKLM8bqiAaTLYn8uzOule/89DIvGMR7qk/Y0nesPqcd1N8zoTcNfxYk
         C8zDR4+G2VKdN1ChANjC1pEPH4+DP09BNVGryd1/KYLWUxvF5TQNr7125P39jEKzmzJ4
         IJvljItW9dFs97GRDEB6sR3e2fD8wlhiNXNl5okJtBiqwXAK1gAUrVQky/3dnQOoiQ+2
         7EY7bNeKA6T0FfkN/+DLPziR+xC4AwcZr26dEzIlkwZ1o2znzjVUMYwtFMXF1dwfsmbc
         zNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GlrIz2XL8Ja5lgRNQzY0XRtjPUO6b3By7ewIDKftUC8=;
        b=09j3C1NDULcvOhFv8YBlQPhfIMwFniDqH4YPNzJshc9Bg9JFdmNrTX5dCyOi8rtp+t
         dRt/jdxajEVC4F6WzePe08xJhj/B+RcI1YdpxDUcRl9ZSRYvs6fKqUN32e36BFTls5he
         aowZZsYWnthMuQ9+eRWHsIzx82aCS6fV8FqtEWRCoMtx3qdYl86rzDzy2liXmOHe4Uc9
         w6A/PRgy6Gm4pPEizHIiKG+uFY1QY+bGoVh9nfoXHmwXXVZCgodQ9ehPQJyFEB7eth/q
         FyPcWSA6W5eM15ToCxlRZZC3FStcw33S/FFpudVHSuaAha2MvTimJY036lcGC37//TA5
         Nn/Q==
X-Gm-Message-State: AOAM533CsR4En0T+d56EZz2lEXEQeAjrOk4yxyflraKEkVqDd3uIq0MD
        PAKH+ThY5iTTFBzGBvwH8Qs=
X-Google-Smtp-Source: ABdhPJyaY2DZG3sDCZWfujrfJMttbP1a7U3nLExQBf6e6Nd9c+/Jnx8QhqWXiN1Cpw//CkjTXQRPxg==
X-Received: by 2002:a05:6402:1908:: with SMTP id e8mr44235414edz.83.1636906303623;
        Sun, 14 Nov 2021 08:11:43 -0800 (PST)
Received: from agape.jhs ([151.57.190.253])
        by smtp.gmail.com with ESMTPSA id nc30sm5395053ejc.35.2021.11.14.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:11:43 -0800 (PST)
Date:   Sun, 14 Nov 2021 17:11:39 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "hch@lst.de" <hch@lst.de>, hdegoede@redhat.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: leave default DMA for PCI devices
Message-ID: <YZE1OxTxURt+stPq@agape.jhs>
References: <20211113142959.27191-1-fabioaiuto83@gmail.com>
 <34347fd8-1d67-4d16-b09f-061bc0c0cb5a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34347fd8-1d67-4d16-b09f-061bc0c0cb5a@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resend with all CC]

Hello Sven,

On Sun, Nov 14, 2021 at 12:56:02PM +0100, Sven Peter wrote:
> On Sat, Nov 13, 2021, at 15:29, Fabio Aiuto wrote:
> > in case of a PCI dwc3 controller, leave the default DMA
> > mask. Calling of a 64 bit DMA mask breaks the driver on
> > cherrytrail based tablets like Cyberbook T116.
> >
> > Fixes: 45d39448b4d0 ("usb: dwc3: support 64 bit DMA in platform driver")
> > Reported-by: Hans De Goede <hdegoede@redhat.com>
> > Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/usb/dwc3/core.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 643239d7d370..f4c09951b517 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1594,9 +1594,11 @@ static int dwc3_probe(struct platform_device *pdev)
> > 
> >  	dwc3_get_properties(dwc);
> > 
> > -	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> > -	if (ret)
> > -		return ret;
> > +	if (!dwc->sysdev_is_parent) {
> 
> 
> Are you sure it's the dwc3 controller that limits DMA to 32 bit addresses and
> not the PCI bus itself?
> I also think the xhci driver will call dma_set_mask_and_coherent again
> later on when dwc3 is used in host mode.

I could not have answered better than Hans, I'm just adding the bisect
log:

git bisect start
# bad: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14
git bisect bad 7d2a07b769330c34b4deabeed939325c77a7ec2f
# good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect good 7cf3dead1ad70c72edb03e2d98e1f3dcd332cdb2
# good: [406254918b232db198ed60f5bf1f8b84d96bca00] Merge tag 'perf-tools-for-v5.14-2021-07-01' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
git bisect good 406254918b232db198ed60f5bf1f8b84d96bca00
# bad: [4ea90317956718e0648e1f87e56530db809a5a04] Merge tag 'for-linus-5.14-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect bad 4ea90317956718e0648e1f87e56530db809a5a04
# good: [8fc4fb1728855a22f9149079ba51877f5ee61fc9] Merge tag 'm68knommu-for-v5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
git bisect good 8fc4fb1728855a22f9149079ba51877f5ee61fc9
# good: [77ad1f0e99bd00af024e650b862cfda3137af660] staging: hi6421-spmi-pmic: cleanup some macros
git bisect good 77ad1f0e99bd00af024e650b862cfda3137af660
# good: [eed0218e8cae9fcd186c30e9fcf5fe46a87e056e] Merge tag 'char-misc-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good eed0218e8cae9fcd186c30e9fcf5fe46a87e056e
# good: [c932ed0adb09a7fa6d6649ee04dd78c83ab07ada] Merge tag 'tty-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good c932ed0adb09a7fa6d6649ee04dd78c83ab07ada
# bad: [738d5ad104bbbe5d1bfb6c0553bb4a1eb91cc433] Revert "of/platform: Add stubs for of_platform_device_create/destroy()"
git bisect bad 738d5ad104bbbe5d1bfb6c0553bb4a1eb91cc433
# good: [8268acfe1cc967dbe9fbb05b5f07a19675a81cff] usb: isp1760: isp1760-udc: Provide missing description for 'udc' param
git bisect good 8268acfe1cc967dbe9fbb05b5f07a19675a81cff
# bad: [318324e6df9787f8ec06660224f555471c8f36d1] usb: musb: Implement tracing for state change events
git bisect bad 318324e6df9787f8ec06660224f555471c8f36d1
# good: [ca5ce82529104e96ccc5e1888979258e233e1644] usb: typec: intel_pmc_mux: Update IOM port status offset for AlderLake
git bisect good ca5ce82529104e96ccc5e1888979258e233e1644
# bad: [ecfbd7b9054bddb12cea07fda41bb3a79a7b0149] usb: gadget: f_fs: Fix setting of device and driver data cross-references
git bisect bad ecfbd7b9054bddb12cea07fda41bb3a79a7b0149
# good: [87191ca9f90244d4e003fbe5c77390b5e585a5ef] USB: UDC: Implement udc_async_callbacks in net2272
git bisect good 87191ca9f90244d4e003fbe5c77390b5e585a5ef
# good: [307462a6f5c5a563ec084bb315f4e0279dfb2026] usb: gadget: function: printer: use list_move instead of list_del/list_add
git bisect good 307462a6f5c5a563ec084bb315f4e0279dfb2026
# bad: [45d39448b4d0260743f25d88fd929451ec8296f2] usb: dwc3: support 64 bit DMA in platform driver
git bisect bad 45d39448b4d0260743f25d88fd929451ec8296f2
# good: [60dfe484cef45293e631b3a6e8995f1689818172] USB: core: Avoid WARNings for 0-length descriptor requests
git bisect good 60dfe484cef45293e631b3a6e8995f1689818172
# first bad commit: [45d39448b4d0260743f25d88fd929451ec8296f2] usb: dwc3: support 64 bit DMA in platform driver

> 
> 
> 
> Sven

thank you,

fabio
