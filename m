Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43AA3B8486
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhF3OAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:00:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40411 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236049AbhF3N7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:59:00 -0400
X-UUID: e7d4bf8d56984e219f26e258a12eef49-20210630
X-UUID: e7d4bf8d56984e219f26e258a12eef49-20210630
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1842347633; Wed, 30 Jun 2021 21:49:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 21:49:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 21:49:45 +0800
From:   <yee.lee@mediatek.com>
To:     <andreyknvl@gmail.com>
CC:     <wsd_upstream@mediatek.com>, Yee Lee <yee.lee@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 1/1] kasan: Add memzero init for unaligned size under SLUB debug
Date:   Wed, 30 Jun 2021 21:49:40 +0800
Message-ID: <20210630134943.20781-2-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630134943.20781-1-yee.lee@mediatek.com>
References: <20210630134943.20781-1-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

Issue: when SLUB debug is on, hwtag kasan_unpoison() would overwrite
the redzone of object with unaligned size.

An additional memzero_explicit() path is added to replacing init by
hwtag instruction for those unaligned size at SLUB debug mode.

The penalty is acceptable since they are only enabled in debug mode,
not production builds. A block of comment is added for explanation.

Signed-off-by: Yee Lee <yee.lee@mediatek.com>
Suggested-by: Marco Elver <elver@google.com>
Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kasan/kasan.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8f450bc28045..6f698f13dbe6 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -387,6 +387,16 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
 
 	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
 		return;
+	/*
+	 * Explicitly initialize the memory with the precise object size
+	 * to avoid overwriting the SLAB redzone. This disables initialization
+	 * in the arch code and may thus lead to performance penalty.
+	 * The penalty is accepted since SLAB redzones aren't enabled in production builds.
+	 */
+	if (IS_ENABLED(CONFIG_SLUB_DEBUG) && init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
+		init = false;
+		memzero_explicit((void *)addr, size);
+	}
 	size = round_up(size, KASAN_GRANULE_SIZE);
 
 	hw_set_mem_tag_range((void *)addr, size, tag, init);
-- 
2.18.0

