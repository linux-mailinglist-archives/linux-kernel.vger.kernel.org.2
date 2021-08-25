Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC33F7494
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhHYLtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbhHYLtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:49:22 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B50C0617AE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:48:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:91f7:1ea1:147b:586f])
        by michel.telenet-ops.be with bizsmtp
        id lnoW2500F34CCxU06noWqy; Wed, 25 Aug 2021 13:48:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mIrOQ-005kYS-Jc; Wed, 25 Aug 2021 13:48:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mIrOQ-00DDKN-7A; Wed, 25 Aug 2021 13:48:30 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Simon Horman <horms@verge.net.au>,
        Tony Luck <tony.luck@intel.com>, Jay Lan <jlan@sgi.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] ia64: Make reserve_elfcorehdr() static
Date:   Wed, 25 Aug 2021 13:48:28 +0200
Message-Id: <fe236cd73b64abc4abd03dd808cb015c907f4c8c.1629884459.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1629884459.git.geert+renesas@glider.be>
References: <cover.1629884459.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There never was a reason for reserve_elfcorehdr() to be global.
Make the function static, and move it before its sole caller.

Fixes: cee87af2a5f75713 ("[IA64] kexec: Use EFI_LOADER_DATA for ELF core header")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This fixes a conflict triggered by
https://lore.kernel.org/r/c7e46e50aaf87ef49bdaa61358d25b122f32b7df.1628670468.git.geert+renesas@glider.be/
and fixed by
https://lore.kernel.org/r/f6eabbbce0fba6da3da0264c1e1cf23c01173999.1629884393.git.geert+renesas@glider.be
 arch/ia64/include/asm/meminit.h |  1 -
 arch/ia64/kernel/setup.c        | 51 ++++++++++++++++-----------------
 2 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/arch/ia64/include/asm/meminit.h b/arch/ia64/include/asm/meminit.h
index 6c47a239fc26df12..2738f62b5f989492 100644
--- a/arch/ia64/include/asm/meminit.h
+++ b/arch/ia64/include/asm/meminit.h
@@ -40,7 +40,6 @@ extern unsigned long efi_memmap_init(u64 *s, u64 *e);
 extern int find_max_min_low_pfn (u64, u64, void *);
 
 extern unsigned long vmcore_find_descriptor_size(unsigned long address);
-extern int reserve_elfcorehdr(u64 *start, u64 *end);
 
 /*
  * For rounding an address to the next IA64_GRANULE_SIZE or order
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index fbd931f1eb270d98..5e6ee8939092a2df 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -325,6 +325,31 @@ static inline void __init setup_crashkernel(unsigned long total, int *n)
 {}
 #endif
 
+#ifdef CONFIG_CRASH_DUMP
+static int __init reserve_elfcorehdr(u64 *start, u64 *end)
+{
+	u64 length;
+
+	/* We get the address using the kernel command line,
+	 * but the size is extracted from the EFI tables.
+	 * Both address and size are required for reservation
+	 * to work properly.
+	 */
+
+	if (!is_vmcore_usable())
+		return -EINVAL;
+
+	if ((length = vmcore_find_descriptor_size(elfcorehdr_addr)) == 0) {
+		vmcore_unusable();
+		return -EINVAL;
+	}
+
+	*start = (unsigned long)__va(elfcorehdr_addr);
+	*end = *start + length;
+	return 0;
+}
+#endif /* CONFIG_CRASH_DUMP */
+
 /**
  * reserve_memory - setup reserved memory areas
  *
@@ -522,32 +547,6 @@ static __init int setup_nomca(char *s)
 }
 early_param("nomca", setup_nomca);
 
-#ifdef CONFIG_CRASH_DUMP
-int __init reserve_elfcorehdr(u64 *start, u64 *end)
-{
-	u64 length;
-
-	/* We get the address using the kernel command line,
-	 * but the size is extracted from the EFI tables.
-	 * Both address and size are required for reservation
-	 * to work properly.
-	 */
-
-	if (!is_vmcore_usable())
-		return -EINVAL;
-
-	if ((length = vmcore_find_descriptor_size(elfcorehdr_addr)) == 0) {
-		vmcore_unusable();
-		return -EINVAL;
-	}
-
-	*start = (unsigned long)__va(elfcorehdr_addr);
-	*end = *start + length;
-	return 0;
-}
-
-#endif /* CONFIG_CRASH_DUMP */
-
 void __init
 setup_arch (char **cmdline_p)
 {
-- 
2.25.1

