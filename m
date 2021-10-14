Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFAE42D88A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhJNLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:51:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3979 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhJNLvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:51:36 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HVSKk1jlKz6H71h;
        Thu, 14 Oct 2021 19:46:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 14 Oct 2021 13:49:29 +0200
Received: from [10.47.26.229] (10.47.26.229) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 12:49:29 +0100
Subject: Re: [RFC] iommu: Use put_pages_list
To:     Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20210930162043.3111119-1-willy@infradead.org>
 <YV85dvlyj5LBdsro@casper.infradead.org>
 <YWgShKtp+89f1a/J@casper.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5e147b84-f048-b5ff-09d6-ceffe4c2364a@huawei.com>
Date:   Thu, 14 Oct 2021 12:52:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YWgShKtp+89f1a/J@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.229]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2021 12:20, Matthew Wilcox wrote:
> I'm going to keep pinging this patch weekly.
> 
> On Thu, Oct 07, 2021 at 07:17:02PM +0100, Matthew Wilcox wrote:
>> ping?

Robin, Were you checking this? You mentioned "I got
side-tracked trying to make io-pgtable use that freelist properly" in 
another thread, which seems related.

Thanks,
John

>>
>> On Thu, Sep 30, 2021 at 05:20:42PM +0100, Matthew Wilcox (Oracle) wrote:
>>> page->freelist is for the use of slab.  We already have the ability
>>> to free a list of pages in the core mm, but it requires the use of a
>>> list_head and for the pages to be chained together through page->lru.
>>> Switch the iommu code over to using free_pages_list().
>>>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>>   drivers/iommu/amd/io_pgtable.c | 99 +++++++++++++++-------------------
>>>   drivers/iommu/dma-iommu.c      | 11 +---
>>>   drivers/iommu/intel/iommu.c    | 89 +++++++++++-------------------
>>>   include/linux/iommu.h          |  3 +-
>>>   4 files changed, 77 insertions(+), 125 deletions(-)
>>>
