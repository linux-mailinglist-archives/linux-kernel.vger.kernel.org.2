Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A84311C3D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBFIiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 03:38:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49247 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229800AbhBFIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 03:37:12 -0500
X-UUID: 116b2c8ac0214046a6ae1e0de80caeb6-20210206
X-UUID: 116b2c8ac0214046a6ae1e0de80caeb6-20210206
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1111705410; Sat, 06 Feb 2021 16:36:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 6 Feb 2021 16:36:08 +0800
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
Subject: [PATCH v3 5/5] arm64: Kconfig: select KASAN_VMALLOC if KANSAN_GENERIC is enabled
Date:   Sat, 6 Feb 2021 16:35:52 +0800
Message-ID: <20210206083552.24394-6-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
References: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch, someone who wants to use VMAP_STACK when
KASAN_GENERIC enabled must explicitly select KASAN_VMALLOC.

From Will's suggestion [1]:
  > I would _really_ like to move to VMAP stack unconditionally, and
  > that would effectively force KASAN_VMALLOC to be set if KASAN is in use.

Because VMAP_STACK now depends on either HW_TAGS or KASAN_VMALLOC if
KASAN enabled, in order to make VMAP_STACK selected unconditionally,
we bind KANSAN_GENERIC and KASAN_VMALLOC together.

Note that SW_TAGS supports neither VMAP_STACK nor KASAN_VMALLOC now,
so this is the first step to make VMAP_STACK selected unconditionally.

Bind KANSAN_GENERIC and KASAN_VMALLOC together is supposed to cost more
memory at runtime, thus the alternative is using SW_TAGS KASAN instead.

[1]: https://lore.kernel.org/lkml/20210204150100.GE20815@willie-the-truck/

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a8f5a9171a85..9be6a57f6447 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -190,6 +190,7 @@ config ARM64
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select KASAN_VMALLOC if KASAN_GENERIC
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
-- 
2.25.1

