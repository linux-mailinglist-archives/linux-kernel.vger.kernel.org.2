Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80016363C13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhDSHFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:05:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:44012 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237536AbhDSHFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:05:01 -0400
IronPort-SDR: yKiEiJZ48TAJtM6rwLPR0LdxxjhM5UcXvKcrATZmw+HT943rCX0LIupXQbqAsJ5EV+hezSznfp
 usAI0jg3mr2w==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="195307314"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="195307314"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 00:04:32 -0700
IronPort-SDR: MUlDaBI5HASs6JlvlWKixauRiUFFsY672fNMw7FpcTRvWpYdDHMy0czmht7QiDdWJewXa95YlQ
 gR17TXsXHsuw==
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="534047464"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 00:04:28 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v2 5/5] mm/shmem: fix shmem_swapin() race with swapoff
References: <20210417094039.51711-1-linmiaohe@huawei.com>
        <20210417094039.51711-6-linmiaohe@huawei.com>
        <87r1j7kok3.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <ed215f73-93c1-d47b-e440-30701a7fca46@huawei.com>
Date:   Mon, 19 Apr 2021 15:04:11 +0800
In-Reply-To: <ed215f73-93c1-d47b-e440-30701a7fca46@huawei.com> (Miaohe Lin's
        message of "Mon, 19 Apr 2021 14:49:47 +0800")
Message-ID: <87h7k24uxg.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2021/4/19 10:15, Huang, Ying wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>> 
>>> When I was investigating the swap code, I found the below possible race
>>> window:
>>>
>>> CPU 1                                           CPU 2
>>> -----                                           -----
>>> shmem_swapin
>>>   swap_cluster_readahead
>>>     if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
>>>                                                 swapoff
>>>                                                   si->flags &= ~SWP_VALID;
>>>                                                   ..
>>>                                                   synchronize_rcu();
>>>                                                   ..
>> 
>> You have removed these code in the previous patches of the series.  And
>> they are not relevant in this patch.
>
> Yes, I should change these. Thanks.
>
>> 
>>>                                                   si->swap_file = NULL;
>>>     struct inode *inode = si->swap_file->f_mapping->host;[oops!]
>>>
>>> Close this race window by using get/put_swap_device() to guard against
>>> concurrent swapoff.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> 
>> No.  This isn't the commit that introduces the race condition.  Please
>> recheck your git blame result.
>> 
>
> I think this is really hard to find exact commit. I used git blame and found
> this race should be existed when this is introduced. Any suggestion ?
> Thanks.

I think the commit that introduces the race condition is commit
8fd2e0b505d1 ("mm: swap: check if swap backing device is congested or
not")

Best Regards,
Huang, Ying

>> Best Regards,
>> Huang, Ying
>> 
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/shmem.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 26c76b13ad23..936ba5595297 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -1492,15 +1492,21 @@ static void shmem_pseudo_vma_destroy(struct vm_area_struct *vma)
>>>  static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
>>>  			struct shmem_inode_info *info, pgoff_t index)
>>>  {
>>> +	struct swap_info_struct *si;
>>>  	struct vm_area_struct pvma;
>>>  	struct page *page;
>>>  	struct vm_fault vmf = {
>>>  		.vma = &pvma,
>>>  	};
>>>  
>>> +	/* Prevent swapoff from happening to us. */
>>> +	si = get_swap_device(swap);
>>> +	if (unlikely(!si))
>>> +		return NULL;
>>>  	shmem_pseudo_vma_init(&pvma, info, index);
>>>  	page = swap_cluster_readahead(swap, gfp, &vmf);
>>>  	shmem_pseudo_vma_destroy(&pvma);
>>> +	put_swap_device(si);
>>>  
>>>  	return page;
>>>  }
>> .
>> 
