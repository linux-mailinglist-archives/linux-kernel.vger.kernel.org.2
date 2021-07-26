Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D663D59AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhGZMDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:03:06 -0400
Received: from foss.arm.com ([217.140.110.172]:51374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233754AbhGZMDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:03:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 844AB31B;
        Mon, 26 Jul 2021 05:43:30 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689D93F70D;
        Mon, 26 Jul 2021 05:43:29 -0700 (PDT)
Subject: Re: [PATCH 18/23] iommu: Express DMA strictness via the domain type
To:     Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <37708e21b55e17eb074ef145afc2157cd0192abe.1626888445.git.robin.murphy@arm.com>
 <f5e902ce-54a2-af7b-b42e-f61f7f96c68e@linux.intel.com>
 <77057c4b-479b-c5b8-4666-f16e294552d1@arm.com>
 <29443387-c088-480c-3d91-17b6d1cc8188@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9b5abd19-8bfe-7215-8b13-108aea2aee5e@arm.com>
Date:   Mon, 26 Jul 2021 13:43:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <29443387-c088-480c-3d91-17b6d1cc8188@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-26 13:29, Lu Baolu wrote:
[...]
>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>>> index b1af1ff324c5..a114a7ad88ec 100644
>>>> --- a/drivers/iommu/dma-iommu.c
>>>> +++ b/drivers/iommu/dma-iommu.c
>>>> @@ -363,13 +363,15 @@ static int iommu_dma_init_domain(struct 
>>>> iommu_domain *domain, dma_addr_t base,
>>>>       init_iova_domain(iovad, 1UL << order, base_pfn);
>>>> -    if (!cookie->fq_domain && !dev_is_untrusted(dev) &&
>>>> -        domain->ops->flush_iotlb_all && 
>>>> !iommu_get_dma_strict(domain)) {
>>>> +    if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain &&
>>>> +        domain->ops->flush_iotlb_all) {
> 
> Perhaps we can remove the ops->flush_iotlb_all check with the
> assumption that any vendor iommu driver with DMA_FQ domain support
> should always provides this callback?

Oh yes, indeed it wouldn't make sense for a driver to claim 
IOMMU_DOMAIN_DMA_FQ support but not implement the one thing that that 
needs the driver to provide. That's yet another neat little cleanup, thanks!

Robin.
