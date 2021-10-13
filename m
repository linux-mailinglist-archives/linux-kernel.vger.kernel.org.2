Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34F42C9E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhJMTXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:23:00 -0400
Received: from foss.arm.com ([217.140.110.172]:44222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhJMTW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:22:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A69F21063;
        Wed, 13 Oct 2021 12:20:52 -0700 (PDT)
Received: from [10.57.95.157] (unknown [10.57.95.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300FF3F70D;
        Wed, 13 Oct 2021 12:20:51 -0700 (PDT)
Subject: Re: [PATCH] iommu/iova: Add support for IOVA max alignment tuning
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>, joro@8bytes.org,
        will@kernel.org
Cc:     akpm@linux-foundation.org, baolu.lu@linux.intel.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        djakov@kernel.org
References: <1634148667-409263-1-git-send-email-quic_c_gdjako@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a72ccd19-4888-d823-5ec6-9ca891b4fe66@arm.com>
Date:   Wed, 13 Oct 2021 20:20:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1634148667-409263-1-git-send-email-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-13 19:11, Georgi Djakov wrote:
> IOVAs are aligned to the smallest PAGE_SIZE order, where the requested
> IOVA can fit. But this might not work for all use-cases. It can cause
> IOVA fragmentation in some multimedia and 8K video use-cases that may
> require larger buffers to be allocated and mapped.
> 
> When the above allocation pattern is used with the current alignment
> scheme, the IOVA space could be quickly exhausted for 32bit devices.
> 
> In order to get better IOVA space utilization and reduce fragmentation,
> a new kernel command line parameter is introduced to make the alignment
> limit configurable by the user during boot.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>   drivers/iommu/iova.c                            | 26 ++++++++++++++++++++++++-

I see no good reason for the IOVA layer to lie to its callers. If they 
don't need an aligned IOVA, they shouldn't ask for one in the first 
place. If callers still need some intermediate degree of alignment then 
the IOVA API might want to grow something more expressive than "bool 
size_aligned", but it should still be the callers' responsibility to 
pass an appropriate value.

Thanks,
Robin.

>   2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ad94a2aa9819..630246dc691f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2056,6 +2056,14 @@
>   			  forcing Dual Address Cycle for PCI cards supporting
>   			  greater than 32-bit addressing.
>   
> +	iommu.max_align_shift=
> +			[ARM64, X86] Limit the alignment of IOVAs to a maximum
> +			PAGE_SIZE order. Larger IOVAs will be aligned to this
> +			specified order. The order is expressed as a power of
> +			two multiplied by the PAGE_SIZE.
> +			Format: { "4" | "5" | "6" | "7" | "8" | "9" }
> +			Default: 9
> +
>   	iommu.strict=	[ARM64, X86] Configure TLB invalidation behaviour
>   			Format: { "0" | "1" }
>   			0 - Lazy mode.
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 9e8bc802ac05..5a8c86871735 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -15,6 +15,9 @@
>   /* The anchor node sits above the top of the usable address space */
>   #define IOVA_ANCHOR	~0UL
>   
> +#define IOMMU_DEFAULT_IOVA_MAX_ALIGN_SHIFT	9
> +static unsigned long iommu_max_align_shift __read_mostly = IOMMU_DEFAULT_IOVA_MAX_ALIGN_SHIFT;
> +
>   static bool iova_rcache_insert(struct iova_domain *iovad,
>   			       unsigned long pfn,
>   			       unsigned long size);
> @@ -27,6 +30,27 @@ static void free_iova_rcaches(struct iova_domain *iovad);
>   static void fq_destroy_all_entries(struct iova_domain *iovad);
>   static void fq_flush_timeout(struct timer_list *t);
>   
> +static unsigned long limit_align_shift(struct iova_domain *iovad, unsigned long shift)
> +{
> +	unsigned long max_align_shift;
> +
> +	max_align_shift = iommu_max_align_shift + PAGE_SHIFT - iova_shift(iovad);
> +	return min_t(unsigned long, max_align_shift, shift);
> +}
> +
> +static int __init iommu_set_def_max_align_shift(char *str)
> +{
> +	unsigned long max_align_shift;
> +
> +	int ret = kstrtoul(str, 10, &max_align_shift);
> +
> +	if (!ret)
> +		iommu_max_align_shift = max_align_shift;
> +
> +	return 0;
> +}
> +early_param("iommu.max_align_shift", iommu_set_def_max_align_shift);
> +
>   static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
>   {
>   	struct iova_domain *iovad;
> @@ -242,7 +266,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
>   
>   	if (size_aligned)
> -		align_mask <<= fls_long(size - 1);
> +		align_mask <<= limit_align_shift(iovad, fls_long(size - 1));
>   
>   	/* Walk the tree backwards */
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> 
