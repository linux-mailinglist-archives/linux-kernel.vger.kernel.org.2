Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D14C3C89E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhGNRnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:43:08 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33995 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhGNRnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:43:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 59CA2580A6F;
        Wed, 14 Jul 2021 13:40:15 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 14 Jul 2021 13:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=jCX74UgdqAO5ih1wL2WZjVTsL6wF
        OXIZazNpVZLX4KM=; b=whOY2qX0MxDBLiN7pHSESTpi1t8ZQd0kBHsYLG3l9QZz
        aNLJus7YQrbreO4k2GVk1u8i6Y8h1YEcHOT8uHi5TPTM/SUx45HltuOYinZIS405
        9Sjc1J09Cq1RI4wbP539EmoN7jXE/hQuKp/Srb/Q+Tub74lCe/zUYoCcAdAT2MzX
        W4DLanp1oBG90fNdDHIh/WCsBg91vkQCmG+IajdJ9HrHbxKJXbe6HB5Rini9xHs5
        aqGzBjfnnt3xIDowJ1ECRr/Wi0N2Tdm9Mmhj0F+vGjPlNS5Zm1Aqf4aVMNg4yrVN
        YwVVgjUtIl4dIL8AjcIfiqk3L6Y/gziiwheOyzu6/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jCX74U
        gdqAO5ih1wL2WZjVTsL6wFOXIZazNpVZLX4KM=; b=IEoCu4rUG+hjgDSjRuLuse
        aPHzEPjQ8GVwhrIyy5wUGRk/VRFsFtOkU3nHK0AQBaXunMg6xgunTDTLl535AKrb
        L7t3qDsZnE1+RZi/BdwlUFIPNPKPldNHZ7c1POMmFcr3BrnPLCFMIos7Xc0XAjZ4
        o+dynyLw0vak/skyQ33RXKHdV0HLPb2nOpgvupLdipudupBaxhsaDaXHDFyaFeXm
        OHnwgePlh+E0skJNiM8ZPtcRqgHFrYHHmdUm3UcGFS/mxs2Y5JftcccDh2OSBBXk
        TkjRBd+ckGM2U9UDHEfqVxdxnP5EDyxa9XYfU60906fqOCZ6G9lHk6OpRnFCwpkQ
        ==
X-ME-Sender: <xms:fSHvYOiE9NQ5pHpQ7mjMujnCQOH5CpQ4Q4JxtS0gBOLgguqzsKu5zQ>
    <xme:fSHvYPAiW1kY36a9GEWteJwzWUYzcLhPLVribq9r-9ox95oafDGvQM9t1T9yMXrGc
    qeM1Dicg787ME965fI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:fSHvYGHY0TnBs9aqHxE98NhG1UwLNXaBKNLV9epUCuOC86Beem8J7Q>
    <xmx:fSHvYHSzDwMulsijllycHkdI0hrmXcJi9gp8lHZl0BdNbBH39MTTlw>
    <xmx:fSHvYLxkHaxwiRPRvncYBPwmw_0nyjqcxgBdKDpI8MSgmu_9x2DCtw>
    <xmx:fyHvYALY0C_nhF8621_MXJtvTNCYTkWTqJHOn2ed5Phz86QiCedxuw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2685851C0060; Wed, 14 Jul 2021 13:40:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-533-gf73e617b8a-fm-20210712.002-gf73e617b
Mime-Version: 1.0
Message-Id: <d3fded2b-8f03-4848-a7ef-22884717ac39@www.fastmail.com>
In-Reply-To: <e7dd955b-ae6b-bd1f-bf1f-4a1df61f1fc6@arm.com>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-2-sven@svenpeter.dev>
 <e7dd955b-ae6b-bd1f-bf1f-4a1df61f1fc6@arm.com>
