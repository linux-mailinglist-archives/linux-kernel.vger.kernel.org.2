Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A352394F9C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 06:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhE3Esz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 00:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhE3Esx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 00:48:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BEBC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 21:47:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e15so3573213plh.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iF5+piAFy1H+gDGG26ovo/7bII1xMjc8kc5KVtIH7A0=;
        b=tuhSD2ZsKhjXfMbK2hbROiILRtH2bDaVw3+Mh5RkfuTk2M9lgJbitrREpNNZn4cdaq
         /VdYZ17bwQ1VHDxGY/Q1mPbzpGgZzK7ue/WacXcLrtrriXP2X5q97Xn5Qvxoxx4hT1oo
         uhCRS8b/ESaet7BMEv4idV+/mYlhNcdM/gb0jAwiAbtMJTO59UX0rhm7qHawdLu7jpbd
         7OljVKzSfT6OQfuHFiHPQZyzsFGs020jfX1UYO38g1V9JS+BgWUOJmRn2YXLq7t5thKd
         he3aRf5iCyo2bqjkfAgcQX1PHbBLtVu9dK7dy5now6pWy5D0z0tUwQ3RoPlWaWhhtZE8
         nP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iF5+piAFy1H+gDGG26ovo/7bII1xMjc8kc5KVtIH7A0=;
        b=f7FPnchCo1IjqrtumAjpjllMtFnZanVhb4QHkcbBaDdpzgaVYM4kVuyPEgE4HhY6Vd
         mbuQHQSfd2GYckfDMH+NVZ2qyLWSV+Lvw35ZWDvEBB4g/CSQHl4skQE2VVE4xgMhCE5v
         6v8RFW4DnelhYKPuuMUM5Vtuhhixae9pXFjHBq4SGFfm0Q2GVhgecaOwT2jVelniIbVw
         AOnsWcFSkkTobk/v1RXazZJ95LK3Cr+EctsZJD/QKiC/XTc1/J462+6i7pLqfIW4pUwe
         jQv6TG4FF3/XH382Ot+AMRS2m7ptmZ4oe9d1nF4A22PM7YAm9HcX8RlpcnIwRA3TJsFA
         rtBw==
X-Gm-Message-State: AOAM533qaXh4Rgz9w3hjsTsjaMeeHOPC+lk+qjYxtbANDfA8myj32rzA
        sL8O7RacoxN+NmJOaTZB7vE=
X-Google-Smtp-Source: ABdhPJwWFUxscK7TYaPSXHdNGMmeiXSBk/y8Q4Df+WenEGiACPYGesObTacCFgCnhHcIiI5K0V7qpg==
X-Received: by 2002:a17:90a:4404:: with SMTP id s4mr12768266pjg.218.1622350034746;
        Sat, 29 May 2021 21:47:14 -0700 (PDT)
Received: from localhost.localdomain (61-230-18-203.dynamic-ip.hinet.net. [61.230.18.203])
        by smtp.gmail.com with ESMTPSA id t1sm7471108pjo.33.2021.05.29.21.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 21:47:14 -0700 (PDT)
From:   Kuan-Ying Lee <kylee0686026@gmail.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Walter Wu <walter-zh.wu@mediatek.com>,
        Kuan-Ying Lee <kylee0686026@gmail.com>
Subject: [PATCH 1/1] kasan: add memory corruption identification for hardware tag-based mode
Date:   Sun, 30 May 2021 12:47:08 +0800
Message-Id: <20210530044708.7155-2-kylee0686026@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530044708.7155-1-kylee0686026@gmail.com>
References: <20210530044708.7155-1-kylee0686026@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory corruption identification at bug report for hardware tag-based
mode. The report shows whether it is "use-after-free" or "out-of-bound"
error instead of "invalid-access" error. This will make it easier for
programmers to see the memory corruption problem.

We extend the slab to store five old free pointer tag and free backtrace,
we can check if the tagged address is in the slab record and make a good
guess if the object is more like "use-after-free" or "out-of-bound".
therefore every slab memory corruption can be identified whether it's
"use-after-free" or "out-of-bound".

