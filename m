Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26043B84E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbhJZRl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbhJZRlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:41:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717CFC061228
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:38:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id v17so14298057qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f+0dxhx0YBByqqgXIIL8cnQMPKeSpMXv8H4jMMrqnmk=;
        b=ir/Wl81o8SFb3Sh0Ld1XTac6UQ4FqGpzCY8Hr8viqqYdRCJuDfGp6GDO4ZTGax32i2
         ftKODouFrQ9+3TdpquCUwwV96nDMrvCXsA8PDtAybTKJxwE6EWrzI9V8TVIdcs2LZdwO
         yGyxrZDpob7EonNK0eU/s8kZszxWTptY9V68fmETk9v0Zd7jG+itBuX4g6nsr44+X2gg
         Udj1DbLlHMu0VKG+zdjas9ytqwFb1+TouBG8RrTssaykoTfwuArOacxdI68IzT0RRY0r
         NttVZw78PSZgakLV4f8bHigwY27ZYoAjFj3+sh75mgdztjc+5qfS7EMmG5CxoDXLMMTa
         c+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f+0dxhx0YBByqqgXIIL8cnQMPKeSpMXv8H4jMMrqnmk=;
        b=rSNCB12KaaNN69pVUWnvVUEPVXek1VEKZ9y+TpfnUH9rLDSMiNMZmXPctBXIrAbiKY
         eKSKs+d2NpbaHFGuqBWFWTh9H5LpfD5/kE1fJyk3iwBccD+tOgvihriaRBUK0VgLdDnW
         1U4yOtNbpHof7w22ZDHE+v98wViF8Qsdl04xPIPteeVQoXbjWjc7Fqj3NNMDwGnFB98M
         7sFh6Z4KmQC/X8Tlt4MIxURXHdGis/B+Hbi7Tu9Z82msp0Ls2qtU8Z89cW3c0OeOHU4R
         YyhFyeBM+iQSxUNnMZl3ASe0xHkLVYi4v/vPWyXl6WHFgsardmy0y0x8WLcvNxtqIjM1
         XtEQ==
X-Gm-Message-State: AOAM532PMkeozW/7W3lBxNqDgUYOv2x/E3vArwZwlvpE2ns47YeL5GCH
        ZVdGjkUEn99piNGrrcxtdMzX8g==
X-Google-Smtp-Source: ABdhPJw1wGuOrl76ejWqGzRtvUg/0F66qljQjVxDV5PDrx9JwVBpOODE49L8czXLYboxq9sc2IZo9A==
X-Received: by 2002:a05:622a:1453:: with SMTP id v19mr27297476qtx.125.1635269911638;
        Tue, 26 Oct 2021 10:38:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id bj37sm11001939qkb.49.2021.10.26.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 10:38:31 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com
Subject: [RFC 7/8] mm: remove set_page_count()
Date:   Tue, 26 Oct 2021 17:38:21 +0000
Message-Id: <20211026173822.502506-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211026173822.502506-1-pasha.tatashin@soleen.com>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_page_count() is dangerous because it resets _refcount to an
arbitrary value. Instead we now initialize _refcount to 1 only once,
and the rest of the time we are using add/dec/cmpxchg to have a
contiguous track of the counter.

Remove set_page_count() and add new tracing hooks to page_ref_init().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h        | 19 +++++---------
 include/trace/events/page_ref.h | 46 ++++++++++++++++++++++++++++-----
 mm/debug_page_ref.c             |  8 +++---
 3 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 81a628dc9b8b..06f5760fcd06 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -7,7 +7,7 @@
 #include <linux/page-flags.h>
 #include <linux/tracepoint-defs.h>
 
-DECLARE_TRACEPOINT(page_ref_set);
+DECLARE_TRACEPOINT(page_ref_init);
 DECLARE_TRACEPOINT(page_ref_mod);
 DECLARE_TRACEPOINT(page_ref_mod_and_test);
 DECLARE_TRACEPOINT(page_ref_mod_and_return);
@@ -26,7 +26,7 @@ DECLARE_TRACEPOINT(page_ref_unfreeze);
  */
 #define page_ref_tracepoint_active(t) tracepoint_enabled(t)
 
