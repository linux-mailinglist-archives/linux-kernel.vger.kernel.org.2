Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C3239CE89
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFFKKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 06:10:37 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49791 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhFFKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 06:10:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C53E5C004A;
        Sun,  6 Jun 2021 06:08:46 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sun, 06 Jun 2021 06:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=AvYtEv+zHia2EJFNGLtSYe+jZTqg
        3D1Jy21AMjEfDdQ=; b=SMMTVA5ci/t/wcsI0QqxV9epg6DYK7veR0Jq2h+ZoSfE
        T3xnlzm4IeKqCAOrzc0FfUHpTIw9wkX2qMj2c6LEOupypaDAR1sp0lPGJ6FUPeae
        hlhW+CiA1Fae+DyTqf9xkPfG5yy7l9RmbEpKfqXISjH52KeIQMNO5L4MWClm1qzB
        ELZZnx5txcf2xemw5nZWGgTnD+/ZJgV/3pO8TRHfk/iznp14f99gyt94G6I8SD51
        IivOW5bFfa1EaBXrGQ9YIgxFduX10R1inFelc8KmGzVrI5qtH5NMClNoDbwKIvBj
        GjDE8Hbb1nANr4xjk6+v27JKisiPUspz2R8U28Mz9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AvYtEv
        +zHia2EJFNGLtSYe+jZTqg3D1Jy21AMjEfDdQ=; b=vBWPwe/OdlbvyGzuQJ+Ewu
        FPCaCBV9wm6WRmBzevdkeicJ2nIJuoCR7PZGVEN6GdbdFKPXyMfim1803yl5dWzB
        Bs91wImpQZtcf02iwzNrHbNtiimSE17h7pbUT27/Fq5uQT/TVB/ft567e65O5w8k
        oQM9vuvlD04A6pJo+g3j74DEpqhEXG0suITG2JJ1thHyZAhgxANixvTY6vmIMpRh
        cKF8Llb3zRTc+aSb/OBut0TKLyEAznQ1fZG2FC1/TMMDqyFXZO4f7JoT9VaTCdTX
        cLU/SE772wEiFFOvY76rfNUGe/j27j0WQ3i1NTpKHwmFBWO/MQOudralLfb5EGtA
        ==
X-ME-Sender: <xms:rp68YKgYCHIJpfZrKIZjoQMvldZatDuCKeBG4lxZAcjEJ8b5moDwDQ>
    <xme:rp68YLCLb4YlwyJV54MTcbcXUTzzOQwGBuRUsr_Y-mbDAcSg5fk3XdLUl1QRrOYnK
    PCzKN86p7X-lcfnAo4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedthedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:rp68YCHyntJ-BUrM4HD2luanj9NUG57UN7T_bit9fQenIGZt-wT-Qw>
    <xmx:rp68YDQqhpQuTlSez8fTRIyDkgbXC456xElYc95VSTbNQ4GhSTNB1g>
    <xmx:rp68YHx0PgPni3MLCblZUnh_Luoj5ml5uQpqXMfS9sHwbbN1hT6fXA>
    <xmx:rp68YC8VHcxtZB5y631OeDkV8MWy_MQlkuac5prq7qHq7Rw84SFdBA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E436951C0060; Sun,  6 Jun 2021 06:08:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <1f06cf8b-9651-47f2-802c-0bcc3963fea1@www.fastmail.com>
In-Reply-To: <YLya4UG3nFBv798l@kroah.com>
References: <20210606093629.69786-1-sven@svenpeter.dev>
 <YLya4UG3nFBv798l@kroah.com>
Date:   Sun, 06 Jun 2021 12:08:25 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, "Felipe Balbi" <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH] usb: dwc3: support 64 bit DMA in platform driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Jun 6, 2021, at 11:52, Greg Kroah-Hartman wrote:
> On Sun, Jun 06, 2021 at 11:36:29AM +0200, Sven Peter wrote:
> > Currently, the dwc3 platform driver does not explicitly ask for
> > a DMA mask. This makes it fall back to the default 32-bit mask which
> > breaks the driver on systems that only have RAM starting above the
> > first 4G like the Apple M1 SoC.
> > 
> > Fix this by using the same logic already present in xhci-plat.c:
> > First, try to set a coherent dma mask for 64-bit, and then attempt
> > again with a 32-bit mask if this fails.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> > 
> > I have taken the code directly from the xhci-plat.c driver so
> > I think this change should be fairly low risk.
> > Unfortunately I only have the Apple M1 to test this on but here
> > the driver still works with the iommu enabled which limits the
> > address space to 32 bit. It also enables to use this with the iommu
> > in bypass mode which requires 64 bit addresses.
> > 
> > I believe this has been working fine so far since the dwc3 driver
> > only uses a few very small buffers in host mode which might still
> > fit within the first 4G of address space on many devices. The
> > majority of DMA buffers are allocated inside the xhci driver which
> > will already call dma_set_mask_and_coherent.
> > 
> > Best,
> > 
> > Sven
> > 
> >  drivers/usb/dwc3/core.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index b6e53d8212cd..ef6bb6aaffd8 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1545,6 +1545,21 @@ static int dwc3_probe(struct platform_device *pdev)
> >  
> >  	dwc3_get_properties(dwc);
> >  
> > +	/* Try to set 64-bit DMA first */
> > +	if (WARN_ON(!dwc->sysdev->dma_mask))
> 
> This will cause systems to reboot if they have panic-on-warn set.  Are
> you sure you want that to happen?

Probably not :) I'll remove the WARN_ON.

thanks,

Sven
