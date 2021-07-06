Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A413BC87D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhGFJaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:30:25 -0400
Received: from foss.arm.com ([217.140.110.172]:35536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhGFJaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:30:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D37E31B;
        Tue,  6 Jul 2021 02:27:45 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1E473F5A1;
        Tue,  6 Jul 2021 02:27:44 -0700 (PDT)
Subject: Re: [PATCH] iommu: Fallback to default setting when def_domain_type()
 callback returns 0
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, joro@8bytes.org,
        will@kernel.org
Cc:     "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210706065106.271765-1-kai.heng.feng@canonical.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d9fa9a62-6522-7d26-0cca-16f6886136ec@arm.com>
Date:   Tue, 6 Jul 2021 10:27:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706065106.271765-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-06 07:51, Kai-Heng Feng wrote:
> Commit 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted
> device into core") not only moved the check for untrusted device to
> IOMMU core, it also introduced a behavioral change by returning
> def_domain_type() directly without checking its return value. That makes
> many devices no longer use the default IOMMU setting.
> 
> So revert back to the old behavior which defaults to
> iommu_def_domain_type when driver callback returns 0.
> 
> Fixes: 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device into core")

Are you sure about that? From that same commit:

@@ -1507,7 +1509,7 @@ static int iommu_alloc_default_domain(struct 
iommu_group *group,
         if (group->default_domain)
                 return 0;

-       type = iommu_get_def_domain_type(dev);
+       type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;

         return iommu_group_alloc_default_domain(dev->bus, group, type);
  }

AFAICS the other two callers should also handle 0 correctly. Have you 
seen a problem in practice?

Robin.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/iommu/iommu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5419c4b9f27a..faac4f795025 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1507,14 +1507,15 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>   static int iommu_get_def_domain_type(struct device *dev)
>   {
>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	unsigned int type = 0;
>   
>   	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
>   		return IOMMU_DOMAIN_DMA;
>   
>   	if (ops->def_domain_type)
> -		return ops->def_domain_type(dev);
> +		type = ops->def_domain_type(dev);
>   
> -	return 0;
> +	return (type == 0) ? iommu_def_domain_type : type;
>   }
>   
>   static int iommu_group_alloc_default_domain(struct bus_type *bus,
> 
