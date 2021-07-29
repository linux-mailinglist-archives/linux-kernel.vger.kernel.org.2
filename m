Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63B03DA987
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhG2Q6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:58:19 -0400
Received: from foss.arm.com ([217.140.110.172]:52986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhG2Q6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:58:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A298F1FB;
        Thu, 29 Jul 2021 09:58:10 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AF463F73D;
        Thu, 29 Jul 2021 09:58:08 -0700 (PDT)
Subject: Re: [PATCH v7 3/4] iommu: rockchip: Add internal ops to handle
 variants
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        xxm@rock-chips.com, Ezequiel Garcia <ezequiel@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
References: <20210525121551.606240-1-benjamin.gaignard@collabora.com>
 <20210525121551.606240-4-benjamin.gaignard@collabora.com>
 <c6175f3d-a324-9fb5-bd39-cfe0447ee5e7@collabora.com>
 <3544194.oiGErgHkdL@diego>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <06cdd178-66af-9ff7-5100-3da4e901040f@arm.com>
Date:   Thu, 29 Jul 2021 17:58:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3544194.oiGErgHkdL@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-29 17:08, Heiko Stübner wrote:
> Hi Dafna,
> 
> Am Donnerstag, 29. Juli 2021, 17:59:26 CEST schrieb Dafna Hirschfeld:
>> On 25.05.21 14:15, Benjamin Gaignard wrote:
>>> @@ -879,7 +895,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>>>    
>>>    	for (i = 0; i < iommu->num_mmu; i++) {
>>>    		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>>> -			       rk_domain->dt_dma);
>>> +			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
>>
>> Hi,
>> This is not related to that patch, I was wondring why are all mmu devices initialized
>> with the same dt_dma?
>> I see for example that the isp0_mmu in rk3399.dtsi has two resources. Can't each resource
>> be initialized with different dt_dma and this way there are two dt tables instead of the two mmus pointing
>> to the same dt table.
> 
> maybe
> git log -1 cd6438c5f8446691afa4829fe1a9d7b656204f11
> 
> "iommu/rockchip: Reconstruct to support multi slaves
>      
> There are some IPs, such as video encoder/decoder, contains 2 slave iommus,
> one for reading and the other for writing. They share the same irq and
> clock with master.
>      
> This patch reconstructs to support this case by making them share the same
> Page Directory, Page Tables and even the register operations.
> That means every instruction to the reading MMU registers would be
> duplicated to the writing MMU and vice versa."

Right. In theory we *could* maintain a separate pagetable for each IOMMU 
instance, but it would just lead to a load of complexity and overhead. 
For a map request, we'd have to do extra work to decide which table(s) 
need modifying, and duplicate all the work of the actual mapping if it's 
more than one. For an unmap request, we'd have no choice but to walk 
*all* the tables backing that domain to figure out which (if any) 
actually had it mapped in the first place.

Given that we already have distinct read and write permissions for 
mappings within a single table, there's not even any functional benefit 
that could be gained in this case (and in the more general case where 
the device might emit all kinds of transactions from all its interfaces 
you'd have to maintain identical mappings for all its IOMMUs anyway). 
Saving memory and code complexity by physically sharing one pagetable 
and not worrying about trying to do selective TLB maintenance is a 
bigger win than anything else could be.

Robin.
