Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A608139D846
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFGJI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:08:59 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:60487 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230395AbhFGJI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:08:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5963E194D;
        Mon,  7 Jun 2021 05:07:04 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Mon, 07 Jun 2021 05:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=4Xrn6sBXHve5ttmu1qx/tNnwpXxm
        QzMsmndeqFUhd1U=; b=eKo0efSNlXsAbYkTNXPkGZywnHA6g84b+8TL0vmP44gr
        Cn8C2H3NSezWhpmqOD0SYrFHHyZJIfkzXyJzpwKFvBNB9p1xqlLUOGW/p74BI/OQ
        VHGFxUL/NFrEAYSXWlZ6f1Z35cdteE8CfGVl9jb9jRqpLmr1QyNlt0+iY1gkMllX
        8QVrUbAg4HZUCSMeg1vih5evZ09jrKweOqu9gPAM2Kj+6rg44kyx6k1dLcvlCSeB
        vxrLrXQH3ECT7c5JULeRsPuClPwUNfC8WvQTrngNM70/5k+LmsHzwZPIIyv7pmi/
        aY/L/qU2MJOIXI3jylwADfzUV3LIJPx0KKdwma7ATA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4Xrn6s
        BXHve5ttmu1qx/tNnwpXxmQzMsmndeqFUhd1U=; b=vgIOA5qTokj4eDiaVTF5Pr
        iIRE5Uymrqabl3GaFIKQr0CrRZBaGaeJARddeW5swCWtYjw6idI+vzf/QLdmaPVF
        Ce6iTjL27vyl/s4jjxWt3UvHsKGBpmCy6hm1cHHVY4eF2yShab2tjKJb3UDojQRv
        +TFvg3xm9N50UMNl5W5nu0dgLAhDuBRoeJB+Da8Zn8mym7j+X7jNvNpD5Lna3Dlf
        Et9P/1vz1EML+qPlmL31J6n6jUUJVBkIyfr/3nzOvC1XHascqPJ15ZisIEBdnqBk
        8blDOHUajrd1WRlFD6XS6kTgN5oxNLDfV/+w9al+meLFtZJWqcfA9BX7gHSqt4DA
        ==
X-ME-Sender: <xms:t-G9YFvulZ_OTnTGPqxfJUcOz2amlsSiI1DVCAOS7HFCYxF1QFCe8g>
    <xme:t-G9YOda1pQb--BKeLVxNhnrX_cjXOe9YALMma7yMDw5nj0r4L7ZrtcsBeWXVeHAS
    iI_-bvZKx68vrBkF4k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpedtudejteetgfegtdetvdeiueffgfduteegjefghfefudeuveduffeutedt
    teeffeenucffohhmrghinheplhhinhhugihfohhunhgurghtihhonhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhv
    vghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:t-G9YIyWRAtM_1Xz7yLikLmtF4wGa5-TRBRTdJJ-CePg4P5tiLUKvA>
    <xmx:t-G9YMNNaeGemUHICB1reVglJNKwotVOJj6GCX4TdFS2Df4GDw9fnQ>
    <xmx:t-G9YF8Su5sUxY1H7gxLfOLOJ1stXgWYlkmt8WiPUj2pQmtbbl8HKg>
    <xmx:t-G9YHJsDKmVdw9orqiXfFdNWxreLEZhD0XIAIcaddWKqLLG6eNZMg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4B48151C0060; Mon,  7 Jun 2021 05:07:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <5b1431bc-64e3-4ecc-a498-eda8e46d5a95@www.fastmail.com>
In-Reply-To: <CAK8P3a0j=vowKpdJxt-GBsFuwqNJZv-dB-XoZihg=XHey1VoCg@mail.gmail.com>
References: <20210607061751.89752-1-sven@svenpeter.dev>
 <CAK8P3a0vbyq-90pUQ6-0Ed=DadR3Pnf0juupLQ70psQSuu_1nw@mail.gmail.com>
 <23348bfc-aad7-4e5f-83b1-e69463e618e5@www.fastmail.com>
 <CAK8P3a0j=vowKpdJxt-GBsFuwqNJZv-dB-XoZihg=XHey1VoCg@mail.gmail.com>
Date:   Mon, 07 Jun 2021 11:06:08 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "USB list" <linux-usb@vger.kernel.org>,
        "Felipe Balbi" <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: support 64 bit DMA in platform driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Jun 7, 2021, at 10:22, Arnd Bergmann wrote:
