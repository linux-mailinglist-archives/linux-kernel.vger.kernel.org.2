Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816B437A0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhEKHlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:41:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2052 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhEKHlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:41:22 -0400
Received: from dggeml764-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FfV8c1LbKzWhXN;
        Tue, 11 May 2021 15:36:00 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggeml764-chm.china.huawei.com (10.1.199.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 15:40:13 +0800
Received: from [10.174.187.224] (10.174.187.224) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 15:40:13 +0800
Subject: Re: [RFC PATCH v4 01/13] iommu: Introduce dirty log tracking
 framework
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
 <20210507102211.8836-2-zhukeqian1@huawei.com>
 <efc2d868-28ba-8ed9-1d6b-610b67d671b5@linux.intel.com>
 <18ac787a-179e-71f7-728b-c43feda80a16@huawei.com>
 <55fda826-9ab6-a3a0-b17e-a4d4879f00bc@linux.intel.com>
 <a8df289a-47c2-c193-cd6f-8415f68b900f@huawei.com>
 <f47e90c6-f3c4-b28f-a810-e03afe79e62d@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <60182a35-e151-7150-3708-4e58dd8e78da@huawei.com>
Date:   Tue, 11 May 2021 15:40:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <f47e90c6-f3c4-b28f-a810-e03afe79e62d@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.224]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On 2021/5/11 11:12, Lu Baolu wrote:
> Hi Keqian,
> 
> On 5/10/21 7:07 PM, Keqian Zhu wrote:
>>>>> I suppose this interface is to ask the vendor IOMMU driver to check
>>>>> whether each device/iommu in the domain supports dirty bit tracking.
>>>>> But what will happen if new devices with different tracking capability
>>>>> are added afterward?
>>>> Yep, this is considered in the vfio part. We will query again after attaching or
>>>> detaching devices from the domain.  When the domain becomes capable, we enable
>>>> dirty log for it. When it becomes not capable, we disable dirty log for it.
>>> If that's the case, why not putting this logic in the iommu subsystem so
>>> that it doesn't need to be duplicate in different upper layers?
>>>
>>> For example, add something like dirty_page_trackable in the struct of
>>> iommu_domain and ask the vendor iommu driver to update it once any
>>> device is added/removed to/from the domain. It's also better to disallow
>> If we do it, the upper layer still needs to query the capability from domain and switch
>> dirty log tracking for it. Or do you mean the domain can switch dirty log tracking automatically
>> when its capability change? If so, I think we're lack of some flexibility. The upper layer
>> may have it's own policy, such as only enable dirty log tracking when all domains are capable,
>> and disable dirty log tracking when just one domain is not capable.
> 
> I may not get you.
> 
> Assume that dirty_page_trackable is an attribution of an iommu_domain.
> This attribution might be changed once a new device (with different
> capability) added or removed. So it should be updated every time a new
> device is attached or detached. This work could be done by the vendor
> iommu driver on the path of dev_attach/dev_detach callback.
Yes, this is what I understand you.

> 
> For upper layers, before starting page tracking, they check the
> dirty_page_trackable attribution of the domain and start it only it's
> capable. Once the page tracking is switched on the vendor iommu driver
> (or iommu core) should block further device attach/detach operations
> until page tracking is stopped.
But when a domain becomes capable after detaching a device, the upper layer
still needs to query it and enable dirty log for it...

To make things coordinated, maybe the upper layer can register a notifier,
when the domain's capability change, the upper layer do not need to query, instead
they just need to realize a callback, and do their specific policy in the callback.
What do you think?

> 
>>
>>> any domain attach/detach once the dirty page tracking is on.
>> Yep, this can greatly simplify our code logic, but I don't know whether our maintainers
>> agree that, as they may think that IOMMU dirty logging should not change original domain
>> behaviors.
> 
> The maintainer owns the last word, but we need to work out a generic and
> self-contained API set.
OK, I see.

Thanks,
Keqian
