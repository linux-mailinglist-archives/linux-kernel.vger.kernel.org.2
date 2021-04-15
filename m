Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA6E360037
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 05:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhDODUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 23:20:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16590 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDODUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 23:20:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FLPf84wj3z17Qhk;
        Thu, 15 Apr 2021 11:17:20 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 11:19:34 +0800
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-3-linmiaohe@huawei.com>
 <87o8ejug76.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <c9bb0a8a-72ca-d9b4-4c31-d4d8cfde0b4c@linux.intel.com>
 <878s5lu16i.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <7ce9d6a2-6a9a-1203-0566-8a3bf478876f@linux.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b652e6a6-0f4f-27d1-0a5e-6b86676ca08e@huawei.com>
Date:   Thu, 15 Apr 2021 11:19:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7ce9d6a2-6a9a-1203-0566-8a3bf478876f@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/15 0:13, Tim Chen wrote:
> 
> 
> On 4/13/21 6:04 PM, Huang, Ying wrote:
>> Tim Chen <tim.c.chen@linux.intel.com> writes:
>>
>>> On 4/12/21 6:27 PM, Huang, Ying wrote:
>>>
>>>>
>>>> This isn't the commit that introduces the race.  You can use `git blame`
>>>> find out the correct commit.  For this it's commit 0bcac06f27d7 "mm,
>>>> swap: skip swapcache for swapin of synchronous device".
>>>>
>>>> And I suggest to merge 1/5 and 2/5 to make it easy to get the full
>>>> picture.
>>>
>>> I'll suggest make fix to do_swap_page race with get/put_swap_device
>>> as a first patch. Then the per_cpu_ref stuff in patch 1 and patch 2 can
>>> be combined together.
>>
>> The original get/put_swap_device() use rcu_read_lock/unlock().  I don't
>> think it's good to wrap swap_read_page() with it.  After all, some
>> complex operations are done in swap_read_page(), including
>> blk_io_schedule().
>>
> 
> In that case then have the patches to make get/put_swap_device to use
> percpu_ref first.  And the patch to to fix the race in do_swap_page
> later in another patch.
> 
> Patch 2 is mixing the two.
> 

Looks like a good way to organize this patch series. Many thanks!

> Tim
> .
> 

