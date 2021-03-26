Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75A934AC53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhCZQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:10:59 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35395 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230080AbhCZQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:10:52 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E57C058081B;
        Fri, 26 Mar 2021 12:10:51 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Fri, 26 Mar 2021 12:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=ydSKVsbgvF7jbPFgx/6CxB2ZQoad
        D/zDEYXlE4rQ4+M=; b=bWJPooEIpn0MwMMFQLSn7CNEsyRZ458l39Bvcp2b+FkU
        U014axn4wWCyjs55Q7ppwoNE7X/zYkICbiLxgElKTVJA2uHsZpyW7F8RfPoncuDa
        pmUYLbgHcPyX/Kheu4DVLyYokUM4j/Wjkl79GT8QEzM+q9GKXz9ZftP88bLZfdtk
        QCsHvqBfA/BK5pYfS5Tt4l/k0NcFqJe+DXSo21qElqUD6OxRDRqqWdP6+SyI+Zg7
        1VomAkHicAVg1XoMeLR4ma18uVhB9rVFZAy09XlwRpEXdh2U+R1utWVY8XPSqpML
        nDL3r6hxlc/8DNw8CDFwSSXNKL5WorBG8EbUo1NebA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ydSKVs
        bgvF7jbPFgx/6CxB2ZQoadD/zDEYXlE4rQ4+M=; b=aaZt7fpnHn+6HG7GPQd/fK
        HwGycVf+4SgEU0/WXqVzn5JcSoQOAarNNqRKjCmnqkdQq/lo2u+XEKfh8O8fv9px
        wMEH/2MH7ToF2Nr3j0vwySALiYQhEdfNhmU1hHrr2eugol1ukbyoLrjM4V/ycO+D
        eAYuSRZgZ3AI9FKUxBu1QLgteow4eS8V+lnDKhcMCmQmFT9uWpETtGiaxjDyCMkG
        n9Qt8r3FbLyoceP/xrzu9gDRxAC7lgiC4OU13uvVHgHomFKU+y9FZKv/gvLWyVeX
        gfC0bb39ajLK0q7y1nYMHrpicPimy3DfQL/c4Ouyrc7QqnF0eiGA73qFEjLJ37Sg
        ==
X-ME-Sender: <xms:iQdeYLsHrDgf--H1Ek0pQghFMA_VQX-u5b3OL_J_KgXbf0TyoynUYw>
    <xme:iQdeYMdoi0KjqAmitX98JooDnmkGC5_JewtKz3WkTl-cRm-rMAwcUUhNqvxQbBLMb
    _ikKr0Eg7I7EKAgfEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehvddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:iQdeYOy-UrYEpxUk7FignU1Cb6nqOly_ZDnv3s-jPoHWDJH6h7mMiQ>
    <xmx:iQdeYKO-NuchSDfCle5TT0KH8p2JRm7k2ZeeSVlQ_nbculalqOYd6A>
    <xmx:iQdeYL9hHfaQBRCifL1hKSHYCHwd7ahPLTlnD5ctFf__lRh4Hp1_4g>
    <xmx:iwdeYKVaB1qgxIudhtH2B9dKQ5zQKK6ZQKI4wheTo_m5qC2e2jhprSieqTA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6BB4451C005E; Fri, 26 Mar 2021 12:10:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <9f06872d-f0ec-43c3-9b53-d144337100b3@www.fastmail.com>
In-Reply-To: <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org>
 <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
 <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl>
Date:   Fri, 26 Mar 2021 17:10:29 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Rob Herring" <robh@kernel.org>, iommu@lists.linux-foundation.org,
        joro@8bytes.org, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Marc Zyngier" <maz@kernel.org>, mohamed.mediouni@caramail.com,
        stan@corellium.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Mar 26, 2021, at 16:59, Mark Kettenis wrote:
> Some of the DARTs provide a bypass facility.  That code make using the
> standard "dma-ranges" property tricky.  That property would need to
> contain the bypass address range.  But that would mean that if the
> DART driver needs to look at that property to figure out the address
> range that supports translation it will need to be able to distinguish
> between the translatable address range and the bypass address range.

Do we understand if and why we even need to bypass certain streams?
And do you have an example for a node in the ADT that contains this bypass range?

I've only seen nodes with "bypass" and "bypass-adress" but that could just be
some software abstraction Apple uses which doesn't map well to Linux or other OSes
and might not even be required here.


Sven

