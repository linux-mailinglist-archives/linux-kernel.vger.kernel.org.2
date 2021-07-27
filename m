Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7498E3D6D12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhG0EAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:00:47 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:36164 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229441AbhG0EAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:00:45 -0400
X-UUID: c2a56f32e34b4b9181147212f965d081-20210727
X-UUID: c2a56f32e34b4b9181147212f965d081-20210727
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 875007197; Tue, 27 Jul 2021 12:00:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 12:00:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Jul 2021 12:00:42 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: [PATCH 1/2] kasan, mm: reset tag when access metadata
Date:   Tue, 27 Jul 2021 12:00:20 +0800
Message-ID: <20210727040021.21371-2-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210727040021.21371-1-Kuan-Ying.Lee@mediatek.com>
References: <20210727040021.21371-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware tag-based KASAN doesn't use compiler instrumentation, we
can not use kasan_disable_current() to ignore tag check.

Thus, we need to reset tags when accessing metadata.

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 mm/kmemleak.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 228a2fbe0657..73d46d16d575 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -290,7 +290,7 @@ static void hex_dump_object(struct seq_file *seq,
 	warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
 	kasan_disable_current();
 	warn_or_seq_hex_dump(seq, DUMP_PREFIX_NONE, HEX_ROW_SIZE,
-			     HEX_GROUP_SIZE, ptr, len, HEX_ASCII);
+			     HEX_GROUP_SIZE, kasan_reset_tag((void *)ptr), len, HEX_ASCII);
 	kasan_enable_current();
 }
 
@@ -1171,7 +1171,7 @@ static bool update_checksum(struct kmemleak_object *object)
 
 	kasan_disable_current();
 	kcsan_disable_current();
-	object->checksum = crc32(0, (void *)object->pointer, object->size);
+	object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
 	kasan_enable_current();
 	kcsan_enable_current();
 
@@ -1246,7 +1246,7 @@ static void scan_block(void *_start, void *_end,
 			break;
 
 		kasan_disable_current();
-		pointer = *ptr;
+		pointer = *(unsigned long *)kasan_reset_tag((void *)ptr);
 		kasan_enable_current();
 
 		untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
-- 
2.18.0

