Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA0A3A9619
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhFPJaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhFPJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:29:58 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241DFC061768
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:27:51 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:cc2e:97ae:7127:22f8])
        by albert.telenet-ops.be with bizsmtp
        id HlTo2500h51zX4F06lToBR; Wed, 16 Jun 2021 11:27:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltRps-0009M7-GT; Wed, 16 Jun 2021 11:27:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltRpr-0060Z3-Nn; Wed, 16 Jun 2021 11:27:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] of: Remove superfluous casts when printing u64 values
Date:   Wed, 16 Jun 2021 11:27:45 +0200
Message-Id: <ef3f4f78385b43230695ba0855d078290c958192.1623835273.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623835273.git.geert+renesas@glider.be>
References: <cover.1623835273.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"u64" is "unsigned long long" on all architectures now.  Hence there is
no longer a need to use casts when formatting using the "ll" length
modifier.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/address.c | 14 ++++----------
 drivers/of/fdt.c     |  6 ++----
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 350b2baa0af38497..c04fce0fb1790cb6 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -78,9 +78,7 @@ static u64 of_bus_default_map(__be32 *addr, const __be32 *range,
 	s  = of_read_number(range + na + pna, ns);
 	da = of_read_number(addr, na);
 
-	pr_debug("default map, cp=%llx, s=%llx, da=%llx\n",
-		 (unsigned long long)cp, (unsigned long long)s,
-		 (unsigned long long)da);
+	pr_debug("default map, cp=%llx, s=%llx, da=%llx\n", cp, s, da);
 
 	if (da < cp || da >= (cp + s))
 		return OF_BAD_ADDR;
@@ -187,9 +185,7 @@ static u64 of_bus_pci_map(__be32 *addr, const __be32 *range, int na, int ns,
 	s  = of_read_number(range + na + pna, ns);
 	da = of_read_number(addr + 1, na - 1);
 
-	pr_debug("PCI map, cp=%llx, s=%llx, da=%llx\n",
-		 (unsigned long long)cp, (unsigned long long)s,
-		 (unsigned long long)da);
+	pr_debug("PCI map, cp=%llx, s=%llx, da=%llx\n", cp, s, da);
 
 	if (da < cp || da >= (cp + s))
 		return OF_BAD_ADDR;
@@ -302,9 +298,7 @@ static u64 of_bus_isa_map(__be32 *addr, const __be32 *range, int na, int ns,
 	s  = of_read_number(range + na + pna, ns);
 	da = of_read_number(addr + 1, na - 1);
 
-	pr_debug("ISA map, cp=%llx, s=%llx, da=%llx\n",
-		 (unsigned long long)cp, (unsigned long long)s,
-		 (unsigned long long)da);
+	pr_debug("ISA map, cp=%llx, s=%llx, da=%llx\n", cp, s, da);
 
 	if (da < cp || da >= (cp + s))
 		return OF_BAD_ADDR;
@@ -459,7 +453,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 
  finish:
 	of_dump_addr("parent translation for:", addr, pna);
-	pr_debug("with offset: %llx\n", (unsigned long long)offset);
+	pr_debug("with offset: %llx\n", offset);
 
 	/* Translate it into parent bus space */
 	return pbus->translate(addr, offset, pna);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 970fa8cdc9303195..344f16bb04ccf081 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -900,8 +900,7 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 	phys_initrd_start = start;
 	phys_initrd_size = end - start;
 
-	pr_debug("initrd_start=0x%llx  initrd_end=0x%llx\n",
-		 (unsigned long long)start, (unsigned long long)end);
+	pr_debug("initrd_start=0x%llx  initrd_end=0x%llx\n", start, end);
 }
 #else
 static inline void early_init_dt_check_for_initrd(unsigned long node)
@@ -1027,8 +1026,7 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 
 		if (size == 0)
 			continue;
-		pr_debug(" - %llx ,  %llx\n", (unsigned long long)base,
-		    (unsigned long long)size);
+		pr_debug(" - %llx, %llx\n", base, size);
 
 		early_init_dt_add_memory_arch(base, size);
 
-- 
2.25.1

