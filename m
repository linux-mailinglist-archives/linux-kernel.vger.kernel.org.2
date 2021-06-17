Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2293AAE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFQIJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:09:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3260 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFQII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:08:59 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5Dnw3xwBz6K6Hr;
        Thu, 17 Jun 2021 15:53:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 10:06:50 +0200
Received: from [10.47.95.81] (10.47.95.81) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 09:06:49 +0100
Subject: Re: [PATCH v13 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>, <robin.murphy@arm.com>,
        <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <linux-doc@vger.kernel.org>
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-5-git-send-email-john.garry@huawei.com>
 <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
Date:   Thu, 17 Jun 2021 09:00:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.95.81]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2021 08:32, Lu Baolu wrote:
> On 6/16/21 7:03 PM, John Garry wrote:
>> @@ -4382,9 +4380,9 @@ int __init intel_iommu_init(void)
>>            * is likely to be much lower than the overhead of 
>> synchronizing
>>            * the virtual and physical IOMMU page-tables.
>>            */
>> -        if (!intel_iommu_strict && cap_caching_mode(iommu->cap)) {
>> -            pr_warn("IOMMU batching is disabled due to virtualization");
>> -            intel_iommu_strict = 1;
>> +        if (cap_caching_mode(iommu->cap)) {
>> +            pr_warn("IOMMU batching disallowed due to 
>> virtualization\n");
>> +            iommu_set_dma_strict(true);
> 
> With this change, VM guest will always show this warning.

Would they have got it before also normally?

I mean, default is intel_iommu_strict=0, so if 
cap_caching_mode(iommu->cap) is true and intel_iommu_strict not set to 1 
elsewhere previously, then we would get this print.

> How about
> removing this message? Users could get the same information through the
> kernel message added by "[PATCH v13 2/6] iommu: Print strict or lazy
> mode at init time".

I think that the print from 2/6 should occur before this print.

Regardless I would think that you would still like to be notified of 
this change in policy, right?

However I now realize that the print is in a loop per iommu, so we would 
get it per iommu:

for_each_active_iommu(iommu, drhd) {
	/*
	 * The flush queue implementation does not perform
	 * page-selective invalidations that are required for efficient
	 * TLB flushes in virtual environments.  The benefit of batching
	 * is likely to be much lower than the overhead of synchronizing
	 * the virtual and physical IOMMU page-tables.
	 */
	if (!intel_iommu_strict && cap_caching_mode(iommu->cap)) {
		pr_warn("IOMMU batching is disabled due to virtualization");
		intel_iommu_strict = 1;
	}
	...
}

I need to change that. How about this:

bool print_warning = false;

for_each_active_iommu(iommu, drhd) {
	/*
	 * The flush queue implementation does not perform
	 * page-selective invalidations that are required for efficient
	 * TLB flushes in virtual environments.  The benefit of batching
	 * is likely to be much lower than the overhead of synchronizing
	 * the virtual and physical IOMMU page-tables.
	 */
	if (!print_warning && cap_caching_mode(iommu->cap)) {
		pr_warn("IOMMU batching disallowed due to virtualization\n");
		iommu_set_dma_strict(true);
		print_warning = true;
	}
	...
}

or use pr_warn_once().

Thanks,
John
