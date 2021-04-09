Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1432035A47F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhDIRRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:17:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:30442 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232395AbhDIRRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:17:32 -0400
IronPort-SDR: xgTrn5iMzvWO/50mqaVNS+p6sRa1ZOUWIomRuu0CVhvraWWXfXuS/F8QcSCH9MWlkO/WbCK9GF
 9ZidjiLkeHVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="190607335"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="190607335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 10:17:18 -0700
IronPort-SDR: zIQTy+bctBXPiRuqxwpT1wrH6pJVXZokV3DAjz/I+HarzA2RDLmg86m83HkfN0zyK+DOohZ9EJ
 9IQhhLrlsnQA==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="422819313"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.107.191])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 10:17:18 -0700
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@suse.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, alex.shi@linux.alibaba.com, willy@infradead.org,
        minchan@kernel.org, richard.weiyang@gmail.com,
        ying.huang@intel.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-3-linmiaohe@huawei.com>
 <7684b3de-2824-9b1f-f033-d4bc14f9e195@linux.intel.com>
 <50d34b02-c155-bad7-da1f-03807ad31275@huawei.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <995a130b-f07a-4771-1fe3-477d2f3c1e8e@linux.intel.com>
Date:   Fri, 9 Apr 2021 10:17:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <50d34b02-c155-bad7-da1f-03807ad31275@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/21 1:42 AM, Miaohe Lin wrote:
> On 2021/4/9 5:34, Tim Chen wrote:
>>
>>
>> On 4/8/21 6:08 AM, Miaohe Lin wrote:
>>> When I was investigating the swap code, I found the below possible race
>>> window:
>>>
>>> CPU 1					CPU 2
>>> -----					-----
>>> do_swap_page
>>>   synchronous swap_readpage
>>>     alloc_page_vma
>>> 					swapoff
>>> 					  release swap_file, bdev, or ...
>>
> 
> Many thanks for quick review and reply!
> 
>> Perhaps I'm missing something.  The release of swap_file, bdev etc
>> happens after we have cleared the SWP_VALID bit in si->flags in destroy_swap_extents
>> if I read the swapoff code correctly.
> Agree. Let's look this more close:
> CPU1								CPU2
> -----								-----
> swap_readpage
>   if (data_race(sis->flags & SWP_FS_OPS)) {
> 								swapoff
> 								  p->swap_file = NULL;
>     struct file *swap_file = sis->swap_file;
>     struct address_space *mapping = swap_file->f_mapping;[oops!]
> 								  ...
> 								  p->flags = 0;
>     ...
> 
> Does this make sense for you?

p->swapfile = NULL happens after the 
p->flags &= ~SWP_VALID, synchronize_rcu(), destroy_swap_extents() sequence in swapoff().

So I don't think the sequence you illustrated on CPU2 is in the right order.
That said, without get_swap_device/put_swap_device in swap_readpage, you could
potentially blow pass synchronize_rcu() on CPU2 and causes a problem.  so I think
the problematic race looks something like the following:


CPU1								CPU2
-----								-----
swap_readpage
  if (data_race(sis->flags & SWP_FS_OPS)) {
								swapoff
								  p->flags = &= ~SWP_VALID;
								  ..
								  synchronize_rcu();
								  ..
								  p->swap_file = NULL;
    struct file *swap_file = sis->swap_file;
    struct address_space *mapping = swap_file->f_mapping;[oops!]
								  ...
    ...

By adding get_swap_device/put_swap_device, then the race is fixed.


CPU1								CPU2
-----								-----
swap_readpage
  get_swap_device()
  ..
  if (data_race(sis->flags & SWP_FS_OPS)) {
								swapoff
								  p->flags = &= ~SWP_VALID;
								  ..
    struct file *swap_file = sis->swap_file;
    struct address_space *mapping = swap_file->f_mapping;[valid value]
  ..
  put_swap_device()
								  synchronize_rcu();
								  ..
								  p->swap_file = NULL;


> 
>>>
>>>       swap_readpage
>>> 	check sis->flags is ok
>>> 	  access swap_file, bdev...[oops!]
>>> 					    si->flags = 0
>>
>> This happens after we clear the si->flags
>> 					synchronize_rcu()
>> 					release swap_file, bdev, in destroy_swap_extents()
>>
>> So I think if we have get_swap_device/put_swap_device in do_swap_page,
>> it should fix the race you've pointed out here.  
>> Then synchronize_rcu() will wait till we have completed do_swap_page and
>> call put_swap_device.
> 
> Right, get_swap_device/put_swap_device could fix this race. __But__ rcu_read_lock()
> in get_swap_device() could disable preempt and do_swap_page() may take a really long
> time because it involves I/O. It may not be acceptable to disable preempt for such a
> long time. :(

I can see that it is not a good idea to hold rcu read lock for a long
time over slow file I/O operation, which will be the side effect of
introducing get/put_swap_device to swap_readpage.  So using percpu_ref
will then be preferable for synchronization once we introduce 
get/put_swap_device into swap_readpage.

Tim
