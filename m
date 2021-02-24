Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7F13238D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhBXIlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbhBXIiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:38:09 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99130C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:37:29 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id k2so1052624ili.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=U5WMw2iN95z0AMy1MV8rFaVMuu5LHFDpfbdSEGsP6SM=;
        b=OCVKcX1eyy82VQgHA/u7ZPi01D0r2gQAjBzoKmRXW0o9g2vqh+WLoao38jolMEwrIo
         EOMHpjU54voo50qx3a4MfaIQeydX5jAGupenuCU21UerPZuBmtCl83l+XntDbXgA9Qt1
         KGBSrc+/CEQfNGBLu9fecEdG6VU3Fk4eqbrgEN00D6TuYOr0CtYPuJNOTPQAP4xamBFJ
         U8McBHPZsDJsDn9IpPVe9sv5bzwJN9x6+N8GYUDoQIRMCAcuFS8uZDnBsT6QVY/zL4bI
         08ezVhC8uAjTw9vOtpbW97VIIYCZYxQIP/STCXFRap+5krSkdS4H8UtB8cIihrjzPG11
         9vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U5WMw2iN95z0AMy1MV8rFaVMuu5LHFDpfbdSEGsP6SM=;
        b=j6i9F6woP4DRvzIR6kfh8L5breqo9wFlBVOcdSSs04Us50vpFd67suB0TQ+W5XUCVj
         p1hYUJEqdzyIcGDhAuSX95k29vRpThzBeFXL1acq2Db4b4Fys7ojGW/uXEiBCFLKasxK
         Qtik2jegeSm+zbhKQiBRtNNOiiLMOdht2C22rkzrJuXBHbaA2AiW5wqyHOTAVGEYE4i6
         8TuWARrlE5dMVq2aOf8+uQnjCFx3JIvxkpG9UzM2Dp2sd7FljiTxOh2Se3dxgh7NgWKM
         a5dBTRHsZVvTeTaUn/WRG/ykgDf236ZI1tFvuQKCLUxRjiwSbF5MTsdoMy7KsmpbNdSe
         yvBQ==
X-Gm-Message-State: AOAM531cThtTGykdRDBCHLgEqaCVNHwgjBGvv3R1/e0mHdyj0ylExkTb
        pXVVQ/5QXj6BpEuYgOt7EOxdTA==
X-Google-Smtp-Source: ABdhPJyn63Mrg7X9DMVFxR92Wy+Jasaavl6P0MVm6G0wgUP4OBVEOvm5J8g2Kj0IW7NoUZiAjyBxag==
X-Received: by 2002:a92:194a:: with SMTP id e10mr24084102ilm.213.1614155848895;
        Wed, 24 Feb 2021 00:37:28 -0800 (PST)
Received: from google.com ([2620:15c:183:200:e588:e0b1:9ba0:55be])
        by smtp.gmail.com with ESMTPSA id a14sm1330867ilm.68.2021.02.24.00.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:37:28 -0800 (PST)
Date:   Wed, 24 Feb 2021 01:37:24 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list
 addition functions
Message-ID: <YDYQRPWLgijq7iNn@google.com>
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-4-yuzhao@google.com>
 <20210126220111.GO308988@casper.infradead.org>
 <YBCUTinnVrlVVm6n@google.com>
 <20210223145011.0181eed96ab0091a493b51f6@linux-foundation.org>
 <YDXkPaKb+nVzkfZX@google.com>
 <ce13ff94-e534-a4ed-4653-d9915f35d45a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce13ff94-e534-a4ed-4653-d9915f35d45a@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 04:06:45PM +0800, Alex Shi wrote:
