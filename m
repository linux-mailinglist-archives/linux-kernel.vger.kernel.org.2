Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD43E8C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhHKIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbhHKIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:52:57 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5BFC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:52:33 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:438:1ff1:1071:f524])
        by albert.telenet-ops.be with bizsmtp
        id g8sX2500K1gJxCh068sXnW; Wed, 11 Aug 2021 10:52:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDjyR-001yhr-J9; Wed, 11 Aug 2021 10:52:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDjyR-00595J-3T; Wed, 11 Aug 2021 10:52:31 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: fdt: Remove early_init_dt_reserve_memory_arch() override capability
Date:   Wed, 11 Aug 2021 10:52:28 +0200
Message-Id: <be0140a0183ecfd0a3afa4fe6d2d77ed418102f9.1628671897.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e7ae8d174eec0b3b ("MIPS: replace add_memory_region with
memblock") removed the last architecture-specific override of
early_init_dt_reserve_memory_arch().
Convert the common implementation from a weak global function to a
static function.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Should the "_arch" suffix be removed?
Similar commit 0fa1c579349fdd90 ("of/fdt: use memblock_virt_alloc for
early alloc") did not.
---
 drivers/of/fdt.c       | 32 ++++++++++++++++----------------
 include/linux/of_fdt.h |  2 --
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0142b9334559baec..ee8f9937227b5e45 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -476,6 +476,22 @@ void *initial_boot_params __ro_after_init;
 
 static u32 of_fdt_crc32;
 
+static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
+					phys_addr_t size, bool nomap)
+{
+	if (nomap) {
+		/*
+		 * If the memory is already reserved (by another region), we
+		 * should not allow it to be marked nomap.
+		 */
+		if (memblock_is_region_reserved(base, size))
+			return -EBUSY;
+
+		return memblock_mark_nomap(base, size);
+	}
+	return memblock_reserve(base, size);
+}
+
 /*
  * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
  */
@@ -1224,22 +1240,6 @@ int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
 	return memblock_mark_hotplug(base, size);
 }
 
-int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
-					phys_addr_t size, bool nomap)
-{
-	if (nomap) {
-		/*
-		 * If the memory is already reserved (by another region), we
-		 * should not allow it to be marked nomap.
-		 */
-		if (memblock_is_region_reserved(base, size))
-			return -EBUSY;
-
-		return memblock_mark_nomap(base, size);
-	}
-	return memblock_reserve(base, size);
-}
-
 static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 {
 	void *ptr = memblock_alloc(size, align);
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index acf820e88952977c..3b1500a0116f91fd 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -68,8 +68,6 @@ extern void early_init_fdt_reserve_self(void);
 extern void __init early_init_dt_scan_chosen_arch(unsigned long node);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
 extern int early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size);
-extern int early_init_dt_reserve_memory_arch(phys_addr_t base, phys_addr_t size,
-					     bool no_map);
 extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
 
 /* Early flat tree scan hooks */
-- 
2.25.1

