Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC253DB8E7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhG3MwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhG3MwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:52:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425E1C061765;
        Fri, 30 Jul 2021 05:52:09 -0700 (PDT)
Received: from [IPv6:2a02:810a:880:f54:51e7:d967:c146:d0c] (unknown [IPv6:2a02:810a:880:f54:51e7:d967:c146:d0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7DA241F448DA;
        Fri, 30 Jul 2021 13:52:07 +0100 (BST)
Subject: Re: [PATCH v7 3/4] iommu: rockchip: Add internal ops to handle
 variants
To:     Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        xxm@rock-chips.com, Ezequiel Garcia <ezequiel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
References: <20210525121551.606240-1-benjamin.gaignard@collabora.com>
 <20210525121551.606240-4-benjamin.gaignard@collabora.com>
 <c6175f3d-a324-9fb5-bd39-cfe0447ee5e7@collabora.com>
 <3544194.oiGErgHkdL@diego> <06cdd178-66af-9ff7-5100-3da4e901040f@arm.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <4ad13d07-85d3-390d-123c-a7ed47056385@collabora.com>
Date:   Fri, 30 Jul 2021 14:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <06cdd178-66af-9ff7-5100-3da4e901040f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.07.21 18:58, Robin Murphy wrote:
> On 2021-07-29 17:08, Heiko Stübner wrote:
>> Hi Dafna,
>>
>> Am Donnerstag, 29. Juli 2021, 17:59:26 CEST schrieb Dafna Hirschfeld:
>>> On 25.05.21 14:15, Benjamin Gaignard wrote:
>>>> @@ -879,7 +895,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>>>>        for (i = 0; i < iommu->num_mmu; i++) {
>>>>            rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>>>> -                   rk_domain->dt_dma);
>>>> +                   rk_ops->dma_addr_dte(rk_domain->dt_dma));
>>>
>>> Hi,
>>> This is not related to that patch, I was wondring why are all mmu devices initialized
>>> with the same dt_dma?
>>> I see for example that the isp0_mmu in rk3399.dtsi has two resources. Can't each resource
>>> be initialized with different dt_dma and this way there are two dt tables instead of the two mmus pointing
>>> to the same dt table.
>>
>> maybe
>> git log -1 cd6438c5f8446691afa4829fe1a9d7b656204f11
>>
>> "iommu/rockchip: Reconstruct to support multi slaves
>> There are some IPs, such as video encoder/decoder, contains 2 slave iommus,
>> one for reading and the other for writing. They share the same irq and
>> clock with master.
>> This patch reconstructs to support this case by making them share the same
>> Page Directory, Page Tables and even the register operations.
>> That means every instruction to the reading MMU registers would be
>> duplicated to the writing MMU and vice versa."
> 
> Right. In theory we *could* maintain a separate pagetable for each IOMMU instance, but it would just lead to a load of complexity and overhead. For a map request, we'd have to do extra work to decide which table(s) need modifying, and duplicate all the work of the actual mapping if it's more than one. For an unmap request, we'd have no choice but to walk *all* the tables backing that domain to figure out which (if any) actually had it mapped in the first place.
> 
> Given that we already have distinct read and write permissions for mappings within a single table, there's not even any functional benefit that could be gained in this case (and in the more general case where the device might emit all kinds of transactions from all its interfaces you'd have to maintain identical mappings for all its IOMMUs anyway). Saving memory and code complexity by physically sharing one pagetable and not worrying about trying to do selective TLB maintenance is a bigger win than anything else could be.
> 
> Robin.

Hi, I just try to understand how this iommu hardware/software works. I have two questions,

1. So we currently miss a potential mapping of the hardware right? I mean , each mmu can map 1024*1024*4K = 4G addresses, so two mmus can potentially map 8G. But since
we set them to identical values, we can map only up to 4G.
2. What is the benefit of setting all mmus if they are all set to the same values? Can't we just work with the first mmu like it was done before that patch
cd6438c5f8446691afa4829fe1a9d7b656204f11

Thanks,
Dafna



