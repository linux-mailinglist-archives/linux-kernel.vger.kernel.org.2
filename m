Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE94075C3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhIKJXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 05:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235539AbhIKJXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 05:23:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E10A61214;
        Sat, 11 Sep 2021 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631352140;
        bh=3VCxxqXbTa0UBxOLuOi/PMP0R3acXRdfAijemphVwnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqVdVjcImN/2xd+K6RJYF+BcgXSPA/KdI/oUvPiRQMNqwTfbPeJXxQ4J2EufALOsV
         T/78RlnGAzwLlNHn2Qsw6GJgwA9Uc05GpuxIeR7CL6ecGvZn/g51y9GUDvql0IvRFk
         lGSl5DkvUOFTavimKc/9rnMDanN5XqYQmF+CZiA3VcmdRe+YJg8LHMsiFtDkrDvnXS
         Be2zrtRKE4hzk0kfj6sEMqSSW6yagHi3i1reRFVAIc+QCa/AQ14Q2/7LQMqrzevZZV
         jJA9WIHvwlrUQp8Agrgrb6JDUyf15bt87kWBVMKl+3Sr3HxYWoAOeM1BRNj8Fq+6q0
         beWk8xw2RzLfA==
From:   guoren@kernel.org
To:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com
Subject: [RFC PATCH V4 4/6] RISC-V: Implement arch_sync_dma* functions
Date:   Sat, 11 Sep 2021 17:21:37 +0800
Message-Id: <20210911092139.79607-5-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911092139.79607-1-guoren@kernel.org>
References: <20210911092139.79607-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

To facilitate streaming DMA APIs, this patch introduces a set of generic
cache operations related dma sync. Any platform can use the generic ops
to provide platform specific cache management operations. Once the
standard RISC-V CMO extension is available, it can be built on top of it.

Below Added by Guo Ren:
1. Fixup arch_sync_dma_for_cpu with "add DMA_TO_DEVICE force" by Guo Ren and
follow the tips by Christoph:
/*
 * Cache operations depending on function and direction argument, inspired by
 * https://lkml.org/lkml/2018/5/18/979
 * "dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20]
 * dma-mapping: provide a generic dma-noncoherent implementation)"
 *
 *          |   map          ==  for_device     |   unmap     ==  for_cpu
 *          |----------------------------------------------------------------
 * TO_DEV   |   writeback        writeback      |   none          none
 * FROM_DEV |   invalidate       invalidate     |   invalidate*   invalidate*
 * BIDIR    |   writeback+inv    writeback+inv  |   invalidate    invalidate
 *
 *     [*] needed for CPU speculative prefetches
 *
 * NOTE: we don't check the validity of direction argument as it is done in
 * upper layer functions (in include/linux/dma-mapping.h)
 */

2. Christoph:
As told a bunch of times before: doing indirect calls here is a
performance nightmare.  Use something that actually does perform
horribly like alternatives.  Or even delay implementing that until
              ^^^^^^^^^^^^ Agree, and TODO in Atish next path?
we need it and do a plain direct call for now.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
 arch/riscv/mm/Makefile                   |  1 +
 arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
 create mode 100644 arch/riscv/mm/dma-noncoherent.c

diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
new file mode 100644
index 000000000000..5bdb03c9c427
--- /dev/null
+++ b/arch/riscv/include/asm/dma-noncoherent.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#ifndef __ASM_RISCV_DMA_NON_COHERENT_H
+#define __ASM_RISCV_DMA_NON_COHERENT_H
+
+#ifdef CONFIG_RISCV_DMA_NONCOHERENT
+struct riscv_dma_cache_sync {
+	void (*cache_invalidate)(phys_addr_t paddr, size_t size);
+	void (*cache_clean)(phys_addr_t paddr, size_t size);
+	void (*cache_flush)(phys_addr_t paddr, size_t size);
+};
+
+void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops);
+#endif
+
+#endif
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 7ebaef10ea1b..959bef49098b 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -27,3 +27,4 @@ KASAN_SANITIZE_init.o := n
 endif
 
 obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
+obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
new file mode 100644
index 000000000000..63134d57016c
--- /dev/null
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RISC-V specific functions to support DMA for non-coherent devices
+ *
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/libfdt.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <asm/dma-noncoherent.h>
+
+static struct riscv_dma_cache_sync *dma_cache_sync;
+unsigned long riscv_dma_uc_offset;
+
+static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+	if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
+		dma_cache_sync->cache_invalidate(paddr, size);
+	else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
+		dma_cache_sync->cache_clean(paddr, size);
+	else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
+		dma_cache_sync->cache_flush(paddr, size);
+}
+
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+	if (!dma_cache_sync)
+		return;
+
+	__dma_sync(paddr, size, dir);
+}
+
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+	if (!dma_cache_sync || dir == DMA_TO_DEVICE)
+		return;
+
+	__dma_sync(paddr, size, DMA_FROM_DEVICE);
+}
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+		const struct iommu_ops *iommu, bool coherent)
+{
+	/* If a specific device is dma-coherent, set it here */
+	dev->dma_coherent = coherent;
+}
+
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	void *flush_addr = page_address(page);
+
+	memset(flush_addr, 0, size);
+	if (dma_cache_sync && dma_cache_sync->cache_flush)
+		dma_cache_sync->cache_flush(__pa(flush_addr), size);
+}
+
+void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops)
+{
+	dma_cache_sync = ops;
+}
-- 
2.25.1

