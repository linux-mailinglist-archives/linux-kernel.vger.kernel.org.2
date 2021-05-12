Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A1C37B83A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhELIp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:45:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2639 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELIp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:45:27 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fg7ZR35LGzlYJM;
        Wed, 12 May 2021 16:42:07 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 16:44:11 +0800
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
 <60182a35-e151-7150-3708-4e58dd8e78da@huawei.com>
 <36cc7267-6aa3-db54-b08c-c2dfc0bbacb6@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <e38f1837-b814-3717-2faf-4df8349cb57c@huawei.com>
Date:   Wed, 12 May 2021 16:44:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <36cc7267-6aa3-db54-b08c-c2dfc0bbacb6@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/12 11:20, Lu Baolu wrote:
> On 5/11/21 3:40 PM, Keqian Zhu wrote:
>>> For upper layers, before starting page tracking, they check the
>>> dirty_page_trackable attribution of the domain and start it only it's
>>> capable. Once the page tracking is switched on the vendor iommu driver
>>> (or iommu core) should block further device attach/detach operations
>>> until page tracking is stopped.
>> But when a domain becomes capable after detaching a device, the upper layer
>> still needs to query it and enable dirty log for it...
>>
>> To make things coordinated, maybe the upper layer can register a notifier,
>> when the domain's capability change, the upper layer do not need to query, instead
>> they just need to realize a callback, and do their specific policy in the callback.
>> What do you think?
>>
> 
> That might be an option. But why not checking domain's attribution every
> time a new tracking period is about to start?
Hi Baolu,

I'll add an attribution in iommu_domain, and the vendor iommu driver will update
the attribution when attach/detach devices.

The attribute should be protected by a lock, so the upper layer shouldn't access
the attribute directly. Then the iommu_domain_support_dirty_log() still should be
retained. Does this design looks good to you?

Thanks,
Keqian
