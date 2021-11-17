Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F45D453D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhKQBYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhKQBYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:24:06 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E230C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:09 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id u16so870635qvk.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1h5Wzp94/Sipgu/3o+uHq113m+sMIY4OkzO9y4mR9jc=;
        b=j9DXTx4ng57xAkRMlxqTywde1NlFoCOEP2KwbR0LpptlhgroYQV1sriPmUUvAoxlsb
         ++tJOFk2GjfvS4IWA+pr577NoNfePIp+6QCE/apcd/1a8OO0/lHeHdSXGqZPA0dphuCJ
         sHrcFzvygs8kS7MUcDUi6CMs38FUVSiqMkN28VNv+39xtD70V10KLnTQni4Z5ZtC6pHc
         l8r4wOFo+OaO5jjLRHbK3TLnhlJAwaME14h2ft8w+MxVPbEv+032MDAyeJyDWX3Uhket
         X7IKlYAvfGb/taxRPyIvEUAe4FzeReXElLIZ4j1bXDUo8I/L7Qw+HHdLoo7+nE40U7zV
         ynjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1h5Wzp94/Sipgu/3o+uHq113m+sMIY4OkzO9y4mR9jc=;
        b=Gn4XLsN1kJL0Hhj001FzfbtK21YqKWseMMDT/bN9mPECu9nIUDqR+Z0izcL8TCcb/T
         uZs2Xqh+inz3aGkEcWC+f1SL6srV6ab2vmzoIiWzWFXDO0RYd88g4oqzQD/U1spifCnc
         IKnVrC6V8qxhL6EbzMIuwtK/WewVQTwuZL04cuxJmI9gp39tP82BomtkdEo35tibJMj7
         HVwbOsLya6nvlz1+rslmmHc2qLyZgHWxW9aXMzT/mHmCYlI8Pqb4BiW1HkGVmK+xqBQp
         JP+xffZzDy4Hlb1EjL1M0Y6AhoWG2MR57Dlkm0sO9vQF0gtJUslg7zRnlXydpK0JSqXg
         xaow==
X-Gm-Message-State: AOAM531+9eapb/rgOgO4CoQEJ936NgUj10RegvvyCpsROyNBT1/S6Wg7
        qc9QOIcl7FyQxaquFtz6jDHxGA==
X-Google-Smtp-Source: ABdhPJz1xBTj4mNz+/NKiIYbHJKGeE3kTVS1OiE1f4YrzufypbcPCU4eTddlRdib3hCTe2Hbl+oLUA==
X-Received: by 2002:ad4:4e49:: with SMTP id eb9mr50037122qvb.22.1637112068328;
        Tue, 16 Nov 2021 17:21:08 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i6sm3482289qti.40.2021.11.16.17.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:21:08 -0800 (PST)
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
Subject: [RFC v2 08/10] mm: simplify page_ref_* functions
Date:   Wed, 17 Nov 2021 01:20:57 +0000
Message-Id: <20211117012059.141450-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211117012059.141450-1-pasha.tatashin@soleen.com>
References: <20211117012059.141450-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that we are using atomic_fetch* variants to add/sub/inc/dec page
_refcount, it makes sense to combined page_ref_* return and non return
functions.

Also remove some extra trace points for non-return  variants. This
improves the tracability by always recording the new _refcount value
after the modifications has occurred.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h        | 102 +++++++++-----------------------
 include/trace/events/page_ref.h |  24 ++------
 mm/debug_page_ref.c             |  14 -----
 3 files changed, 34 insertions(+), 106 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index c7033f506d68..8c76bf3bf7e1 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -8,8 +8,6 @@
 #include <linux/tracepoint-defs.h>
 
 DECLARE_TRACEPOINT(page_ref_init);
-DECLARE_TRACEPOINT(page_ref_mod);
-DECLARE_TRACEPOINT(page_ref_mod_and_test);
 DECLARE_TRACEPOINT(page_ref_mod_and_return);
 DECLARE_TRACEPOINT(page_ref_add_unless);
 DECLARE_TRACEPOINT(page_ref_freeze);
@@ -27,8 +25,6 @@ DECLARE_TRACEPOINT(page_ref_unfreeze);
 #define page_ref_tracepoint_active(t) tracepoint_enabled(t)
 
 extern void __page_ref_init(struct page *page);
