Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92EE413053
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhIUIrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:47:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3848 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhIUIrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:47:01 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HDFLb5jzPz67lZq;
        Tue, 21 Sep 2021 16:43:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 10:45:31 +0200
Received: from [10.47.88.85] (10.47.88.85) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 09:45:30 +0100
Subject: Re: [PATCH v4 5/6] iova: Add iova_len argument to init_iova_domain()
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC:     <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
        <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jonathanh@nvidia.com>, <sakari.ailus@linux.intel.com>,
        <bingbu.cao@intel.com>, <tian.shu.qiu@intel.com>,
        <mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
        <digetx@gmail.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>, <chenxiang66@hisilicon.com>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-6-git-send-email-john.garry@huawei.com>
 <20210802150644.GD28735@willie-the-truck>
 <c6be0b9f-531b-dc12-2747-3acbecfcd531@huawei.com>
 <1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4add7fb2-e9de-9c15-1915-6a6e2596941d@huawei.com>
Date:   Tue, 21 Sep 2021 09:48:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.85]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2021 17:16, Robin Murphy wrote:
>>>>
>>>> Also fix up all users to set this value (at 0, meaning use default).
>>> Wrap that in init_iova_domain_defaults() to avoid the mysterious 0?
>>
>> Sure, I can do something like that. I actually did have separate along 
>> those lines in v3 before I decided to change it.
> 
> Y'know, at this point I'm now starting to seriously wonder whether 
> moving the rcaches into iommu_dma_cookie wouldn't make a whole lot of 
> things simpler... :/
> 
> Does that sound like crazy talk to you, or an idea worth entertaining?

Hi Robin,

JFYI, to try to make inroads into my IOVA issues, I'm going to look to 
do this first, if you don't mind. I think that the fq stuff can also be 
put into a separate structure also, rather than iova_domain, and that 
can also be a member of iommu_dma_cookie.

BTW, with regards to separating the rcache magazine code out, I see 
someone already trying to introduce something similar:

https://lore.kernel.org/lkml/CAKW4uUxperg41z8Lu5QYsS-YEGt1anuD1CuiUqXC0ANFqJBosQ@mail.gmail.com/T/#me4cc5de775ad16ab3d6e7ca854b55f274ddcba08

https://lore.kernel.org/lkml/YUkErK1vVZMht4s8@casper.infradead.org/T/#t

Cheers,
John
