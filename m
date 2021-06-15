Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968D23A8860
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhFOSTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFOSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:19:50 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0653C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:17:45 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:bda0:7de0:767e:26f9])
        by albert.telenet-ops.be with bizsmtp
        id HWHe2500a4N5gS306WHeeA; Tue, 15 Jun 2021 20:17:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltDd4-00HYOP-66; Tue, 15 Jun 2021 20:17:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltDd3-005qAG-NQ; Tue, 15 Jun 2021 20:17:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] of: fdt: Add generic support for parsing elf core header properties
Date:   Tue, 15 Jun 2021 20:17:25 +0200
Message-Id: <8661d652968d050489852ccb50df5ad4cc048900.1623780059.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623780059.git.geert+renesas@glider.be>
References: <cover.1623780059.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two methods to specify the location of the elf core header:
using the "elfcorehdr=" kernel parameter, as handled by generic code in
kernel/crash_dump.c, or using the "linux,elfcorehdr" property under the
"/chosen" node in the Device Tree, as handled by architecture-specific
code in arch/arm64/mm/init.c.

Extend support for "linux,elfcorehdr" to all platforms supporting DT by
adding platform-agnostic handling for parsing this property to the FDT
core code.  This can co-exist safely with the architecture-specific
handling, until the latter has been removed.

This requires moving the call to of_scan_flat_dt() up, as the code
scanning the "/chosen" node now needs to be aware of the values of
"#address-cells" and "#size-cells".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/chosen.txt |  6 ++--
 drivers/of/fdt.c                             | 37 ++++++++++++++++++--
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 45e79172a646c537..5b0b94eb2d04e79d 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -106,9 +106,9 @@ respectively, of the root node.
 linux,elfcorehdr
 ----------------
 
-This property (currently used only on arm64) holds the memory range,
-the address and the size, of the elf core header which mainly describes
-the panicked kernel's memory layout as PT_LOAD segments of elf format.
+This property holds the memory range, the address and the size, of the elf
+core header which mainly describes the panicked kernel's memory layout as
+PT_LOAD segments of elf format.
 e.g.
 
 / {
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a03d43f95495d8e1..f13db831c8028cce 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt)	"OF: fdt: " fmt
 
+#include <linux/crash_dump.h>
 #include <linux/crc32.h>
 #include <linux/kernel.h>
 #include <linux/initrd.h>
@@ -909,6 +910,35 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
+#ifdef CONFIG_CRASH_DUMP
+/**
+ * early_init_dt_check_for_elfcorehdr - Decode elfcorehdr location from flat
+ * tree
+ * @node: reference to node containing elfcorehdr location ('chosen')
+ */
+static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
+{
+	const __be32 *prop;
+	int len;
+
+	pr_debug("Looking for elfcorehdr property... ");
+
+	prop = of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
+	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
+		return;
+
+	elfcorehdr_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
+	elfcorehdr_size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+	pr_debug("elfcorehdr_start=0x%llx elfcorehdr_size=0x%llx\n",
+		 elfcorehdr_addr, elfcorehdr_size);
+}
+#else
+static inline void early_init_dt_check_for_elfcorehdr(unsigned long node)
+{
+}
+#endif
+
 #ifdef CONFIG_SERIAL_EARLYCON
 
 int __init early_init_dt_scan_chosen_stdout(void)
@@ -1057,6 +1087,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 		return 0;
 
 	early_init_dt_check_for_initrd(node);
+	early_init_dt_check_for_elfcorehdr(node);
 
 	/* Retrieve command line */
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
@@ -1201,14 +1232,14 @@ void __init early_init_dt_scan_nodes(void)
 {
 	int rc = 0;
 
+	/* Initialize {size,address}-cells info */
+	of_scan_flat_dt(early_init_dt_scan_root, NULL);
+
 	/* Retrieve various information from the /chosen node */
 	rc = of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
 	if (!rc)
 		pr_warn("No chosen node found, continuing without\n");
 
-	/* Initialize {size,address}-cells info */
-	of_scan_flat_dt(early_init_dt_scan_root, NULL);
-
 	/* Setup memory, calling early_init_dt_add_memory_arch */
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 }
-- 
2.25.1

