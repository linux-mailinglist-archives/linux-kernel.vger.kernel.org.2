Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F13DDDE0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhHBQla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:41:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3563 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhHBQl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:41:29 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdkKL5RtDz6FFxb;
        Tue,  3 Aug 2021 00:41:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 2 Aug 2021 18:41:18 +0200
Received: from [10.47.87.154] (10.47.87.154) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 17:41:17 +0100
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
Message-ID: <a7c2ce29-ca28-83a3-6432-a508df9825ac@huawei.com>
Date:   Mon, 2 Aug 2021 17:40:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.154]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2021 17:16, Robin Murphy wrote:
> On 2021-08-02 17:06, John Garry wrote:
>> On 02/08/2021 16:06, Will Deacon wrote:
>>> On Wed, Jul 14, 2021 at 06:36:42PM +0800, John Garry wrote:
>>>> Add max opt argument to init_iova_domain(), and use it to set the 
>>>> rcaches
>>>> range.
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

As I see, the rcache stuff isn't really specific to IOVA anyway, so it 
seems sane.

> 
> Does that sound like crazy talk to you, or an idea worth entertaining?

If you're going to start moving things, has anyone considered putting 
rcache support in lib as a generic solution to "Magazines and Vmem: .." 
paper?

Thanks,
John
