Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15993236E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 06:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhBXFaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 00:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhBXFaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 00:30:20 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:29:39 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n14so802752iog.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L64nDafSpApw6tdJqoiLotUXxxEYlXFFzcp5NqAIWQY=;
        b=IfK/75S6Qwzl0UBlJ3CnbRenXUM2Zh3Iveesryg/c7uWLEVCv/D5kCIdLKFqTmD2aF
         rFP+sAT8h13EEZZkwAQ3qIWEHtAXPw6zhoqkHh1DSmaFwX4ZZ1V+huPddYLNJ1llTcQ1
         e0WRNHQGU5WPDnfQ5DytAb4004LGi/pVStZg2KMVAzYshWyrq/p0C4WDSckJDzsp7DcR
         EAHXHmkvf5J56/9EmSGF8DXA/c7vUVvFgxwKJgdjlKJ7CXHHqjHvu1YH5+JGFqobZO0Y
         vhh0lbbzB+VItqAtvhplLAFAuFPlV5MKUCLzw/9wbbeRflGdJOagFnQjBkAiUfUeGv8n
         ZcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L64nDafSpApw6tdJqoiLotUXxxEYlXFFzcp5NqAIWQY=;
        b=Nod73GCAkOIaGUCOLdJyVDJLdnqvymPXXMhSKwRzNIUw7LJ4jl3nQI5JD2aFLk6HiT
         hzwTs7+CMT/UrCFwcuEMbikXJmJWvWsVfODJ5LjyJvhScYZ7kFPlQ8ReM/vs9sMLaRZC
         4a2OhdQhcb+HLwfyA4swP3UCQnZ+mh6yHPevrEPckOaH2xnzaj5wAvv+kP+Sq5PHAEqz
         Z9fPCtyqDDDNoKLw+R1TI7KsyVMn97OfqEuR3jdsV37KGswDTF7SBnYS24OThXmIWqyi
         blyD/ki461aArWlSGdyg/Ur5zFNnjgkDM0ENVJLMKgIpqEuv3Oo/jULLRgakE/kio5Th
         xSSw==
X-Gm-Message-State: AOAM5339xiKaI6DUgibhyDS3KEnIIjHqo22TqDty+rbUNbR7gmvGQnXT
        bBleQ/sGoQMmY+ntVZ0Rak0Uog==
X-Google-Smtp-Source: ABdhPJzkR4Kc1vnS9U2bAasVVIUjk1PVFHl/Gt1cb/uCkk+1TbsbXnMswIj2fkEiUAKhSxlLbH3D7A==
X-Received: by 2002:a05:6602:130a:: with SMTP id h10mr20876755iov.48.1614144578729;
        Tue, 23 Feb 2021 21:29:38 -0800 (PST)
Received: from google.com ([2620:15c:183:200:e588:e0b1:9ba0:55be])
        by smtp.gmail.com with ESMTPSA id y11sm1504291iob.2.2021.02.23.21.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 21:29:38 -0800 (PST)
Date:   Tue, 23 Feb 2021 22:29:33 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list
 addition functions
Message-ID: <YDXkPaKb+nVzkfZX@google.com>
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-4-yuzhao@google.com>
 <20210126220111.GO308988@casper.infradead.org>
 <YBCUTinnVrlVVm6n@google.com>
 <20210223145011.0181eed96ab0091a493b51f6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223145011.0181eed96ab0091a493b51f6@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 02:50:11PM -0800, Andrew Morton wrote:
> On Tue, 26 Jan 2021 15:14:38 -0700 Yu Zhao <yuzhao@google.com> wrote:
> 
> > On Tue, Jan 26, 2021 at 10:01:11PM +0000, Matthew Wilcox wrote:
> > > On Fri, Jan 22, 2021 at 03:05:53PM -0700, Yu Zhao wrote:
> > > > +++ b/mm/swap.c
> > > > @@ -231,7 +231,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
> > > >  	if (!PageUnevictable(page)) {
> > > >  		del_page_from_lru_list(page, lruvec, page_lru(page));
> > > >  		ClearPageActive(page);
> > > > -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> > > > +		add_page_to_lru_list_tail(page, lruvec);
> > > >  		__count_vm_events(PGROTATED, thp_nr_pages(page));
> > > >  	}
> > > 
> > > Is it profitable to do ...
> > > 
> > > -		del_page_from_lru_list(page, lruvec, page_lru(page));
> > > +		enum lru_list lru = page_lru(page);
> > > +		del_page_from_lru_list(page, lruvec, lru);
> > > 		ClearPageActive(page);
> > > -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> > > +		lru &= ~LRU_ACTIVE;
> > > +		add_page_to_lru_list_tail(page, lruvec, lru);
> > 
> > Ok, now we want to trade readability for size. Sure, I'll see how
> > much we could squeeze.
> 
> As nothing has happened here and the code bloat issue remains, I'll
> hold this series out of 5.12-rc1.

