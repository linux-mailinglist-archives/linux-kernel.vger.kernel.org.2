Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DC141D7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350030AbhI3KgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:36:04 -0400
Received: from foss.arm.com ([217.140.110.172]:52026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350019AbhI3KgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:36:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7566113E;
        Thu, 30 Sep 2021 03:34:19 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 794D73F793;
        Thu, 30 Sep 2021 03:34:16 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        steven.price@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V3 01/13] arm64/mm: Dynamically initialize protection_map[]
Date:   Thu, 30 Sep 2021 16:05:04 +0530
Message-Id: <1632998116-11552-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going forward some protection_map[] elements (i.e __PXXX and __SXXX) would
contain a runtime variable with FEAT_LPA2 enabled, preventing a successful
build because of their current static initialization. This change prevents
the problem via assigning a dummy protection value i.e __pgprot(0) to all
__PXXX and __SXXX elements which builds successfully but later updates the
protection_map[] array in platform mem_init(). __pgprot(0) does not cause
any problem because vm_get_page_prot() which uses protection_map[] should
never be called before platform mem_init().

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 34 +++++++++++++++++-----------------
 arch/arm64/mm/init.c                  | 22 ++++++++++++++++++++++
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 7032f04..539503a 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -88,23 +88,23 @@ extern bool arm64_use_ng_mappings;
 #define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN)
 #define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_RDONLY | PTE_NG | PTE_PXN)
 
-#define __P000  PAGE_NONE
-#define __P001  PAGE_READONLY
-#define __P010  PAGE_READONLY
-#define __P011  PAGE_READONLY
-#define __P100  PAGE_EXECONLY
-#define __P101  PAGE_READONLY_EXEC
-#define __P110  PAGE_READONLY_EXEC
-#define __P111  PAGE_READONLY_EXEC
-
-#define __S000  PAGE_NONE
-#define __S001  PAGE_READONLY
-#define __S010  PAGE_SHARED
-#define __S011  PAGE_SHARED
-#define __S100  PAGE_EXECONLY
-#define __S101  PAGE_READONLY_EXEC
-#define __S110  PAGE_SHARED_EXEC
-#define __S111  PAGE_SHARED_EXEC
+#define __P000  __pgprot(0)
+#define __P001  __pgprot(0)
+#define __P010  __pgprot(0)
+#define __P011  __pgprot(0)
+#define __P100  __pgprot(0)
+#define __P101  __pgprot(0)
+#define __P110  __pgprot(0)
+#define __P111  __pgprot(0)
+
+#define __S000  __pgprot(0)
+#define __S001  __pgprot(0)
+#define __S010  __pgprot(0)
+#define __S011  __pgprot(0)
+#define __S100  __pgprot(0)
+#define __S101  __pgprot(0)
+#define __S110  __pgprot(0)
+#define __S111  __pgprot(0)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 37a8175..27f7c6c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -403,6 +403,27 @@ void __init bootmem_init(void)
 	memblock_dump_all();
 }
 
+static void init_protection_map(void)
+{
+	protection_map[0] = PAGE_NONE;
+	protection_map[1] = PAGE_READONLY;
+	protection_map[2] = PAGE_READONLY;
+	protection_map[3] = PAGE_READONLY;
+	protection_map[4] = PAGE_EXECONLY;
+	protection_map[5] = PAGE_READONLY_EXEC;
+	protection_map[6] = PAGE_READONLY_EXEC;
+	protection_map[7] = PAGE_READONLY_EXEC;
+
+	protection_map[8] = PAGE_NONE;
+	protection_map[9] = PAGE_READONLY;
+	protection_map[10] = PAGE_SHARED;
+	protection_map[11] = PAGE_SHARED;
+	protection_map[12] = PAGE_EXECONLY;
+	protection_map[13] = PAGE_READONLY_EXEC;
+	protection_map[14] = PAGE_SHARED_EXEC;
+	protection_map[15] = PAGE_SHARED_EXEC;
+}
+
 /*
  * mem_init() marks the free areas in the mem_map and tells us how much memory
  * is free.  This is done after various parts of the system have claimed their
@@ -444,6 +465,7 @@ void __init mem_init(void)
 		 */
 		sysctl_overcommit_memory = OVERCOMMIT_ALWAYS;
 	}
+	init_protection_map();
 }
 
 void free_initmem(void)
-- 
2.7.4

