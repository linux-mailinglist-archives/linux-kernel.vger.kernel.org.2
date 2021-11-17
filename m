Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A990A453D96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhKQBYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhKQBYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:24:01 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6415C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:03 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id i13so876527qvm.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FH+5WwfhYAIPkELABVWXQa59kewrxSBrQi9rSX9g1+4=;
        b=dxGaQ1Jm6wnJiktHsiiJzi9cGowGHt9885KSWbetos6ByWbMlbSZpMM0AdmCk/Fwir
         gefma3OXH3C7sU0IlUxnVjdNvtgLrgLe6XKwKw5w1fbH0R+ibKs93tMzCu5XXe3tIROp
         9ijxwjorlCdAey9/gGKeDLoFXmNqp99+fws9Bwp2r91h2KEJxfEZbV/GQAu1xsVQzNyl
         bFI7nHzkhgsndH8Ho15TgS7s9oPElstUuROmID4N+ersMw5H20nekARp2R/NXNyY01h7
         osHsC/3oMSjy+drpFHeNREPPw05Ke+b2X05anr6Moe8zV+1JckHlwehi8jYurUTh50Sm
         Kh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FH+5WwfhYAIPkELABVWXQa59kewrxSBrQi9rSX9g1+4=;
        b=ONR23BYCtRAUTfpMiHB89NQYphPvN9YK8hcphMDQ+2C/l1DOZJdtzcI0LNNcchFxfY
         Tj2XL9shavPS3UWAKpXed2wPTgfTgZrSsU/YFFHMlQ3VABStylYEE7sfcfhZYRh3XcQd
         wRlLipeEEV5cYg1TI3C0Q+J3utjOB1WlyHLQqK5FtCYG56aSrkaOSUJoeNxiC1ybGdl+
         H+rDjeCQH1hhYRN13kC0THjPQucRcwzel6iJLhHv+KL3OZxYeJYH1V1T+Mf6yf051EED
         qVRhXwihw77p0uxMOUCMH7a2CER9N/+6+8XJTnmPMxxt/NbldT9+Tvfucy8IVq1quurL
         BtvQ==
X-Gm-Message-State: AOAM532SlectGAht2fBaGn/NWqsTX3fSfa8SBP6SyVB9c30bij3rvNrk
        94YDYL9RLh9VQPr5T+GV790OJQ==
X-Google-Smtp-Source: ABdhPJxTy8b7URnrYZvIhG5z3M4otJoTKhYmGFrYUufMdmaTlrH62mCpVzHb576jgixQZXohtggHhA==
X-Received: by 2002:a05:6214:5195:: with SMTP id kl21mr51097605qvb.42.1637112062978;
        Tue, 16 Nov 2021 17:21:02 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i6sm3482289qti.40.2021.11.16.17.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:21:02 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com
Subject: [RFC v2 01/10] mm: page_ref_add_unless() does not trace 'u' argument
Date:   Wed, 17 Nov 2021 01:20:50 +0000
Message-Id: <20211117012059.141450-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211117012059.141450-1-pasha.tatashin@soleen.com>
References: <20211117012059.141450-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In other page_ref_* functions all arguments and returns are traced, but
in page_ref_add_unless the 'u' argument which stands for unless boolean
is not traced. However, what is more confusing is that in the tracing
routine:
	__page_ref_mod_unless(struct page *page, int v, int u);

The 'u' argument present, but instead a return value is passed into
this argument.

Add a new template specific for page_ref_add_unless(), and trace all
arguments and the return value.

Fixes: 95813b8faa0c ("mm/page_ref: add tracepoint to track down page reference manipulation")

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h        | 10 ++++----
 include/trace/events/page_ref.h | 43 ++++++++++++++++++++++++++++++---
 mm/debug_page_ref.c             |  8 +++---
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 2e677e6ad09f..1903af5fb087 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -11,7 +11,7 @@ DECLARE_TRACEPOINT(page_ref_set);
 DECLARE_TRACEPOINT(page_ref_mod);
 DECLARE_TRACEPOINT(page_ref_mod_and_test);
 DECLARE_TRACEPOINT(page_ref_mod_and_return);
-DECLARE_TRACEPOINT(page_ref_mod_unless);
+DECLARE_TRACEPOINT(page_ref_add_unless);
 DECLARE_TRACEPOINT(page_ref_freeze);
 DECLARE_TRACEPOINT(page_ref_unfreeze);
 
