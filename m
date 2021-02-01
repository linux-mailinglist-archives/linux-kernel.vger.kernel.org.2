Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E161E30A81B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhBAMzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231733AbhBAMzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:55:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E064264EA5;
        Mon,  1 Feb 2021 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612184060;
        bh=zWF+wd/PULo/VNVJQJXebEqy2S1k4Ep9nQ1G7TCUPGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8uQwfyhxCKnCpl7YK40xhXOBD2Y6FXdga9DxkiUjzgICQ0zWinEap4SZs/wV0G90
         1fm+qS+22XjKt68W1uuH0RYjXouOEHtNH3Fq3du1OGc7tsuUdi676ysPDiLImnzUg5
         l1JKGMFvIyZpxl9LnBSx9A79LAtaKHC5JQfwNgc/8WPtrxOVCscHp1gXW4kIjqgP8E
         So86FU5DCiLrcK4rsNy0ufqeghDr5/2HFDHex5QaZlirsO3mCDRD8ug5G2AgLJ3ECE
         H02kHxC/J9rtlq9VyhUE7DPfqcpKroRyWUIeDOb2vZDf2ivNWHcy+EFQC6ZaL63OZh
         721NsBB9E96RQ==
Date:   Mon, 1 Feb 2021 12:54:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 1/2] perf/smmuv3: Don't reserve the PMCG register
 spaces
Message-ID: <20210201125412.GA14772@willie-the-truck>
References: <20210130071414.1575-1-thunder.leizhen@huawei.com>
 <20210130071414.1575-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210130071414.1575-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 03:14:13PM +0800, Zhen Lei wrote:
> According to the SMMUv3 specification:
> Each PMCG counter group is represented by one 4KB page (Page 0) with one
> optional additional 4KB page (Page 1), both of which are at IMPLEMENTATION
> DEFINED base addresses.
> 
> This means that the PMCG register spaces may be within the 64KB pages of
> the SMMUv3 register space. When both the SMMU and PMCG drivers reserve
> their own resources, a resource conflict occurs.
> 
> To avoid this conflict, don't reserve the PMCG regions.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 74474bb322c3f26..5e894f957c7b935 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -793,17 +793,30 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>  		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>  	};
>  
> -	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
> -	if (IS_ERR(smmu_pmu->reg_base))
> -		return PTR_ERR(smmu_pmu->reg_base);
> +	/*
> +	 * The register spaces of the PMCG may be in the register space of
> +	 * other devices. For example, SMMU. Therefore, the PMCG resources are
> +	 * not reserved to avoid resource conflicts with other drivers.
> +	 */
> +	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res_0)
> +		return ERR_PTR(-EINVAL);

I tried to apply this, but you've got your return type in a muddle:

@@ @@
+drivers/perf/arm_smmuv3_pmu.c: In function ‘smmu_pmu_probe’:
+drivers/perf/arm_smmuv3_pmu.c:803:10: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
+  803 |   return ERR_PTR(-EINVAL);
+      |          ^~~~~~~~~~~~~~~~
+drivers/perf/arm_smmuv3_pmu.c:803:31: warning: incorrect type in return expression (different base types) [sparse]
+drivers/perf/arm_smmuv3_pmu.c:803:31:    expected int [sparse]
+drivers/perf/arm_smmuv3_pmu.c:803:31:    got void * [sparse]
+drivers/perf/arm_smmuv3_pmu.c:806:10: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
+  806 |   return ERR_PTR(-ENOMEM);
+      |          ^~~~~~~~~~~~~~~~
+drivers/perf/arm_smmuv3_pmu.c:806:31: warning: incorrect type in return expression (different base types) [sparse]
+drivers/perf/arm_smmuv3_pmu.c:806:31:    expected int [sparse]
+drivers/perf/arm_smmuv3_pmu.c:806:31:    got void * [sparse]
+drivers/perf/arm_smmuv3_pmu.c:816:11: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
+  816 |    return ERR_PTR(-EINVAL);
+      |           ^~~~~~~~~~~~~~~~
+drivers/perf/arm_smmuv3_pmu.c:816:39: warning: incorrect type in return expression (different base types) [sparse]
+drivers/perf/arm_smmuv3_pmu.c:816:39:    expected int [sparse]
+drivers/perf/arm_smmuv3_pmu.c:816:39:    got void * [sparse]
+drivers/perf/arm_smmuv3_pmu.c:819:11: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
+  819 |    return ERR_PTR(-ENOMEM);
+      |           ^~~~~~~~~~~~~~~~
+drivers/perf/arm_smmuv3_pmu.c:819:39: warning: incorrect type in return expression (different base types) [sparse]
+drivers/perf/arm_smmuv3_pmu.c:819:39:    expected int [sparse]
+drivers/perf/arm_smmuv3_pmu.c:819:39:    got void * [sparse]

Will
