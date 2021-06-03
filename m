Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85182399C92
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFCIar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:30:47 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:48691 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFCIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:30:46 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 63967FF806;
        Thu,  3 Jun 2021 08:28:57 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v3 1/3] riscv: Factorize xip and !xip kernel address conversion macros
Date:   Thu,  3 Jun 2021 10:27:47 +0200
Message-Id: <20210603082749.1256129-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603082749.1256129-1-alex@ghiti.fr>
References: <20210603082749.1256129-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the kernel address conversion code, make the same definition of
kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for both xip
and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/include/asm/page.h    | 14 +++-----------
 arch/riscv/include/asm/pgtable.h |  2 ++
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 6a7761c86ec2..6e004d8fda4d 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -93,9 +93,7 @@ extern unsigned long va_pa_offset;
 #ifdef CONFIG_64BIT
 extern unsigned long va_kernel_pa_offset;
 #endif
-#ifdef CONFIG_XIP_KERNEL
 extern unsigned long va_kernel_xip_pa_offset;
-#endif
 extern unsigned long pfn_base;
 #define ARCH_PFN_OFFSET		(pfn_base)
 #else
@@ -103,6 +101,7 @@ extern unsigned long pfn_base;
 #ifdef CONFIG_64BIT
 #define va_kernel_pa_offset	0
 #endif
+#define va_kernel_xip_pa_offset 0
 #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
 #endif /* CONFIG_MMU */
 
@@ -110,29 +109,22 @@ extern unsigned long kernel_virt_addr;
 
 #ifdef CONFIG_64BIT
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_pa_offset))
-#ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_pa_to_va(y)	({						\
 	unsigned long _y = y;								\
 	(_y >= CONFIG_PHYS_RAM_BASE) ?							\
 		(void *)((unsigned long)(_y) + va_kernel_pa_offset + XIP_OFFSET) :	\
 		(void *)((unsigned long)(_y) + va_kernel_xip_pa_offset);		\
 	})
-#else
-#define kernel_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_kernel_pa_offset))
-#endif
 #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
 
 #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - va_pa_offset)
-#ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_va_to_pa(y) ({						\
 	unsigned long _y = y;							\
 	(_y < kernel_virt_addr + XIP_OFFSET) ?					\
 		((unsigned long)(_y) - va_kernel_xip_pa_offset) :		\
 		((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET);	\
 	})
-#else
-#define kernel_mapping_va_to_pa(x)	((unsigned long)(x) - va_kernel_pa_offset)
-#endif
+
 #define __va_to_pa_nodebug(x)	({						\
 	unsigned long _x = x;							\
 	(_x < kernel_virt_addr) ?						\
@@ -141,7 +133,7 @@ extern unsigned long kernel_virt_addr;
 #else
 #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
 #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
-#endif
+#endif /* CONFIG_64BIT */
 
 #ifdef CONFIG_DEBUG_VIRTUAL
 extern phys_addr_t __virt_to_phys(unsigned long x);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index bde8ce3bfe7c..d98e931a31e5 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -77,6 +77,8 @@
 
 #ifdef CONFIG_XIP_KERNEL
 #define XIP_OFFSET		SZ_8M
+#else
+#define XIP_OFFSET		0
 #endif
 
 #ifndef __ASSEMBLY__
-- 
2.30.2

