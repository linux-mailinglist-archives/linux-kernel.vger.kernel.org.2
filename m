Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30C7435B65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhJUHL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231305AbhJUHL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:11:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40D39611CB;
        Thu, 21 Oct 2021 07:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634800181;
        bh=Cls98fn6dnG6uMjJS5huAWj6jeFgWd2LJ1jvMwPJpp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdQEIKs3KRJXHrdv2eTw5bf9AOePGbn5Jjb/GvSpyj6WaMjj/5zh4te/yn+bGW4wa
         o6oP2UomX/um/n0ZewnX+ikmjPke24AiiamX/7BiRFB1QPvLd7g4iJG33Up5lH9Nvu
         CTV7wZaWyrbvW6/gw4OxuDKdO5sH+0B4anh3MTL8vI32ZmmYyh7EyLI5YqHYhc8VwO
         zgNllZ/rFF9sEli7xe6wXcmkwPT9PbVSiQk6cdXkpkRyjv+b0f86NXsp3DEMFTdZft
         i5FMayP1ic2VPKmXN5oKN/jQwAifMjP9jZGHaU7V8gBagfyZg3Z0gIjBOdQS39PbTV
         xzcg65xNdqfZg==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] memblock: exclude MEMBLOCK_NOMAP regions from kmemleak
Date:   Thu, 21 Oct 2021 10:09:29 +0300
Message-Id: <20211021070929.23272-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211021070929.23272-1-rppt@kernel.org>
References: <20211021070929.23272-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Vladimir Zapolskiy reports:

commit a7259df76702 ("memblock: make memblock_find_in_range method private")
invokes a kernel panic while running kmemleak on OF platforms with nomaped
regions:

  Unable to handle kernel paging request at virtual address fff000021e00000
  [...]
    scan_block+0x64/0x170
    scan_gray_list+0xe8/0x17c
    kmemleak_scan+0x270/0x514
    kmemleak_write+0x34c/0x4ac

The memory allocated from memblock is registered with kmemleak, but if it
is marked MEMBLOCK_NOMAP it won't have linear map entries so an attempt to
scan such areas will fault.

Ideally, memblock_mark_nomap() would inform kmemleak to ignore
MEMBLOCK_NOMAP memory, but it can be called before kmemleak interfaces
operating on physical addresses can use __va() conversion.

Make sure that functions that mark allocated memory as MEMBLOCK_NOMAP take
care of informing kmemleak to ignore such memory.

Link: https://lore.kernel.org/all/8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org
Link: https://lore.kernel.org/all/c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com
Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
Reported-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 drivers/acpi/tables.c        | 3 +++
 drivers/of/of_reserved_mem.c | 2 ++
 mm/memblock.c                | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f9383736fa0f..71419eb16e09 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -21,6 +21,7 @@
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
 #include <linux/security.h>
+#include <linux/kmemleak.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -601,6 +602,8 @@ void __init acpi_table_upgrade(void)
 	 */
 	arch_reserve_mem_area(acpi_tables_addr, all_tables_size);
 
+	kmemleak_ignore_phys(acpi_tables_addr);
+
 	/*
 	 * early_ioremap only can remap 256k one time. If we map all
 	 * tables one time, we will hit the limit. Need to map chunks
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 59c1390cdf42..9da8835ba5a5 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -21,6 +21,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
+#include <linux/kmemleak.h>
 
 #include "of_private.h"
 
@@ -46,6 +47,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 		err = memblock_mark_nomap(base, size);
 		if (err)
 			memblock_free(base, size);
+		kmemleak_ignore_phys(base);
 	}
 
 	return err;
diff --git a/mm/memblock.c b/mm/memblock.c
index 184dcd2e5d99..dab804b09d62 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -932,6 +932,9 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
  * covered by the memory map. The struct page representing NOMAP memory
  * frames in the memory map will be PageReserved()
  *
+ * Note: if the memory being marked %MEMBLOCK_NOMAP was allocated from
+ * memblock, the caller must inform kmemleak to ignore that memory
+ *
  * Return: 0 on success, -errno on failure.
  */
 int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
-- 
2.28.0

