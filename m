Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2B0347061
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhCXEGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:06:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33263 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229957AbhCXEFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:05:38 -0400
X-UUID: e34170eaa28946bdbf56de68a9d3745c-20210324
X-UUID: e34170eaa28946bdbf56de68a9d3745c-20210324
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 979377580; Wed, 24 Mar 2021 12:05:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Mar 2021 12:05:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Mar 2021 12:05:33 +0800
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
Subject: [PATCH v4 5/5] arm64: Kconfig: select KASAN_VMALLOC if KANSAN_GENERIC is enabled
Date:   Wed, 24 Mar 2021 12:05:22 +0800
Message-ID: <20210324040522.15548-6-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210324040522.15548-1-lecopzer.chen@mediatek.com>
References: <20210324040522.15548-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A3457C077D10D4C7DD6B3D9223F0B41AFC95665282A9E44F390A034C7FB65A4C2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch, someone who wants to use VMAP_STACK when
KASAN_GENERIC enabled must explicitly select KASAN_VMALLOC.

From Will's suggestion [1]:
  > I would _really_ like to move to VMAP stack unconditionally, and
  > that would effectively force KASAN_VMALLOC to be set if KASAN is in use

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
index 3e54fa938234..07762359d741 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -195,6 +195,7 @@ config ARM64
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select KASAN_VMALLOC if KASAN_GENERIC
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
-- 
2.25.1

