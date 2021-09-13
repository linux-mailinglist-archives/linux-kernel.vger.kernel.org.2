Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58455408A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhIML14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbhIML1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:27:51 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:35 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p23-20020a05620a22f700b003d5ac11ac5cso40823143qki.15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9lBuIl0uPI1ZQBCrnGIbYZD+uvnKuUY9gwGZHXFGUeM=;
        b=rfFKZJW7387I8bY6bZwe3tpbSrQulDsb6V7Xwc91XTAZqQ2rVHjixGGJPtC/N1ZUqQ
         yhGp8ziZ7XDZv++dd0r1xKomcebuFt3fXxSrL14JZIjrz/g8w0QFsopRiUg/0B2fCOH6
         sHz903yPsr4JP3JTMVutIG/T3ajRAjA349fLtSXz14Z+WkEdiriM41DBAbg0wTdPuxG9
         Lcx2B0ZuQeG1z+UazCNJm6rxW3utVeBQf7qnv1h3JL+uElYgkA03GRabboaMPc2S9oPD
         U5e58FCuQ2G0kN3WoUCCgjUslqVlfBfYUQAAwIp32EZpc3ctNvzIoyOFTt9EUg88uK6t
         XegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9lBuIl0uPI1ZQBCrnGIbYZD+uvnKuUY9gwGZHXFGUeM=;
        b=TbDdaX0Vo86rWpnZtthjJUcL4jIoW5IPwqwTZh0Xx5ch9lDveL9ccYi1lgdpyPSNv7
         fKymvp8S48JTXndgB+DDHbBjcLb1IG2cyJN3jPU+olAi992X7JX4rXe0EkircGEnTc6+
         rC8lE7bC/wKhKQ/oNuOHmkbNQj8fesvqB6ikPSvFHhBrT4c0ToA3KINn6T6M/LDPMlt+
         qV5Odpm4O43auL3EMplQVvf+CEYgVcdiLPJx9KMJraWpoUdeggQStgdy7iRlWiWoPOJm
         dbDajjS1m9XiYLqDO0lJ5UsRG5Rlxn2rHFlxxI4NhTOci9ZW/aIrophp40rjYtrTSoVN
         +OzQ==
X-Gm-Message-State: AOAM531O/xFdokte6c5VMvz0JFtQEU22a1Wiz3t6GsAFNnJBSEnlecWD
        8Ms5OpVYk2MbLN/zj/7feKU734py9g==
X-Google-Smtp-Source: ABdhPJyNUgHw7kceOqsp4Cupmd43ozMe7QekCJ0d68BoVeT370Wlv0ct72Ik/tHi4n3BsxxrwHEYtaLuOg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1f19:d46:38c8:7e48])
 (user=elver job=sendgmr) by 2002:a0c:ffc3:: with SMTP id h3mr1804390qvv.22.1631532394351;
 Mon, 13 Sep 2021 04:26:34 -0700 (PDT)
Date:   Mon, 13 Sep 2021 13:26:06 +0200
In-Reply-To: <20210913112609.2651084-1-elver@google.com>
Message-Id: <20210913112609.2651084-4-elver@google.com>
Mime-Version: 1.0
References: <20210913112609.2651084-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 3/6] lib/stackdepot: introduce __stack_depot_save()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2:
* Refer to __stack_depot_save() in comment of stack_depot_save().
---
 include/linux/stackdepot.h |  4 ++++
 lib/stackdepot.c           | 43 ++++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 6 deletions(-)

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
index c80a9f734253..bda58597e375 100644
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
@@ -339,6 +350,26 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
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
+ *          See __stack_depot_save() for more details.
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
2.33.0.309.g3052b89438-goog

