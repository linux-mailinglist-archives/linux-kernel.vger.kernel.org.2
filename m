Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B42402A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhIGOQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhIGOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:15:24 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1798C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:14:14 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id v6-20020adfe4c6000000b001574f9d8336so2149148wrm.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xcObahmn+nrr83zfh05tWVTdAkOdXoaYlFTrwb+vDxw=;
        b=PwTMtZh9hU0VqLk69hEXqYfnxKsjVqFY7wOSFa1J0JB6DQhg2CtMHi//BlIXmlAJcR
         yl9HreJGMh+fm26LpJy0ArZAj++4Fu4KvyaIdfJ82LB3ATSviQI6qC2cUv53tm+SqOqo
         ZgPg/NhW5nrFtj6UtT6b7nwehz/BqtUvvuNGJ7Xqvz7NDleWgKV/yIGmUsypiwLCBrLH
         w/wrxaP8qWrm/esdH1O/wqUUWOxZN/0ETQ/gcpzJMgGZnv0+XxeRCAyCu+4EaPQOHmwf
         3rgpocuiCwu5u0uohAPSkFEYqzBswRdhUe+J3Ce5DVzKXUaqfnRxeVl7hFxA8IARySQj
         rdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xcObahmn+nrr83zfh05tWVTdAkOdXoaYlFTrwb+vDxw=;
        b=VKZzCd7oe+xnMGZPyL5IFQzMZtvHw6ohnjdpKnRTN+fVyKLrYNQL2/yLprGbAbtnu7
         OCpZOC8t2/1JQX11TSYWJkr+/6cEAcvSv0i4Xv9lQZr12fjVS50q81Sf2XyqomUgEELo
         rjieuzr9lB6NiItcWnBEYIetEePjtME41RGhugioY3g5At5Rgo29OlmF5qvUmNPc5vT0
         PQ/C838I5Cf6r6uSRJXr7LkwXV6hUw0u+Z5P8OXr5OQXIkXvetuzHmpAa3WLdABeMD6u
         gcMLRuGhH0C0KuhQNxrh0VAIlIVg7+ok7PE6PKFJfvYpv2ZZvkzNVDPSs51NX7naDP4a
         66KQ==
X-Gm-Message-State: AOAM530il6izkz1qf4Q9iqeXA8fA6+I8PPHYgmM6IWSyPl762N94mNkm
        7NBICJMdglXVVWbrqB2re5Pv3doC+w==
X-Google-Smtp-Source: ABdhPJz1b1Axug1WWI+1xRe0YSX8kMPS6z8VQ8CJ0thqYCiLI9VeUYCGXaKQD6xIAXx4V6nEcFtte+5HyQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6800:c1ea:4271:5898])
 (user=elver job=sendgmr) by 2002:a05:600c:2193:: with SMTP id
 e19mr4229864wme.40.1631024053139; Tue, 07 Sep 2021 07:14:13 -0700 (PDT)
Date:   Tue,  7 Sep 2021 16:13:06 +0200
In-Reply-To: <20210907141307.1437816-1-elver@google.com>
Message-Id: <20210907141307.1437816-6-elver@google.com>
Mime-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH 5/6] kasan: generic: introduce kasan_record_aux_stack_noalloc()
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

Introduce a variant of kasan_record_aux_stack() that does not do any
memory allocation through stackdepot. This will permit using it in
contexts that cannot allocate any memory.

Signed-off-by: Marco Elver <elver@google.com>
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
2.33.0.153.gba50c8fa24-goog

