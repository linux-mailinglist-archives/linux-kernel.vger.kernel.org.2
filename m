Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371223AFF94
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFVIuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:50:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56813 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229747AbhFVIuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:50:20 -0400
X-UUID: b95d6c1b4f8a44b7b4dd24d4e16b1eae-20210622
X-UUID: b95d6c1b4f8a44b7b4dd24d4e16b1eae-20210622
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1243209495; Tue, 22 Jun 2021 16:47:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 16:47:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Jun 2021 16:47:57 +0800
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
Subject: [PATCH] kasan: [v2]unpoison use memzero to init unaligned object
Date:   Tue, 22 Jun 2021 16:47:20 +0800
Message-ID: <20210622084723.27637-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

Follows the discussion: https://patchwork.kernel.org/project/linux-mediatek/list/?series=504439

This patch Add memzero_explict to initialize unaligned object.

Based on the integrateion of initialization in kasan_unpoison(). The hwtag instructions, constrained with its granularity, has to overwrite the data btyes in unaligned objects. This would cause issue when it works with SLUB debug redzoning.

In this patch, an additional initalizaing path is added for the unaligned objects. It contains memzero_explict() to clear out the data and disables its init flag for the following hwtag actions.

In lab test, this path is executed about 1.1%(941/80854) within the overall kasan_unpoison during a non-debug booting process.

Lab test: QEMU5.2 (+mte) / linux kernel 5.13-rc7

Signed-off-by: Yee Lee <yee.lee@mediatek.com>
---
 mm/kasan/kasan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index d8faa64614b7..edc11bcc3ff3 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -389,7 +389,7 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
 		return;
 	if (init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
 		init = false;
-		memset((void *)addr, 0, size);
+		memzero_explicit((void *)addr, size);
 	}
 	size = round_up(size, KASAN_GRANULE_SIZE);
 	hw_set_mem_tag_range((void *)addr, size, tag, init);
2.18.0

