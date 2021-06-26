Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4D3B4DEA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFZKMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:12:07 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58718 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229586AbhFZKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:12:02 -0400
X-UUID: 18061d37e5004212a9df52c84f059005-20210626
X-UUID: 18061d37e5004212a9df52c84f059005-20210626
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2029163543; Sat, 26 Jun 2021 18:09:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 26 Jun 2021 18:09:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 26 Jun 2021 18:09:35 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <chinwen.chang@mediatek.com>, <nicholas.tang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: [PATCH v4 1/3] kasan: rename CONFIG_KASAN_SW_TAGS_IDENTIFY to CONFIG_KASAN_TAGS_IDENTIFY
Date:   Sat, 26 Jun 2021 18:09:29 +0800
Message-ID: <20210626100931.22794-2-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210626100931.22794-1-Kuan-Ying.Lee@mediatek.com>
References: <20210626100931.22794-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CONFIG_KASAN_SW_TAGS_IDENTIFY to
CONFIG_KASAN_TAGS_IDENTIFY in order to be compatible
with hardware tag-based mode.

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Suggested-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/Kconfig.kasan         | 2 +-
 mm/kasan/kasan.h          | 4 ++--
 mm/kasan/report_sw_tags.c | 2 +-
 mm/kasan/sw_tags.c        | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index c3b228828a80..fdb4a08dba83 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -167,7 +167,7 @@ config KASAN_STACK
 	  instrumentation is also disabled as it adds inline-style
 	  instrumentation that is run unconditionally.
 
-config KASAN_SW_TAGS_IDENTIFY
+config KASAN_TAGS_IDENTIFY
 	bool "Enable memory corruption identification"
 	depends on KASAN_SW_TAGS
 	help
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 7b45b17a8106..952df2db7fdd 100644
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
2.18.0

