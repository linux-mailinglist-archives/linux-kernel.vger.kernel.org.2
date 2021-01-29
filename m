Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B29F308AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhA2RFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:05:05 -0500
Received: from foss.arm.com ([217.140.110.172]:51532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhA2REs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:04:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF3D013A1;
        Fri, 29 Jan 2021 09:04:02 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63C843F71B;
        Fri, 29 Jan 2021 09:04:01 -0800 (PST)
Subject: Re: [PATCH v3 2/3] perf/smmuv3: Add a MODULE_SOFTDEP() to indicate
 dependency on SMMU
To:     John Garry <john.garry@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-3-thunder.leizhen@huawei.com>
 <67e0859b-2633-3516-527f-57557e210fa1@arm.com>
 <4b116f38-84da-9ef9-350c-8900944b0433@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a5595eae-0de9-e454-8a3d-5718512422ee@arm.com>
Date:   Fri, 29 Jan 2021 17:03:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <4b116f38-84da-9ef9-350c-8900944b0433@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-29 15:34, John Garry wrote:
> On 29/01/2021 15:12, Robin Murphy wrote:
>> On 2021-01-27 11:32, Zhen Lei wrote:
>>> The MODULE_SOFTDEP() gives user space a hint of the loading sequence. 
>>> And
>>> when command "modprobe arm_smmuv3_pmu" is executed, the 
>>> arm_smmu_v3.ko is
>>> automatically loaded in advance.
>>
>> Why do we need this? If probe order doesn't matter when both drivers 
>> are built-in, why should module load order?
>>
>> TBH I'm not sure why we even have a Kconfig dependency on ARM_SMMU_V3, 
>> given that the drivers operate completely independently :/
> 
> Can that Kconfig dependency just be removed? I think that it was added 
> under the idea that there is no point in having the SMMUv3 PMU driver 
> without the SMMUv3 driver.

A PMCG *might* be usable for simply counting transactions to measure 
device activity regardless of its associated SMMU being enabled. Either 
way, it's not really Kconfig's job to decide what makes sense (beyond 
the top-level "can this driver *ever* be used on this platform" 
visibility choices). Imagine if we gave every PCI/USB/etc. device driver 
an explicit dependency on at least one host controller driver being 
enabled...

Robin.
