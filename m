Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277A6324601
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 22:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhBXV5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 16:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbhBXV5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 16:57:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0142C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6WxIneZcO/SUH7hErcEWS3By/z8JN7qOPJP3yPgVG+0=; b=C/a2VuDZIiwEjZoMFuz3vCeMyD
        O37a/I9/fTysH6djR9rxz1msOVy6CVzBDEcWB5cmGXP1TGjKIpEoI3aK9Ng8veH0smDSUcCw97ZVU
        6lr5yUaime/8T1qthLiqAsXxS0K2gGSh6/FwlImI1CzSWTX3i+6gua9J93nEXHiIyR2JchO/ndqBV
        RJ22QBlw4HdyDPYmCsXGfP4b6LhXsvRP0hY2glbB59kR8vknkrOKMfoQzxi6G7cc2e54d+OaQ5cNh
        +JMc94gUHjXcDwYQcVwENsH2XlTllc7MtrnGGRPA1KE6ywqoLHBCqOwqtg2e+XAas+s2+TAlh/50t
        DBFLHXZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lF299-009w0c-Fb; Wed, 24 Feb 2021 21:56:42 +0000
Date:   Wed, 24 Feb 2021 21:56:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, vbabka@suse.cz,
        alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm: test page->flags directly in page_lru()
Message-ID: <20210224215639.GT2858050@casper.infradead.org>
References: <20210122220600.906146-11-yuzhao@google.com>
 <20210224084807.2179942-1-yuzhao@google.com>
 <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 05:15:58AM -0800, Andrew Morton wrote:
> Here's what the preprocessor produces for an allmodconfig version of
> PageActive():
> 
> static inline __attribute__((__gnu_inline__)) __attribute__((__unused__)) __attribute__((no_instrument_function)) __attribute__((__always_inline__)) int PageActive(struct page *page)
> {
> 	return test_bit(PG_active, &({ do { if (__builtin_expect(!!(PagePoisoned(compound_head(page))), 0)) { dump_page(compound_head(page), "VM_BUG_ON_PAGE(" "PagePoisoned(compound_head(page))"")"); do { ({ asm volatile("%c0: nop\n\t" ".pushsection .discard.instr_begin\n\t" ".long %c0b - .\n\t" ".popsection\n\t" : : "i" (373)); }); do { asm volatile("1:\t" ".byte 0x0f, 0x0b" "\n" ".pushsection __bug_table,\"aw\"\n" "2:\t" ".long " "1b" " - 2b" "\t# bug_entry::bug_addr\n" "\t" ".long " "%c0" " - 2b" "\t# bug_entry::file\n" "\t.word %c1" "\t# bug_entry::line\n" "\t.word %c2" "\t# bug_entry::flags\n" "\t.org 2b+%c3\n" ".popsection" : : "i" ("./include/linux/page-flags.h"), "i" (338), "i" (0), "i" (sizeof(struct bug_entry))); } while (0); do { ({ asm volatile("%c0:\n\t" ".pushsection .discard.unreachable\n\t" ".long %c0b - .\n\t" ".popsection\n\t" : : "i" (374)); }); asm volatile(""); __builtin_unreachable(); } while (0); } while (0); } } while (0); compound_head(page); })->flags);
> 
> }
> 
> That's all to test a single bit!
> 
> Four calls to compound_head().

If only somebody were working on a patch series to get rid of
all those calls to compound_head()!  Some reviews on
https://lore.kernel.org/linux-mm/20210128070404.1922318-2-willy@infradead.org/
would be nice.

So, I haven't done page_lru() yet in my folio tree.  What I would do is:

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..3895cfe6502b 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -63,22 +63,27 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
  * Returns the LRU list a page should be on, as an index
  * into the array of LRU lists.
  */
-static __always_inline enum lru_list page_lru(struct page *page)
+static __always_inline enum lru_list folio_lru(struct folio *folio)
 {
 	enum lru_list lru;
 
-	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
+	VM_BUG_ON_PAGE(FolioActive(folio) && FolioUnevictable(folio), folio);
 
-	if (PageUnevictable(page))
+	if (FolioUnevictable(folio))
 		return LRU_UNEVICTABLE;
 
-	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
-	if (PageActive(page))
+	lru = page_is_file_lru(&folio->page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
+	if (FolioActive(folio))
 		lru += LRU_ACTIVE;
 
 	return lru;
 }
 
+static __always_inline enum lru_list page_lru(struct page *page)
+{
+	return folio_lru(page_folio(page));
+}
+
 static __always_inline void add_page_to_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {

That would cause compound_head() to be called once instead of four times
(assuming VM_BUG_ON is enabled).  It can be reduced down to zero times
when the callers are converted from being page-based to being folio-based.

There is a further problem with PageFoo() being a READ_ONCE()
of page->flags, so the compiler can't CSE it.  I have ideas in that
direction too; essentially ...

	unsigned long page_flags = PageFlags(page);

	if (PageFlagUnevictable(flags))
...
	if (PageFlagsActive(flags))
...

and we can generate the PageFlagsFoo macros with the same machinery in
page-flags.h that generates PageFoo and FolioFoo.  This strikes me as
less critical than the folio work to remove all the unnecessary calls
to compound_head().

> 	movq	%rbx, %rbp	# page, _14
> # ./include/linux/page-flags.h:184: 	unsigned long head = READ_ONCE(page->compound_head);
> 	call	__sanitizer_cov_trace_pc	#

It's a bit unfair to complain about code generation with a
sanitizer-enabled build ...

