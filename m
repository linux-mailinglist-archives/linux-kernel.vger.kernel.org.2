Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7DF3E8C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbhHKIyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhHKIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:54:05 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A2C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:53:40 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:438:1ff1:1071:f524])
        by albert.telenet-ops.be with bizsmtp
        id g8tf2500X1gJxCh068tfzh; Wed, 11 Aug 2021 10:53:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDjzX-001yiR-96; Wed, 11 Aug 2021 10:53:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDjzW-0059AM-NL; Wed, 11 Aug 2021 10:53:38 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: fdt: Remove weak early_init_dt_mark_hotplug_memory_arch()
Date:   Wed, 11 Aug 2021 10:53:37 +0200
Message-Id: <1a61f75ec50d3c2922fcdbe33337266a58a4125f.1628671960.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 41a9ada3e6b4253f ("of/fdt: mark hotpluggable memory") introduced
two (for systems with and without memblock) weak versions of
early_init_dt_mark_hotplug_memory_arch(), that could be overridden by an
architecture-specific version.  However, no overrides ever emerged.
Later, commit aca52c3983891060 ("mm: remove CONFIG_HAVE_MEMBLOCK")
removed the non-memblock version.

Remove early_init_dt_mark_hotplug_memory_arch(), and replace it by a
direct call to memblock_mark_hotplug().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/fdt.c       | 7 +------
 include/linux/of_fdt.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ee8f9937227b5e45..d29e610d336d39a5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1120,7 +1120,7 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 		if (!hotpluggable)
 			continue;
 
-		if (early_init_dt_mark_hotplug_memory_arch(base, size))
+		if (memblock_mark_hotplug(base, size))
 			pr_warn("failed to mark hotplug range 0x%llx - 0x%llx\n",
 				base, base + size);
 	}
@@ -1235,11 +1235,6 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 	memblock_add(base, size);
 }
 
-int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
-{
-	return memblock_mark_hotplug(base, size);
-}
-
 static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 {
 	void *ptr = memblock_alloc(size, align);
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 3b1500a0116f91fd..cf6a65b94d40e6a7 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -67,7 +67,6 @@ extern void early_init_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
 extern void __init early_init_dt_scan_chosen_arch(unsigned long node);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
-extern int early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size);
 extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
 
 /* Early flat tree scan hooks */
-- 
2.25.1

