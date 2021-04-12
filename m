Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143A735B836
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 03:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhDLBov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 21:44:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:16117 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235543AbhDLBos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:44:48 -0400
IronPort-SDR: WP7ihIab611jDvhYJKrkOmidfX8AtLmhScRFE5eexnwiKN+fPquVtR/wVNy6j5exPqWAVmtETq
 BGqcMwbhcelQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="194203436"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="194203436"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 18:44:30 -0700
IronPort-SDR: /TLdrKv6QNTpc9r6cNaJvN03c0rl7R1vpQvNcc+PWAqDmUej2sY+vRll5ALrrzHw6Wxu4tLV6A
 5a3AdkRs4etQ==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="459970583"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 18:44:26 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <vbabka@suse.cz>, <alex.shi@linux.alibaba.com>,
        <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <hughd@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
References: <20210408130820.48233-1-linmiaohe@huawei.com>
        <20210408130820.48233-3-linmiaohe@huawei.com>
        <7684b3de-2824-9b1f-f033-d4bc14f9e195@linux.intel.com>
        <50d34b02-c155-bad7-da1f-03807ad31275@huawei.com>
        <995a130b-f07a-4771-1fe3-477d2f3c1e8e@linux.intel.com>
        <d2a26fb0-caef-04b7-e163-88bcda358b0d@huawei.com>
Date:   Mon, 12 Apr 2021 09:44:23 +0800
In-Reply-To: <d2a26fb0-caef-04b7-e163-88bcda358b0d@huawei.com> (Miaohe Lin's
        message of "Sat, 10 Apr 2021 11:17:29 +0800")
Message-ID: <87r1jgwa2w.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2021/4/10 1:17, Tim Chen wrote:
>> 
>> 
>> On 4/9/21 1:42 AM, Miaohe Lin wrote:
>>> On 2021/4/9 5:34, Tim Chen wrote:
>>>>
>>>>
>>>> On 4/8/21 6:08 AM, Miaohe Lin wrote:
>>>>> When I was investigating the swap code, I found the below possible race
>>>>> window:
>>>>>
>>>>> CPU 1					CPU 2
>>>>> -----					-----
>>>>> do_swap_page
>>>>>   synchronous swap_readpage
>>>>>     alloc_page_vma
>>>>> 					swapoff
>>>>> 					  release swap_file, bdev, or ...
>>>>
>>>
>>> Many thanks for quick review and reply!
>>>
>>>> Perhaps I'm missing something.  The release of swap_file, bdev etc
>>>> happens after we have cleared the SWP_VALID bit in si->flags in destroy_swap_extents
>>>> if I read the swapoff code correctly.
>>> Agree. Let's look this more close:
>>> CPU1								CPU2
>>> -----								-----
>>> swap_readpage
>>>   if (data_race(sis->flags & SWP_FS_OPS)) {
>>> 								swapoff
>>> 								  p->swap_file = NULL;
>>>     struct file *swap_file = sis->swap_file;
>>>     struct address_space *mapping = swap_file->f_mapping;[oops!]
>>> 								  ...
>>> 								  p->flags = 0;
>>>     ...
>>>
>>> Does this make sense for you?
>> 
>> p->swapfile = NULL happens after the 
>> p->flags &= ~SWP_VALID, synchronize_rcu(), destroy_swap_extents() sequence in swapoff().
>> 
>> So I don't think the sequence you illustrated on CPU2 is in the right order.
>> That said, without get_swap_device/put_swap_device in swap_readpage, you could
>> potentially blow pass synchronize_rcu() on CPU2 and causes a problem.  so I think
>> the problematic race looks something like the following:
>> 
>> 
>> CPU1								CPU2
>> -----								-----
>> swap_readpage
>>   if (data_race(sis->flags & SWP_FS_OPS)) {
>> 								swapoff
>> 								  p->flags = &= ~SWP_VALID;
>> 								  ..
>> 								  synchronize_rcu();
>> 								  ..
>> 								  p->swap_file = NULL;
>>     struct file *swap_file = sis->swap_file;
>>     struct address_space *mapping = swap_file->f_mapping;[oops!]
>> 								  ...
>>     ...
>> 
>
> Agree. This is also what I meant to illustrate. And you provide a better one. Many thanks!

For the pages that are swapped in through swap cache.  That isn't an
issue.  Because the page is locked, the swap entry will be marked with
SWAP_HAS_CACHE, so swapoff() cannot proceed until the page has been
unlocked.

So the race is for the fast path as follows,

		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
		    __swap_count(entry) == 1)

I found it in your original patch description.  But please make it more
explicit to reduce the potential confusing.

Best Regards,
Huang, Ying
