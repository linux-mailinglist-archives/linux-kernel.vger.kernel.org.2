Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4946F3A6D38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhFNRcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 13:32:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3241 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbhFNRct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:32:49 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3db804BLz6F9Tn;
        Tue, 15 Jun 2021 01:23:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 19:30:44 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 18:30:43 +0100
Subject: Re: [PATCH v12 5/5] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-6-git-send-email-john.garry@huawei.com>
 <868374d4-e816-b607-82de-7e7c27a4c66b@arm.com>
 <b12d96fa-9879-2739-fadd-2ebb02d75918@huawei.com>
 <56f1fc88-baec-e1cf-109e-59978e2d16a8@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0e477a85-db02-1513-a449-02a9fbfccdfa@huawei.com>
Date:   Mon, 14 Jun 2021 18:24:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <56f1fc88-baec-e1cf-109e-59978e2d16a8@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.26]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2021 18:19, Robin Murphy wrote:
>>> We shouldn't need to keep IOMMU_CMD_LINE_STRICT at all now, since it 
>>> was only to prevent a driver's "default lazy" setting passed in here 
>>> from downgrading an explicitly-set strict mode.
>>>
>>> With that cleaned up too,
>>>
>>
>> Patch 1/5 mentions whether the invalidation policy comes from the 
>> cmdline - similar to the default domain type print - so I was going to 
>> keep that.
> 
> Oh, silly me, I'd forgotten that already and was just looking at my 
> local tree... Let's keep it for consistency with how we report the 
> domain type then.
> 
>> And then maybe we should also set it from the deprecated x86 
>> driver-specific params.
> 
> I don't think it's worth exporting more low-level guts to allow that to 
> happen - tying in to iommu_set_dma_strict() would be too late, as 
> before. I think the separate pr_warn()s which announce the relevant 
> parameter is deprecated (but has still taken effect) should be enough.
> 

Fine, I suppose someone using a deprecated interface can't complain 
about imperfect prints.

And I'll pick up your RB tag (unless you mention otherwise).

Thanks,
John


