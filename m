Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9BC323928
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhBXJCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:02:54 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:59987 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233607AbhBXJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:02:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UPRGegh_1614157280;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UPRGegh_1614157280)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Feb 2021 17:01:21 +0800
Subject: Re: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list
 addition functions
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-4-yuzhao@google.com>
 <20210126220111.GO308988@casper.infradead.org> <YBCUTinnVrlVVm6n@google.com>
 <20210223145011.0181eed96ab0091a493b51f6@linux-foundation.org>
 <YDXkPaKb+nVzkfZX@google.com>
 <ce13ff94-e534-a4ed-4653-d9915f35d45a@linux.alibaba.com>
 <YDYQRPWLgijq7iNn@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <1dd70f97-982f-f150-cd4b-592a220b1c82@linux.alibaba.com>
Date:   Wed, 24 Feb 2021 17:01:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <YDYQRPWLgijq7iNn@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/2/24 下午4:37, Yu Zhao 写道:
>>> @@ -65,18 +63,12 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
>>>   */
>>>  static __always_inline enum lru_list page_lru(struct page *page)
>>>  {
>>> -	enum lru_list lru;
>>> +	unsigned long flags = READ_ONCE(page->flags);
>>>  
>>>  	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
>>>  
>>> -	if (PageUnevictable(page))
>>> -		return LRU_UNEVICTABLE;
>>> -
>>> -	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
>>> -	if (PageActive(page))
>>> -		lru += LRU_ACTIVE;
>>> -
>>> -	return lru;
>>> +	return (flags & BIT(PG_unevictable)) ? LRU_UNEVICTABLE :
>>> +	       (LRU_FILE * !(flags & BIT(PG_swapbacked)) + !!(flags & BIT(PG_active)));
>> Currently each of page flags used different flags policy, does this mean above flags could be
>> change to PF_ANY policy?
> That's a good question. Semantically, no because
> PG_{active,unevictable} only apply to head pages. But practically,
> I think the answer is yes, and the only place that needs to
> explicitly call compound_head() is gather_stats() in
> fs/proc/task_mmu.c, IIRC.
> 


A quick testing for your testing request:

# ll vmlinux vmlinux.new
-rwxr-xr-x 1 root root 62245304 Feb 24 16:57 vmlinux
-rwxr-xr-x 1 root root 62245280 Feb 24 16:55 vmlinux.new
# gcc --version
gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3)
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# scripts/bloat-o-meter vmlinux vmlinux.new
add/remove: 0/0 grow/shrink: 1/15 up/down: 1/-2008 (-2007)
Function                                     old     new   delta
vermagic                                      37      38      +1
trace_event_raw_event_mm_lru_insertion       471     418     -53
perf_trace_mm_lru_insertion                  526     473     -53
__munlock_pagevec                           1134    1069     -65
isolate_migratepages_block                  2623    2547     -76
isolate_lru_page                             384     303     -81
__pagevec_lru_add                            753     652    -101
release_pages                                780     667    -113
__page_cache_release                         429     276    -153
move_pages_to_lru                            871     702    -169
lru_lazyfree_fn                              712     539    -173
check_move_unevictable_pages                 938     763    -175
__activate_page                              665     488    -177
lru_deactivate_fn                            636     452    -184
pagevec_move_tail_fn                         597     411    -186
lru_deactivate_file_fn                      1000     751    -249
Total: Before=17029652, After=17027645, chg -0.01%