> 
> 
> 在 2021/2/24 下午1:29, Yu Zhao 写道:
> > On Tue, Feb 23, 2021 at 02:50:11PM -0800, Andrew Morton wrote:
> >> On Tue, 26 Jan 2021 15:14:38 -0700 Yu Zhao <yuzhao@google.com> wrote:
> >>
> >>> On Tue, Jan 26, 2021 at 10:01:11PM +0000, Matthew Wilcox wrote:
> >>>> On Fri, Jan 22, 2021 at 03:05:53PM -0700, Yu Zhao wrote:
> >>>>> +++ b/mm/swap.c
> >>>>> @@ -231,7 +231,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
> >>>>>  	if (!PageUnevictable(page)) {
> >>>>>  		del_page_from_lru_list(page, lruvec, page_lru(page));
> >>>>>  		ClearPageActive(page);
> >>>>> -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> >>>>> +		add_page_to_lru_list_tail(page, lruvec);
> >>>>>  		__count_vm_events(PGROTATED, thp_nr_pages(page));
> >>>>>  	}
> >>>>
> >>>> Is it profitable to do ...
> >>>>
> >>>> -		del_page_from_lru_list(page, lruvec, page_lru(page));
> >>>> +		enum lru_list lru = page_lru(page);
> >>>> +		del_page_from_lru_list(page, lruvec, lru);
> >>>> 		ClearPageActive(page);
> >>>> -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> >>>> +		lru &= ~LRU_ACTIVE;
> >>>> +		add_page_to_lru_list_tail(page, lruvec, lru);
> >>>
> >>> Ok, now we want to trade readability for size. Sure, I'll see how
> >>> much we could squeeze.
> >>
> >> As nothing has happened here and the code bloat issue remains, I'll
> >> hold this series out of 5.12-rc1.
> > 
> > Sorry for the slow response. I was trying to ascertain why
> > page_lru(), a tiny helper, could bloat vmlinux by O(KB). It turned out
> > compound_head() included in Page{Active,Unevictable} is a nuisance in
> > our case. Testing PG_{active,unevictable} against
> > compound_head(page)->flags is really unnecessary because all lru
> > operations are eventually done on page->lru not
> > compound_head(page)->lru. With the following change, which sacrifices
> > the readability a bit, we gain 998 bytes with Clang but lose 227 bytes
> > with GCC, which IMO is a win. (We use Clang by default.)
> > 
> > 
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 355ea1ee32bd..ec0878a3cdfe 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -46,14 +46,12 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
> >  {
> >  	VM_BUG_ON_PAGE(!PageLRU(page), page);
> >  
> > -	__ClearPageLRU(page);
> > -
> >  	/* this shouldn't happen, so leave the flags to bad_page() */
> > -	if (PageActive(page) && PageUnevictable(page))
> > +	if ((page->flags & (BIT(PG_active) | BIT(PG_unevictable))) ==
> > +	    (BIT(PG_active) | BIT(PG_unevictable)))
> >  		return;
> >  
> > -	__ClearPageActive(page);
> > -	__ClearPageUnevictable(page);
> > +	page->flags &= ~(BIT(PG_lru) | BIT(PG_active) | BIT(PG_unevictable));
> >  }
> >  
> >  /**
> > @@ -65,18 +63,12 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
> >   */
> >  static __always_inline enum lru_list page_lru(struct page *page)
> >  {
> > -	enum lru_list lru;
> > +	unsigned long flags = READ_ONCE(page->flags);
> >  
> >  	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
> >  
> > -	if (PageUnevictable(page))
> > -		return LRU_UNEVICTABLE;
> > -
> > -	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
> > -	if (PageActive(page))
> > -		lru += LRU_ACTIVE;
> > -
> > -	return lru;
> > +	return (flags & BIT(PG_unevictable)) ? LRU_UNEVICTABLE :
> > +	       (LRU_FILE * !(flags & BIT(PG_swapbacked)) + !!(flags & BIT(PG_active)));
> 
> Currently each of page flags used different flags policy, does this mean above flags could be
> change to PF_ANY policy?

That's a good question. Semantically, no because
PG_{active,unevictable} only apply to head pages. But practically,
I think the answer is yes, and the only place that needs to
explicitly call compound_head() is gather_stats() in
fs/proc/task_mmu.c, IIRC.

> 
> Thanks
> Alex
> 
> >  }
> >  
> >  static __always_inline void add_page_to_lru_list(struct page *page,
> > 
> > 
> > I'll post this as a separate patch. Below the bloat-o-meter collected
> > on top of c03c21ba6f4e.
> > 
> > $ ./scripts/bloat-o-meter ../vmlinux.clang.orig ../vmlinux.clang
> > add/remove: 0/1 grow/shrink: 7/10 up/down: 191/-1189 (-998)
> > Function                                     old     new   delta
> > lru_lazyfree_fn                              848     893     +45
> > lru_deactivate_file_fn                      1037    1075     +38
> > perf_trace_mm_lru_insertion                  515     548     +33
> > check_move_unevictable_pages                 983    1006     +23
> > __activate_page                              706     729     +23
> > trace_event_raw_event_mm_lru_insertion       476     497     +21
> > lru_deactivate_fn                            691     699      +8
> > __bpf_trace_mm_lru_insertion                  13      11      -2
> > __traceiter_mm_lru_insertion                  67      62      -5
> > move_pages_to_lru                            964     881     -83
> > __pagevec_lru_add_fn                         665     581     -84
> > isolate_lru_page                             524     419    -105
> > __munlock_pagevec                           1609    1481    -128
> > isolate_migratepages_block                  3370    3237    -133
> > __page_cache_release                         556     413    -143
> > lruvec_lru_size                              151       -    -151
> > release_pages                               1025     866    -159
> > pagevec_move_tail_fn                         805     609    -196
> > Total: Before=19502982, After=19501984, chg -0.01%
> > 
> > $ ./scripts/bloat-o-meter ../vmlinux.gcc.orig ../vmlinux.gcc
> > add/remove: 0/1 grow/shrink: 9/9 up/down: 1010/-783 (227)
> > Function                                     old     new   delta
> > shrink_lruvec                               1690    1950    +260
> > lru_deactivate_file_fn                       961    1128    +167
> > isolate_migratepages_block                  3286    3427    +141
> > check_move_unevictable_pages                1042    1170    +128
> > lru_lazyfree_fn                              709     822    +113
> > lru_deactivate_fn                            665     724     +59
> > __activate_page                              703     760     +57
> > trace_event_raw_event_mm_lru_insertion       432     478     +46
> > perf_trace_mm_lru_insertion                  464     503     +39
> > __bpf_trace_mm_lru_insertion                  13      11      -2
> > __traceiter_mm_lru_insertion                  66      57      -9
> > isolate_lru_page                             472     405     -67
> > __munlock_pagevec                           1282    1212     -70
> > __pagevec_lru_add                            976     893     -83
> > __page_cache_release                         508     418     -90
> > release_pages                                978     887     -91
> > move_pages_to_lru                            954     853    -101
> > lruvec_lru_size                              131       -    -131
> > pagevec_move_tail_fn                         770     631    -139
> > Total: Before=19237248, After=19237475, chg +0.00%
> > 
