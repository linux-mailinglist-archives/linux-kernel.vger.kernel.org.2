Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8736539D6AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFGIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:04:12 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:38311 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230410AbhFGIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:04:07 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EECC4DBD;
        Mon,  7 Jun 2021 04:02:14 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Mon, 07 Jun 2021 04:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=pi51sQPyO+v+HxFzLV7xeS0Ul+G+
        7aVbQaStkS90iwc=; b=p/Nu1H7vvxJLufWppVSbptoET2eqBryLbD1enxhS3BWb
        b+sEiYKS3WcqyPx5PDO0qg8vVmHhw655EWjHvA2FkZByr42gPnQstHUu+zj3S4fO
        lBg82ADuvNUjBdJGhbgRb5vqPCgfyVPJYnDmT6X+Ru0OdrzrvrakkZW8IASUmWkp
        DEsG7oJuzKwmQfYmoIs/l/ooMhE25yAT00/j6wKcNkhqNaClUXFhPreZC++mRwwN
        5DXh2vQ/oht161uXbuzw/d7/CpVl1rtfvBMAUmOIXNji+4fFHz2jfCazZTAtgQT2
        v4yAJoJoFP7CD03VUN8XigWyjXONPDjoes2yihirwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pi51sQ
        PyO+v+HxFzLV7xeS0Ul+G+7aVbQaStkS90iwc=; b=eN1yEgQYNjJULIUkPXXEfy
        E+b6MyqVsZ3gzK0fZSu0jMmVKkEdUnCi/CabGXKyRGQuf4mxgSUPzfNNcmfK4KE0
        oSy89RWr8lfhwuWyi7JELUbwuxXb7LqeowuLqIVQBpdvAcF6FvPGF8Kg16aoBdI3
        6bXgI1GSWXd4CBD0ihv5B6r/nzvO/Rj4PxzpePHxYgddBYLsJdwjJoGbmwdhaeP1
        MA/IW1gPBr4vN5yoKi9pMG2mvHt+eqAhW/ynlQm3eO6COzBQ4uQYR/OviuB8gjI3
        SCCY5VxZ3m/T8c2yVhlXdbFsr4pGIHiA9crd3hWrMPwrhdc4v2TaxA+6PLK2FIiw
        ==
X-ME-Sender: <xms:hdK9YBW6W3gZWyWOl2lWqckHjGzP3OraRCEZ9qEn5fEQD4yXOugExA>
    <xme:hdK9YBk1j7H1oeczZ2GQfyTwp0UTKA-6rN0XlGFMbarpvkflFcnzzeI0Jw8B4mV-q
    umHzz-YsRTuhhiCB00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtiedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:hdK9YNZpGty1FCzJJrfjLcaf-nZfgDav_cMg2me0_lgF04vsPyMSMg>
    <xmx:hdK9YEXAgNz2z4wW3U6t5pTyUzyoXp8zuMLwYVQjjS0PhSE2jJphIQ>
    <xmx:hdK9YLmfb-FSvhEFfjiL1y3_PH29DDdMC6IyFhYw6GKLk9yYN7GRNA>
    <xmx:htK9YAyLHx0I6AvEKaUBfqODCnt-W8yqmzaPtcxxjDNxg3k1og3GtA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B3D2A51C0061; Mon,  7 Jun 2021 04:02:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <23348bfc-aad7-4e5f-83b1-e69463e618e5@www.fastmail.com>
In-Reply-To: <CAK8P3a0vbyq-90pUQ6-0Ed=DadR3Pnf0juupLQ70psQSuu_1nw@mail.gmail.com>
References: <20210607061751.89752-1-sven@svenpeter.dev>
 <CAK8P3a0vbyq-90pUQ6-0Ed=DadR3Pnf0juupLQ70psQSuu_1nw@mail.gmail.com>
Date:   Mon, 07 Jun 2021 10:01:50 +0200
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



On Mon, Jun 7, 2021, at 09:25, Arnd Bergmann wrote:
> On Mon, Jun 7, 2021 at 8:18 AM Sven Peter <sven@svenpeter.dev> wrote:
> >
> > Currently, the dwc3 platform driver does not explicitly ask for
> > a DMA mask. This makes it fall back to the default 32-bit mask which
> > breaks the driver on systems that only have RAM starting above the
> > first 4G like the Apple M1 SoC.
> >
> > Fix this by calling dma_set_mask_and_coherent with a 64bit mask.
> >
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >
> > Third time's a charm I hope - this time much simpler :)
> 
> I think this is almost good, but there is still one small issue:
> 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index b6e53d8212cd..ba4792b6a98f 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1545,6 +1545,10 @@ static int dwc3_probe(struct platform_device *pdev)
> >
> >         dwc3_get_properties(dwc);
> >
> > +       ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> > +       if (ret)
> > +               return ret;
> 
> This will now  fail on machines with dwc3 connected to a 32-bit bus (or a
> bus that is accidentally not annotated as supporting 64-bit) when there is
> some memory that is not addressable through that bus.
> 
> If dma_set_mask_and_coherent() fails, the platform should just fall back to
> 32-bit addressing as it did before your change. dma_alloc_*() will do that
> implicitly by allocating from ZONE_DMA32, while dma_map_*() fails
> on any non-addressable memory, or falls back to swiotlb if that is available.


Makes sense, but just to make sure I understand this correctly:
All that needs to be done is call dma_set_mask_and_coherent with a 64 bit
mask and then just ignore the return value?


Thanks,

Sven
