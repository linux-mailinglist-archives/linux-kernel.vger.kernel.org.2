Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B874235EABE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhDNCVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:21:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16555 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbhDNCVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:21:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKmMv6nqQzNvYw;
        Wed, 14 Apr 2021 10:17:47 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 10:20:37 +0800
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
To:     "Huang, Ying" <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
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
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <26c15777-d775-967b-3ddf-1db983154053@huawei.com>
Date:   Wed, 14 Apr 2021 10:20:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <878s5lu16i.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/14 9:04, Huang, Ying wrote:
> Tim Chen <tim.c.chen@linux.intel.com> writes:
> 
>> On 4/12/21 6:27 PM, Huang, Ying wrote:
>>
>>>
>>> This isn't the commit that introduces the race.  You can use `git blame`
>>> find out the correct commit.  For this it's commit 0bcac06f27d7 "mm,
>>> swap: skip swapcache for swapin of synchronous device".
>>>
>>> And I suggest to merge 1/5 and 2/5 to make it easy to get the full
>>> picture.
>>
>> I'll suggest make fix to do_swap_page race with get/put_swap_device
>> as a first patch. Then the per_cpu_ref stuff in patch 1 and patch 2 can
>> be combined together.
> 
> The original get/put_swap_device() use rcu_read_lock/unlock().  I don't
> think it's good to wrap swap_read_page() with it.  After all, some
> complex operations are done in swap_read_page(), including
> blk_io_schedule().
> 

The patch was split to make it easier to review originally, i.e. 1/5 introduces
the percpu_ref to swap and 2/5 uses it to fix the race between do_swap_page()
and swapoff.
Btw, I have no preference for merging 1/5 and 2/5 or not.

> Best Regards,
> Huang, Ying
> .
> 

