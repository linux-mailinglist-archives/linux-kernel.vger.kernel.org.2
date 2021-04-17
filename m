Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A28362E6F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhDQH76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 03:59:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16473 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbhDQH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 03:59:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FMlm51db4zyNvN;
        Sat, 17 Apr 2021 15:57:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Sat, 17 Apr 2021 15:59:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: Move HOLES_IN_ZONE into mm
Date:   Sat, 17 Apr 2021 15:59:46 +0800
Message-ID: <20210417075946.181402-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a55749639dc1 ("ia64: drop marked broken DISCONTIGMEM and VIRTUAL_MEM_MAP")
drop VIRTUAL_MEM_MAP, so there is no need HOLES_IN_ZONE on ia64.

Also move HOLES_IN_ZONE into mm/Kconfig, select it if architecture needs
this feature.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig | 4 +---
 arch/ia64/Kconfig  | 3 ---
 arch/mips/Kconfig  | 3 ---
 mm/Kconfig         | 3 +++
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f0b17d758912..3c5a53e0db91 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -202,6 +202,7 @@ config ARM64
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
+	select HOLES_IN_ZONE
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
@@ -1053,9 +1054,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool y
 	depends on NUMA
 
-config HOLES_IN_ZONE
-	def_bool y
-
 source "kernel/Kconfig.hz"
 
 config ARCH_SPARSEMEM_ENABLE
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 279252e3e0f7..36499e99102d 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -308,9 +308,6 @@ config NODES_SHIFT
 	  MAX_NUMNODES will be 2^(This value).
 	  If in doubt, use the default.
 
-config HOLES_IN_ZONE
-	bool
-
 config HAVE_ARCH_NODEDATA_EXTENSION
 	def_bool y
 	depends on NUMA
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7a174ea61ca5..c6d522fbd67d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1233,9 +1233,6 @@ config HAVE_PLAT_MEMCPY
 config ISA_DMA_API
 	bool
 
-config HOLES_IN_ZONE
-	bool
-
 config SYS_SUPPORTS_RELOCATABLE
 	bool
 	help
diff --git a/mm/Kconfig b/mm/Kconfig
index a8a367c30053..afc57cbf1cea 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -128,6 +128,9 @@ config HAVE_FAST_GUP
 	depends on MMU
 	bool
 
+config HOLES_IN_ZONE
+	bool
+
 # Don't discard allocated memory used to track "memory" and "reserved" memblocks
 # after early boot, so it can still be used to test for validity of memory.
 # Also, memblocks are updated with memory hot(un)plug.
-- 
2.26.2

