Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D8632A537
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446599AbhCBMMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:12:22 -0500
Received: from foss.arm.com ([217.140.110.172]:50148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350137AbhCBLx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:53:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0905106F;
        Tue,  2 Mar 2021 03:41:00 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C1933FA00;
        Tue,  2 Mar 2021 03:40:58 -0800 (PST)
Subject: Re: [RFC 10/13] iommu/arm-smmu-impl: Get rid of Marvell's
 implementation details
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, ardb@kernel.org,
        hch@infradead.org, narmstrong@baylibre.com, dwmw2@infradead.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com, arnd@arndb.de,
        will@kernel.org
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
 <20210226140305.26356-11-nsaenzjulienne@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <96b6c3e4-d9d3-270e-6d8e-7c826ae11827@arm.com>
Date:   Tue, 2 Mar 2021 11:40:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226140305.26356-11-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-26 14:03, Nicolas Saenz Julienne wrote:
> arm-smmu can now deal with integrations on buses that don't support
> 64bit MMIO accesses. No need to create a special case for that on
> Marvell's integration.

This breaks compatibility with existing DTs.

Robin.

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 ---------------------
>   1 file changed, 21 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index 136872e77195..55d40e37e144 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -145,25 +145,6 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
>   	.reset = arm_mmu500_reset,
>   };
>   
> -static u64 mrvl_mmu500_readq(struct arm_smmu_device *smmu, int page, int off)
> -{
> -	/*
> -	 * Marvell Armada-AP806 erratum #582743.
> -	 * Split all the readq to double readl
> -	 */
> -	return hi_lo_readq_relaxed(arm_smmu_page(smmu, page) + off);
> -}
> -
> -static void mrvl_mmu500_writeq(struct arm_smmu_device *smmu, int page, int off,
> -			       u64 val)
> -{
> -	/*
> -	 * Marvell Armada-AP806 erratum #582743.
> -	 * Split all the writeq to double writel
> -	 */
> -	hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + off);
> -}
> -
>   static int mrvl_mmu500_cfg_probe(struct arm_smmu_device *smmu)
>   {
>   
> @@ -181,8 +162,6 @@ static int mrvl_mmu500_cfg_probe(struct arm_smmu_device *smmu)
>   }
>   
>   static const struct arm_smmu_impl mrvl_mmu500_impl = {
> -	.read_reg64 = mrvl_mmu500_readq,
> -	.write_reg64 = mrvl_mmu500_writeq,
>   	.cfg_probe = mrvl_mmu500_cfg_probe,
>   	.reset = arm_mmu500_reset,
>   };
> 
