Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DC73B1B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhFWNiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:38:04 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:55030 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230182AbhFWNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:38:02 -0400
X-UUID: 2c1ef5406b6a47a0ab1eff22471b5ae3-20210623
X-UUID: 2c1ef5406b6a47a0ab1eff22471b5ae3-20210623
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 166794494; Wed, 23 Jun 2021 21:35:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Jun 2021 21:35:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 21:35:40 +0800
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
Subject: [PATCH v2 1/1] kasan: Add memzero init for unaligned size under SLUB debug
Date:   Wed, 23 Jun 2021 21:35:32 +0800
Message-ID: <20210623133533.2246-2-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210623133533.2246-1-yee.lee@mediatek.com>
References: <20210623133533.2246-1-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

Issue: when SLUB debug is on, hwtag kasan_unpoison() would overwrite the redzone with unaligned object size.

An additional memzero_explicit() path is added to replacing hwtag initialization
at SLUB deubg mode.

Signed-off-by: Yee Lee <yee.lee@mediatek.com>
Suggested-by: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kasan/kasan.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index d8faa64614b7..e984a9ac814d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -387,10 +387,12 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
 
 	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
 		return;
+	#if IS_ENABLED(CONFIG_SLUB_DEBUG)
 	if (init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
 		init = false;
-		memset((void *)addr, 0, size);
+		memzero_explicit((void *)addr, size);
 	}
+	#endif
 	size = round_up(size, KASAN_GRANULE_SIZE);
 	hw_set_mem_tag_range((void *)addr, size, tag, init);
 }
-- 
2.18.0

