Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFCC3D7417
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhG0LO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236212AbhG0LOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627384494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GLSOqE5YqQWmtvywswniwVjXT+sCyGzAgVxfPkQlwx4=;
        b=jRKSgYq1XUFtgTuMR+QS/hDBCKhufWGwFQa5SyAn1ESo121CT/weJqSptR89qApBt686OB
        X2yy1yvQhFSuYkdO516pctV+1pdGgjaK4sKQXM+fYAvl1roJOV6lXs76HWXpmJHRmKQ8Iy
        0+Coxp3RCqQGbUr9QLfUYOoLDDVEEYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-6Cb1HH3iNzGdoDkl6Qg_ew-1; Tue, 27 Jul 2021 07:14:50 -0400
X-MC-Unique: 6Cb1HH3iNzGdoDkl6Qg_ew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85A33100A616;
        Tue, 27 Jul 2021 11:14:49 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.193.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 076AD61093;
        Tue, 27 Jul 2021 11:14:46 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     rppt@kernel.org
Cc:     bp@alien8.de, tglx@linutronix.de, x86@kernel.org,
        pjones@redhat.com, konrad@kernel.org, george.kennedy@oracle.com,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] iscsi_ibft: fix crash due to KASLR physical memory remapping
Date:   Tue, 27 Jul 2021 13:14:46 +0200
Message-Id: <20210727111446.119561-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with commit a799c2bd29d19c565f37fa038b31a0a1d44d0e4d
memory reservations have been moved earlier during the boot process,
before the execution of the Kernel Address Space Layout Randomization code.

setup_arch() calls the iscsi_ibft's find_ibft_region() function
to find and reserve the memory dedicated to the iBFT; this function
also saves a (virt) pointer to the iBFT table for later use.

The problem is that if KALSR is active, the physical memory gets
remapped somewhere else in the virtual address space and the pointer is
no longer valid, this will cause a kernel panic when the iscsi driver tries
to dereference it.

This patch fixes the bug by saving the address of the physical location
of the ibft; later the driver will use isa_bus_to_virt() to get
the correct virtual address.

It will also simplify the code by renaming find_ibft_region()
to reserve_ibft_region() and removing all the wrappers.

[   37.764225] iBFT detected.
[   37.778877] BUG: unable to handle page fault for address: ffff888000099fd8
[   37.816542] #PF: supervisor read access in kernel mode
[   37.844304] #PF: error_code(0x0000) - not-present page
[   37.872857] PGD 0 P4D 0
[   37.886985] Oops: 0000 [#1] SMP PTI
[   37.904809] CPU: 46 PID: 1073 Comm: modprobe Tainted: G               X --------- ---  5.13.0-0.rc2.19.el9.x86_64 #1
[   37.956525] Hardware name: HP ProLiant DL580 G7, BIOS P65 10/01/2013
[   37.987170] RIP: 0010:ibft_init+0x3e/0xd42 [iscsi_ibft]
[   38.012976] Code: 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 83 3d e1 cc 7e d7 00 74 28 48 c7 c7 21 81 1b c0 e8 b3 10 81 d5 48 8b 05 cc cc 7e d7 <0f> b6 70 08 48 63 50 04 40 80 fe 01 75 5e 31 f6 48 01 c2 eb 6e 83
[   38.106835] RSP: 0018:ffffb7d288fc3db0 EFLAGS: 00010246
[   38.131341] RAX: ffff888000099fd0 RBX: 0000000000000000 RCX: 0000000000000000
[   38.167110] RDX: 0000000000000000 RSI: ffff9ba7efb97c80 RDI: ffff9ba7efb97c80
[   38.200777] RBP: ffffffffc01c82be R08: 0000000000000000 R09: ffffb7d288fc3bf0
[   38.237188] R10: ffffb7d288fc3be8 R11: ffffffff96de70a8 R12: ffff9ba4059d6400
[   38.270940] R13: 000055689f1ac050 R14: 000055689df18962 R15: ffffb7d288fc3e78
[   38.307167] FS:  00007f9546720b80(0000) GS:ffff9ba7efb80000(0000) knlGS:0000000000000000
[   38.351204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.381034] CR2: ffff888000099fd8 CR3: 000000044175e004 CR4: 00000000000206e0
[   38.419938] Call Trace:
[   38.432679]  ? ibft_create_kobject+0x1d2/0x1d2 [iscsi_ibft]
[   38.462584]  do_one_initcall+0x44/0x1d0
[   38.480856]  ? kmem_cache_alloc_trace+0x119/0x220
[   38.505554]  do_init_module+0x5c/0x270
[   38.526578]  __do_sys_init_module+0x12e/0x1b0
[   38.548699]  do_syscall_64+0x40/0x80
[   38.565679]  entry_SYSCALL_64_after_hwframe+0x44/0xae

v2: fix a comment in linux/iscsi_ibft.h

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 arch/x86/kernel/setup.c            | 10 -------
 drivers/firmware/iscsi_ibft.c      | 10 +++++--
 drivers/firmware/iscsi_ibft_find.c | 48 +++++++++++-------------------
 include/linux/iscsi_ibft.h         | 18 +++++------
 4 files changed, 32 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bff3a784aec5..63b20536c8d2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -572,16 +572,6 @@ void __init reserve_standard_io_resources(void)
 
 }
 
