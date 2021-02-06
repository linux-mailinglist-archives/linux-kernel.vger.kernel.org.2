Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E8311C3A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 09:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBFIha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 03:37:30 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49247 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229684AbhBFIgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 03:36:54 -0500
X-UUID: 9d3405466d6343438602b56379476005-20210206
X-UUID: 9d3405466d6343438602b56379476005-20210206
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1824139656; Sat, 06 Feb 2021 16:36:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 6 Feb 2021 16:36:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 6 Feb 2021 16:36:08 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>
CC:     <dan.j.williams@intel.com>, <aryabinin@virtuozzo.com>,
        <glider@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <linux-mediatek@lists.infradead.org>,
        <yj.chiang@mediatek.com>, <catalin.marinas@arm.com>,
        <ardb@kernel.org>, <andreyknvl@google.com>, <broonie@kernel.org>,
        <linux@roeck-us.net>, <rppt@kernel.org>,
        <tyhicks@linux.microsoft.com>, <robin.murphy@arm.com>,
        <vincenzo.frascino@arm.com>, <gustavoars@kernel.org>,
        <lecopzer@gmail.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH v3 4/5] arm64: kaslr: support randomized module area with KASAN_VMALLOC
Date:   Sat, 6 Feb 2021 16:35:51 +0800
Message-ID: <20210206083552.24394-5-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
References: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DEC81A8B4BED333FFD3CB4BEEA964F8E7288657F38F621992E8AA30C4139E42E2000:8
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
index 1c74c45b9494..a2858058e724 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -161,15 +161,17 @@ u64 __init kaslr_early_init(u64 dt_phys)
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

