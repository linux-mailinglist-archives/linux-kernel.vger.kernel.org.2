Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43430BEF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBBM7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:59:49 -0500
Received: from foss.arm.com ([217.140.110.172]:49364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhBBM7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:59:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 442C81FB;
        Tue,  2 Feb 2021 04:58:59 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC6083F718;
        Tue,  2 Feb 2021 04:58:57 -0800 (PST)
Subject: Re: [PATCH] iommu: Update the document of IOMMU_DOMAIN_UNMANAGED
To:     Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        jiangkunkun@huawei.com, Will Deacon <will@kernel.org>,
        wanghaibin.wang@huawei.com
References: <20210202085330.31716-1-zhukeqian1@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8eac9259-66e5-9b83-39a9-46a86097d450@arm.com>
Date:   Tue, 2 Feb 2021 12:58:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202085330.31716-1-zhukeqian1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-02 08:53, Keqian Zhu wrote:
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>   include/linux/iommu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 77e561ed57fd..e8f2efae212b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -68,7 +68,7 @@ struct iommu_domain_geometry {
>    *				  devices
>    *	IOMMU_DOMAIN_IDENTITY	- DMA addresses are system physical addresses
>    *	IOMMU_DOMAIN_UNMANAGED	- DMA mappings managed by IOMMU-API user, used
> - *				  for VMs
> + *				  for VMs or userspace driver frameworks

Given that "VMs" effectively has to mean VFIO, doesn't it effectively 
already imply other uses of VFIO anyway? Unmanaged domains are also used 
in other subsystems/drivers inside the kernel and we're not naming 
those, so I don't see that it's particularly helpful to specifically 
call out one more VFIO use-case.

Perhaps the current wording could be generalised a little more, but we 
certainly don't want to start trying to maintain an exhaustive list of 
users here...

Robin.

>    *	IOMMU_DOMAIN_DMA	- Internally used for DMA-API implementations.
>    *				  This flag allows IOMMU drivers to implement
>    *				  certain optimizations for these domains
> 