-static __init void reserve_ibft_region(void)
-{
-	unsigned long addr, size = 0;
-
-	addr = find_ibft_region(&size);
-
-	if (size)
-		memblock_reserve(addr, size);
-}
-
 static bool __init snb_gfx_workaround_needed(void)
 {
 #ifdef CONFIG_PCI
diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 7127a04bca19..612a59e213df 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -84,8 +84,10 @@ MODULE_DESCRIPTION("sysfs interface to BIOS iBFT information");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(IBFT_ISCSI_VERSION);
 
+static struct acpi_table_ibft *ibft_addr;
+
 #ifndef CONFIG_ISCSI_IBFT_FIND
-struct acpi_table_ibft *ibft_addr;
+phys_addr_t ibft_phys_addr;
 #endif
 
 struct ibft_hdr {
@@ -858,11 +860,13 @@ static int __init ibft_init(void)
 	int rc = 0;
 
 	/*
-	   As on UEFI systems the setup_arch()/find_ibft_region()
+	   As on UEFI systems the setup_arch()/reserve_ibft_region()
 	   is called before ACPI tables are parsed and it only does
 	   legacy finding.
 	*/
-	if (!ibft_addr)
+	if (ibft_phys_addr)
+		ibft_addr = isa_bus_to_virt(ibft_phys_addr);
+	else
 		acpi_find_ibft_region();
 
 	if (ibft_addr) {
diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
index 64bb94523281..a0594590847d 100644
--- a/drivers/firmware/iscsi_ibft_find.c
+++ b/drivers/firmware/iscsi_ibft_find.c
@@ -31,8 +31,8 @@
 /*
  * Physical location of iSCSI Boot Format Table.
  */
-struct acpi_table_ibft *ibft_addr;
-EXPORT_SYMBOL_GPL(ibft_addr);
+phys_addr_t ibft_phys_addr;
+EXPORT_SYMBOL_GPL(ibft_phys_addr);
 
 static const struct {
 	char *sign;
@@ -47,13 +47,24 @@ static const struct {
 #define VGA_MEM 0xA0000 /* VGA buffer */
 #define VGA_SIZE 0x20000 /* 128kB */
 
-static int __init find_ibft_in_mem(void)
+/*
+ * Routine used to find and reserve the iSCSI Boot Format Table
+ */
+void __init reserve_ibft_region(void)
 {
 	unsigned long pos;
 	unsigned int len = 0;
 	void *virt;
 	int i;
 
+	ibft_phys_addr = 0;
+
+	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
+	 * only use ACPI for this
+	 */
+	if (efi_enabled(EFI_BOOT))
+		return;
+
 	for (pos = IBFT_START; pos < IBFT_END; pos += 16) {
 		/* The table can't be inside the VGA BIOS reserved space,
 		 * so skip that area */
@@ -70,35 +81,12 @@ static int __init find_ibft_in_mem(void)
 				/* if the length of the table extends past 1M,
 				 * the table cannot be valid. */
 				if (pos + len <= (IBFT_END-1)) {
-					ibft_addr = (struct acpi_table_ibft *)virt;
-					pr_info("iBFT found at 0x%lx.\n", pos);
-					goto done;
+					ibft_phys_addr = pos;
+					memblock_reserve(ibft_phys_addr, PAGE_ALIGN(len));
+					pr_info("iBFT found at 0x%lx.\n", ibft_phys_addr);
+					return;
 				}
 			}
 		}
 	}
-done:
-	return len;
-}
-/*
- * Routine used to find the iSCSI Boot Format Table. The logical
- * kernel address is set in the ibft_addr global variable.
- */
-unsigned long __init find_ibft_region(unsigned long *sizep)
-{
-	ibft_addr = NULL;
-
-	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
-	 * only use ACPI for this */
-
-	if (!efi_enabled(EFI_BOOT))
-		find_ibft_in_mem();
-
-	if (ibft_addr) {
-		*sizep = PAGE_ALIGN(ibft_addr->header.length);
-		return (u64)virt_to_phys(ibft_addr);
-	}
-
-	*sizep = 0;
-	return 0;
 }
diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
index b7b45ca82bea..790e7fcfc1a6 100644
--- a/include/linux/iscsi_ibft.h
+++ b/include/linux/iscsi_ibft.h
@@ -13,26 +13,22 @@
 #ifndef ISCSI_IBFT_H
 #define ISCSI_IBFT_H
 
-#include <linux/acpi.h>
+#include <linux/types.h>
 
 /*
- * Logical location of iSCSI Boot Format Table.
- * If the value is NULL there is no iBFT on the machine.
+ * Physical location of iSCSI Boot Format Table.
+ * If the value is 0 there is no iBFT on the machine.
  */
-extern struct acpi_table_ibft *ibft_addr;
+extern phys_addr_t ibft_phys_addr;
 
 /*
  * Routine used to find and reserve the iSCSI Boot Format Table. The
- * mapped address is set in the ibft_addr variable.
+ * physical address is set in the ibft_phys_addr variable.
  */
 #ifdef CONFIG_ISCSI_IBFT_FIND
-unsigned long find_ibft_region(unsigned long *sizep);
+void reserve_ibft_region(void);
 #else
-static inline unsigned long find_ibft_region(unsigned long *sizep)
-{
-	*sizep = 0;
-	return 0;
-}
+static inline void reserve_ibft_region(void) {}
 #endif
 
 #endif /* ISCSI_IBFT_H */
-- 
2.27.0