Date:   Wed, 14 Jul 2021 19:39:48 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>, "Joerg Roedel" <joro@8bytes.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>, devicetree@vger.kernel.org,
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
Subject: Re: [PATCH v4 1/3] iommu: io-pgtable: add DART pagetable format
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 13, 2021, at 21:17, Robin Murphy wrote:
> On 2021-06-27 15:34, Sven Peter wrote:
> > Apple's DART iommu uses a pagetable format that shares some
> > similarities with the ones already implemented by io-pgtable.c.
> > Add a new format variant to support the required differences
> > so that we don't have to duplicate the pagetable handling code.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 62 ++++++++++++++++++++++++++++++++++
> >   drivers/iommu/io-pgtable.c     |  1 +
> >   include/linux/io-pgtable.h     |  7 ++++
> >   3 files changed, 70 insertions(+)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 87def58e79b5..1dd5c45b4b5b 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -127,6 +127,9 @@
> >   #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
> >   #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
> >   
> > +#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
> > +#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
> > +
> >   /* IOPTE accessors */
> >   #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
> >   
> > @@ -381,6 +384,15 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
> >   {
> >   	arm_lpae_iopte pte;
> >   
> > +	if (data->iop.fmt == ARM_APPLE_DART) {
> > +		pte = 0;
> > +		if (!(prot & IOMMU_WRITE))
> > +			pte |= APPLE_DART_PTE_PROT_NO_WRITE;
> > +		if (!(prot & IOMMU_READ))
> > +			pte |= APPLE_DART_PTE_PROT_NO_READ;
> > +		return pte;
> > +	}
> > +
> >   	if (data->iop.fmt == ARM_64_LPAE_S1 ||
> >   	    data->iop.fmt == ARM_32_LPAE_S1) {
> >   		pte = ARM_LPAE_PTE_nG;
> > @@ -1043,6 +1055,51 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> >   	return NULL;
> >   }
> >   
> > +static struct io_pgtable *
> > +apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> > +{
> > +	struct arm_lpae_io_pgtable *data;
> > +	int i;
> > +
> > +	if (cfg->oas > 36)
> > +		return NULL;
> > +
> > +	data = arm_lpae_alloc_pgtable(cfg);
> > +	if (!data)
> > +		return NULL;
> > +
> > +	/*
> > +	 * Apple's DART always requires three levels with the first level being
> > +	 * stored in four MMIO registers. We always concatenate the first and
> > +	 * second level so that we only have to setup the MMIO registers once.
> > +	 * This results in an effective two level pagetable.
> > +	 */
> 
> Nit: I appreciate the effort to document the weirdness, but this comment 
> did rather mislead me initially, and now that I (think I) understand how 
> things work it seems a bit backwards. Could we say something like:
> 
>    "The table format itself always uses two levels, but the total VA
>     space is mapped by four separate tables, making the MMIO registers
>     an effective "level 1". For simplicity, though, we treat this
>     equivalently to LPAE stage 2 concatenation at level 2, with the
>     additional TTBRs each just pointing at consecutive pages."
> 
> ?
> 

Sure, your version is much easier to understand! Thanks.

> > +	if (data->start_level < 1)
> > +		return NULL;
> > +	if (data->start_level == 1 && data->pgd_bits > 2)
> > +		return NULL;
> > +	if (data->start_level > 1)
> > +		data->pgd_bits = 0;
> > +	data->start_level = 2;
> > +	cfg->apple_dart_cfg.n_ttbrs = 1 << data->pgd_bits;
> > +	data->pgd_bits += data->bits_per_level;
> > +
> > +	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
> > +					   cfg);
> > +	if (!data->pgd)
> > +		goto out_free_data;
> > +
> > +	for (i = 0; i < cfg->apple_dart_cfg.n_ttbrs; ++i)
> > +		cfg->apple_dart_cfg.ttbr[i] =
> > +			virt_to_phys(data->pgd + i * ARM_LPAE_GRANULE(data));
> > +
> > +	return &data->iop;
> > +
> > +out_free_data:
> > +	kfree(data);
> > +	return NULL;
> > +}
> > +
> >   struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
> >   	.alloc	= arm_64_lpae_alloc_pgtable_s1,
> >   	.free	= arm_lpae_free_pgtable,
> > @@ -1068,6 +1125,11 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
> >   	.free	= arm_lpae_free_pgtable,
> >   };
> >   
> > +struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns = {
> > +	.alloc	= apple_dart_alloc_pgtable,
> > +	.free	= arm_lpae_free_pgtable,
> > +};
> > +
> >   #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
> >   
> >   static struct io_pgtable_cfg *cfg_cookie __initdata;
> > diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> > index 6e9917ce980f..fd8e6bd6caf9 100644
> > --- a/drivers/iommu/io-pgtable.c
> > +++ b/drivers/iommu/io-pgtable.c
> > @@ -20,6 +20,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
> >   	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
> >   	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
> >   	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
> > +	[ARM_APPLE_DART] = &io_pgtable_apple_dart_init_fns,
> >   #endif
> >   #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
> >   	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
> > diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> > index 4d40dfa75b55..a4bfac7f85f7 100644
> > --- a/include/linux/io-pgtable.h
> > +++ b/include/linux/io-pgtable.h
> > @@ -16,6 +16,7 @@ enum io_pgtable_fmt {
> >   	ARM_V7S,
> >   	ARM_MALI_LPAE,
> >   	AMD_IOMMU_V1,
> > +	ARM_APPLE_DART,
> 
> s/ARM_// - this is pure Apple ;)
> 
> With that fixed and hopefully a somewhat clarified comment above,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

True, I'll remove the ARM_ prefix and also change the commit message to match the
subsystem style as mentioned in your reply for the third patch.

Thanks for the review!

> 
> >   	IO_PGTABLE_NUM_FMTS,
> >   };
> >   
> > @@ -136,6 +137,11 @@ struct io_pgtable_cfg {
> >   			u64	transtab;
> >   			u64	memattr;
> >   		} arm_mali_lpae_cfg;
> > +
> > +		struct {
> > +			u64 ttbr[4];
> > +			u32 n_ttbrs;
> > +		} apple_dart_cfg;
> >   	};
> >   };
> >   
> > @@ -246,5 +252,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
> >   extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
> >   extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
> >   extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
> > +extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
> >   
> >   #endif /* __IO_PGTABLE_H */
> > 
> 


Sven
