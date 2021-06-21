Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA17D3AECB6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFUPrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:47:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52055 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230028AbhFUPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:47:51 -0400
X-UUID: 4d3fb1b3cf1e47ee99897b930936ce1e-20210621
X-UUID: 4d3fb1b3cf1e47ee99897b930936ce1e-20210621
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1944458588; Mon, 21 Jun 2021 23:45:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Jun 2021 23:45:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Jun 2021 23:45:32 +0800
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
Subject: [PATCH] kasan: unpoison use memset to init unaligned object size
Date:   Mon, 21 Jun 2021 23:44:41 +0800
Message-ID: <20210621154442.18463-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

This patch adds a memset to initialize object of unaligned size.
Duing to the MTE granulrity, the integrated initialization using
hwtag instruction will force clearing out bytes in granular size,
which may cause undesired effect, such as overwriting to the redzone
of SLUB debug. In this patch, for the unaligned object size, function
uses memset to initailize context instead of the hwtag instruction.

Signed-off-by: Yee Lee <yee.lee@mediatek.com>
---
 mm/kasan/kasan.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8f450bc28045..d8faa64614b7 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -387,8 +387,11 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
 
 	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
 		return;
+	if (init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
+		init = false;
+		memset((void *)addr, 0, size);
+	}
 	size = round_up(size, KASAN_GRANULE_SIZE);
-
 	hw_set_mem_tag_range((void *)addr, size, tag, init);
 }
 
-- 
2.18.0

