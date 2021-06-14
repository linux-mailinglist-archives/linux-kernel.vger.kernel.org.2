Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E403A6BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhFNQhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:37:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3239 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhFNQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:37:40 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3cJS5k7wz6G8bn;
        Tue, 15 Jun 2021 00:26:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 18:35:36 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 17:35:35 +0100
Subject: Re: [PATCH] iommu: Update "iommu.strict" documentation
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <will@kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <baolu.lu@linux.intel.com>
References: <2c8c06e1b449d6b060c5bf9ad3b403cd142f405d.1623682646.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1e95deac-b0c3-e122-f1e5-7748424a2c9f@huawei.com>
Date:   Mon, 14 Jun 2021 17:29:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <2c8c06e1b449d6b060c5bf9ad3b403cd142f405d.1623682646.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.26]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2021 15:57, Robin Murphy wrote:
> Consolidating the flush queue logic also meant that the "iommu.strict"
> option started taking effect on x86 as well. Make sure we document that.
> 
> Fixes: a250c23f15c2 ("iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I assumed that all bets were off when we use a cmdline param which is 
not "officially" supported.

Anyway, FWIW:
Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb89dbdedc46..20a32de990ed 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1987,7 +1987,7 @@
>   			  forcing Dual Address Cycle for PCI cards supporting
>   			  greater than 32-bit addressing.
>   
> -	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
> +	iommu.strict=	[ARM64, X86] Configure TLB invalidation behaviour
>   			Format: { "0" | "1" }
>   			0 - Lazy mode.
>   			  Request that DMA unmap operations use deferred
