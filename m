Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF839D0E5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 21:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFFTQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 15:16:19 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57925 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231409AbhFFTPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:15:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 16EFA13CA;
        Sun,  6 Jun 2021 15:13:39 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sun, 06 Jun 2021 15:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=MvwFPayhTcEWvcEKv5TmWDsTvmr0
        uW8J60CdljadmjU=; b=npM9QM3gszq8Ill6wwP/SEkE4LhInrBY4dFbI9BhX0dD
        kKD2bcY8I5mJpeCkwo3fhY+88TRsYuJLy8Xf27Qe/d+0z6yQIwqcOgbmI3uJD1NE
        081ARB9ehTaeq/RdI6uVNmS9fYJnJP0AXvB4pLE3XpakWIwMPJUG1D4P8+XtHwmb
        BPP5eGdW6MB0dw2/dqTriTRxXVYy8fEwNisAH3tCUsp1uqJzofDY3Rh7kPqOU9Bg
        pG7sDigVZIi8d+Pu50uKOHRMjokZkYmv4JVFdILB1c6ioKhadtZgSzOUHTFo4ey0
        NeEqVDF2VahZ4QNBS7/dtxuh/rTUkJcY+htPe0itoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MvwFPa
        yhTcEWvcEKv5TmWDsTvmr0uW8J60CdljadmjU=; b=vE6KlurLNw53dkBYH8EL2n
        9Jkl/4Hz3XbvsZ1KXAUCTPZRdWBPTzQLOD4Zlp04/gZDoNVsnyh0Mb+qJpiUlk8/
        Snd+qkuYOBDDFlI00sIDWshBOnvwDQS6AYTpz2IIYTMtkamu+hjRWjj3OZ18d019
        6liUA6na4BjR18xbSby1QculoUE+y4PIgIxKcyIudhOnwmzYCJMhARiXswSU8Hea
        zGYVY4dr41SMtiJwTZaGt218eFTB+Scn5MeFXBDI7FiftalgOsC+D/ybuYBfTbTZ
        QYIEoJbYzatA1eavW1UvM66o9S+GeN8I54ah2Yf2GTezcA/0dvgh5gEL0/e1U8Nw
        ==
X-ME-Sender: <xms:Yh69YLICqtCInGw4nSR1CQjjwXbsWoqpwSEfQpZph3s85fsSkXgbqQ>
    <xme:Yh69YPIt3bYtF4xtWzCshCFmHtiSivm3KuL8TcPACBppjk_ObD5amG0I8kQz-Knh0
    P0ji7azBxf8Oug4n3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedthedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:Yh69YDtU7MGezEX6tXJPpnMJyRxAMFvAJYH4IdTPDMolBY7WRGn14w>
    <xmx:Yh69YEZLlPpEzoaTTFMtpmcqp5Qe1Vd-n1yi2Dg6Wkz5zj16O1_hUQ>
    <xmx:Yh69YCa1kEHSGvPGxa10_dMm7svRkC8DICUbQ6siXtYwvWo9whDbSQ>
    <xmx:Yh69YBkBc9maanbms25rrGOBoaLzjOhl29efwsazPxCmiO8VT9E4PQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2FE7F51C0060; Sun,  6 Jun 2021 15:13:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <f321012c-8108-4797-9f24-7786c1f7d468@www.fastmail.com>
In-Reply-To: <CAK8P3a3TetrYDq0un8NT2ZPM=MSGg68Qr0gEV0Ua4Jfqoy-ErQ@mail.gmail.com>
References: <20210606103656.71079-1-sven@svenpeter.dev>
 <CAK8P3a3TetrYDq0un8NT2ZPM=MSGg68Qr0gEV0Ua4Jfqoy-ErQ@mail.gmail.com>
Date:   Sun, 06 Jun 2021 21:13:17 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "USB list" <linux-usb@vger.kernel.org>,
        "Felipe Balbi" <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: support 64 bit DMA in platform driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Jun 6, 2021, at 17:43, Arnd Bergmann wrote:
> On Sun, Jun 6, 2021 at 12:36 PM Sven Peter <sven@svenpeter.dev> wrote:
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index b6e53d8212cd..4930541a8984 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1545,6 +1545,21 @@ static int dwc3_probe(struct platform_device *pdev)
> >
> >         dwc3_get_properties(dwc);
> >
> > +       /* Try to set 64-bit DMA first */
> > +       if (!dwc->sysdev->dma_mask)
> > +               /* Platform did not initialize dma_mask */
> > +               ret = dma_coerce_mask_and_coherent(dwc->sysdev,
> > +                                                  DMA_BIT_MASK(64));
> > +       else
> > +               ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> > +
> > +       /* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
> > +       if (ret) {
> > +               ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(32));
> > +               if (ret)
> > +                       return ret;
> > +       }
> 
> Please drop the dma_coerce_mask_and_coherent() code path as well: if
> the device is marked as non-DMA capable in the platform, it's better have
> it not be usable at all than to assume a particular bus property that may
> or may not be present on that bus.
> 
> The 32-bit mask is the default on all buses you might see a dwc3 controller
> on, so you can drop that as well, and just leave the
> dma_set_mask_and_coherent().
> 
>         Arnd
> 

Makes sense, will drop the two things for v3.

Thanks,

Sven

