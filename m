Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71DA362BDA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhDPXRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbhDPXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:17:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51336C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=E+rNvZH/v24SH+BMkGHYoijVhEslQSTS8uP6FhJ/M14=; b=TkQ2pGogRgOQhcBWFSofysPz9y
        EG/XQ0PTJ3g/SLbIv8Ezgc7TYUXOaq08D6e67Pyzy+ZyAxnN/leX522obRxIHviAu/ViCpmgL46hd
        JLEapZ2ES2byDXCOegUUy6QZEvhvswpvJD/iXsDnqKpTYjCIEE0qGaGPUCfbfcfvB/ID94Vqfzf6y
        cauzoB9/biiM98zZeNNfFlwyuaQ+gknBYEwAkVCUUAOrCI59xt77P3CT+cFEAljJamoHsMBxIzm/o
        h9a/AQc5Ovau7KXMYhVluopSQsYKE3DTuY6yPzf3NtfrCr8BbHGNlVD1mZYw/7xrALexKsQP/eHDu
        NqbFDFsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXXh0-00AZxX-8D; Fri, 16 Apr 2021 23:16:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] mm/page_owner: Constify dump_page_owner
Date:   Sat, 17 Apr 2021 00:15:28 +0100
Message-Id: <20210416231531.2521383-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210416231531.2521383-1-willy@infradead.org>
References: <20210416231531.2521383-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_page_owner() only uses struct page to find the page_ext, and
lookup_page_ext() already takes a const argument.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page_owner.h | 6 +++---
 mm/page_owner.c            | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 3468794f83d2..719bfe5108c5 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -14,7 +14,7 @@ extern void __set_page_owner(struct page *page,
 extern void __split_page_owner(struct page *page, unsigned int nr);
 extern void __copy_page_owner(struct page *oldpage, struct page *newpage);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
-extern void __dump_page_owner(struct page *page);
+extern void __dump_page_owner(const struct page *page);
 extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 					pg_data_t *pgdat, struct zone *zone);
 
@@ -46,7 +46,7 @@ static inline void set_page_owner_migrate_reason(struct page *page, int reason)
 	if (static_branch_unlikely(&page_owner_inited))
 		__set_page_owner_migrate_reason(page, reason);
 }
-static inline void dump_page_owner(struct page *page)
+static inline void dump_page_owner(const struct page *page)
 {
 	if (static_branch_unlikely(&page_owner_inited))
 		__dump_page_owner(page);
@@ -69,7 +69,7 @@ static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
 static inline void set_page_owner_migrate_reason(struct page *page, int reason)
 {
 }
-static inline void dump_page_owner(struct page *page)
+static inline void dump_page_owner(const struct page *page)
 {
 }
 #endif /* CONFIG_PAGE_OWNER */
diff --git a/mm/page_owner.c b/mm/page_owner.c
index adfabb560eb9..f51a57e92aa3 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -392,7 +392,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	return -ENOMEM;
 }
 
-void __dump_page_owner(struct page *page)
+void __dump_page_owner(const struct page *page)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
 	struct page_owner *page_owner;
-- 
2.30.2

