Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863DA314751
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 05:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhBIEH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 23:07:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11712 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBIDtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:49:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZSwR18dCzlHtb;
        Tue,  9 Feb 2021 11:26:15 +0800 (CST)
Received: from [10.174.179.149] (10.174.179.149) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 11:27:57 +0800
Subject: Re: [PATCH RFC] hugetlb_cgroup: fix unbalanced css_put for shared
 mappings
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <almasrymina@google.com>, <rientjes@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210123093111.60785-1-linmiaohe@huawei.com>
 <32100d84-8a26-2f8f-303f-52182ce72f52@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1f683c18-6a22-b5a9-6352-2e7d956132bb@huawei.com>
Date:   Tue, 9 Feb 2021 11:27:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <32100d84-8a26-2f8f-303f-52182ce72f52@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/9 3:52, Mike Kravetz wrote:
> On 1/23/21 1:31 AM, Miaohe Lin wrote:
>> The current implementation of hugetlb_cgroup for shared mappings could have
>> different behavior. Consider the following two scenarios:
>>
>> 1.Assume initial css reference count of hugetlb_cgroup is 1:
>>   1.1 Call hugetlb_reserve_pages with from = 1, to = 2. So css reference
>> count is 2 associated with 1 file_region.
>>   1.2 Call hugetlb_reserve_pages with from = 2, to = 3. So css reference
>> count is 3 associated with 2 file_region.
>>   1.3 coalesce_file_region will coalesce these two file_regions into one.
>> So css reference count is 3 associated with 1 file_region now.
>>
>> 2.Assume initial css reference count of hugetlb_cgroup is 1 again:
>>   2.1 Call hugetlb_reserve_pages with from = 1, to = 3. So css reference
>> count is 2 associated with 1 file_region.
>>
>> Therefore, we might have one file_region while holding one or more css
>> reference counts. This inconsistency could lead to unbalanced css_put().
>> If we do css_put one by one (i.g. hole punch case), scenario 2 would put
>> one more css reference. If we do css_put all together (i.g. truncate case),
>> scenario 1 will leak one css reference.
> 
> Sorry for the delay in replying.  This is tricky code and I needed some quiet
> time to study it.
> 

That's fine. I was trying to catch more buggy case too.

> I agree that the issue described exists.  Can you describe what a user would
> see in the above imbalance scenarios?  What happens if we do one too many
> css_put calls?  What happens if we leak the reference and do not do the
> required number of css_puts?
> 

The imbalanced css_get/css_put would result in a non-zero reference when we try to
destroy the hugetlb cgroup. The hugetlb cgroup dir is removed __but__ associated
resource is not freed. This might result in OOM or can not create a new hugetlb cgroup
in a really busy workload finally.

> The code changes look correct.
> 
> I just wish this code was not so complicated.  I think the private mapping
> case could be simplified to only take a single css_ref per reserve map.

Could you explain this more?
It seems one reserve map already takes a single css_ref. And a hugepage outside
reservation would take a single css_ref too.

> However, for shared mappings we need to track each individual reservation
> which adds the complexity.  I can not think of a better way to do things.
> 

I can't figure out one too. And the fix might make the code more complex. :(

> Please update commit message with an explanation of what users might see
> because of this issue and resubmit as a patch.
> 

Will do. Thanks.

> Thanks,
> 

Many thanks for reply. :)
