Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FED3A4CEB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 06:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFLEyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 00:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhFLEyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 00:54:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80891C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 21:52:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s14so6087109pfd.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 21:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j92rbW58nMKVCYwSujbaWen32AsKLCNI08XRkv0EOjw=;
        b=Xfi5pFS5wr+Bh+YDz4R+vXBO2Ktv1C09hoV4O9TSqdbjrlelLG/e7uFI2bfZqsDDUc
         xHqKMGdzUYPO2/F/n5wk8ntDe/8RBE3Zp3OKN/6SGRjry9Gw483Q8CWGOAsPzsA5AAoF
         lfyoowB8gd0LvlOIdOwTt+VOggIOD2NSvP7i55KhxTLAYItI7VbkwSTDkYG19fX/0eV/
         6nLVD7arWh+OGQ8psryJ1WxUvsZws7v7ONSq5rH2dUKV8tBQW96SqF+V+FZSy6UISCVk
         ylwu/ZFwO91Sw2sAd7mpJY6CA43vcGT5s47i5LnzphJlK+DLoCWszfq7EUR+HmLOoic2
         w/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j92rbW58nMKVCYwSujbaWen32AsKLCNI08XRkv0EOjw=;
        b=XRPN+qgNW783sCaG91zfOrX06ayu5YLtL9mQdWoRTsR6MWw8/7VTe/xbMhsoqQJ6El
         yISkdZpCb8FKwXhedjxewgpRcL6DJNwj8dqqtXtbUZMlqoO0Qtxs7KcDa6UF1nB9qMCz
         OFbkZ9qmj8HUHTX6cAtKLbAXwSS5SG4vOlUgBFGYpyRaEkY5aD9tsQ9YWuCBXw5t+OY5
         x2gePAAg7Lf/EJyFwVixC7Jfc53wloxktjdP7IXBxH4GygJ9St0NfD/2IlQXmXop0DJl
         sIKs3KcQg60Oi4gUeKv0exEeKxfPoYvNOrZmdFTga/IY7iLEetVYUjaUKlnCLG5hgXY8
         rlKw==
X-Gm-Message-State: AOAM531dYxlVyCKKGAc8tUpe9ouYcga9ahlOdH65CrRmm1kFaYRtuEzg
        Iuj7VwWH9gf7KagiPHi0VrA=
X-Google-Smtp-Source: ABdhPJxDo+WsgA3UnK6FWWqskp9r5kiLsOiH1I274oKbBgKPMG9WgfhorioBDDsRN1S9PsiObTQeFg==
X-Received: by 2002:aa7:8892:0:b029:2f5:33fc:1073 with SMTP id z18-20020aa788920000b02902f533fc1073mr11510790pfe.79.1623473565850;
        Fri, 11 Jun 2021 21:52:45 -0700 (PDT)
Received: from lee-virtual-machine.localdomain (61-230-42-225.dynamic-ip.hinet.net. [61.230.42.225])
        by smtp.gmail.com with ESMTPSA id m1sm6076572pgd.78.2021.06.11.21.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 21:52:45 -0700 (PDT)
From:   Kuan-Ying Lee <kylee0686026@gmail.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kuan-Ying Lee <kylee0686026@gmail.com>,
        Marco Elver <elver@google.com>
Subject: [PATCH v2 1/3] kasan: rename CONFIG_KASAN_SW_TAGS_IDENTIFY to CONFIG_KASAN_TAGS_IDENTIFY
Date:   Sat, 12 Jun 2021 12:51:54 +0800
Message-Id: <20210612045156.44763-2-kylee0686026@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210612045156.44763-1-kylee0686026@gmail.com>
References: <20210612045156.44763-1-kylee0686026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CONFIG_KASAN_SW_TAGS_IDENTIFY to
CONFIG_KASAN_TAGS_IDENTIFY in order to be compatible
with hardware tag-based mode.

Signed-off-by: Kuan-Ying Lee <kylee0686026@gmail.com>
Suggested-by: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/Kconfig.kasan         | 2 +-
 mm/kasan/kasan.h          | 4 ++--
 mm/kasan/report_sw_tags.c | 2 +-
 mm/kasan/sw_tags.c        | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index cffc2ebbf185..6f5d48832139 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -155,7 +155,7 @@ config KASAN_STACK
 	  CONFIG_COMPILE_TEST.	On gcc it is assumed to always be safe
 	  to use and enabled by default.
 
-config KASAN_SW_TAGS_IDENTIFY
+config KASAN_TAGS_IDENTIFY
 	bool "Enable memory corruption identification"
 	depends on KASAN_SW_TAGS
 	help
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8f450bc28045..b0fc9a1eb7e3 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -153,7 +153,7 @@ struct kasan_track {
 	depot_stack_handle_t stack;
 };
 
-#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
+#ifdef CONFIG_KASAN_TAGS_IDENTIFY
 #define KASAN_NR_FREE_STACKS 5
 #else
 #define KASAN_NR_FREE_STACKS 1
@@ -170,7 +170,7 @@ struct kasan_alloc_meta {
 #else
 	struct kasan_track free_track[KASAN_NR_FREE_STACKS];
 #endif
-#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
+#ifdef CONFIG_KASAN_TAGS_IDENTIFY
 	u8 free_pointer_tag[KASAN_NR_FREE_STACKS];
 	u8 free_track_idx;
 #endif
diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
index 3d20d3451d9e..821a14a19a92 100644
--- a/mm/kasan/report_sw_tags.c
+++ b/mm/kasan/report_sw_tags.c
@@ -31,7 +31,7 @@
 
 const char *kasan_get_bug_type(struct kasan_access_info *info)
 {
-#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
+#ifdef CONFIG_KASAN_TAGS_IDENTIFY
 	struct kasan_alloc_meta *alloc_meta;
 	struct kmem_cache *cache;
 	struct page *page;
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 9362938abbfa..dd05e6c801fa 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -177,7 +177,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
 	if (!alloc_meta)
 		return;
 
-#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
+#ifdef CONFIG_KASAN_TAGS_IDENTIFY
 	idx = alloc_meta->free_track_idx;
 	alloc_meta->free_pointer_tag[idx] = tag;
 	alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
@@ -196,7 +196,7 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 	if (!alloc_meta)
 		return NULL;
 
-#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
+#ifdef CONFIG_KASAN_TAGS_IDENTIFY
 	for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
 		if (alloc_meta->free_pointer_tag[i] == tag)
 			break;
-- 
2.25.1

