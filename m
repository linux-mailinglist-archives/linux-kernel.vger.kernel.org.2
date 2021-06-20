Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF303ADE38
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhFTLuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:50:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60758 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229632AbhFTLu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:50:27 -0400
X-UUID: 4ad91dac93454e12a7fff2379ad760e2-20210620
X-UUID: 4ad91dac93454e12a7fff2379ad760e2-20210620
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1014899775; Sun, 20 Jun 2021 19:48:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 20 Jun 2021 19:48:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 20 Jun 2021 19:48:11 +0800
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
Subject: [PATCH v3 3/3] kasan: add memory corruption identification support for hardware tag-based mode
Date:   Sun, 20 Jun 2021 19:47:56 +0800
Message-ID: <20210620114756.31304-4-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com>
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory corruption identification support for hardware tag-based
mode. We store one old free pointer tag and free backtrace.

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Suggested-by: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/Kconfig.kasan | 2 +-
 mm/kasan/kasan.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 6f5d48832139..2cc25792bc2f 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -157,7 +157,7 @@ config KASAN_STACK
 
 config KASAN_TAGS_IDENTIFY
 	bool "Enable memory corruption identification"
-	depends on KASAN_SW_TAGS
+	depends on KASAN_SW_TAGS || KASAN_HW_TAGS
 	help
 	  This option enables best-effort identification of bug type
 	  (use-after-free or out-of-bounds) at the cost of increased
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b0fc9a1eb7e3..d6f982b8a84e 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -153,7 +153,7 @@ struct kasan_track {
 	depot_stack_handle_t stack;
 };
 
-#ifdef CONFIG_KASAN_TAGS_IDENTIFY
+#if defined(CONFIG_KASAN_TAGS_IDENTIFY) && defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_NR_FREE_STACKS 5
 #else
 #define KASAN_NR_FREE_STACKS 1
-- 
2.18.0

