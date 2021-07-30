Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E73DB76C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbhG3Kvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:51:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12427 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbhG3Kvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:51:48 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GbkdR63rhzcjkH;
        Fri, 30 Jul 2021 18:48:11 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 18:51:41 +0800
Received: from SWX921481.china.huawei.com (10.126.202.167) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Jul 2021 18:51:37 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <tyhicks@linux.microsoft.com>,
        <linux@roeck-us.net>, <maz@kernel.org>, <tabba@google.com>,
        <lecopzer.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        "Qi Liu" <liuqi115@huawei.com>
Subject: [PATCH] arm64: fix the doc of RANDOMIZE_MODULE_REGION_FULL
Date:   Fri, 30 Jul 2021 22:50:56 +1200
Message-ID: <20210730105056.19784-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.167]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously kaslr is setting the module region to 2GB rather than 4GB since
commit b2eed9b588112 ("arm64/kernel: kaslr: reduce module randomization
range to 2 GB").
On the other hand, module_alloc() can fall back to a 2GB window even though
RANDOMIZE_MODULE_REGION_FULL is not set. In this case, PLT is still needed.
So fix the doc to be more precise to avoid any confusion to the readers of
the code.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/arm64/Kconfig        | 7 ++++---
 arch/arm64/kernel/kaslr.c | 4 +++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5b13a932561..525c1f0b2430 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1800,11 +1800,11 @@ config RANDOMIZE_BASE
 	  If unsure, say N.
 
 config RANDOMIZE_MODULE_REGION_FULL
-	bool "Randomize the module region over a 4 GB range"
+	bool "Randomize the module region over a 2 GB range"
 	depends on RANDOMIZE_BASE
 	default y
 	help
-	  Randomizes the location of the module region inside a 4 GB window
+	  Randomizes the location of the module region inside a 2 GB window
 	  covering the core kernel. This way, it is less likely for modules
 	  to leak information about the location of core kernel data structures
 	  but it does imply that function calls between modules and the core
@@ -1812,7 +1812,8 @@ config RANDOMIZE_MODULE_REGION_FULL
 
 	  When this option is not set, the module region will be randomized over
 	  a limited range that contains the [_stext, _etext] interval of the
-	  core kernel, so branch relocations are always in range.
+	  core kernel, so branch relocations are almost always in range unless
+	  the region is exhausted and we fall back to a larger 2GB area.
 
 config CC_HAVE_STACKPROTECTOR_SYSREG
 	def_bool $(cc-option,-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=0)
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index cfa2cfde3019..2bc43014ced3 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -162,7 +162,9 @@ u64 __init kaslr_early_init(void)
 		 * a PAGE_SIZE multiple in the range [_etext - MODULES_VSIZE,
 		 * _stext) . This guarantees that the resulting region still
 		 * covers [_stext, _etext], and that all relative branches can
-		 * be resolved without veneers.
+		 * be resolved without veneers unless this region is exhausted
+		 * and we fall back to get memory from a larger 2GB window in
+		 * module_alloc()
 		 */
 		module_range = MODULES_VSIZE - (u64)(_etext - _stext);
 		module_alloc_base = (u64)_etext + offset - MODULES_VSIZE;
-- 
2.25.1

