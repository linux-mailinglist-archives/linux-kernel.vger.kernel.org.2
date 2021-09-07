Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9665F402650
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhIGJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:44:19 -0400
Received: from foss.arm.com ([217.140.110.172]:33852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242700AbhIGJoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:44:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 995D131B;
        Tue,  7 Sep 2021 02:43:12 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B47C3F766;
        Tue,  7 Sep 2021 02:43:11 -0700 (PDT)
Subject: Re: [question] Assign multiple devices from different SMMUs to a
 arm_smmu_domain
To:     Kunkun Jiang <jiangkunkun@huawei.com>,
        Will Deacon <will@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
References: <bbfcb875-0da1-c303-ed48-fdaa890c89b3@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <202f32cd-8036-563e-028b-781b999766be@arm.com>
Date:   Tue, 7 Sep 2021 10:43:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bbfcb875-0da1-c303-ed48-fdaa890c89b3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-07 08:41, Kunkun Jiang wrote:
> Hi all,
> 
> I am working on VFIO DMA dirty pages tracking based on ARM SMMU HTTU,
> and have done a lot of testing.In the test, I found a problem that 
> greatly affects
> performance of VFIO DMA dirty pages tracking.
> 
> According to the current arm-smmu-v3 driver, multiple VFIO pass-through
> device comes from different SMMUs will be assigned to different
> arm_smmu_domain. It will create page table for each arm_smmu_domain,
> even though these page tables are exactly the same. Bacause dirty pages
> tracking needs to traverse the page table, multiple page tables will make
> performance worse.
> 
> I learned the ARM SMMUv3 spec and had some exchanges with my colleagues
> who work on SMMU hardware. I did not find the restriction that multiple
> SMMUs cannot share the same page table. We migth be able to do this like
> x86 IOMMU. If I have missed something, please point it out.

Sure, it's not impossible, there are just a lot of fiddly 
considerations, mostly around how to handle SMMU instances with 
different capabilities. We haven't had a strong need to support this 
case so far, so we've simply been avoiding all that complexity.

Robin.

> Looking forward to your suggestions.😁
> 
> Thanks,
> Kunkun Jiang
> 
