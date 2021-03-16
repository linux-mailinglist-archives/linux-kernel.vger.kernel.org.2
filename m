Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FBE33CAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 02:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhCPBsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 21:48:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13933 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhCPBr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:47:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dzx2W0T2vzkZRl;
        Tue, 16 Mar 2021 09:45:55 +0800 (CST)
Received: from [10.174.177.131] (10.174.177.131) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 09:47:23 +0800
Subject: Re: [PATCH v2] hugetlb_cgroup: fix imbalanced css_get and css_put
 pair for shared mappings
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <almasrymina@google.com>, <rientjes@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210301120540.37076-1-linmiaohe@huawei.com>
 <771ee69e-61d9-b1c9-b72d-3a50d2cbe4de@oracle.com>
 <7868ec9c-0762-2a78-2dfc-2bd07dca15f5@huawei.com>
 <2b23bbf7-bb32-4ed7-87ae-5e55b4bc6629@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <004ebc95-314c-1fbf-be12-cdeeda2b84d7@huawei.com>
Date:   Tue, 16 Mar 2021 09:47:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2b23bbf7-bb32-4ed7-87ae-5e55b4bc6629@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/16 2:42, Mike Kravetz wrote:
> On 3/12/21 7:11 PM, Miaohe Lin wrote:
>> On 2021/3/13 3:09, Mike Kravetz wrote:
>>> On 3/1/21 4:05 AM, Miaohe Lin wrote:
>>>> The current implementation of hugetlb_cgroup for shared mappings could have
>>>> different behavior. Consider the following two scenarios:
>>>>
>>>> 1.Assume initial css reference count of hugetlb_cgroup is 1:
>>>>   1.1 Call hugetlb_reserve_pages with from = 1, to = 2. So css reference
>>>> count is 2 associated with 1 file_region.
>>>>   1.2 Call hugetlb_reserve_pages with from = 2, to = 3. So css reference
>>>> count is 3 associated with 2 file_region.
>>>>   1.3 coalesce_file_region will coalesce these two file_regions into one.
>>>> So css reference count is 3 associated with 1 file_region now.
>>>>
>>>> 2.Assume initial css reference count of hugetlb_cgroup is 1 again:
>>>>   2.1 Call hugetlb_reserve_pages with from = 1, to = 3. So css reference
>>>> count is 2 associated with 1 file_region.
>>>>
>>>> Therefore, we might have one file_region while holding one or more css
>>>> reference counts. This inconsistency could lead to imbalanced css_get()
>>>> and css_put() pair. If we do css_put one by one (i.g. hole punch case),
>>>> scenario 2 would put one more css reference. If we do css_put all together
>>>> (i.g. truncate case), scenario 1 will leak one css reference.
>>>>
>>>> The imbalanced css_get() and css_put() pair would result in a non-zero
>>>> reference when we try to destroy the hugetlb cgroup. The hugetlb cgroup
>>>> directory is removed __but__ associated resource is not freed. This might
>>>> result in OOM or can not create a new hugetlb cgroup in a busy workload
>>>> ultimately.
>>>>
>>>> In order to fix this, we have to make sure that one file_region must hold
>>>> and only hold one css reference. So in coalesce_file_region case, we should
>>>
>>> I think this would sound/read better if stated as:
>>> ... one file_region must hold exactly one css reference ...
>>>
>>> This phrase is repeated in comments throughout the patch.
>>>
>>>> release one css reference before coalescence. Also only put css reference
>>>> when the entire file_region is removed.
>>>>
>>>> The last thing to note is that the caller of region_add() will only hold
>>>> one reference to h_cg->css for the whole contiguous reservation region.
>>>> But this area might be scattered when there are already some file_regions
>>>> reside in it. As a result, many file_regions may share only one h_cg->css
>>>> reference. In order to ensure that one file_region must hold and only hold
>>>> one h_cg->css reference, we should do css_get() for each file_region and
>>>> release the reference held by caller when they are done.
>>>
>>> Thanks for adding this to the commit message.
>>>
>>>>
>>>> Fixes: 075a61d07a8e ("hugetlb_cgroup: add accounting for shared mappings")
>>>> Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> Cc: stable@kernel.org
>>>> ---
>>>> v1->v2:
>>>> 	Fix auto build test ERROR when CGROUP_HUGETLB is disabled.
>>>> ---
>>>>  include/linux/hugetlb_cgroup.h | 15 ++++++++++--
>>>>  mm/hugetlb.c                   | 42 ++++++++++++++++++++++++++++++----
>>>>  mm/hugetlb_cgroup.c            | 11 +++++++--
>>>>  3 files changed, 60 insertions(+), 8 deletions(-)
>>>
>>> Just a few minor nits below, all in comments.  It is not required, but
>>> would be nice to update these.  Code looks good.
>>>
>>
>> Many thanks for review! I will fix all this nits. Should I resend this patch or send another
>> one to fix this? Just let me know which is the easiest one for you.
>>
>> Thanks again. :)
>>
> 
> This is really Andrew's call as it goes through his tree.
> 

Sorry, I should have sought advice from Andrew explictly.

> I would suggest you just update the comments and send another verion.
> In that way, Andrew can do whatever is easiest for him.

Will send v3. Many thanks.

> 

