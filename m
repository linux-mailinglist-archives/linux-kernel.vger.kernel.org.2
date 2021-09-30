Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210E841D27A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 06:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbhI3EpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 00:45:00 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:49988 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229783AbhI3Eo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 00:44:59 -0400
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6E6E0837F24A;
        Thu, 30 Sep 2021 04:43:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 9FE102EBFA4;
        Thu, 30 Sep 2021 04:43:15 +0000 (UTC)
Message-ID: <623750dd31aa3fe5e45c416be98ab37707e2c45d.camel@perches.com>
Subject: [PATCH] memblock: Neaten logging
From:   Joe Perches <joe@perches.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Sep 2021 21:43:14 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: 6t9y1rb5cmp7fo7zws5snfumpd59wgb5
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 9FE102EBFA4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19csmIWk1lvSAhwFxDGSmuB2T445XKQSSo=
X-HE-Tag: 1632976995-185363
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more typical kernel logging styles.

o Add and use #define pr_fmt KBUILD_MODNAME ": " fmt
o Neaten memblock_dbg to use %s: %pS: to output __func__ and caller
o Convert existing uses of pr_<level> and memblock_dbg appropriately

Logging output is now always prefixed with 'memblock: '
Debugging output is now prefixed with 'memblock: ', function and caller

Signed-off-by: Joe Perches <joe@perches.com>
---
 mm/memblock.c | 59 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 184dcd2e5d99..405335c966a8 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2001 Peter Bergner.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -146,10 +148,12 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
 	     i++, rgn = &memblock_type->regions[i])
 
 #define memblock_dbg(fmt, ...)						\
-	do {								\
-		if (memblock_debug)					\
-			pr_info(fmt, ##__VA_ARGS__);			\
-	} while (0)
+do {									\
+	if (memblock_debug)						\
+		pr_info("%s: %pS: " fmt,				\
+			__func__, __builtin_return_address(0),		\
+			##__VA_ARGS__);					\
+} while (0)
 
 static int memblock_debug __initdata_memblock;
 static bool system_has_some_mirror __initdata_memblock = false;
@@ -447,14 +451,14 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 		new_array = addr ? __va(addr) : NULL;
 	}
 	if (!addr) {
-		pr_err("memblock: Failed to double %s array from %ld to %ld entries !\n",
+		pr_err("Failed to double %s array from %ld to %ld entries !\n",
 		       type->name, type->max, type->max * 2);
 		return -1;
 	}
 
 	new_end = addr + new_size - 1;
-	memblock_dbg("memblock: %s is doubled to %ld at [%pa-%pa]",
-			type->name, type->max * 2, &addr, &new_end);
+	memblock_dbg("%s is doubled to %ld at [%pa-%pa]\n",
+		     type->name, type->max * 2, &addr, &new_end);
 
 	/*
 	 * Found space, we now need to move the array over before we add the
@@ -667,8 +671,7 @@ int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("%s: [%pa-%pa] nid=%d %pS\n", __func__,
-		     &base, &end, nid, (void *)_RET_IP_);
+	memblock_dbg("[%pa-%pa] nid=%d\n", &base, &end, nid);
 
 	return memblock_add_range(&memblock.memory, base, size, nid, 0);
 }
@@ -688,8 +691,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+	memblock_dbg("[%pa-%pa]\n", &base, &end);
 
 	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
 }
@@ -789,8 +791,7 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+	memblock_dbg("[%pa-%pa]\n", &base, &end);
 
 	return memblock_remove_range(&memblock.memory, base, size);
 }
@@ -821,8 +822,7 @@ int __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+	memblock_dbg("[%pa-%pa]\n", &base, &end);
 
 	kmemleak_free_part_phys(base, size);
 	return memblock_remove_range(&memblock.reserved, base, size);
@@ -832,8 +832,7 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+	memblock_dbg("[%pa-%pa]\n", &base, &end);
 
 	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
 }
@@ -843,8 +842,7 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+	memblock_dbg("[%pa-%pa]\n", &base, &end);
 
 	return memblock_add_range(&physmem, base, size, MAX_NUMNODES, 0);
 }
@@ -1409,9 +1407,8 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
 					     phys_addr_t start,
 					     phys_addr_t end)
 {
-	memblock_dbg("%s: %llu bytes align=0x%llx from=%pa max_addr=%pa %pS\n",
-		     __func__, (u64)size, (u64)align, &start, &end,
-		     (void *)_RET_IP_);
+	memblock_dbg("%llu bytes align=0x%llx from=%pa max_addr=%pa\n",
+		     (u64)size, (u64)align, &start, &end);
 	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
 					false);
 }
@@ -1510,9 +1507,8 @@ void * __init memblock_alloc_exact_nid_raw(
 			phys_addr_t min_addr, phys_addr_t max_addr,
 			int nid)
 {
-	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
-		     __func__, (u64)size, (u64)align, nid, &min_addr,
-		     &max_addr, (void *)_RET_IP_);
+	memblock_dbg("%llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa\n",
+		     (u64)size, (u64)align, nid, &min_addr, &max_addr);
 
 	return memblock_alloc_internal(size, align, min_addr, max_addr, nid,
 				       true);
@@ -1542,9 +1538,8 @@ void * __init memblock_alloc_try_nid_raw(
 			phys_addr_t min_addr, phys_addr_t max_addr,
 			int nid)
 {
-	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
-		     __func__, (u64)size, (u64)align, nid, &min_addr,
-		     &max_addr, (void *)_RET_IP_);
+	memblock_dbg("%llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa\n",
+		     (u64)size, (u64)align, nid, &min_addr, &max_addr);
 
 	return memblock_alloc_internal(size, align, min_addr, max_addr, nid,
 				       false);
@@ -1574,9 +1569,8 @@ void * __init memblock_alloc_try_nid(
 {
 	void *ptr;
 
-	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
-		     __func__, (u64)size, (u64)align, nid, &min_addr,
-		     &max_addr, (void *)_RET_IP_);
+	memblock_dbg("%llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa\n",
+		     (u64)size, (u64)align, nid, &min_addr, &max_addr);
 	ptr = memblock_alloc_internal(size, align,
 					   min_addr, max_addr, nid, false);
 	if (ptr)
@@ -1599,8 +1593,7 @@ void __init __memblock_free_late(phys_addr_t base, phys_addr_t size)
 	phys_addr_t cursor, end;
 
 	end = base + size - 1;
-	memblock_dbg("%s: [%pa-%pa] %pS\n",
-		     __func__, &base, &end, (void *)_RET_IP_);
+	memblock_dbg("[%pa-%pa]\n", &base, &end);
 	kmemleak_free_part_phys(base, size);
 	cursor = PFN_UP(base);
 	end = PFN_DOWN(base + size);


