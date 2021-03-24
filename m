Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1773347DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhCXQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:38:26 -0400
Received: from foss.arm.com ([217.140.110.172]:36060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235159AbhCXQiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:38:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6786D6E;
        Wed, 24 Mar 2021 09:38:07 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98D4F3F7D7;
        Wed, 24 Mar 2021 09:38:05 -0700 (PDT)
Subject: Re: [PATCH 1/3] iommu: io-pgtable: add DART pagetable format
To:     Sven Peter <sven@svenpeter.dev>, iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <20210320151903.60759-2-sven@svenpeter.dev>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2e7e4002-4f37-9348-40e6-aaa523207472@arm.com>
Date:   Wed, 24 Mar 2021 16:37:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210320151903.60759-2-sven@svenpeter.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-20 15:19, Sven Peter wrote:
> Apple's DART iommu uses a pagetable format that's very similar to the ones
> already implemented by io-pgtable.c.
> Add a new format variant to support the required differences.

TBH there look to be more differences than similarities, but I guess we 
already opened that door with the Mali format, and nobody likes writing 
pagetable code :)

> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>   drivers/iommu/Kconfig          | 13 +++++++
>   drivers/iommu/io-pgtable-arm.c | 70 ++++++++++++++++++++++++++++++++++
>   drivers/iommu/io-pgtable.c     |  3 ++
>   include/linux/io-pgtable.h     |  6 +++
>   4 files changed, 92 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 192ef8f61310..3c95c8524abe 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -39,6 +39,19 @@ config IOMMU_IO_PGTABLE_LPAE
>   	  sizes at both stage-1 and stage-2, as well as address spaces
>   	  up to 48-bits in size.
> 
> +config IOMMU_IO_PGTABLE_APPLE_DART

Does this really need to be configurable? I don't think there's an 
appreciable code saving to be had, and it's not like we do it for any of 
the other sub-formats.

> +	bool "Apple DART Descriptor Format"
> +	select IOMMU_IO_PGTABLE
> +	select IOMMU_IO_PGTABLE_LPAE
> +	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	help
> +	  Enable support for the Apple DART iommu pagetable format.
> +	  This format is a variant of the ARMv7/v8 Long Descriptor
> +	  Format specific to Apple's iommu found in their SoCs.
> +
> +	  Say Y here if you have a Apple SoC like the M1 which
> +	  contains DART iommus.
> +
>   config IOMMU_IO_PGTABLE_LPAE_SELFTEST
>   	bool "LPAE selftests"
>   	depends on IOMMU_IO_PGTABLE_LPAE
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 87def58e79b5..18674469313d 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -127,6 +127,10 @@
>   #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
>   #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
> 
> +/* APPLE_DART_PTE_PROT_NO_WRITE actually maps to ARM_LPAE_PTE_AP_RDONLY  */
> +#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
Given that there's apparently zero similarity with any of the other 
attributes/permissions, this seems more like a coincidence that probably 
doesn't need to be called out.

> +#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
> +

Do you have XN permission? How about memory type attributes?

