Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67680442562
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 02:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhKBCAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 22:00:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25337 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhKBCAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 22:00:12 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HjtFw0PM5zbhNk;
        Tue,  2 Nov 2021 09:52:52 +0800 (CST)
Received: from huawei.com (10.67.174.47) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 2
 Nov 2021 09:57:35 +0800
From:   He Ying <heying24@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <akpm@linux-foundation.org>,
        <npiggin@gmail.com>, <aneesh.kumar@linux.ibm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc: Fix reference leak of node np in opal_lpc_init
Date:   Mon, 1 Nov 2021 21:59:18 -0400
Message-ID: <20211102015918.134647-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When breaking from for_each_compatible_node body, we increase the
reference of node np. Then calling isa_bridge_init_non_pci()
will assign np to isa_bridge_devnode. It looks good. However,
other error paths in the code should put the node np back to avoid
the reference leak. Fix the problem by adding missing
of_node_put().

Signed-off-by: He Ying <heying24@huawei.com>
---
 arch/powerpc/kernel/isa-bridge.c          | 10 +++++++++-
 arch/powerpc/platforms/powernv/opal-lpc.c |  6 +++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index 39c625737c09..bcf1d6024f9e 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -192,14 +192,17 @@ void __init isa_bridge_init_non_pci(struct device_node *np)
 	u64 cbase, pbase, size = 0;
 
 	/* If we already have an ISA bridge, bail off */
-	if (isa_bridge_devnode != NULL)
+	if (isa_bridge_devnode != NULL) {
+		of_node_put(np);
 		return;
+	}
 
 	pna = of_n_addr_cells(np);
 	if (of_property_read_u32(np, "#address-cells", &na) ||
 	    of_property_read_u32(np, "#size-cells", &ns)) {
 		pr_warn("ISA: Non-PCI bridge %pOF is missing address format\n",
 			np);
+		of_node_put(np);
 		return;
 	}
 
@@ -207,6 +210,7 @@ void __init isa_bridge_init_non_pci(struct device_node *np)
 	if (na != 2 || ns != 1) {
 		pr_warn("ISA: Non-PCI bridge %pOF has unsupported address format\n",
 			np);
+		of_node_put(np);
 		return;
 	}
 	rs = na + ns + pna;
@@ -216,6 +220,7 @@ void __init isa_bridge_init_non_pci(struct device_node *np)
 	if (ranges == NULL || rlen < rs) {
 		pr_warn("ISA: Non-PCI bridge %pOF has absent or invalid ranges\n",
 			np);
+		of_node_put(np);
 		return;
 	}
 
@@ -233,6 +238,7 @@ void __init isa_bridge_init_non_pci(struct device_node *np)
 	if (!size || !pbasep) {
 		pr_warn("ISA: Non-PCI bridge %pOF has no usable IO range\n",
 			np);
+		of_node_put(np);
 		return;
 	}
 
@@ -246,6 +252,7 @@ void __init isa_bridge_init_non_pci(struct device_node *np)
 	if (pbase == OF_BAD_ADDR) {
 		pr_warn("ISA: Non-PCI bridge %pOF failed to translate IO base\n",
 			np);
+		of_node_put(np);
 		return;
 	}
 
@@ -253,6 +260,7 @@ void __init isa_bridge_init_non_pci(struct device_node *np)
 	if ((cbase & ~PAGE_MASK) || (pbase & ~PAGE_MASK)) {
 		pr_warn("ISA: Non-PCI bridge %pOF has non aligned IO range\n",
 			np);
+		of_node_put(np);
 		return;
 	}
 
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index 1e5d51db40f8..5647752b2d6a 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -398,8 +398,11 @@ void __init opal_lpc_init(void)
 		opal_lpc_chip_id = of_get_ibm_chip_id(np);
 		break;
 	}
-	if (opal_lpc_chip_id < 0)
+	if (opal_lpc_chip_id < 0) {
+		if (np)
+			of_node_put(np);
 		return;
+	}
 
 	/* Does it support direct mapping ? */
 	if (of_get_property(np, "ranges", NULL)) {
@@ -407,6 +410,7 @@ void __init opal_lpc_init(void)
 			opal_lpc_chip_id);
 		isa_bridge_init_non_pci(np);
 	} else {
+		of_node_put(np);
 		pr_info("OPAL: Found non-mapped LPC bus on chip %d\n",
 			opal_lpc_chip_id);
 
-- 
2.17.1

