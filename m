Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87D2402A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhIGOPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbhIGOPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:15:17 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F42C0613C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:14:08 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so15177742qvt.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ClauTO0DAc/W2CE5FaWJtasGRNKjOeQhVVw0fZ55opA=;
        b=ICdgop9Bb/UlNIicMIQWpjefBvU62X7yD2tARPBACjMMeNeFKwL6hpa4za3Q+GViph
         59yYezR+3aidPQ4onhqjPPPGR4f/IJ0F0Lq2blaciGq800jLMrwOi6qn9Tr39ECNIEHI
         wpHPULsvIva0eZTmQLyc2Xu/kI8dANICLgD99thQF9/xwBQM453Fcpo01BqwkjaiJEc7
         VW6igdwjJSIfWLdmnBMhQ/2AmmT/YbgKiSok59dlxnsL7bOq1G9Xf8FpiQS0SGrGT4sc
         IDimGSf/TGzEFVj2tZta1r7d+1QalLw3e4KnH938MLWkG9cgJiBntBlEk2MNKDx+r5/O
         XgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ClauTO0DAc/W2CE5FaWJtasGRNKjOeQhVVw0fZ55opA=;
        b=GzP1WynBcHltzXwffZY7MMReSESt6HzCXtX39C9mewmYodwdse9c7rMg8NcexQkDrO
         f8AiOkyZhV06E5LnB6vNYAnQqFd7ugKmp9QQJQnT5XdAQrdQRTn5JcOMwExJj0VDMygi
         2PIXKnH5Pzsr7tVtF00pGcbIEC6+rpITPThRUC/SNmqE0/3QfLAgu2VWDoxuVJLqgonp
         yWii5/94P35QsKNr7T4ODBl/5TlnRngYRu11tbAqWsERZlaHsLdzQcdp7zk+dR8nAMxi
         iJWnT6Iszv8YYqgb9nTDzpFMY58TdzT8mLEWhAoAyIo9QjbYAHnkCNM0poTAsegL0zv7
         n44w==
X-Gm-Message-State: AOAM531gtlGBNlp3ygvuoBt+gXF9r56SXeN8aUOgkpf5T2PhdbcQuUfZ
        ojoIWvZsjBndAk0mtMpOlRkELIhTnw==
X-Google-Smtp-Source: ABdhPJw87QSuzKKPiaQWZq+ibYy/Wvgp6rb9RM4pXrZmwrnDnpMuaZQjS0f+oetPSFS2lDFVXSeJ2ZruVQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6800:c1ea:4271:5898])
 (user=elver job=sendgmr) by 2002:a05:6214:14f2:: with SMTP id
 k18mr17256135qvw.19.1631024048156; Tue, 07 Sep 2021 07:14:08 -0700 (PDT)
Date:   Tue,  7 Sep 2021 16:13:04 +0200
In-Reply-To: <20210907141307.1437816-1-elver@google.com>
Message-Id: <20210907141307.1437816-4-elver@google.com>
Mime-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH 3/6] lib/stackdepot: introduce __stack_depot_save()
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __stack_depot_save(), which provides more fine-grained control over
stackdepot's memory allocation behaviour, in case stackdepot runs out of
"stack slabs".

Normally stackdepot uses alloc_pages() in case it runs out of space;
passing can_alloc==false to __stack_depot_save() prohibits this, at the
cost of more likely failure to record a stack trace.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/stackdepot.h |  4 ++++
 lib/stackdepot.c           | 42 ++++++++++++++++++++++++++++++++------
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 97b36dc53301..b2f7e7c6ba54 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -15,6 +15,10 @@
 
 typedef u32 depot_stack_handle_t;
 
+depot_stack_handle_t __stack_depot_save(unsigned long *entries,
+					unsigned int nr_entries,
+					gfp_t gfp_flags, bool can_alloc);
+
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index c80a9f734253..cab6cf117290 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -248,17 +248,28 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
 /**
- * stack_depot_save - Save a stack trace from an array
+ * __stack_depot_save - Save a stack trace from an array
  *
  * @entries:		Pointer to storage array
  * @nr_entries:		Size of the storage array
  * @alloc_flags:	Allocation gfp flags
+ * @can_alloc:		Allocate stack slabs (increased chance of failure if false)
+ *
+ * Saves a stack trace from @entries array of size @nr_entries. If @can_alloc is
+ * %true, is allowed to replenish the stack slab pool in case no space is left
+ * (allocates using GFP flags of @alloc_flags). If @can_alloc is %false, avoids
+ * any allocations and will fail if no space is left to store the stack trace.
+ *
+ * Context: Any context, but setting @can_alloc to %false is required if
+ *          alloc_pages() cannot be used from the current context. Currently
+ *          this is the case from contexts where neither %GFP_ATOMIC nor
+ *          %GFP_NOWAIT can be used (NMI, raw_spin_lock).
  *
- * Return: The handle of the stack struct stored in depot
+ * Return: The handle of the stack struct stored in depot, 0 on failure.
  */
-depot_stack_handle_t stack_depot_save(unsigned long *entries,
-				      unsigned int nr_entries,
-				      gfp_t alloc_flags)
+depot_stack_handle_t __stack_depot_save(unsigned long *entries,
+					unsigned int nr_entries,
+					gfp_t alloc_flags, bool can_alloc)
 {
 	struct stack_record *found = NULL, **bucket;
 	depot_stack_handle_t retval = 0;
@@ -291,7 +302,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 	 * The smp_load_acquire() here pairs with smp_store_release() to
 	 * |next_slab_inited| in depot_alloc_stack() and init_stack_slab().
 	 */
-	if (unlikely(!smp_load_acquire(&next_slab_inited))) {
+	if (unlikely(can_alloc && !smp_load_acquire(&next_slab_inited))) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
@@ -339,6 +350,25 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 fast_exit:
 	return retval;
 }
+EXPORT_SYMBOL_GPL(__stack_depot_save);
+
+/**
+ * stack_depot_save - Save a stack trace from an array
+ *
+ * @entries:		Pointer to storage array
+ * @nr_entries:		Size of the storage array
+ * @alloc_flags:	Allocation gfp flags
+ *
+ * Context: Contexts where allocations via alloc_pages() are allowed.
+ *
+ * Return: The handle of the stack struct stored in depot, 0 on failure.
+ */
+depot_stack_handle_t stack_depot_save(unsigned long *entries,
+				      unsigned int nr_entries,
+				      gfp_t alloc_flags)
+{
+	return __stack_depot_save(entries, nr_entries, alloc_flags, true);
+}
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
 static inline int in_irqentry_text(unsigned long ptr)
-- 
2.33.0.153.gba50c8fa24-goog

