Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0630914C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 02:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhA3BiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 20:38:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12355 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhA3Bfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 20:35:50 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSGvK0yY4z7d2C;
        Sat, 30 Jan 2021 09:33:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 30 Jan 2021
 09:34:56 +0800
Subject: Re: [PATCH v3 2/3] perf/smmuv3: Add a MODULE_SOFTDEP() to indicate
 dependency on SMMU
To:     Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-3-thunder.leizhen@huawei.com>
 <67e0859b-2633-3516-527f-57557e210fa1@arm.com>
 <4b116f38-84da-9ef9-350c-8900944b0433@huawei.com>
 <a5595eae-0de9-e454-8a3d-5718512422ee@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <bc012c2b-4e94-8cd5-68c6-d4d9224aca0f@huawei.com>
Date:   Sat, 30 Jan 2021 09:34:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a5595eae-0de9-e454-8a3d-5718512422ee@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/30 1:03, Robin Murphy wrote:
> On 2021-01-29 15:34, John Garry wrote:
>> On 29/01/2021 15:12, Robin Murphy wrote:
>>> On 2021-01-27 11:32, Zhen Lei wrote:
>>>> The MODULE_SOFTDEP() gives user space a hint of the loading sequence. And
>>>> when command "modprobe arm_smmuv3_pmu" is executed, the arm_smmu_v3.ko is
>>>> automatically loaded in advance.
>>>
>>> Why do we need this? If probe order doesn't matter when both drivers are built-in, why should module load order?
>>>
>>> TBH I'm not sure why we even have a Kconfig dependency on ARM_SMMU_V3, given that the drivers operate completely independently :/
>>
>> Can that Kconfig dependency just be removed? I think that it was added under the idea that there is no point in having the SMMUv3 PMU driver without the SMMUv3 driver.
> 
> A PMCG *might* be usable for simply counting transactions to measure device activity regardless of its associated SMMU being enabled.

If that's the case, the SOFTDEP really shouldn't be added. I wasn't trying to make sure they were loaded in order, just to make sure that the SMMU was not forgotten to load.

> Either way, it's not really Kconfig's job to decide what makes sense (beyond the top-level "can this driver *ever* be used on this platform" visibility choices). Imagine if we gave every PCI/USB/etc. device driver an explicit ?dependency on at least one host controller driver being enabled...
> 
> Robin.
> 
> .
> 

