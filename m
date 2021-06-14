Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF13A5E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhFNILv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:11:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3228 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:11:50 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3P0s5vvHz6H7n1;
        Mon, 14 Jun 2021 15:56:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 14 Jun 2021 10:09:46 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 09:09:46 +0100
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <f3940a3f-d1c1-148d-e4b5-51cecf924ff5@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <03675e2f-c3a6-ce33-ef96-f9ae544b2d13@huawei.com>
Date:   Mon, 14 Jun 2021 09:03:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f3940a3f-d1c1-148d-e4b5-51cecf924ff5@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.95.26]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2021 03:14, Lu Baolu wrote:
> On 2021/6/11 20:20, John Garry wrote:
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index 2a71347611d4..4467353f981b 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -94,6 +94,7 @@ choice
>>       prompt "IOMMU default DMA mode"
>>       depends on IOMMU_DMA
>> +    default IOMMU_DEFAULT_LAZY if INTEL_IOMMU
>>       default IOMMU_DEFAULT_STRICT
> 
> If two default values are different. Which one will be overridden?

If I understand your question correctly, I think you are asking if both 
are set:
CONFIG_IOMMU_DEFAULT_LAZY=y
CONFIG_IOMMU_DEFAULT_STRICT=y

If this happens, then make defconfig complains about both being set, and 
selects the 2nd, whatever that is.

If neither are set, then IOMMU_DEFAULT_LAZY is set if INTEL_IOMMU is 
set, otherwise IOMMU_DEFAULT_STRICT.

Thanks,
John
