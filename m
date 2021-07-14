Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F45F3C84D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbhGNM4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbhGNM4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:56:17 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA5BC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 05:53:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by andre.telenet-ops.be with bizsmtp
        id V0tP2500K1ccfby010tPVP; Wed, 14 Jul 2021 14:53:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3eOB-0018jI-K7; Wed, 14 Jul 2021 14:53:23 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3eOB-00AaR3-8A; Wed, 14 Jul 2021 14:53:23 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] of: kexec: Remove FDT_PROP_* definitions
Date:   Wed, 14 Jul 2021 14:53:22 +0200
Message-Id: <af415c86cd2ba9c8a6bb2eaaf56c3198a24b23d3.1626267092.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FDT_PROP_* definitions make it harder to follow the code.
Remove them, and use the actual string literals instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is v2 of "of: kexec: Always use FDT_PROP_INITRD_START and
FDT_PROP_INITRD_END".
https://lore.kernel.org/r/a4e07a0c1efea913ce5a61136162b5b720b96b48.1623835273.git.geert+renesas@glider.be/

v2:
  - Invert direction, as requested by Rob.
---
 drivers/of/kexec.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index f335d941a716e841..761fd870d1db277f 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -18,14 +18,6 @@
 #include <linux/random.h>
 #include <linux/types.h>
 
-/* relevant device tree properties */
-#define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
-#define FDT_PROP_MEM_RANGE	"linux,usable-memory-range"
-#define FDT_PROP_INITRD_START	"linux,initrd-start"
-#define FDT_PROP_INITRD_END	"linux,initrd-end"
-#define FDT_PROP_BOOTARGS	"bootargs"
-#define FDT_PROP_KASLR_SEED	"kaslr-seed"
-#define FDT_PROP_RNG_SEED	"rng-seed"
 #define RNG_SEED_SIZE		128
 
 /*
@@ -310,10 +302,10 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		goto out;
 	}
 
-	ret = fdt_delprop(fdt, chosen_node, FDT_PROP_KEXEC_ELFHDR);
+	ret = fdt_delprop(fdt, chosen_node, "linux,elfcorehdr");
 	if (ret && ret != -FDT_ERR_NOTFOUND)
 		goto out;
-	ret = fdt_delprop(fdt, chosen_node, FDT_PROP_MEM_RANGE);
+	ret = fdt_delprop(fdt, chosen_node, "linux,usable-memory-range");
 	if (ret && ret != -FDT_ERR_NOTFOUND)
 		goto out;
 
@@ -347,12 +339,12 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 
 	/* add initrd-* */
 	if (initrd_load_addr) {
-		ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_INITRD_START,
+		ret = fdt_setprop_u64(fdt, chosen_node, "linux,initrd-start",
 				      initrd_load_addr);
 		if (ret)
 			goto out;
 
-		ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_INITRD_END,
+		ret = fdt_setprop_u64(fdt, chosen_node, "linux,initrd-end",
 				      initrd_load_addr + initrd_len);
 		if (ret)
 			goto out;
@@ -362,11 +354,11 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 			goto out;
 
 	} else {
-		ret = fdt_delprop(fdt, chosen_node, FDT_PROP_INITRD_START);
+		ret = fdt_delprop(fdt, chosen_node, "linux,initrd-start");
 		if (ret && (ret != -FDT_ERR_NOTFOUND))
 			goto out;
 
-		ret = fdt_delprop(fdt, chosen_node, FDT_PROP_INITRD_END);
+		ret = fdt_delprop(fdt, chosen_node, "linux,initrd-end");
 		if (ret && (ret != -FDT_ERR_NOTFOUND))
 			goto out;
 	}
@@ -374,8 +366,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		/* add linux,elfcorehdr */
 		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
-				FDT_PROP_KEXEC_ELFHDR,
-				image->elf_load_addr,
+				"linux,elfcorehdr", image->elf_load_addr,
 				image->elf_headers_sz);
 		if (ret)
 			goto out;
@@ -391,8 +382,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 
 		/* add linux,usable-memory-range */
 		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
-				FDT_PROP_MEM_RANGE,
-				crashk_res.start,
+				"linux,usable-memory-range", crashk_res.start,
 				crashk_res.end - crashk_res.start + 1);
 		if (ret)
 			goto out;
@@ -400,17 +390,17 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 
 	/* add bootargs */
 	if (cmdline) {
-		ret = fdt_setprop_string(fdt, chosen_node, FDT_PROP_BOOTARGS, cmdline);
+		ret = fdt_setprop_string(fdt, chosen_node, "bootargs", cmdline);
 		if (ret)
 			goto out;
 	} else {
-		ret = fdt_delprop(fdt, chosen_node, FDT_PROP_BOOTARGS);
+		ret = fdt_delprop(fdt, chosen_node, "bootargs");
 		if (ret && (ret != -FDT_ERR_NOTFOUND))
 			goto out;
 	}
 
 	/* add kaslr-seed */
-	ret = fdt_delprop(fdt, chosen_node, FDT_PROP_KASLR_SEED);
+	ret = fdt_delprop(fdt, chosen_node, "kaslr-seed");
 	if (ret == -FDT_ERR_NOTFOUND)
 		ret = 0;
 	else if (ret)
@@ -419,26 +409,26 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 	if (rng_is_initialized()) {
 		u64 seed = get_random_u64();
 
-		ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_KASLR_SEED, seed);
+		ret = fdt_setprop_u64(fdt, chosen_node, "kaslr-seed", seed);
 		if (ret)
 			goto out;
 	} else {
 		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
-				FDT_PROP_KASLR_SEED);
+			  "kaslr-seed");
 	}
 
 	/* add rng-seed */
 	if (rng_is_initialized()) {
 		void *rng_seed;
 
-		ret = fdt_setprop_placeholder(fdt, chosen_node, FDT_PROP_RNG_SEED,
+		ret = fdt_setprop_placeholder(fdt, chosen_node, "rng-seed",
 				RNG_SEED_SIZE, &rng_seed);
 		if (ret)
 			goto out;
 		get_random_bytes(rng_seed, RNG_SEED_SIZE);
 	} else {
 		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
-				FDT_PROP_RNG_SEED);
+			  "rng-seed");
 	}
 
 	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
-- 
2.25.1

