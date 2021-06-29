Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA13B6FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhF2JQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:16:27 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:59491 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhF2JQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:16:26 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C57F724000F;
        Tue, 29 Jun 2021 09:13:56 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 1/3] riscv: Fix memory_limit for 64-bit kernel
Date:   Tue, 29 Jun 2021 11:13:46 +0200
Message-Id: <20210629091349.3802690-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in Documentation/riscv/vm-layout.rst, the end of the
virtual address space for 64-bit kernel is occupied by the modules/BPF/
kernel mappings so this actually reduces the amount of memory we are able
to map and then use in the linear mapping. So make sure this limit is
correctly set.

Fixes: c9811e379b21 ("riscv: Add mem kernel parameter support")
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 12f956b3a674..04a5db3a9788 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -124,10 +124,17 @@ void __init mem_init(void)
 }
 
 /*
- * The default maximal physical memory size is -PAGE_OFFSET,
- * limit the memory size via mem.
+ * The default maximal physical memory size is -PAGE_OFFSET for 32-bit kernel,
+ * whereas for 64-bit kernel, the end of the virtual address space is occupied
+ * by the modules/BPF/kernel mappings which reduces the available size of the
+ * linear mapping.
+ * Limit the memory size via mem.
  */
+#ifdef CONFIG_64BIT
+static phys_addr_t memory_limit = -PAGE_OFFSET - SZ_4G;
+#else
 static phys_addr_t memory_limit = -PAGE_OFFSET;
+#endif
 
 static int __init early_mem(char *p)
 {
-- 
2.30.2

