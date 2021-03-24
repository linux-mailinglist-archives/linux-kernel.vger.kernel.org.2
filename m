Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E180347063
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhCXEGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:06:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56235 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229981AbhCXEFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:05:38 -0400
X-UUID: 4f555892369f483ca5cd0ed9efb7ceed-20210324
X-UUID: 4f555892369f483ca5cd0ed9efb7ceed-20210324
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 110564171; Wed, 24 Mar 2021 12:05:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Mar 2021 12:05:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Mar 2021 12:05:32 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <ryabinin.a.a@gmail.com>, <glider@google.com>,
        <andreyknvl@gmail.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <tyhicks@linux.microsoft.com>,
        <maz@kernel.org>, <rppt@kernel.org>, <linux@roeck-us.net>,
        <gustavoars@kernel.org>, <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH v4 4/5] arm64: kaslr: support randomized module area with KASAN_VMALLOC
Date:   Wed, 24 Mar 2021 12:05:21 +0800
Message-ID: <20210324040522.15548-5-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210324040522.15548-1-lecopzer.chen@mediatek.com>
References: <20210324040522.15548-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After KASAN_VMALLOC works in arm64, we can randomize module region
into vmalloc area now.

Test:
	VMALLOC area ffffffc010000000 fffffffdf0000000

	before the patch:
		module_alloc_base/end ffffffc008b80000 ffffffc010000000
	after the patch:
		module_alloc_base/end ffffffdcf4bed000 ffffffc010000000

	And the function that insmod some modules is fine.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/kernel/kaslr.c  | 18 ++++++++++--------
 arch/arm64/kernel/module.c | 16 +++++++++-------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 27f8939deb1b..341342b207f6 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -128,15 +128,17 @@ u64 __init kaslr_early_init(void)
 	/* use the top 16 bits to randomize the linear region */
 	memstart_offset_seed = seed >> 48;
 
-	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
-	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) &&
+	    (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+	     IS_ENABLED(CONFIG_KASAN_SW_TAGS)))
 		/*
-		 * KASAN does not expect the module region to intersect the
-		 * vmalloc region, since shadow memory is allocated for each
-		 * module at load time, whereas the vmalloc region is shadowed
-		 * by KASAN zero pages. So keep modules out of the vmalloc
-		 * region if KASAN is enabled, and put the kernel well within
-		 * 4 GB of the module region.
+		 * KASAN without KASAN_VMALLOC does not expect the module region
+		 * to intersect the vmalloc region, since shadow memory is
+		 * allocated for each module at load time, whereas the vmalloc
+		 * region is shadowed by KASAN zero pages. So keep modules
+		 * out of the vmalloc region if KASAN is enabled without
+		 * KASAN_VMALLOC, and put the kernel well within 4 GB of the
+		 * module region.
 		 */
 		return offset % SZ_2G;
 
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index fe21e0f06492..b5ec010c481f 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -40,14 +40,16 @@ void *module_alloc(unsigned long size)
 				NUMA_NO_NODE, __builtin_return_address(0));
 
 	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
-	    !IS_ENABLED(CONFIG_KASAN_GENERIC) &&
-	    !IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+	    (IS_ENABLED(CONFIG_KASAN_VMALLOC) ||
+	     (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
+	      !IS_ENABLED(CONFIG_KASAN_SW_TAGS))))
 		/*
-		 * KASAN can only deal with module allocations being served
-		 * from the reserved module region, since the remainder of
-		 * the vmalloc region is already backed by zero shadow pages,
-		 * and punching holes into it is non-trivial. Since the module
-		 * region is not randomized when KASAN is enabled, it is even
+		 * KASAN without KASAN_VMALLOC can only deal with module
+		 * allocations being served from the reserved module region,
+		 * since the remainder of the vmalloc region is already
+		 * backed by zero shadow pages, and punching holes into it
+		 * is non-trivial. Since the module region is not randomized
+		 * when KASAN is enabled without KASAN_VMALLOC, it is even
 		 * less likely that the module region gets exhausted, so we
 		 * can simply omit this fallback in that case.
 		 */
-- 
2.25.1