@@ -30,7 +30,7 @@ extern void __page_ref_set(struct page *page, int v);
 extern void __page_ref_mod(struct page *page, int v);
 extern void __page_ref_mod_and_test(struct page *page, int v, int ret);
 extern void __page_ref_mod_and_return(struct page *page, int v, int ret);
-extern void __page_ref_mod_unless(struct page *page, int v, int u);
+extern void __page_ref_add_unless(struct page *page, int v, int u, int ret);
 extern void __page_ref_freeze(struct page *page, int v, int ret);
 extern void __page_ref_unfreeze(struct page *page, int v);
 
@@ -50,7 +50,7 @@ static inline void __page_ref_mod_and_test(struct page *page, int v, int ret)
 static inline void __page_ref_mod_and_return(struct page *page, int v, int ret)
 {
 }
-static inline void __page_ref_mod_unless(struct page *page, int v, int u)
+static inline void __page_ref_add_unless(struct page *page, int v, int u, int ret)
 {
 }
 static inline void __page_ref_freeze(struct page *page, int v, int ret)
@@ -237,8 +237,8 @@ static inline bool page_ref_add_unless(struct page *page, int nr, int u)
 {
 	bool ret = atomic_add_unless(&page->_refcount, nr, u);
 
-	if (page_ref_tracepoint_active(page_ref_mod_unless))
-		__page_ref_mod_unless(page, nr, ret);
+	if (page_ref_tracepoint_active(page_ref_add_unless))
+		__page_ref_add_unless(page, nr, u, ret);
 	return ret;
 }
 
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 8a99c1cd417b..c32d6d161cdb 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -94,6 +94,43 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 		__entry->val, __entry->ret)
 );
 
+DECLARE_EVENT_CLASS(page_ref_add_unless_template,
+
+	TP_PROTO(struct page *page, int v, int u, int ret),
+
+	TP_ARGS(page, v, u, ret),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned long, flags)
+		__field(int, count)
+		__field(int, mapcount)
+		__field(void *, mapping)
+		__field(int, mt)
+		__field(int, val)
+		__field(int, unless)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->pfn = page_to_pfn(page);
+		__entry->flags = page->flags;
+		__entry->count = page_ref_count(page);
+		__entry->mapcount = page_mapcount(page);
+		__entry->mapping = page->mapping;
+		__entry->mt = get_pageblock_migratetype(page);
+		__entry->val = v;
+		__entry->ret = ret;
+	),
+
+	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d unless=%d ret=%d",
+		__entry->pfn,
+		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
+		__entry->count,
+		__entry->mapcount, __entry->mapping, __entry->mt,
+		__entry->val, __entry->unless, __entry->ret)
+);
+
 DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_mod_and_test,
 
 	TP_PROTO(struct page *page, int v, int ret),
@@ -108,11 +145,11 @@ DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_mod_and_return,
 	TP_ARGS(page, v, ret)
 );
 
-DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_mod_unless,
+DEFINE_EVENT(page_ref_add_unless_template, page_ref_add_unless,
 
-	TP_PROTO(struct page *page, int v, int ret),
+	TP_PROTO(struct page *page, int v, int u, int ret),
 
-	TP_ARGS(page, v, ret)
+	TP_ARGS(page, v, u, ret)
 );
 
 DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_freeze,
diff --git a/mm/debug_page_ref.c b/mm/debug_page_ref.c
index f3b2c9d3ece2..1426d6887b01 100644
--- a/mm/debug_page_ref.c
+++ b/mm/debug_page_ref.c
@@ -33,12 +33,12 @@ void __page_ref_mod_and_return(struct page *page, int v, int ret)
 EXPORT_SYMBOL(__page_ref_mod_and_return);
 EXPORT_TRACEPOINT_SYMBOL(page_ref_mod_and_return);
 
-void __page_ref_mod_unless(struct page *page, int v, int u)
+void __page_ref_add_unless(struct page *page, int v, int u, int ret)
 {
-	trace_page_ref_mod_unless(page, v, u);
+	trace_page_ref_add_unless(page, v, u, ret);
 }
-EXPORT_SYMBOL(__page_ref_mod_unless);
-EXPORT_TRACEPOINT_SYMBOL(page_ref_mod_unless);
+EXPORT_SYMBOL(__page_ref_add_unless);
+EXPORT_TRACEPOINT_SYMBOL(page_ref_add_unless);
 
 void __page_ref_freeze(struct page *page, int v, int ret)
 {
-- 
2.34.0.rc1.387.gb447b232ab-goog

