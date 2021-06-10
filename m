Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42AE3A30B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJQdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:33:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3204 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFJQdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:33:31 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G18Pt73ckz6H6jZ;
        Fri, 11 Jun 2021 00:22:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 18:31:33 +0200
Received: from [10.47.80.201] (10.47.80.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 17:31:32 +0100
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v11 0/3] Enhance IOMMU default DMA mode build options
To:     Joerg Roedel <joro@8bytes.org>
CC:     <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <rdunlap@infradead.org>
References: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
 <YMB4tCrkZv1b44qM@8bytes.org>
Message-ID: <4c1f02c5-fc6c-997f-19de-081efbb96566@huawei.com>
Date:   Thu, 10 Jun 2021 17:25:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YMB4tCrkZv1b44qM@8bytes.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.201]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 09:15, Joerg Roedel wrote:
> On Tue, Jun 08, 2021 at 09:18:25PM +0800, John Garry wrote:
>> Zhen Lei (3):
>>    iommu: Enhance IOMMU default DMA mode build options
>>    iommu/vt-d: Add support for IOMMU default DMA mode build options
>>    iommu/amd: Add support for IOMMU default DMA mode build options
> So I like the idea, but can we go a step further and get (mostly) rid of
> the driver-specific setup code for lazy/non-lazy mode? This can happen
> in the dma-iommu code and the drivers only need to keep the support for
> their legacy command line options.

The AMD driver just maintains a flag and a print for the strict mode 
setting.

The Intel driver still maintains some lazy vs strict config, depending 
on the platform:
- DMAR caching mode set means that we enforce strict mode globally
- workaround for ironlake gpu means that we enforce strict mode globally

So there isn't much driver-specific setup remaining, and I can't see the 
intel stuff being moved into dma-iommu.c or asbtracted (for that).

We could prob replace the driver-specific logs with new logs in iommu.c, 
and do away with maintaining the proprietary driver strict mode flags. 
That's if we're ok with replacing the driver-specific logs, though.

Thanks,
John