-extern void __page_ref_mod(struct page *page, int v);
-extern void __page_ref_mod_and_test(struct page *page, int v, int ret);
 extern void __page_ref_mod_and_return(struct page *page, int v, int ret);
 extern void __page_ref_add_unless(struct page *page, int v, int u, int ret);
 extern void __page_ref_freeze(struct page *page, int v, int ret);
@@ -41,12 +37,6 @@ extern void __page_ref_unfreeze(struct page *page, int v);
 static inline void __page_ref_init(struct page *page)
 {
 }
-static inline void __page_ref_mod(struct page *page, int v)
-{
-}
-static inline void __page_ref_mod_and_test(struct page *page, int v, int ret)
-{
-}
 static inline void __page_ref_mod_and_return(struct page *page, int v, int ret)
 {
 }
@@ -127,12 +117,7 @@ static inline int page_ref_add_return(struct page *page, int nr)
 
 static inline void page_ref_add(struct page *page, int nr)
 {
-	int old_val = atomic_fetch_add(nr, &page->_refcount);
-	int new_val = old_val + nr;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod))
-		__page_ref_mod(page, nr);
+	page_ref_add_return(page, nr);
 }
 
 static inline void folio_ref_add(struct folio *folio, int nr)
@@ -140,30 +125,25 @@ static inline void folio_ref_add(struct folio *folio, int nr)
 	page_ref_add(&folio->page, nr);
 }
 
-static inline void page_ref_sub(struct page *page, int nr)
+static inline int page_ref_sub_return(struct page *page, int nr)
 {
 	int old_val = atomic_fetch_sub(nr, &page->_refcount);
 	int new_val = old_val - nr;
 
 	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod))
-		__page_ref_mod(page, -nr);
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, -nr, new_val);
+	return new_val;
 }
 
-static inline void folio_ref_sub(struct folio *folio, int nr)
+static inline void page_ref_sub(struct page *page, int nr)
 {
-	page_ref_sub(&folio->page, nr);
+	page_ref_sub_return(page, nr);
 }
 
-static inline int page_ref_sub_return(struct page *page, int nr)
+static inline void folio_ref_sub(struct folio *folio, int nr)
 {
-	int old_val = atomic_fetch_sub(nr, &page->_refcount);
-	int new_val = old_val - nr;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, -nr, new_val);
-	return new_val;
+	page_ref_sub(&folio->page, nr);
 }
 
 static inline int folio_ref_sub_return(struct folio *folio, int nr)
@@ -171,14 +151,20 @@ static inline int folio_ref_sub_return(struct folio *folio, int nr)
 	return page_ref_sub_return(&folio->page, nr);
 }
 
-static inline void page_ref_inc(struct page *page)
+static inline int page_ref_inc_return(struct page *page)
 {
 	int old_val = atomic_fetch_inc(&page->_refcount);
 	int new_val = old_val + 1;
 
 	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod))
-		__page_ref_mod(page, 1);
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, 1, new_val);
+	return new_val;
+}
+
+static inline void page_ref_inc(struct page *page)
+{
+	page_ref_inc_return(page);
 }
 
 static inline void folio_ref_inc(struct folio *folio)
@@ -186,14 +172,20 @@ static inline void folio_ref_inc(struct folio *folio)
 	page_ref_inc(&folio->page);
 }
 
-static inline void page_ref_dec(struct page *page)
+static inline int page_ref_dec_return(struct page *page)
 {
 	int old_val = atomic_fetch_dec(&page->_refcount);
 	int new_val = old_val - 1;
 
 	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod))
-		__page_ref_mod(page, -1);
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, -1, new_val);
+	return new_val;
+}
+
+static inline void page_ref_dec(struct page *page)
+{
+	page_ref_dec_return(page);
 }
 
 static inline void folio_ref_dec(struct folio *folio)
@@ -203,14 +195,7 @@ static inline void folio_ref_dec(struct folio *folio)
 
 static inline int page_ref_sub_and_test(struct page *page, int nr)
 {
-	int old_val = atomic_fetch_sub(nr, &page->_refcount);
-	int new_val = old_val - nr;
-	int ret = new_val == 0;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod_and_test))
-		__page_ref_mod_and_test(page, -nr, ret);
-	return ret;
+	return page_ref_sub_return(page, nr) == 0;
 }
 
 static inline int folio_ref_sub_and_test(struct folio *folio, int nr)
@@ -218,17 +203,6 @@ static inline int folio_ref_sub_and_test(struct folio *folio, int nr)
 	return page_ref_sub_and_test(&folio->page, nr);
 }
 
