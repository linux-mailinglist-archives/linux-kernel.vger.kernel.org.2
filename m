Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4530B36ED20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbhD2PK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhD2PK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:10:57 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE6C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:10:10 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d4dd:70b4:3264:8d97])
        by laurent.telenet-ops.be with bizsmtp
        id yfA6240094p6Y3801fA6tY; Thu, 29 Apr 2021 17:10:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lc8In-001HmU-J3; Thu, 29 Apr 2021 17:10:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lc8In-009dGx-34; Thu, 29 Apr 2021 17:10:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Alex Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] riscv: Consistify protect_kernel_linear_mapping_text_rodata() use
Date:   Thu, 29 Apr 2021 17:10:04 +0200
Message-Id: <b89a090317cf26bbe1caaa3cfa513a789ece1b19.1619708711.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The various uses of protect_kernel_linear_mapping_text_rodata() are
not consistent:
  - Its definition depends on "64BIT && !XIP_KERNEL",
  - Its forward declaration depends on MMU,
  - Its single caller depends on "STRICT_KERNEL_RWX && 64BIT && MMU &&
    !XIP_KERNEL".

Fix this by settling on the dependencies of the caller, which can be
simplified as STRICT_KERNEL_RWX depends on "MMU && !XIP_KERNEL".
Provide a dummy definition, as the caller is protected by
"IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)" instead of "#ifdef
CONFIG_STRICT_KERNEL_RWX".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Only tested on K210 (SiPeed MAIX BiT).
---
 arch/riscv/include/asm/set_memory.h | 7 ++++++-
 arch/riscv/kernel/setup.c           | 2 --
 arch/riscv/mm/init.c                | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index a9c56776fa0e74d6..086f757e8ba3cc69 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -17,7 +17,6 @@ int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 int set_memory_rw_nx(unsigned long addr, int numpages);
 void protect_kernel_text_data(void);
-void protect_kernel_linear_mapping_text_rodata(void);
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
@@ -27,6 +26,12 @@ static inline void protect_kernel_text_data(void) {}
 static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
+void protect_kernel_linear_mapping_text_rodata(void);
+#else
+static inline void protect_kernel_linear_mapping_text_rodata(void) {}
+#endif
+
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 bool kernel_page_present(struct page *page);
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 7b31779101f662e4..03901d3a8b027343 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -293,9 +293,7 @@ void __init setup_arch(char **cmdline_p)
 
 	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
 		protect_kernel_text_data();
-#if defined(CONFIG_64BIT) && defined(CONFIG_MMU) && !defined(CONFIG_XIP_KERNEL)
 		protect_kernel_linear_mapping_text_rodata();
-#endif
 	}
 
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 3ebc0f5d2b73b42b..6cc0421a5d0ef4a3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -646,7 +646,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 }
 
-#if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
+#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
 void protect_kernel_linear_mapping_text_rodata(void)
 {
 	unsigned long text_start = (unsigned long)lm_alias(_start);
-- 
2.25.1