Signed-off-by: Kuan-Ying Lee <kylee0686026@gmail.com>
---
 lib/Kconfig.kasan         |  8 ++++++++
 mm/kasan/hw_tags.c        | 25 ++++++++++++++++++++++---
 mm/kasan/kasan.h          |  4 ++--
 mm/kasan/report_hw_tags.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index cffc2ebbf185..f7e666b23058 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -163,6 +163,14 @@ config KASAN_SW_TAGS_IDENTIFY
 	  (use-after-free or out-of-bounds) at the cost of increased
 	  memory consumption.
 
+config KASAN_HW_TAGS_IDENTIFY
+	bool "Enable memory corruption identification"
+	depends on KASAN_HW_TAGS
+	help
+	  This option enables best-effort identification of bug type
+	  (use-after-free or out-of-bounds) at the cost of increased
+	  memory consumption.
+
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
 	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 4004388b4e4b..b1c6bb116600 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -220,22 +220,41 @@ void kasan_set_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
 	struct kasan_alloc_meta *alloc_meta;
+	u8 idx = 0;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (alloc_meta)
-		kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
+	if (!alloc_meta)
+		return;
+
+#ifdef CONFIG_KASAN_HW_TAGS_IDENTIFY
+	idx = alloc_meta->free_track_idx;
+	alloc_meta->free_pointer_tag[idx] = tag;
+	alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
+#endif
+
+	kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
 }
 
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
 	struct kasan_alloc_meta *alloc_meta;
+	int i = 0;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	if (!alloc_meta)
 		return NULL;
 
-	return &alloc_meta->free_track[0];
+#ifdef CONFIG_KASAN_HW_TAGS_IDENTIFY
+	for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
+		if (alloc_meta->free_pointer_tag[i] == tag)
+			break;
+	}
+	if (i == KASAN_NR_FREE_STACKS)
+		i = alloc_meta->free_track_idx;
+#endif
+
+	return &alloc_meta->free_track[i];
 }
 
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8f450bc28045..41b47f456130 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -153,7 +153,7 @@ struct kasan_track {
 	depot_stack_handle_t stack;
 };
 
-#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
+#if defined(CONFIG_KASAN_SW_TAGS_IDENTIFY) || defined(CONFIG_KASAN_HW_TAGS_IDENTIFY)
 #define KASAN_NR_FREE_STACKS 5
 #else
 #define KASAN_NR_FREE_STACKS 1
@@ -170,7 +170,7 @@ struct kasan_alloc_meta {
 #else
 	struct kasan_track free_track[KASAN_NR_FREE_STACKS];
 #endif
-#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
+#if defined(CONFIG_KASAN_SW_TAGS_IDENTIFY) || defined(CONFIG_KASAN_HW_TAGS_IDENTIFY)
 	u8 free_pointer_tag[KASAN_NR_FREE_STACKS];
 	u8 free_track_idx;
 #endif
diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
index 42b2168755d6..d77109b85a09 100644
--- a/mm/kasan/report_hw_tags.c
+++ b/mm/kasan/report_hw_tags.c
@@ -14,9 +14,37 @@
 #include <linux/types.h>
 
 #include "kasan.h"
+#include "../slab.h"
 
 const char *kasan_get_bug_type(struct kasan_access_info *info)
 {
+#ifdef CONFIG_KASAN_HW_TAGS_IDENTIFY
+	struct kasan_alloc_meta *alloc_meta;
+	struct kmem_cache *cache;
+	struct page *page;
+	const void *addr;
+	void *object;
+	u8 tag;
+	int i;
+
+	tag = get_tag(info->access_addr);
+	addr = kasan_reset_tag(info->access_addr);
+	page = kasan_addr_to_page(addr);
+	if (page && PageSlab(page)) {
+		cache = page->slab_cache;
+		object = nearest_obj(cache, page, (void *)addr);
+		alloc_meta = kasan_get_alloc_meta(cache, object);
+
+		if (alloc_meta) {
+			for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
+				if (alloc_meta->free_pointer_tag[i] == tag)
+					return "use-after-free";
+			}
+		}
+		return "out-of-bounds";
+	}
+
+#endif
 	return "invalid-access";
 }
 
-- 
2.17.1

