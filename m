Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D2A408A20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbhIML2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbhIML1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:27:55 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFDBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:40 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v21-20020a05620a0a9500b003d5c1e2f277so40514693qkg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RLfVSTnmaFR6BCLsdGDNNy/lIjkdCKWfb/4pjdgI7U4=;
        b=FgLtShlMOVfjaXGo7f/oS0G8myvJmOGkAHupBhG1n66pC03AfWY1h02QQwxGm/BC2q
         NIiVoAt5RptGMta67XGFwYCxNjlG5g+z4pbIT5EDeS+HaFlHPyxz6XLuLeBlG+4Abr3v
         kYNbhUcrEFGFUE4/+CaCg1scl6StUbvOZxBpqOPfJgxIHfBIzP1tOoqI5daIERLmD/Xx
         y79UikpTXnQMSKEd6Zhq79VGWW3+g8XJG6WHCYb1QvfRVRgYch7iMM9pNUn3WOVf62yO
         rmPhlXm2OXvKXpmRroN3j6TxIJlZD+7fafvKRni0OdTZ5WyJIp789q/oqpIb9A8/9eM7
         hrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RLfVSTnmaFR6BCLsdGDNNy/lIjkdCKWfb/4pjdgI7U4=;
        b=So/1lXcQ6MODllTNIjmaL0MkL2e9tY4dxjJapGi48P/60KLqxJI6t0lE+De98hBE/A
         ZbAb0fIehbMdk5Sh4gdSp5RkSnX3Buawl8wGjBPFhsfPsLxZYgXgIzCtgz6zix4Gn4Rq
         3FiScxOhjLdfjlVWt6AOnchuJyPC1G4ydnioi0++P7UzIWXSNYcDyGrxIlopJ7ko+66c
         OZB9Wj+pt8XAF8W9gzjWtAEAxRws012GjN121VU88e4QVqQpJzIGYDFY4ypO5owTIij5
         /wImhCiaHtOMCk/sPFgaSIyhAetb/F2KGQF5wwzhZU+Pfy1Ig5z9uPfRxZE/0AeboXMG
         szHw==
X-Gm-Message-State: AOAM530t2sxUX1tEbVX2xWqxbLpBujWKmszYE1lpS+4JnT99o8roiicX
        7tCyiz3uxTfYemlAyu1JR7/UB2NIqg==
X-Google-Smtp-Source: ABdhPJwEBO7FeGHgJTcmfUUVA+smyLBjaAlSYjqDfG51drrvptWMJdaA6VPLMTvhcadpEq6oPbHI9LyatA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1f19:d46:38c8:7e48])
 (user=elver job=sendgmr) by 2002:ad4:56a8:: with SMTP id bd8mr9898132qvb.0.1631532399089;
 Mon, 13 Sep 2021 04:26:39 -0700 (PDT)
Date:   Mon, 13 Sep 2021 13:26:08 +0200
In-Reply-To: <20210913112609.2651084-1-elver@google.com>
Message-Id: <20210913112609.2651084-6-elver@google.com>
Mime-Version: 1.0
References: <20210913112609.2651084-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 5/6] kasan: generic: introduce kasan_record_aux_stack_noalloc()
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

Introduce a variant of kasan_record_aux_stack() that does not do any
memory allocation through stackdepot. This will permit using it in
contexts that cannot allocate any memory.

Signed-off-by: Marco Elver <elver@google.com>
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/kasan.h |  2 ++
 mm/kasan/generic.c    | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index dd874a1ee862..736d7b458996 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -370,12 +370,14 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_record_aux_stack(void *ptr);
+void kasan_record_aux_stack_noalloc(void *ptr);
 
 #else /* CONFIG_KASAN_GENERIC */
 
 static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
 static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 static inline void kasan_record_aux_stack(void *ptr) {}
+static inline void kasan_record_aux_stack_noalloc(void *ptr) {}
 
 #endif /* CONFIG_KASAN_GENERIC */
 
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 2a8e59e6326d..84a038b07c6f 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -328,7 +328,7 @@ DEFINE_ASAN_SET_SHADOW(f3);
 DEFINE_ASAN_SET_SHADOW(f5);
 DEFINE_ASAN_SET_SHADOW(f8);
 
-void kasan_record_aux_stack(void *addr)
+static void __kasan_record_aux_stack(void *addr, bool can_alloc)
 {
 	struct page *page = kasan_addr_to_page(addr);
 	struct kmem_cache *cache;
@@ -345,7 +345,17 @@ void kasan_record_aux_stack(void *addr)
 		return;
 
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT, true);
+	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT, can_alloc);
+}
+
+void kasan_record_aux_stack(void *addr)
+{
+	return __kasan_record_aux_stack(addr, true);
+}
+
+void kasan_record_aux_stack_noalloc(void *addr)
+{
+	return __kasan_record_aux_stack(addr, false);
 }
 
 void kasan_set_free_info(struct kmem_cache *cache,
-- 
2.33.0.309.g3052b89438-goog

