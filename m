Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD3635A400
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDIQux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:50:53 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42123 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234195AbhDIQuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:50:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1C619580820;
        Fri,  9 Apr 2021 12:50:35 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Fri, 09 Apr 2021 12:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=/tRhd4nT96NN65qLLACQUONSZaU+
        voT8hPuzE7VOEXA=; b=XP2D2yQFBRFN02eCaNV2a07K3M2o+2oBMkj1QyvJAra1
        WrpX9oq0AK/fq4Eh/oOs0efnMlq3X0LCunwT0AlAF9fmTQAzWqG7dm0AFPtDhvPf
        FWoHuCV7WOrQvanTfX+A4LuGv+Qi4Vv5q/H3hsHR2SrM3q+ANrix6HXA9g0J/A/8
        OPYtttP5BO6ahW7+ajD2zn1HWE+2isEynKRm4Q58t+YXKK+ENr2RPziPcjieml1O
        qX44MNnyWFJGYCEAF9pZI2CvgB/iJpuUfWLusFqHnC5FcDCwC14mboTkfJiZP2cB
        ELHNOyN88GlLRpHiRupCN01Ssbh6yaeIEfZnei+ckA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/tRhd4
        nT96NN65qLLACQUONSZaU+voT8hPuzE7VOEXA=; b=fKdpTyCVED5ZL/nDo3qtjx
        cxxnVfcDhmb5dsQx/UkmoK3kaD7OLAcaVeNzEj88nnpVmea/AXmGadD1XDO7XZUD
        qORAlRfKF3QAdR0T0LPDHL19riADbdObzl1XCDCZ5gCjULuS2oji+40pmrGh1dUR
        Zoi3ADyUc6ftO7HrkXZhn8+RXUeCLsZv6JK0qF1wwOO1KWQHSXIELMC1y0wz9V8j
        5Inc41ppRlt8S4wXNk7fKogNC7O35vBrUzW85TuPdyO+PRS4GhGMu0Bkn95mXusr
        fylOHcoeDt2H2HbGob54d3XUZi/w/URPxg4VAs7/xxMWw4U+yvOe3ug9Wc1moRzg
        ==
X-ME-Sender: <xms:2IVwYOOk5XRZ55prkxAaNTjwW9Vsk2tOF5KdDgthBhf1ZnoKPcaMeA>
    <xme:2IVwYM9CJTuvJ9StwIc2smBzfOajvxjFtzfjhAT93DXCg_inWtq9GCJPgrGJJ5XKZ
    Ju7K4aHwjztYpkwq0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepvedvgeevuddvvedvgfelfeegiedvgeehieeutdelvedvieevveeljeef
    vedtleehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:2IVwYFTEF7kV4WJeiCo771usTqOs9a9XFHC09UgIxex6EHSAh1YacQ>
    <xmx:2IVwYOt71UPl6yW2GPFfcuYSDiDKCZaxyaT8ozF26nw2B0huJc_kQA>
    <xmx:2IVwYGepIvLkYsmlUTQ7Z64EOiXYLfhhEndUOtAFe0nomUJsLZyskg>
    <xmx:2oVwYC1_KexD6Azt8i1PxNbWuaQ7r6733tn-FOSsWvUjAhWbEORzUlU3PyQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D740651C005F; Fri,  9 Apr 2021 12:50:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <10040e18-6e49-432b-b85c-bcc1345a5e18@www.fastmail.com>
In-Reply-To: <20210407104209.GA15173@willie-the-truck>
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-4-sven@svenpeter.dev>
 <20210407104209.GA15173@willie-the-truck>
Date:   Fri, 09 Apr 2021 18:50:12 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Will Deacon" <will@kernel.org>
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>, devicetree@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        "Marc Zyngier" <maz@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Petr Mladek via iommu" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2 3/3] iommu: dart: Add DART iommu driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Apr 7, 2021, at 12:42, Will Deacon wrote:
> On Sun, Mar 28, 2021 at 09:40:09AM +0200, Sven Peter wrote:
> > Apple's new SoCs use iommus for almost all peripherals. These Device
> > Address Resolution Tables must be setup before these peripherals can
> > act as DMA masters.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >  MAINTAINERS                      |   1 +
> >  drivers/iommu/Kconfig            |  14 +
> >  drivers/iommu/Makefile           |   1 +
> >  drivers/iommu/apple-dart-iommu.c | 858 +++++++++++++++++++++++++++++++
> >  4 files changed, 874 insertions(+)
> >  create mode 100644 drivers/iommu/apple-dart-iommu.c
> 
> [...]
> 
> > +/* must be called with held domain->lock */
> > +static int apple_dart_attach_stream(struct apple_dart_domain *domain,
> > +				    struct apple_dart *dart, u32 sid)
> > +{
> > +	unsigned long flags;
> > +	struct apple_dart_stream *stream;
> > +	struct io_pgtable_cfg *pgtbl_cfg;
> > +	int ret;
> > +
> > +	list_for_each_entry(stream, &domain->streams, stream_head) {
> > +		if (stream->dart == dart && stream->sid == sid) {
> > +			stream->num_devices++;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	spin_lock_irqsave(&dart->lock, flags);
> > +
> > +	if (WARN_ON(dart->used_sids & BIT(sid))) {
> > +		ret = -EINVAL;
> > +		goto error;
> > +	}
> > +
> > +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> > +	if (!stream) {
> > +		ret = -ENOMEM;
> > +		goto error;
> > +	}
> 
> Just in case you missed it, a cocci bot noticed that you're using GFP_KERNEL
> to allocate while holding a spinlock here:
> 
> https://lore.kernel.org/r/alpine.DEB.2.22.394.2104041724340.2958@hadrien
> 

Thanks for the reminder!
I haven't replied yet because that one was found later when the bot picked up
a (slightly earlier) version that Marc was using to bring up pcie I believe.
I'll fix it for the next version.


Sven
