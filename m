Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE23E46CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhHINke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:40:34 -0400
Received: from foss.arm.com ([217.140.110.172]:32974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhHINke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:40:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 751486D;
        Mon,  9 Aug 2021 06:40:13 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D5783F718;
        Mon,  9 Aug 2021 06:40:12 -0700 (PDT)
Subject: Re: [PATCH v3 25/25] iommu: Allow enabling non-strict mode
 dynamically
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org,
        iommu@lists.linux-foundation.org, rajatja@google.com,
        linux-arm-kernel@lists.infradead.org
References: <cover.1628094600.git.robin.murphy@arm.com>
 <22b044263f69e2bfe404c4379a435005ea58b3e2.1628094601.git.robin.murphy@arm.com>
 <20210809124931.GA1097@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <283ba58e-0257-8785-d0e6-eb96ab169e35@arm.com>
Date:   Mon, 9 Aug 2021 14:40:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809124931.GA1097@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-09 13:49, Will Deacon wrote:
> On Wed, Aug 04, 2021 at 06:15:53PM +0100, Robin Murphy wrote:
>> Allocating and enabling a flush queue is in fact something we can
>> reasonably do while a DMA domain is active, without having to rebuild it
>> from scratch. Thus we can allow a strict -> non-strict transition from
>> sysfs without requiring to unbind the device's driver, which is of
>> particular interest to users who want to make selective relaxations to
>> critical devices like the one serving their root filesystem.
>>
>> Disabling and draining a queue also seems technically possible to
>> achieve without rebuilding the whole domain, but would certainly be more
>> involved. Furthermore there's not such a clear use-case for tightening
>> up security *after* the device may already have done whatever it is that
>> you don't trust it not to do, so we only consider the relaxation case.
>>
>> CC: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>> ---
>>
>> v3: Actually think about concurrency, rework most of the fq data
>>      accesses to be (hopefully) safe and comment it all
>> ---
>>   drivers/iommu/dma-iommu.c | 25 ++++++++++++++++++-------
>>   drivers/iommu/iommu.c     | 16 ++++++++++++----
>>   drivers/iommu/iova.c      |  9 ++++++---
>>   3 files changed, 36 insertions(+), 14 deletions(-)
> 
> I failed to break this, so hopefully you've caught everything now.
> 
> Only thing I wasn't sure of is why we still need the smp_wmb() in
> init_iova_flush_queue(). Can we remove it now that we have one before
> assigning into the cookie?

Mostly because I failed to spot it, I think :)

Indeed now that we don't have any callers other than iommu_dma_init_fq() 
to worry about, I don't think that one matters any more. It would if 
were testing cookie->iovad->fq directly as our indicator instead of 
cookie->fq_domain, but then we'd still need the new barrier to ensure 
iommu_dma_flush_iotlb_all() properly observes the latter, so we may as 
well rely on that everywhere and let it fully replace the old one.

Thanks,
Robin.
