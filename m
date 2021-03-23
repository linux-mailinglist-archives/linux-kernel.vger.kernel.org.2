Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42ED346AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhCWVFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:05:52 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:38611 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233460AbhCWVFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:05:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 869E65808F8;
        Tue, 23 Mar 2021 17:05:28 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Tue, 23 Mar 2021 17:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=7AwKQ20yTUlj5ILOqFiSR0NWHgZy
        DvHCZx+iOwKTD9A=; b=33vdjbL9sLaxm4AVMCxAQw5cEedmH7+oy/Fol1wpmhlj
        KdbaZ6dLGDLHYxj6iX6SCtu7c6rgc/fZ/I/6st7CLWfCeM+kQ4Qs3YTS/VZ4gLpx
        0c2qsGmGZAOVGdQw/3mLVJ0SzX18hvoTGg60spR3+6A59D8wcoXHAB7OI56wzTVL
        9MsRSi/+3NNH+YSeak3vpzpGZe545A5O3vnz0GXTsSn7EarKaOX+U4H9PgVMOaJf
        RT3gTktsyPdWLhnGjG1Vw8fh5URfj9u8WeovTGLk1cOzIScIoAN+2N6gZdQfMtFe
        RNY9jl5HcdkWZ6f+p8CfwwlvlfNzkTg/kjxObDoEfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7AwKQ2
        0yTUlj5ILOqFiSR0NWHgZyDvHCZx+iOwKTD9A=; b=PVMsmS///9y5o8YHEheE21
        Ehga8Q/Dd7zacqoBBQsG7g05XKAjstaEXqWdfvEq+y2wiU/RfJtTCR80j6M5EqtZ
        pT4k96c5LTlTpM8DhSyb9gX3AN6dnX2QjQ3/Noftpaaof+2bX2ALJhsvllnWxacS
        Z3wIm/j3W4TnyingfrbcOtBBmvzB4j2q3V4GGmNl07PJ1el7p2bp44PLhqdndp43
        0fL/oBYye5E9Lj/1n4SYNYjmmdUhQfi8TCCHZNndfnF5KJw5SnKLhvP7qb4k0Pp5
        P5HlkGIYXwnjtjMGMc2FKAWqx33tgAqiJ2uFsUNODZMch2Q5hLJ4nJay+y8gsdgg
        ==
X-ME-Sender: <xms:FlhaYCbdxiCd3Xy-QRdw1eFowKJpQjPqM_2gyz0bSSZtoKH2xwIGBg>
    <xme:FlhaYFZpWroX_2mhT2wHqTBJ7TOOsKlW3xax4OoEmqxEckesCbX_vcR2vbm-MIPVI
    wc9r6SJ0k1oyOWgJxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegiedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:FlhaYM91yjkKujZIiGQXQwr4p0AzmHmCl4Y15vufH5r-wMXDO3xcLw>
    <xmx:FlhaYEqPw-LOLHpPTlOLJWFp0IMDzhSVOezJZ8_rSBVA4CwcyyHvkA>
    <xmx:FlhaYNpCfMBJ-mlHOLKLkuMZOH_YS14lW5PhOK6Ut9Hnm_ToFHeTxg>
    <xmx:GFhaYOQSV0XszcUHR0EH4S7HdHZdWCw1IEnnt2PPdxowpn5ZQsDhkkHU8QQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 30D0E51C005F; Tue, 23 Mar 2021 17:05:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <1a2da66b-221a-404f-a0af-d2b247ced0b0@www.fastmail.com>
In-Reply-To: <c1bcca33753f71d3@bloch.sibelius.xs4all.nl>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <8360b3b3-296c-450d-abc3-bb47159bf4e1@www.fastmail.com>
 <c1bcc0be8ae6e500@bloch.sibelius.xs4all.nl>
 <d280843b-77e3-4fa8-9452-5a2f8a45052e@www.fastmail.com>
 <c1bcca33753f71d3@bloch.sibelius.xs4all.nl>
Date:   Tue, 23 Mar 2021 22:03:45 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Mark Kettenis" <mark.kettenis@xs4all.nl>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, robh+dt@kernel.org,
        "Arnd Bergmann" <arnd@kernel.org>, marcan@marcan.st,
        "Marc Zyngier" <maz@kernel.org>, mohamed.mediouni@caramail.com,
        stan@corellium.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Mar 23, 2021, at 21:00, Mark Kettenis wrote:
> The problem with both #1 and #2 is that you end up with two references
> to (effectively) different iommu's in the dwc3 device node.  I don't
> see how that is compatible with the idea of using a single translation
> table for both sub-DARTs.

I don't have a strong opinion about this fwiw.
Option #1 and #2 seem to have precedence in the already existing
iommu bindings though [1,2,3].
I just want to make sure we've thought through all options and understand
their advantages/disadvantages before we take a decision.


I've been reading some more Linux iommu code and here's how I understand
it now / how I could implement at least #1 with a single shared pagetable.
This might also be possible for option #2, but I'll need to think that through
in more detail.

An iommu domain is a collection of devices that share a virtual address space.
During domain allocation I can just allocate a single DART pagetable and
not have anything point to it for now.

A stream identifies the smallest unit the iommu hardware can differentiate.
For the DART we have 16 of these with a single TCR + the four TTBR register
for each stream.

A device is assigned to individual streams using the "iommus" property. When
a device is attached to a domain we now simply setup the TTBR registers to
point to the iommu domain pagetable. It doesn't matter here if it's a single
stream or multiple ones or even multiple devices sharing a single stream as
long as they're attached to the same domain.

All operations (map, unmap, etc.) now simply first modify the domain
pagetable and then issue the TLB maintenance operations for attached streams.


> 
> If you no longer think that is desirable, you'll still have the
> problem that you'll need to modify the dwc3 driver code such that it
> uses the right IOMMU to do its DMA address translation.  Given what
> you write above that sounds really ugly and confusing.  I would
> certainly want to avoid doing that in OpenBSD.

Yeah, I absolutely don't want to hack on the dwc3 code at all.
That will end up being *very* ugly.



Best,

Sven


[1] Documentation/devicetree/bindings/iommu/iommu.txt "Multiple-master IOMMU"
[2] Documentation/devicetree/bindings/qcom,iommu.txt last example
[3] Documentation/devicetree/bindings/arm,smmu.yaml first example