-extern void __page_ref_set(struct page *page, int v);
+extern void __page_ref_init(struct page *page);
 extern void __page_ref_mod(struct page *page, int v);
 extern void __page_ref_mod_and_test(struct page *page, int v, int ret);
 extern void __page_ref_mod_and_return(struct page *page, int v, int ret);
@@ -38,7 +38,7 @@ extern void __page_ref_unfreeze(struct page *page, int v);
 
 #define page_ref_tracepoint_active(t) false
 
-static inline void __page_ref_set(struct page *page, int v)
+static inline void __page_ref_init(struct page *page)
 {
 }
 static inline void __page_ref_mod(struct page *page, int v)
@@ -72,15 +72,8 @@ static inline int page_count(const struct page *page)
 	return atomic_read(&compound_head(page)->_refcount);
 }
 
-static inline void set_page_count(struct page *page, int v)
-{
-	atomic_set(&page->_refcount, v);
-	if (page_ref_tracepoint_active(page_ref_set))
-		__page_ref_set(page, v);
-}
-
 /*
- * Setup the page refcount to one before being freed into the page allocator.
+ * Setup the page->_refcount to 1 before being freed into the page allocator.
  * The memory might not be initialized and therefore there cannot be any
  * assumptions about the current value of page->_refcount. This call should be
  * done during boot when memory is being initialized, during memory hotplug
@@ -89,7 +82,9 @@ static inline void set_page_count(struct page *page, int v)
  */
 static inline void page_ref_init(struct page *page)
 {
-	set_page_count(page, 1);
+	atomic_set(&page->_refcount, 1);
+	if (page_ref_tracepoint_active(page_ref_init))
+		__page_ref_init(page);
 }
 
 static inline int page_ref_add_return(struct page *page, int nr)
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 8a99c1cd417b..87551bb1df9e 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -10,6 +10,45 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
+DECLARE_EVENT_CLASS(page_ref_init_template,
+
+	TP_PROTO(struct page *page),
+
+	TP_ARGS(page),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned long, flags)
+		__field(int, count)
+		__field(int, mapcount)
+		__field(void *, mapping)
+		__field(int, mt)
+		__field(int, val)
+	),
+
+	TP_fast_assign(
+		__entry->pfn = page_to_pfn(page);
+		__entry->flags = page->flags;
+		__entry->count = page_ref_count(page);
+		__entry->mapcount = page_mapcount(page);
+		__entry->mapping = page->mapping;
+		__entry->mt = get_pageblock_migratetype(page);
+	),
+
+	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d",
+		__entry->pfn,
+		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
+		__entry->count,
+		__entry->mapcount, __entry->mapping, __entry->mt)
+);
+
+DEFINE_EVENT(page_ref_init_template, page_ref_init,
+
+	TP_PROTO(struct page *page),
+
+	TP_ARGS(page)
+);
+
 DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_PROTO(struct page *page, int v),
@@ -44,13 +83,6 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 		__entry->val)
 );
 
-DEFINE_EVENT(page_ref_mod_template, page_ref_set,
-
-	TP_PROTO(struct page *page, int v),
-
-	TP_ARGS(page, v)
-);
-
 DEFINE_EVENT(page_ref_mod_template, page_ref_mod,
 
 	TP_PROTO(struct page *page, int v),
diff --git a/mm/debug_page_ref.c b/mm/debug_page_ref.c
index f3b2c9d3ece2..e32149734122 100644
--- a/mm/debug_page_ref.c
+++ b/mm/debug_page_ref.c
@@ -5,12 +5,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_ref.h>
 
-void __page_ref_set(struct page *page, int v)
+void __page_ref_init(struct page *page)
 {
-	trace_page_ref_set(page, v);
+	trace_page_ref_init(page);
 }
-EXPORT_SYMBOL(__page_ref_set);
-EXPORT_TRACEPOINT_SYMBOL(page_ref_set);
+EXPORT_SYMBOL(__page_ref_init);
+EXPORT_TRACEPOINT_SYMBOL(page_ref_init);
 
 void __page_ref_mod(struct page *page, int v)
 {
-- 
2.33.0.1079.g6e70778dc9-goog