>   /* IOPTE accessors */
>   #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
> 
> @@ -381,6 +385,17 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>   {
>   	arm_lpae_iopte pte;
> 
> +#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART

As a general tip, prefer IS_ENABLED() to inline #ifdefs.

> +	if (data->iop.fmt == ARM_APPLE_DART) { > +		pte = 0;
> +		if (!(prot & IOMMU_WRITE))
> +			pte |= APPLE_DART_PTE_PROT_NO_WRITE;
> +		if (!(prot & IOMMU_READ))
> +			pte |= APPLE_DART_PTE_PROT_NO_READ;
> +		return pte;
> +	}
> +#endif
> +
>   	if (data->iop.fmt == ARM_64_LPAE_S1 ||
>   	    data->iop.fmt == ARM_32_LPAE_S1) {
>   		pte = ARM_LPAE_PTE_nG;
> @@ -1043,6 +1058,54 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>   	return NULL;
>   }
> 
> +#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART

Similarly, prefer __maybe_unused rather than #ifdefing functions if they 
don't contain any config-dependent references.

> +static struct io_pgtable *
> +apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> +{
> +	struct arm_lpae_io_pgtable *data;
> +
> +	if (cfg->ias > 38)
> +		return NULL;
> +	if (cfg->oas > 36)
> +		return NULL;
> +
> +	if (!cfg->coherent_walk)
> +		return NULL;

For completeness you should probably also reject any quirks, since none 
of them are applicable either.

> +
> +	cfg->pgsize_bitmap &= SZ_16K;

No block mappings?

> +	if (!cfg->pgsize_bitmap)
> +		return NULL;
> +
> +	data = arm_lpae_alloc_pgtable(cfg);
> +	if (!data)
> +		return NULL;
> +
> +	/*
> +	 * the hardware only supports this specific three level pagetable layout with
> +	 * the first level being encoded into four hardware registers
> +	 */
> +	data->start_level = ARM_LPAE_MAX_LEVELS - 2;

The comment implies that walks should start at level 1 (for a 3-level 
table), but the code here says (in an unnecessarily roundabout manner) 
level 2 :/

Which is it?

> +	data->pgd_bits = 13;

What if ias < 38? Couldn't we get away with only allocating as much as 
we actually need?

> +	data->bits_per_level = 11;
> +
> +	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
> +					   cfg);
> +	if (!data->pgd)
> +		goto out_free_data;
> +
> +	cfg->apple_dart_cfg.pgd[0] = virt_to_phys(data->pgd);
> +	cfg->apple_dart_cfg.pgd[1] = virt_to_phys(data->pgd + 0x4000);
> +	cfg->apple_dart_cfg.pgd[2] = virt_to_phys(data->pgd + 0x8000);
> +	cfg->apple_dart_cfg.pgd[3] = virt_to_phys(data->pgd + 0xc000);
> +
> +	return &data->iop;
> +
> +out_free_data:
> +	kfree(data);
> +	return NULL;
> +}
> +#endif
> +
>   struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
>   	.alloc	= arm_64_lpae_alloc_pgtable_s1,
>   	.free	= arm_lpae_free_pgtable,
> @@ -1068,6 +1131,13 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
>   	.free	= arm_lpae_free_pgtable,
>   };
> 
> +#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
> +struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns = {
> +	.alloc	= apple_dart_alloc_pgtable,
> +	.free	= arm_lpae_free_pgtable,
> +};
> +#endif
> +
>   #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
> 
>   static struct io_pgtable_cfg *cfg_cookie __initdata;
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index 6e9917ce980f..d86590b0673a 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -27,6 +27,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
>   #ifdef CONFIG_AMD_IOMMU
>   	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
>   #endif
> +#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
> +	[ARM_APPLE_DART] = &io_pgtable_apple_dart_init_fns,
> +#endif
>   };
> 
>   struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index a4c9ca2c31f1..19d9b631d319 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -16,6 +16,7 @@ enum io_pgtable_fmt {
>   	ARM_V7S,
>   	ARM_MALI_LPAE,
>   	AMD_IOMMU_V1,
> +	ARM_APPLE_DART,
>   	IO_PGTABLE_NUM_FMTS,
>   };
> 
> @@ -136,6 +137,10 @@ struct io_pgtable_cfg {
>   			u64	transtab;
>   			u64	memattr;
>   		} arm_mali_lpae_cfg;
> +
> +		struct {
> +			u64 pgd[4];

Nit: in the driver you call the registers "TTBR" rather than "PGD". The 
config here tries to represent hardware/architecture definitions rather 
than internal abstractions.

Robin.

> +		} apple_dart_cfg;
>   	};
>   };
> 
> @@ -250,5 +255,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
> +extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
> 
>   #endif /* __IO_PGTABLE_H */
> --
> 2.25.1
> 
> 
