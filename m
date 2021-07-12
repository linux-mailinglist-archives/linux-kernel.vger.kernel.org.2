Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64303C5B21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhGLLFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:05:37 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35873 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234923AbhGLLFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:05:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 91254580AF9;
        Mon, 12 Jul 2021 07:02:46 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Mon, 12 Jul 2021 07:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=7XyyQqaPm43E+iSA6HEfleHFR36O
        XWaTALDg2LKUkgk=; b=xwjCPhQd0xWBFg4xsAE2OGMHZIACEIN1AJC4/+P1tGFa
        zFL9zncOUF+88bPV4qC+v3E7iAk/B35NTHUyEOSkRgG7DSSWNVNPahmq1x1xIyt8
        4izt0VYsxKGG+T46UjGfpIaKfZZ8Es+pEE3BrhqUGS7NrwHItHj7ziHDqLCk5yO5
        BX+j+ak2TQILZEpGSnmaTz8D8iZNqvD9hKOGjsXr++0eL8e/9vH9MZhsMLb6F3Lm
        b1N5B6ApWbQAr81c0TUy+atLA/e2NCg0RhEgz+5avim4jRUbr/EbCUjk7N5e5VHr
        LbbySTBnDLc9v/AOt3UjWzA4FeKCRsE0CDoOLA5yng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7XyyQq
        aPm43E+iSA6HEfleHFR36OXWaTALDg2LKUkgk=; b=ouodfEzeihWXi3YKhCGJZb
        3fslL+cRjTPE3SGqWePpDDraM1i8uBW7MNNt9ObldK51+CKThOEA+xoBsIwyrEOz
        rjcnOgpxvNKQlv3ZRKmqJFQk48dBEDdlzgnevSfYpdfNy6aEMRDbWeKHZsSjAQ6s
        zzOs35CsOfDIQkV0yIVkYU8lancSJLXt1Ih04iiN0+jJUGDELJWZBt2U3SEPFpVo
        CPYkW1LNkeKgY7ToNMwfWrbrZ7m+FSW29OqJsbsh/fVculWVsWOuhOxU/YTQEct2
        twiAkhSj+LxuB5iSs4FrpVv5wg5e+fzmMcb2oa8D/lNbjtCQkPA9oAJmqPF1Zu5Q
        ==
X-ME-Sender: <xms:VCHsYA9j-VSGyScKqbwUdt9sdp3bXneZd2nejh2qEDZXx_yH_9Kr-Q>
    <xme:VCHsYIvD-NiUWimqxHR6JGRvKR4Ve-vh7YB_JIQ94-X8N_1IXhakNvoTF2RNYB7_1
    GXYda5R1h4bdm7tqV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:VCHsYGB8HqcvOxogMoO8DO4BapMlpVjlA1jc7UMGbCFoZgbPXXqDmg>
    <xmx:VCHsYAehHLkhao02W5b4WQdO4XiqlfIM8Xdbv0TTx8E1nlu-w64Ufg>
    <xmx:VCHsYFOelErVvdihV7A_Wm3nrBKOp2eWiNgYaY8YmkuRRaOWE7af2w>
    <xmx:ViHsYGv8DWHIuMz381N0ZC19MlCwPID0_5WLnpeWGpRLhGqtQNZAHQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D489951C0060; Mon, 12 Jul 2021 07:02:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-531-g1160beca77-fm-20210705.001-g1160beca
Mime-Version: 1.0
Message-Id: <16ffb4ec-86a4-4300-b175-5d7a1fcbf994@www.fastmail.com>
In-Reply-To: <YNx2U4GPoKxV3PWd@maud>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-4-sven@svenpeter.dev> <YNx2U4GPoKxV3PWd@maud>
Date:   Mon, 12 Jul 2021 13:02:24 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Alyssa Rosenzweig" <alyssa@collabora.com>
Cc:     "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Arnd Bergmann" <arnd@kernel.org>, devicetree@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        "Marc Zyngier" <maz@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Petr Mladek via iommu" <iommu@lists.linux-foundation.org>,
        "Alexander Graf" <graf@amazon.com>,
        "Alyssa Rosenzweig" <alyssa.rosenzweig@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Rouven Czerwinski" <r.czerwinski@pengutronix.de>
Subject: Re: [PATCH v4 3/3] iommu: dart: Add DART iommu driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Wed, Jun 30, 2021, at 15:49, Alyssa Rosenzweig wrote:
> Looks really good! Just a few minor comments. With them addressed,
> 
> 	Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Thanks!

> 
> > +	  Say Y here if you are using an Apple SoC with a DART IOMMU.
> 
> Nit: Do we need to spell out "with a DART IOMMU"? Don't all the apple
> socs need DART?

Good point, I'll remove it.

> 
> > +/*
> > + * This structure is used to identify a single stream attached to a domain.
> > + * It's used as a list inside that domain to be able to attach multiple
> > + * streams to a single domain. Since multiple devices can use a single stream
> > + * it additionally keeps track of how many devices are represented by this
> > + * stream. Once that number reaches zero it is detached from the IOMMU domain
> > + * and all translations from this stream are disabled.
> > + *
> > + * @dart: DART instance to which this stream belongs
> > + * @sid: stream id within the DART instance
> > + * @num_devices: count of devices attached to this stream
> > + * @stream_head: list head for the next stream
> > + */
> > +struct apple_dart_stream {
> > +	struct apple_dart *dart;
> > +	u32 sid;
> > +
> > +	u32 num_devices;
> > +
> > +	struct list_head stream_head;
> > +};
> 
> It wasn't obvious to me why we can get away without reference counting.
> Looking ahead it looks like we assert locks in each case. Maybe add
> that to the comment?

Sure, I'll add that to the comment.

> 
> ```
> > +static void apple_dart_hw_set_ttbr(struct apple_dart *dart, u16 sid, u16 idx,
> > +				   phys_addr_t paddr)
> > +{
> > +	writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
> > +	       dart->regs + DART_TTBR(sid, idx));
> > +}
> ```
> 
> Should we be checking alignment here? Something like
> 
>     BUG_ON(paddr & ((1 << DART_TTBR_SHIFT) - 1));
> 

Sure, right now paddr will always be aligned but adding that
BUG_ON doesn't hurt :)



Best,

Sven
