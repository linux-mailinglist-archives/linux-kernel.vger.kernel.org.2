Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C74305309
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhA0F7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:59:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12032 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbhA0DXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:23:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DQRjw31RZzMPb4;
        Wed, 27 Jan 2021 10:04:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Wed, 27 Jan 2021
 10:05:51 +0800
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: Use DEFINE_RES_MEM() to simplify
 code
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210122131448.1167-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7f0b488d-f9b2-92b8-5914-2cef76b4d398@huawei.com>
Date:   Wed, 27 Jan 2021 10:05:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210122131448.1167-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've sent another set of patches. https://lkml.org/lkml/2021/1/26/1065
If those patches are acceptable, then this one should be ignored.


On 2021/1/22 21:14, Zhen Lei wrote:
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index bca458c00e48a8b..f04c55a7503c790 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3479,11 +3479,7 @@ static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
>  static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
>  				      resource_size_t size)
>  {
> -	struct resource res = {
> -		.flags = IORESOURCE_MEM,
> -		.start = start,
> -		.end = start + size - 1,
> -	};
> +	struct resource res = DEFINE_RES_MEM(start, size);
>  
>  	return devm_ioremap_resource(dev, &res);
>  }
> 

