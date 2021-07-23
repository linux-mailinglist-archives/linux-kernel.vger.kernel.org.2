Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F4A3D4256
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhGWVAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:00:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17043 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhGWVAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627076435; x=1658612435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z1V0kd2qCOL9tX4hStPvB2PLIDsfutT0f6QLFPZOYuY=;
  b=iG7AibeurwyiXWIYpcVlKNGlMgi7EDzIF5Xxk3W4fxTwmHWWgn5LQq37
   EyncGuAeFqlEjjIo2GtiTMrs0dnVQBUAPzCx++xE6sfgtlXBU0TDwSG8C
   zvlc0cnVC/wrc4wSxf9osnSG6CyIlyBpwqmXhMXa8RJxG65gvrsLefx9M
   dBkxR4weihxTcnAKNNP0Ib2eqnOwmYzQSE57960+AF4j9++sWUdISpKL3
   NfoGOqZ8rwjQNkcfUhmX0q57YYhPtvrX+MYzZHhae8vwGGkEzmsJ6vZx9
   k9vcc+QjYc+fBKy2OORvQcOO3D6dnq5ufjewrq65LszRn7KdbN1visNxh
   g==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; 
   d="scan'208";a="279198454"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:35 +0800
IronPort-SDR: wlAe2RrtPk9YszOES+guOlXkGe2D44T+KKaARqmja73Dzx8L0FtZFW/CMCcfebahCdNLwshpqK
 b5+rXAR7Mw7AGOqufqWAsR+mflFSUL/ldvdX0sCn60MFsdQDbMfkUj+ZYaKcdX70fkFjJxhrHR
 DmuFlJE6fnHWC6xCTlfu9pkpa7+2TKw75vfgcWTdPMl6DlQzWWn5YejCne0T7FWRkeLhF7w9aH
 XaTzu4hxk6ZlEu7BdXXocF8upktR+K8n+pSM9DDtQw/z8HEcjIhwVokNgXD2rD3GHUP+0FzExJ
 n/aYEMkxvR8CGU2ffJvcWug2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:16:44 -0700
IronPort-SDR: 7ealWTp55CZ7bL3tJ/aaVbGP16h6pCxLZLGJvdMqFInFeK8lXI6qJJN+T294Fk+cYCKbuRL5a4
 DhDqryWpLNkLiLpQOnSDhKLtI/n83up5yrg0WRdErqNgFt6WnEsy6VIRw8FiXw0beTku/Xy+2j
 Cn5C3UcecDXN800Im5bjdY1oxeqxFb3MnA6CPcHcUHHba368h5HZWtH2v9d/0hlW7IwbBfjpDC
 xgEeNzkU5VFflnDZT1HNlyhkeQBEszXMbNruQNMxO/1AVPQTvXu4H3WBXPGZCJ/IUvMI+MhHm5
 AlM=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:36 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, devicetree@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [RFC 1/5] RISC-V: Implement arch_sync_dma* functions
Date:   Fri, 23 Jul 2021 14:40:27 -0700
Message-Id: <20210723214031.3251801-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723214031.3251801-1-atish.patra@wdc.com>
References: <20210723214031.3251801-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To facilitate streaming DMA APIs, this patch introduces a set of generic
cache operations related dma sync. Any platform can use the generic ops
to provide platform specific cache management operations. Once the
standard RISC-V CMO extension is available, it can be built on top of it.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
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
index 000000000000..2f6e9627c4aa
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
+	if (!dma_cache_sync)
+		return;
+
+	__dma_sync(paddr, size, dir);
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
2.31.1

