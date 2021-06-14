Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDA93A5E38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhFNITY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:19:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3229 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhFNITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:19:21 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3P9Y2DN7z6H7X8;
        Mon, 14 Jun 2021 16:04:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 10:17:18 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 09:17:17 +0100
Subject: Re: [PATCH v12 2/5] iommu: Enhance IOMMU default DMA mode build
 options
To:     Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-3-git-send-email-john.garry@huawei.com>
 <a4c85f00-918b-5952-7585-8e1110ac5195@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <953e1210-c88f-3e50-fbb9-cc559923829e@huawei.com>
Date:   Mon, 14 Jun 2021 09:11:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a4c85f00-918b-5952-7585-8e1110ac5195@linux.intel.com>
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

On 12/06/2021 02:21, Lu Baolu wrote:
> On 2021/6/11 20:20, John Garry wrote:
>> +config IOMMU_DEFAULT_LAZY
>> +    bool "lazy"
>> +    help
>> +      Support lazy mode, where for every IOMMU DMA unmap operation, the
>> +      flush operation of IOTLB and the free operation of IOVA are 
>> deferred.
>> +      They are only guaranteed to be done before the related IOVA 
>> will be
>> +      reused.
>> +
>> +      The isolation provided in this mode is not as secure as STRICT 
>> mode,
>> +      such that a vulnerable time window may be created between the DMA
>> +      unmap and the mapping finally being torn down in the IOMMU, 
>> where the
>> +      device can still access the system memory. However this mode may
> 
> " ... and the mappings cached in the IOMMU IOTLB or device TLB finally
> being invalidated, where the device probably can still access the memory
> which has already been unmapped by the device driver."

ok, I can try to incorporate some of this wording.

As for this:

On 12/06/2021 03:12, Lu Baolu wrote:
 > On 2021/6/11 20:20, John Garry wrote:
 >> +choice
 >> +    prompt "IOMMU default DMA mode"
 >
 > This is not explicit.
 >
 > How about
 >
 > "IOMMU DMA default cache invalidation policy"
 >
 > ?
 >

OK, but I'd rather use IOTLB, as that better matches the relevant 
iommu.c API name (iommu_ops.flush_iotlb_all).

Thanks,
john
