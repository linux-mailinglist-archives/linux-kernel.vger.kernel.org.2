Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E032A4E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbhCBLUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 06:20:37 -0500
Received: from foss.arm.com ([217.140.110.172]:49570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383247AbhCBLIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:08:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27DBAED1;
        Tue,  2 Mar 2021 03:07:23 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9C703F73C;
        Tue,  2 Mar 2021 03:07:20 -0800 (PST)
Subject: Re: [RFC 09/13] iommu/arm-smmu: Make use of
 dev_64bit_mmio_supported()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, ardb@kernel.org,
        hch@infradead.org, narmstrong@baylibre.com, dwmw2@infradead.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com, arnd@arndb.de,
        will@kernel.org
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
 <20210226140305.26356-10-nsaenzjulienne@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3a4cf13f-c098-9ff3-6c0e-2c94daae452b@arm.com>
Date:   Tue, 2 Mar 2021 11:07:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226140305.26356-10-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-26 14:03, Nicolas Saenz Julienne wrote:
> Some arm SMMU implementations might sit on a bus that doesn't support
> 64bit memory accesses. In that case default to using hi_lo_{readq,
> writeq}() and BUG if such platform tries to use AArch64 formats as they
> rely on writeq()'s atomicity.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu.h | 9 +++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d8c6bfde6a61..239ff42b20c3 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1889,6 +1889,15 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
>   	}
>   
> +	/*
> +	 * 64bit accesses not possible through the interconnect, AArch64
> +	 * formats depend on it.
> +	 */
> +	BUG_ON(!dev_64bit_mmio_supported(smmu->dev) &&
> +	       smmu->features & (ARM_SMMU_FEAT_FMT_AARCH64_4K |
> +				ARM_SMMU_FEAT_FMT_AARCH64_16K |
> +				ARM_SMMU_FEAT_FMT_AARCH64_64K));

No. Crashing the kernel in a probe routine which is free to fail is 
unacceptable either way, but guaranteeing failure in the case that the 
workaround *would* be required is doubly so.

Basically, this logic is backwards - if you really wanted to handle it 
generically, this would be the point at which you'd need to actively 
suppress all the detected hardware features which depend on 64-bit 
atomicity, not complain about them.

> +
>   	if (smmu->impl && smmu->impl->cfg_probe) {
>   		ret = smmu->impl->cfg_probe(smmu);
>   		if (ret)
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index d2a2d1bc58ba..997d13a21717 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -477,15 +477,20 @@ static inline void arm_smmu_writel(struct arm_smmu_device *smmu, int page,
>   {
>   	if (smmu->impl && unlikely(smmu->impl->write_reg))
>   		smmu->impl->write_reg(smmu, page, offset, val);
> -	else
> +	else if (dev_64bit_mmio_supported(smmu->dev))
>   		writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
> +	else
> +		hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);

As Arnd pointed out, this is in completely the wrong place. Also, in 
general it doesn't work if the implementation already needs a hook to 
filter or override register accesses for any other reason. TBH I'm not 
convinced that this isn't *more* of a mess than handling it on a 
SoC-specific basis...

Robin.

>   }
>   
>   static inline u64 arm_smmu_readq(struct arm_smmu_device *smmu, int page, int offset)
>   {
>   	if (smmu->impl && unlikely(smmu->impl->read_reg64))
>   		return smmu->impl->read_reg64(smmu, page, offset);
> -	return readq_relaxed(arm_smmu_page(smmu, page) + offset);
> +	else if (dev_64bit_mmio_supported(smmu->dev))
> +		return readq_relaxed(arm_smmu_page(smmu, page) + offset);
> +	else
> +		return hi_lo_readq_relaxed(arm_smmu_page(smmu, page) + offset);
>   }
>   
>   static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
> 
