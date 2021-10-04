Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECB1420F6E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbhJDNeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:34:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3911 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbhJDNcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:32:41 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HNM2k6pySz67b2m;
        Mon,  4 Oct 2021 21:27:26 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 4 Oct 2021 15:30:50 +0200
Received: from [10.47.27.199] (10.47.27.199) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 14:30:49 +0100
Subject: Re: [PATCH 5/5] iommu/iova: Avoid double-negatives in magazine
 helpers
To:     Will Deacon <will@kernel.org>
CC:     <joro@8bytes.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <robin.murphy@arm.com>, <xieyongji@bytedance.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <virtualization@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thunder.leizhen@huawei.com>, <baolu.lu@linux.intel.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-6-git-send-email-john.garry@huawei.com>
 <20211004113836.GB27373@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <743a089c-6b5f-ed3f-d0bd-23b891c03a66@huawei.com>
Date:   Mon, 4 Oct 2021 14:33:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211004113836.GB27373@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.199]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2021 12:38, Will Deacon wrote:

Hi Will,

>> To avoid this, stop using double-negatives, like !iova_magazine_full() and
>> !iova_magazine_empty(), and use positive tests, like
>> iova_magazine_has_space() and iova_magazine_has_pfns(), respectively; these
>> can safely deal with cpu_rcache->{loaded, prev} = NULL.
> I don't understand why you're saying that things like !iova_magazine_empty()
> are double-negatives. What about e.g. !list_empty() elsewhre in the kernel?

IMO, a check for an empty magazine is a negative check, as opposed to a 
check for availability.

But I'm not saying that patterns like !list_empty() are a bad practice. 
I'm just saying that they are not NULL safe, and that matters in this 
case as we can potentially pass a NULL pointer.

> 
> The crux of the fix seems to be:
> 
>> @@ -783,8 +787,9 @@ static bool __iova_rcache_insert(struct iova_caching_domain *rcached,
>>   		if (new_mag) {
>>   			spin_lock(&rcache->lock);
>>   			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
>> -				rcache->depot[rcache->depot_size++] =
>> -						cpu_rcache->loaded;
>> +				if (cpu_rcache->loaded)
>> +					rcache->depot[rcache->depot_size++] =
>> +							cpu_rcache->loaded;
> Which could be independent of the renaming?

If cpu_rcache->loaded was NULL, then we crash before we reach this code.

Anyway, since I earlier reworked init_iova_rcaches() to properly handle 
failed mem allocations for rcache->cpu_rcaches, I can rework further to 
fail the init for failed mem allocations for cpu_rcaches->loaded, so we 
don't need this change.

Thanks,
John
