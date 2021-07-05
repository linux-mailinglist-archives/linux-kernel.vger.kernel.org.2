Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB83BBB4C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhGEKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:36:09 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56971 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231144AbhGEKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:36:05 -0400
X-UUID: 0eae808af56540558ddbc3655f0bf543-20210705
X-UUID: 0eae808af56540558ddbc3655f0bf543-20210705
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1933772066; Mon, 05 Jul 2021 18:33:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Jul 2021 18:33:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Jul 2021 18:33:25 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <nicholas.Tang@mediatek.com>, <Kuan-Ying.lee@mediatek.com>,
        <chinwen.chang@mediatek.com>, Marco Elver <elver@google.com>,
        Yee Lee <yee.lee@mediatek.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v6 1/2] mm: move helper to check slub_debug_enabled
Date:   Mon, 5 Jul 2021 18:32:26 +0800
Message-ID: <20210705103229.8505-2-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210705103229.8505-1-yee.lee@mediatek.com>
References: <20210705103229.8505-1-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Move the helper to check slub_debug_enabled, so that we can confine
the use of #ifdef outside slub.c as well.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Yee Lee <yee.lee@mediatek.com>
---
 mm/slab.h | 15 +++++++++++----
 mm/slub.c | 14 --------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 7b60ef2f32c3..67d3272f3368 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -216,10 +216,18 @@ DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 extern void print_tracking(struct kmem_cache *s, void *object);
 long validate_slab_cache(struct kmem_cache *s);
+static inline bool __slub_debug_enabled(void)
+{
+	return static_branch_unlikely(&slub_debug_enabled);
+}
 #else
 static inline void print_tracking(struct kmem_cache *s, void *object)
 {
 }
+static inline bool __slub_debug_enabled(void)
+{
+	return false;
+}
 #endif
 
 /*
@@ -229,11 +237,10 @@ static inline void print_tracking(struct kmem_cache *s, void *object)
  */
 static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
 {
-#ifdef CONFIG_SLUB_DEBUG
-	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
-	if (static_branch_unlikely(&slub_debug_enabled))
+	if (IS_ENABLED(CONFIG_SLUB_DEBUG))
+		VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
+	if (__slub_debug_enabled())
 		return s->flags & flags;
-#endif
 	return false;
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index 3bc8b940c933..71515c484d1c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -119,25 +119,11 @@
  */
 
 #ifdef CONFIG_SLUB_DEBUG
-
 #ifdef CONFIG_SLUB_DEBUG_ON
 DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
 #else
 DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
-
-static inline bool __slub_debug_enabled(void)
-{
-	return static_branch_unlikely(&slub_debug_enabled);
-}
-
-#else		/* CONFIG_SLUB_DEBUG */
-
-static inline bool __slub_debug_enabled(void)
-{
-	return false;
-}
-
 #endif		/* CONFIG_SLUB_DEBUG */
 
 static inline bool kmem_cache_debug(struct kmem_cache *s)
-- 
2.18.0

