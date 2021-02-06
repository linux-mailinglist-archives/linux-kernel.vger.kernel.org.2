Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D509C311C35
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 09:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBFIgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 03:36:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46417 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229537AbhBFIgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 03:36:50 -0500
X-UUID: 54a4c85ce4454427adab3f6a641998f7-20210206
X-UUID: 54a4c85ce4454427adab3f6a641998f7-20210206
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 494478168; Sat, 06 Feb 2021 16:36:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 6 Feb 2021 16:36:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 6 Feb 2021 16:36:05 +0800
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
Subject: [PATCH v3 1/5] arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
Date:   Sat, 6 Feb 2021 16:35:48 +0800
Message-ID: <20210206083552.24394-2-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
References: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
("kasan: support backing vmalloc space with real shadow memory")

Like how the MODULES_VADDR does now, just not to early populate
the VMALLOC_START between VMALLOC_END.

Before:

MODULE_VADDR: no mapping, no zoreo shadow at init
VMALLOC_VADDR: backed with zero shadow at init

After:

MODULE_VADDR: no mapping, no zoreo shadow at init
VMALLOC_VADDR: no mapping, no zoreo shadow at init

Thus the mapping will get allocated on demand by the core function
of KASAN_VMALLOC.

  -----------  vmalloc_shadow_start
 |           |
 |           |
 |           | <= non-mapping
 |           |
 |           |
 |-----------|
 |///////////|<- kimage shadow with page table mapping.
 |-----------|
 |           |
 |           | <= non-mapping
 |           |
 ------------- vmalloc_shadow_end
 |00000000000|
 |00000000000| <= Zero shadow
 |00000000000|
 ------------- KASAN_SHADOW_END

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/mm/kasan_init.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d8e66c78440e..20d06008785f 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
 {
 	u64 kimg_shadow_start, kimg_shadow_end;
 	u64 mod_shadow_start, mod_shadow_end;
+	u64 vmalloc_shadow_end;
 	phys_addr_t pa_start, pa_end;
 	u64 i;
 
@@ -223,6 +224,8 @@ static void __init kasan_init_shadow(void)
 	mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
 	mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
 
+	vmalloc_shadow_end = (u64)kasan_mem_to_shadow((void *)VMALLOC_END);
+
 	/*
 	 * We are going to perform proper setup of shadow memory.
 	 * At first we should unmap early shadow (clear_pgds() call below).
@@ -241,12 +244,17 @@ static void __init kasan_init_shadow(void)
 
 	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
 				   (void *)mod_shadow_start);
-	kasan_populate_early_shadow((void *)kimg_shadow_end,
-				   (void *)KASAN_SHADOW_END);
 
-	if (kimg_shadow_start > mod_shadow_end)
-		kasan_populate_early_shadow((void *)mod_shadow_end,
-					    (void *)kimg_shadow_start);
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
+		kasan_populate_early_shadow((void *)vmalloc_shadow_end,
+					    (void *)KASAN_SHADOW_END);
+	else {
+		kasan_populate_early_shadow((void *)kimg_shadow_end,
+					    (void *)KASAN_SHADOW_END);
+		if (kimg_shadow_start > mod_shadow_end)
+			kasan_populate_early_shadow((void *)mod_shadow_end,
+						    (void *)kimg_shadow_start);
+	}
 
 	for_each_mem_range(i, &pa_start, &pa_end) {
 		void *start = (void *)__phys_to_virt(pa_start);
-- 
2.25.1