> On Mon, Jun 7, 2021 at 10:01 AM Sven Peter <sven@svenpeter.dev> wrote:
> > On Mon, Jun 7, 2021, at 09:25, Arnd Bergmann wrote:
> > > On Mon, Jun 7, 2021 at 8:18 AM Sven Peter <sven@svenpeter.dev> wrote:
> > > >
> > > > Currently, the dwc3 platform driver does not explicitly ask for
> > > > a DMA mask. This makes it fall back to the default 32-bit mask which
> > > > breaks the driver on systems that only have RAM starting above the
> > > > first 4G like the Apple M1 SoC.
> > > >
> > > > Fix this by calling dma_set_mask_and_coherent with a 64bit mask.
> > > >
> > > > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > > > ---
> > > >
> > > > Third time's a charm I hope - this time much simpler :)
> > >
> > > I think this is almost good, but there is still one small issue:
> > >
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index b6e53d8212cd..ba4792b6a98f 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -1545,6 +1545,10 @@ static int dwc3_probe(struct platform_device *pdev)
> > > >
> > > >         dwc3_get_properties(dwc);
> > > >
> > > > +       ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> > > > +       if (ret)
> > > > +               return ret;
> > >
> > > This will now  fail on machines with dwc3 connected to a 32-bit bus (or a
> > > bus that is accidentally not annotated as supporting 64-bit) when there is
> > > some memory that is not addressable through that bus.
> > >
> > > If dma_set_mask_and_coherent() fails, the platform should just fall back to
> > > 32-bit addressing as it did before your change. dma_alloc_*() will do that
> > > implicitly by allocating from ZONE_DMA32, while dma_map_*() fails
> > > on any non-addressable memory, or falls back to swiotlb if that is available.
> >
> >
> > Makes sense, but just to make sure I understand this correctly:
> > All that needs to be done is call dma_set_mask_and_coherent with a 64 bit
> > mask and then just ignore the return value?
> 
> If the driver never calls dma_map_*() on the device, that is correct, otherwise
> it has to be careful about what pointers it passes in there to avoid
> failing later.
> Since it is already working without the dma_set_mask(), I don't expect a
> problem there.
> 
> I suppose in theory, the dwc3_alloc_scratch_buffers() should use GFP_DMA32
> if dma_set_mask_and_coherent() failed. On arm32, it won't matter since
> all kernel pointers are generall within ZONE_DMA32, and on arm64 we always
> build with SWIOTLB enabled. Not sure where else you'd typically find dwc3,
> or if any of them are broken without changing this.
> 
>         Arnd
> 

I've looked at Documentation/core-api/dma-api-howto.rst again which mentions that

	By default, the kernel assumes that your device can address 32-bits of DMA
	addressing.  For a 64-bit capable device, this needs to be increased, and for
	a device with limitations, it needs to be decreased.
	[...]
	These calls usually return zero to indicated your device can perform DMA
	properly on the machine given the address mask you provided, but they might
	return an error if the mask is too small to be supportable on the given
	system.  If it returns non-zero, your device cannot perform DMA properly on
	this platform, and attempting to do so will result in undefined behavior.
	You must not use DMA on this device unless the dma_set_mask family of
	functions has returned success.

which, unless I'm reading this incorrectly, should mean that asking for a 64bit
mask is always fine. In the worst case the mask will just be downgraded to
32bit if the bus is correctly annotated (the places I looked at that use the mask
take the min of that one and dev->bus_dma_limit).
Only asking for a mask that is too small would be bad.

I have also found [1],[2] which made changes to that documentation and that also
seems to confirm that it's fine to just ask for a 64 bit mask either way.


So for these cases

> > > This will now  fail on machines with dwc3 connected to a 32-bit bus (or a
> > > bus that is accidentally not annotated as supporting 64-bit) when there is
> > > some memory that is not addressable through that bus.

the call should return success but the final mask used for allocations should
remain at 32bit. Before the change no memory above the 32bit limit was used by
the dwc3 core and after the change we still can't use any memory above the
32bit limit.


Now if we had a dwc3 controller with
 * a quirk that only allows 32bit DMA for the core dwc3 controller
 * but support for >32bit DMA for xhci buffers (xhci already asks for a 64bit mask) 
 * on a bus that's otherwise annotated to support 64bit
this change will break that.

But that's unrelated to the dma_set_mask_and_coherent return value since
just calling it with a 64bit mask will already cause trouble (and also be successful!).

The problem I see is that we likely wouldn't know about devices with a quirk like this
since so far everything has been working fine there. I'm not really sure how to guard
against that either since we would only notice on the first DMA transfer above the 32bit
limit. I'm also not sure how likely the existence of such a weird device is.

This hypothetical dwc3 controller should probably either be confined to a bus with a 
proper 32bit limit or get a quirk that enforces allocations from ZONE_DMA32. Doesn't
change the fact that they used to work but would now break after this patch.



[1] https://lists.linuxfoundation.org/pipermail/iommu/2019-February/033669.html
[2] https://lists.linuxfoundation.org/pipermail/iommu/2019-February/033674.html

Best,

Sven
