Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668C332384D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhBXIHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:07:40 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42320 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233871AbhBXIHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:07:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UPR-KCg_1614154005;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UPR-KCg_1614154005)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Feb 2021 16:06:46 +0800
Subject: Re: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list
 addition functions
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-4-yuzhao@google.com>
 <20210126220111.GO308988@casper.infradead.org> <YBCUTinnVrlVVm6n@google.com>
 <20210223145011.0181eed96ab0091a493b51f6@linux-foundation.org>
 <YDXkPaKb+nVzkfZX@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ce13ff94-e534-a4ed-4653-d9915f35d45a@linux.alibaba.com>
Date:   Wed, 24 Feb 2021 16:06:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <YDXkPaKb+nVzkfZX@google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/2/24 ÏÂÎç1:29, Yu Zhao Ð´µÀ:
> On Tue, Feb 23, 2021 at 02:50:11PM -0800, Andrew Morton wrote:
>> On Tue, 26 Jan 2021 15:14:38 -0700 Yu Zhao <yuzhao@google.com> wrote:
>>
>>> On Tue, Jan 26, 2021 at 10:01:11PM +0000, Matthew Wilcox wrote:
>>>> On Fri, Jan 22, 2021 at 03:05:53PM -0700, Yu Zhao wrote:
>>>>> +++ b/mm/swap.c
>>>>> @@ -231,7 +231,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
>>>>>  	if (!PageUnevictable(page)) {
>>>>>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>>>>>  		ClearPageActive(page);
>>>>> -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
>>>>> +		add_page_to_lru_list_tail(page, lruvec);
>>>>>  		__count_vm_events(PGROTATED, thp_nr_pages(page));
>>>>>  	}
>>>>
>>>> Is it profitable to do ...
>>>>
>>>> -		del_page_from_lru_list(page, lruvec, page_lru(page));
>>>> +		enum lru_list lru = page_lru(page);
>>>> +		del_page_from_lru_list(page, lruvec, lru);
>>>> 		ClearPageActive(page);
>>>> -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
>>>> +		lru &= ~LRU_ACTIVE;
>>>> +		add_page_to_lru_list_tail(page, lruvec, lru);
>>>
>>> Ok, now we want to trade readability for size. Sure, I'll see how
>>> much we could squeeze.
>>
>> As nothing has happened here and the code bloat issue remains, I'll
>> hold this series out of 5.12-rc1.
> 
> Sorry for the slow response. I was trying to ascertain why
> page_lru(), a tiny helper, could bloat vmlinux by O(KB). It turned out
> compound_head() included in Page{Active,Unevictable} is a nuisance in
> our case. Testing PG_{active,unevictable} against
> compound_head(page)->flags is really unnecessary because all lru
> operations are eventually done on page->lru not
> compound_head(page)->lru. With the following change, which sacrifices
> the readability a bit, we gain 998 bytes with Clang but lose 227 bytes
> with GCC, which IMO is a win. (We use Clang by default.)
> 
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 355ea1ee32bd..ec0878a3cdfe 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -46,14 +46,12 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(!PageLRU(page), page);
>  
> -	__ClearPageLRU(page);
> -
>  	/* this shouldn't happen, so leave the flags to bad_page() */
> -	if (PageActive(page) && PageUnevictable(page))
> +	if ((page->flags & (BIT(PG_active) | BIT(PG_unevictable))) ==
> +	    (BIT(PG_active) | BIT(PG_unevictable)))
>  		return;
>  
> -	__ClearPageActive(page);
> -	__ClearPageUnevictable(page);
> +	page->flags &= ~(BIT(PG_lru) | BIT(PG_active) | BIT(PG_unevictable));
>  }
>  
>  /**
> @@ -65,18 +63,12 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
>   */
>  static __always_inline enum lru_list page_lru(struct page *page)
>  {
> -	enum lru_list lru;
> +	unsigned long flags = READ_ONCE(page->flags);
>  
>  	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
>  
> -	if (PageUnevictable(page))
> -		return LRU_UNEVICTABLE;
> -
> -	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
> -	if (PageActive(page))
> -		lru += LRU_ACTIVE;
> -
> -	return lru;
> +	return (flags & BIT(PG_unevictable)) ? LRU_UNEVICTABLE :
> +	       (LRU_FILE * !(flags & BIT(PG_swapbacked)) + !!(flags & BIT(PG_active)));

Currently each of page flags used different flags policy, does this mean above flags could be
change to PF_ANY policy?

Thanks
Alex

>  }
>  
>  static __always_inline void add_page_to_lru_list(struct page *page,
> 
> 
> I'll post this as a separate patch. Below the bloat-o-meter collected
> on top of c03c21ba6f4e.
> 
> $ ./scripts/bloat-o-meter ../vmlinux.clang.orig ../vmlinux.clang
> add/remove: 0/1 grow/shrink: 7/10 up/down: 191/-1189 (-998)
> Function                                     old     new   delta
> lru_lazyfree_fn                              848     893     +45
> lru_deactivate_file_fn                      1037    1075     +38
> perf_trace_mm_lru_insertion                  515     548     +33
> check_move_unevictable_pages                 983    1006     +23
> __activate_page                              706     729     +23
> trace_event_raw_event_mm_lru_insertion       476     497     +21
> lru_deactivate_fn                            691     699      +8
> __bpf_trace_mm_lru_insertion                  13      11      -2
> __traceiter_mm_lru_insertion                  67      62      -5
> move_pages_to_lru                            964     881     -83
> __pagevec_lru_add_fn                         665     581     -84
> isolate_lru_page                             524     419    -105
> __munlock_pagevec                           1609    1481    -128
> isolate_migratepages_block                  3370    3237    -133
> __page_cache_release                         556     413    -143
> lruvec_lru_size                              151       -    -151
> release_pages                               1025     866    -159
> pagevec_move_tail_fn                         805     609    -196
> Total: Before=19502982, After=19501984, chg -0.01%
> 
> $ ./scripts/bloat-o-meter ../vmlinux.gcc.orig ../vmlinux.gcc
> add/remove: 0/1 grow/shrink: 9/9 up/down: 1010/-783 (227)
> Function                                     old     new   delta
> shrink_lruvec                               1690    1950    +260
> lru_deactivate_file_fn                       961    1128    +167
> isolate_migratepages_block                  3286    3427    +141
> check_move_unevictable_pages                1042    1170    +128
> lru_lazyfree_fn                              709     822    +113
> lru_deactivate_fn                            665     724     +59
> __activate_page                              703     760     +57
> trace_event_raw_event_mm_lru_insertion       432     478     +46
> perf_trace_mm_lru_insertion                  464     503     +39
> __bpf_trace_mm_lru_insertion                  13      11      -2
> __traceiter_mm_lru_insertion                  66      57      -9
> isolate_lru_page                             472     405     -67
> __munlock_pagevec                           1282    1212     -70
> __pagevec_lru_add                            976     893     -83
> __page_cache_release                         508     418     -90
> release_pages                                978     887     -91
> move_pages_to_lru                            954     853    -101
> lruvec_lru_size                              131       -    -131
> pagevec_move_tail_fn                         770     631    -139
> Total: Before=19237248, After=19237475, chg +0.00%
> 