-static inline int page_ref_inc_return(struct page *page)
-{
-	int old_val = atomic_fetch_inc(&page->_refcount);
-	int new_val = old_val + 1;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, 1, new_val);
-	return new_val;
-}
-
 static inline int folio_ref_inc_return(struct folio *folio)
 {
 	return page_ref_inc_return(&folio->page);
@@ -236,14 +210,7 @@ static inline int folio_ref_inc_return(struct folio *folio)
 
 static inline int page_ref_dec_and_test(struct page *page)
 {
-	int old_val = atomic_fetch_dec(&page->_refcount);
-	int new_val = old_val - 1;
-	int ret = new_val == 0;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod_and_test))
-		__page_ref_mod_and_test(page, -1, ret);
-	return ret;
+	return page_ref_dec_return(page) == 0;
 }
 
 static inline int folio_ref_dec_and_test(struct folio *folio)
@@ -251,17 +218,6 @@ static inline int folio_ref_dec_and_test(struct folio *folio)
 	return page_ref_dec_and_test(&folio->page);
 }
 
-static inline int page_ref_dec_return(struct page *page)
-{
-	int old_val = atomic_fetch_dec(&page->_refcount);
-	int new_val = old_val - 1;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, -1, new_val);
-	return new_val;
-}
-
 static inline int folio_ref_dec_return(struct folio *folio)
 {
 	return page_ref_dec_return(&folio->page);
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 2b8e5a4df53b..600ea20c3e11 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -49,7 +49,7 @@ DEFINE_EVENT(page_ref_init_template, page_ref_init,
 	TP_ARGS(page)
 );
 
-DECLARE_EVENT_CLASS(page_ref_mod_template,
+DECLARE_EVENT_CLASS(page_ref_unfreeze_template,
 
 	TP_PROTO(struct page *page, int v),
 
@@ -83,14 +83,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 		__entry->val)
 );
 
-DEFINE_EVENT(page_ref_mod_template, page_ref_mod,
-
-	TP_PROTO(struct page *page, int v),
-
-	TP_ARGS(page, v)
-);
-
-DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
+DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_PROTO(struct page *page, int v, int ret),
 
@@ -163,14 +156,7 @@ DECLARE_EVENT_CLASS(page_ref_add_unless_template,
 		__entry->val, __entry->unless, __entry->ret)
 );
 
-DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_mod_and_test,
-
-	TP_PROTO(struct page *page, int v, int ret),
-
-	TP_ARGS(page, v, ret)
-);
-
-DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_mod_and_return,
+DEFINE_EVENT(page_ref_mod_template, page_ref_mod_and_return,
 
 	TP_PROTO(struct page *page, int v, int ret),
 
@@ -184,14 +170,14 @@ DEFINE_EVENT(page_ref_add_unless_template, page_ref_add_unless,
 	TP_ARGS(page, v, u, ret)
 );
 
-DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_freeze,
+DEFINE_EVENT(page_ref_mod_template, page_ref_freeze,
 
 	TP_PROTO(struct page *page, int v, int ret),
 
 	TP_ARGS(page, v, ret)
 );
 
-DEFINE_EVENT(page_ref_mod_template, page_ref_unfreeze,
+DEFINE_EVENT(page_ref_unfreeze_template, page_ref_unfreeze,
 
 	TP_PROTO(struct page *page, int v),
 
diff --git a/mm/debug_page_ref.c b/mm/debug_page_ref.c
index ad21abfec463..f5f39a77c6da 100644
--- a/mm/debug_page_ref.c
+++ b/mm/debug_page_ref.c
@@ -12,20 +12,6 @@ void __page_ref_init(struct page *page)
 EXPORT_SYMBOL(__page_ref_init);
 EXPORT_TRACEPOINT_SYMBOL(page_ref_init);
 
-void __page_ref_mod(struct page *page, int v)
-{
-	trace_page_ref_mod(page, v);
-}
-EXPORT_SYMBOL(__page_ref_mod);
-EXPORT_TRACEPOINT_SYMBOL(page_ref_mod);
-
-void __page_ref_mod_and_test(struct page *page, int v, int ret)
-{
-	trace_page_ref_mod_and_test(page, v, ret);
-}
-EXPORT_SYMBOL(__page_ref_mod_and_test);
-EXPORT_TRACEPOINT_SYMBOL(page_ref_mod_and_test);
-
 void __page_ref_mod_and_return(struct page *page, int v, int ret)
 {
 	trace_page_ref_mod_and_return(page, v, ret);
-- 
2.34.0.rc1.387.gb447b232ab-goog

