Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD33B9DC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhGBI4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:56:40 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:57668 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230166AbhGBI4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:56:39 -0400
X-UUID: df8c743da07944278bd3274ff0bd92ef-20210702
X-UUID: df8c743da07944278bd3274ff0bd92ef-20210702
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1761975509; Fri, 02 Jul 2021 16:54:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 2 Jul 2021 16:53:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 2 Jul 2021 16:53:57 +0800
From:   <yee.lee@mediatek.com>
To:     <andreyknvl@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <nicholas.Tang@mediatek.com>,
        <Kuan-Ying.lee@mediatek.com>, <chinwen.chang@mediatek.com>,
        Marco Elver <elver@google.com>, Yee Lee <yee.lee@mediatek.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 1/2] mm: introduce helper to check slub_debug_enabled
Date:   Fri, 2 Jul 2021 16:53:31 +0800
Message-ID: <20210702085332.10035-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Introduce a helper to check slub_debug_enabled, so that we can confine
the use of #ifdef to the definition of the slub_debug_enabled_unlikely()
helper.

---

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Yee Lee <yee.lee@mediatek.com>

---
 mm/slab.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 7b60ef2f32c3..a11126afe24c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -216,10 +216,18 @@ DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 extern void print_tracking(struct kmem_cache *s, void *object);
 long validate_slab_cache(struct kmem_cache *s);
+static inline bool slub_debug_enabled_unlikely(void)
+{
+	return static_branch_unlikely(&slub_debug_enabled);
+}
 #else
 static inline void print_tracking(struct kmem_cache *s, void *object)
 {
 }
+static inline bool slub_debug_enabled_unlikely(void)
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
+	if (slub_debug_enabled_unlikely())
 		return s->flags & flags;
-#endif
 	return false;
 }
 
-- 
2.18.0

