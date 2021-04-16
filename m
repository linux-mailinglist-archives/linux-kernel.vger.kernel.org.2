Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C90E362BDD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhDPXST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhDPXSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:18:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7105AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xZhuTUvtuYk71ODuthYcq52OaEFXlTopb6bLDdjKTZU=; b=UYvM4ECxD6r09rNrzSL94mn5+A
        4PbIboPc2nW0E0eh/KfRbepmAb/F8tx6UJmD6KYgVs1L1a3OUkR9IYB55lfyQTV7qmf2RL7M/A3iH
        CD3CRmuxf3HqbQcVRhEqYdMFJInNcjpBvgoBiMBYfMBSVzDckLrZKpuOiti7qoJlEYx8ijXQQGjFU
        UzV38LiY5dbu+/FiFlM/fq/gJYG3AnFo9Tp6UzYcKUVtoflmP+y+wYiFlZAPuaZKdpYdq5IBvrwKC
        9l0+BCSYIZxyuicBgJdk8NcyTt1wMz/YiQm62QnOKDXW/kyioMe613vd8A3BvmTCQUhsAXuU26Wbb
        GRxgnwdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXXha-00Aa15-0H; Fri, 16 Apr 2021 23:16:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mm: Constify get_pfnblock_flags_mask and get_pfnblock_migratetype
Date:   Sat, 17 Apr 2021 00:15:30 +0100
Message-Id: <20210416231531.2521383-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210416231531.2521383-1-willy@infradead.org>
References: <20210416231531.2521383-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct page is not modified by these routines, so it can be marked
const.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pageblock-flags.h |  2 +-
 mm/page_alloc.c                 | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index fff52ad370c1..973fd731a520 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -54,7 +54,7 @@ extern unsigned int pageblock_order;
 /* Forward declaration */
 struct page;
 
-unsigned long get_pfnblock_flags_mask(struct page *page,
+unsigned long get_pfnblock_flags_mask(const struct page *page,
 				unsigned long pfn,
 				unsigned long mask);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0152670c6f04..4be2179eedd5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -474,7 +474,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 #endif
 
 /* Return a pointer to the bitmap storing bits affecting a block of pages */
-static inline unsigned long *get_pageblock_bitmap(struct page *page,
+static inline unsigned long *get_pageblock_bitmap(const struct page *page,
 							unsigned long pfn)
 {
 #ifdef CONFIG_SPARSEMEM
@@ -484,7 +484,7 @@ static inline unsigned long *get_pageblock_bitmap(struct page *page,
 #endif /* CONFIG_SPARSEMEM */
 }
 
-static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
+static inline int pfn_to_bitidx(const struct page *page, unsigned long pfn)
 {
 #ifdef CONFIG_SPARSEMEM
 	pfn &= (PAGES_PER_SECTION-1);
@@ -495,7 +495,7 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
 }
 
 static __always_inline
-unsigned long __get_pfnblock_flags_mask(struct page *page,
+unsigned long __get_pfnblock_flags_mask(const struct page *page,
 					unsigned long pfn,
 					unsigned long mask)
 {
@@ -520,13 +520,14 @@ unsigned long __get_pfnblock_flags_mask(struct page *page,
  *
  * Return: pageblock_bits flags
  */
-unsigned long get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
-					unsigned long mask)
+unsigned long get_pfnblock_flags_mask(const struct page *page,
+					unsigned long pfn, unsigned long mask)
 {
 	return __get_pfnblock_flags_mask(page, pfn, mask);
 }
 
-static __always_inline int get_pfnblock_migratetype(struct page *page, unsigned long pfn)
+static __always_inline int get_pfnblock_migratetype(const struct page *page,
+					unsigned long pfn)
 {
 	return __get_pfnblock_flags_mask(page, pfn, MIGRATETYPE_MASK);
 }
-- 
2.30.2