Sorry for the slow response. I was trying to ascertain why
page_lru(), a tiny helper, could bloat vmlinux by O(KB). It turned out
compound_head() included in Page{Active,Unevictable} is a nuisance in
our case. Testing PG_{active,unevictable} against
compound_head(page)->flags is really unnecessary because all lru
operations are eventually done on page->lru not
compound_head(page)->lru. With the following change, which sacrifices
the readability a bit, we gain 998 bytes with Clang but lose 227 bytes
with GCC, which IMO is a win. (We use Clang by default.)


diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..ec0878a3cdfe 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -46,14 +46,12 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageLRU(page), page);
 
-	__ClearPageLRU(page);
-
 	/* this shouldn't happen, so leave the flags to bad_page() */
-	if (PageActive(page) && PageUnevictable(page))
+	if ((page->flags & (BIT(PG_active) | BIT(PG_unevictable))) ==
+	    (BIT(PG_active) | BIT(PG_unevictable)))
 		return;
 
-	__ClearPageActive(page);
-	__ClearPageUnevictable(page);
+	page->flags &= ~(BIT(PG_lru) | BIT(PG_active) | BIT(PG_unevictable));
 }
 
 /**
@@ -65,18 +63,12 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
  */
 static __always_inline enum lru_list page_lru(struct page *page)
 {
-	enum lru_list lru;
+	unsigned long flags = READ_ONCE(page->flags);
 
 	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
 
-	if (PageUnevictable(page))
-		return LRU_UNEVICTABLE;
-
-	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
-	if (PageActive(page))
-		lru += LRU_ACTIVE;
-
-	return lru;
+	return (flags & BIT(PG_unevictable)) ? LRU_UNEVICTABLE :
+	       (LRU_FILE * !(flags & BIT(PG_swapbacked)) + !!(flags & BIT(PG_active)));
 }
 
 static __always_inline void add_page_to_lru_list(struct page *page,


I'll post this as a separate patch. Below the bloat-o-meter collected
on top of c03c21ba6f4e.

$ ./scripts/bloat-o-meter ../vmlinux.clang.orig ../vmlinux.clang
add/remove: 0/1 grow/shrink: 7/10 up/down: 191/-1189 (-998)
Function                                     old     new   delta
lru_lazyfree_fn                              848     893     +45
lru_deactivate_file_fn                      1037    1075     +38
perf_trace_mm_lru_insertion                  515     548     +33
check_move_unevictable_pages                 983    1006     +23
__activate_page                              706     729     +23
trace_event_raw_event_mm_lru_insertion       476     497     +21
lru_deactivate_fn                            691     699      +8
__bpf_trace_mm_lru_insertion                  13      11      -2
__traceiter_mm_lru_insertion                  67      62      -5
move_pages_to_lru                            964     881     -83
__pagevec_lru_add_fn                         665     581     -84
isolate_lru_page                             524     419    -105
__munlock_pagevec                           1609    1481    -128
isolate_migratepages_block                  3370    3237    -133
__page_cache_release                         556     413    -143
lruvec_lru_size                              151       -    -151
release_pages                               1025     866    -159
pagevec_move_tail_fn                         805     609    -196
Total: Before=19502982, After=19501984, chg -0.01%

$ ./scripts/bloat-o-meter ../vmlinux.gcc.orig ../vmlinux.gcc
add/remove: 0/1 grow/shrink: 9/9 up/down: 1010/-783 (227)
Function                                     old     new   delta
shrink_lruvec                               1690    1950    +260
lru_deactivate_file_fn                       961    1128    +167
isolate_migratepages_block                  3286    3427    +141
check_move_unevictable_pages                1042    1170    +128
lru_lazyfree_fn                              709     822    +113
lru_deactivate_fn                            665     724     +59
__activate_page                              703     760     +57
trace_event_raw_event_mm_lru_insertion       432     478     +46
perf_trace_mm_lru_insertion                  464     503     +39
__bpf_trace_mm_lru_insertion                  13      11      -2
__traceiter_mm_lru_insertion                  66      57      -9
isolate_lru_page                             472     405     -67
__munlock_pagevec                           1282    1212     -70
__pagevec_lru_add                            976     893     -83
__page_cache_release                         508     418     -90
release_pages                                978     887     -91
move_pages_to_lru                            954     853    -101
lruvec_lru_size                              131       -    -131
pagevec_move_tail_fn                         770     631    -139
Total: Before=19237248, After=19237475, chg +0.00%
