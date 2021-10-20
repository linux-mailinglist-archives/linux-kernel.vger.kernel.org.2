Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8443484B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJTJvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:51:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49606 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230031AbhJTJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:51:16 -0400
X-UUID: 52b919d9a5ba49d6a32525d28890f2c0-20211020
X-UUID: 52b919d9a5ba49d6a32525d28890f2c0-20211020
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1720517181; Wed, 20 Oct 2021 17:48:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 20 Oct 2021 17:48:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Oct 2021 17:48:52 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Marco Elver <elver@google.com>
CC:     <chinwen.chang@mediatek.com>, <yee.lee@mediatek.com>,
        <nicholas.tang@mediatek.com>, <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-mediatek@lists.infradead.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: [PATCH v3] kasan: add kasan mode messages when kasan init
Date:   Wed, 20 Oct 2021 17:48:50 +0800
Message-ID: <20211020094850.4113-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple kasan modes. It makes sense that we add some messages
to know which kasan mode is when booting up. see [1].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212195 [1]
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
v3:
 - Rebase to linux-next
 - Move kasan_mode_info() into hw_tags.c
v2:
 - Rebase to linux-next
 - HW-tag based mode need to consider asymm mode
 - Thanks Marco's suggestion

 arch/arm64/mm/kasan_init.c |  2 +-
 mm/kasan/hw_tags.c         | 14 +++++++++++++-
 mm/kasan/sw_tags.c         |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 5b996ca4d996..6f5a6fe8edd7 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -309,7 +309,7 @@ void __init kasan_init(void)
 	kasan_init_depth();
 #if defined(CONFIG_KASAN_GENERIC)
 	/* CONFIG_KASAN_SW_TAGS also requires kasan_init_sw_tags(). */
-	pr_info("KernelAddressSanitizer initialized\n");
+	pr_info("KernelAddressSanitizer initialized (generic)\n");
 #endif
 }
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index dc892119e88f..7355cb534e4f 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -106,6 +106,16 @@ static int __init early_kasan_flag_stacktrace(char *arg)
 }
 early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
 
+static inline const char *kasan_mode_info(void)
+{
+	if (kasan_mode == KASAN_MODE_ASYNC)
+		return "async";
+	else if (kasan_mode == KASAN_MODE_ASYMM)
+		return "asymm";
+	else
+		return "sync";
+}
+
 /* kasan_init_hw_tags_cpu() is called for each CPU. */
 void kasan_init_hw_tags_cpu(void)
 {
@@ -177,7 +187,9 @@ void __init kasan_init_hw_tags(void)
 		break;
 	}
 
-	pr_info("KernelAddressSanitizer initialized\n");
+	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, stacktrace=%s)\n",
+		kasan_mode_info(),
+		kasan_stack_collection_enabled() ? "on" : "off");
 }
 
 void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index bd3f540feb47..77f13f391b57 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -42,7 +42,7 @@ void __init kasan_init_sw_tags(void)
 	for_each_possible_cpu(cpu)
 		per_cpu(prng_state, cpu) = (u32)get_cycles();
 
-	pr_info("KernelAddressSanitizer initialized\n");
+	pr_info("KernelAddressSanitizer initialized (sw-tags)\n");
 }
 
 /*
-- 
2.18.0

