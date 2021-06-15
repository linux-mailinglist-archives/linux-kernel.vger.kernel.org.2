Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF043A7EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhFONK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:10:28 -0400
Received: from foss.arm.com ([217.140.110.172]:34890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhFONK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:10:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B891311D4;
        Tue, 15 Jun 2021 06:08:22 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8234F3F719;
        Tue, 15 Jun 2021 06:08:21 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] iommu/amd: Do not use flush-queue when NpCache is
 on
To:     Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-3-namit@vmware.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <afd4e764-a003-32eb-c50e-a77543772db0@arm.com>
Date:   Tue, 15 Jun 2021 14:08:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607182541.119756-3-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-07 19:25, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Do not use flush-queue on virtualized environments, where the NpCache
> capability of the IOMMU is set. This is required to reduce
> virtualization overheads.
> 
> This change follows a similar change to Intel's VT-d and a detailed
> explanation as for the rationale is described in commit 29b32839725f
> ("iommu/vt-d: Do not use flush-queue when caching-mode is on").
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   drivers/iommu/amd/init.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index d006724f4dc2..ba3b76ed776d 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1850,8 +1850,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>   	if (ret)
>   		return ret;
>   
> -	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
> +	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
> +		if (!amd_iommu_unmap_flush)
> +			pr_warn_once("IOMMU batching is disabled due to virtualization");

Nit: you can just use pr_warn() (or arguably pr_info()) since the 
explicit conditions already only match once. Speaking of which, it might 
be better to use amd_iommu_np_cache instead, since other patches are 
planning to clean up the last remnants of amd_iommu_unmap_flush.

Robin.

> +
>   		amd_iommu_np_cache = true;
> +		amd_iommu_unmap_flush = true;
> +	}
>   
>   	init_iommu_perf_ctr(iommu);
>   
> 
