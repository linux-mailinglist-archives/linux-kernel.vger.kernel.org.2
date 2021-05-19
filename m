Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC16388B43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbhESKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:03:20 -0400
Received: from foss.arm.com ([217.140.110.172]:57234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhESKDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:03:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B74F3101E;
        Wed, 19 May 2021 03:01:39 -0700 (PDT)
Received: from [10.57.66.179] (unknown [10.57.66.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E03A3F719;
        Wed, 19 May 2021 03:01:38 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/2] iommu/arm-smmu-v3: Add some parameter check in
 __arm_smmu_tlb_inv_range()
To:     Kunkun Jiang <jiangkunkun@huawei.com>,
        Will Deacon <will@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     wanghaibin.wang@huawei.com
References: <20210519094307.3275-1-jiangkunkun@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c577a7cc-8db3-5802-53cb-985f0c7216b3@arm.com>
Date:   Wed, 19 May 2021 11:01:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519094307.3275-1-jiangkunkun@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-19 10:43, Kunkun Jiang wrote:
> Hi all,
> 
> This set of patches solves some errors when I tested the SMMU nested mode.
> 
> Test scenario description:
> guest kernel: 4KB translation granule
> host kernel: 16KB translation granule
> 
> errors:
> 1. encountered an endless loop in __arm_smmu_tlb_inv_range because
> num_pages is 0
> 2. encountered CERROR_ILL because the fields of TLB invalidation
> command are as follow: TG = 2, NUM = 0, SCALE = 0, TTL = 0. The
> combination is exactly the kind of reserved combination pointed
> out in the SMMUv3 spec(page 143-144, version D.a)
> 
> In my opinion, it is more appropriate to add parameter check in
> __arm_smmu_tlb_inv_range(), although these problems only appeared
> when I tested the SMMU nested mode. What do you think?

FWIW I think it would be better to fix the caller to not issue broken 
commands in the first place. The kernel shouldn't do so for itself (and 
definitely needs fixing if it ever does), so it sounds like the nesting 
implementation needs to do a bit more validation of what it's passing 
through.

Robin.

> This series include patches as below:
> Patch 1:
> - align the invalid range with leaf page size upwards when smmu
> supports RIL
> 
> Patch 2:
> - add a check to standardize granule size when smmu supports RIL
> 
> Kunkun Jiang (2):
>    iommu/arm-smmu-v3: Align invalid range with leaf page size upwards
>      when support RIL
>    iommu/arm-smmu-v3: Standardize granule size when support RIL
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
