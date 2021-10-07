Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AFF424D27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 08:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbhJGGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:20:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:48521 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231797AbhJGGU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:20:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="213305887"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="213305887"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 23:18:33 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="478431836"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.191]) ([10.254.214.191])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 23:18:31 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, arei.gonglei@huawei.com
Subject: Re: [PATCH v2 1/2] iommu/vt-d: convert the return type of
 first_pte_in_page to bool
To:     "Longpeng(Mike)" <longpeng2@huawei.com>, dwmw2@infradead.org,
        will@kernel.org, joro@8bytes.org
References: <20211005152308.1061-1-longpeng2@huawei.com>
 <20211005152308.1061-2-longpeng2@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <62016e41-5d9d-2d42-e16f-59809f9f1f75@linux.intel.com>
Date:   Thu, 7 Oct 2021 14:18:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211005152308.1061-2-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/5 23:23, Longpeng(Mike) wrote:
> first_pte_in_page() returns boolean value, so let's convert its
> return type to bool.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>   include/linux/intel-iommu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 05a65eb..a590b00 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -708,7 +708,7 @@ static inline bool dma_pte_superpage(struct dma_pte *pte)
>   	return (pte->val & DMA_PTE_LARGE_PAGE);
>   }
>   
> -static inline int first_pte_in_page(struct dma_pte *pte)
> +static inline bool first_pte_in_page(struct dma_pte *pte)
>   {
>   	return !((unsigned long)pte & ~VTD_PAGE_MASK);
>   }
> 

Probably,

	return IS_ALIGNED((unsigned long)pte, VTD_PAGE_SIZE);

looks neater?

Best regards,
baolu
