Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88435B7DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 02:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbhDLAz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 20:55:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:12362 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235388AbhDLAzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 20:55:25 -0400
IronPort-SDR: 6nh6IxeGRSHOzk95MTlgjvllmI9QROPNINfWv5EPoZwpL4yx+3pvqKBlK6ZpcHu60ew8Fd2X8R
 iSy9u56Gyz7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="194198797"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="194198797"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 17:55:07 -0700
IronPort-SDR: T0w+1dSLSNJceumKgMBiMnlQebHoIE4I9Fv+9sQrumPYKc3AGx5lqaQAKY713tP7MbcVtqlLzc
 5H30oT+UFXUg==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="459960660"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 17:55:03 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 4/5] mm/swap_state: fix potential faulted in race in
 swap_ra_info()
References: <20210408130820.48233-1-linmiaohe@huawei.com>
        <20210408130820.48233-5-linmiaohe@huawei.com>
        <874kgfyh85.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <d88fbae4-20f5-0c7f-1c9b-b814b87ab222@huawei.com>
Date:   Mon, 12 Apr 2021 08:55:01 +0800
In-Reply-To: <d88fbae4-20f5-0c7f-1c9b-b814b87ab222@huawei.com> (Miaohe Lin's
        message of "Fri, 9 Apr 2021 17:00:02 +0800")
Message-ID: <87v98swcd6.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2021/4/9 16:50, Huang, Ying wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>> 
>>> While we released the pte lock, somebody else might faulted in this pte.
>>> So we should check whether it's swap pte first to guard against such race
>>> or swp_type would be unexpected. And we can also avoid some unnecessary
>>> readahead cpu cycles possibly.
>>>
>>> Fixes: ec560175c0b6 ("mm, swap: VMA based swap readahead")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/swap_state.c | 13 +++++++++----
>>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>>> index 709c260d644a..3bf0d0c297bc 100644
>>> --- a/mm/swap_state.c
>>> +++ b/mm/swap_state.c
>>> @@ -724,10 +724,10 @@ static void swap_ra_info(struct vm_fault *vmf,
>>>  {
>>>  	struct vm_area_struct *vma = vmf->vma;
>>>  	unsigned long ra_val;
>>> -	swp_entry_t entry;
>>> +	swp_entry_t swap_entry;
>>>  	unsigned long faddr, pfn, fpfn;
>>>  	unsigned long start, end;
>>> -	pte_t *pte, *orig_pte;
>>> +	pte_t *pte, *orig_pte, entry;
>>>  	unsigned int max_win, hits, prev_win, win, left;
>>>  #ifndef CONFIG_64BIT
>>>  	pte_t *tpte;
>>> @@ -742,8 +742,13 @@ static void swap_ra_info(struct vm_fault *vmf,
>>>  
>>>  	faddr = vmf->address;
>>>  	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
>>> -	entry = pte_to_swp_entry(*pte);
>>> -	if ((unlikely(non_swap_entry(entry)))) {
>>> +	entry = *pte;
>>> +	if (unlikely(!is_swap_pte(entry))) {
>>> +		pte_unmap(orig_pte);
>>> +		return;
>>> +	}
>>> +	swap_entry = pte_to_swp_entry(entry);
>>> +	if ((unlikely(non_swap_entry(swap_entry)))) {
>>>  		pte_unmap(orig_pte);
>>>  		return;
>>>  	}
>> 
>> This isn't a real issue.  entry or swap_entry isn't used in this
>
> Agree. It seems the entry or swap_entry here is just used for check whether
> pte is still valid swap_entry.

If you check the git history, you will find that the check has been
necessary before.  Because the function is used earlier in
do_swap_page() at that time.

Best Regards,
Huang, Ying
