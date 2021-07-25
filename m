Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83B3D4CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhGYImx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhGYImr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 04:42:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25484C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 02:23:18 -0700 (PDT)
Date:   Sun, 25 Jul 2021 09:22:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627204995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2mb9i/UeQG/ZQ7sxaqb9i1CdE6NFBMwZPxsEktfiHG4=;
        b=CKFjzvbm+1mH9xOP/UhZicri4fa4eTxtfeejtR1cSuBKa3wyYHG93mffZt1dy1TEDQf1SF
        R7mXISsJ//i67dHJBdSP1BzZc3C2/YftwsKeOvUaGd/b02U4IxmTM+DKtU3GOxxvRtWpuY
        mC9F6PMEp/rPq3m3ftJJFv0XoYVBNgUWWV1xyXPpsFyCkaQrWRptgBRJcSZGuJUjU3BUwC
        +2PUYnkG3abnZlzX/CcYYVVHy2rvbiV5wzZuCcLUXZ9aO1rKW4jlj9jmDQRc9LeEmtkY5K
        eUKRUknEEX29b0v/VZFfiMg/clvz/NfReSaaYw1g7+5JdW1MzTCelnQwFV5bsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627204995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2mb9i/UeQG/ZQ7sxaqb9i1CdE6NFBMwZPxsEktfiHG4=;
        b=bx7aokiulGrvWvkHH3EQjA64TYl2Lb0Z6s6RFUnTfv0vQ8uETUKXY1Pnm/pfhIMCxVOQ7h
        APJeRm7KDf3nkXDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] efi/urgent for v5.14-rc3
References: <162720492071.8837.4047241618315201209.tglx@nanos>
Message-ID: <162720492192.8837.18180570727914662033.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest efi/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2021-07-25

up to:  ddab1e71d2df: Merge tag 'efi-urgent-for-v5.14-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/urgent

A set of EFI fixes:

  - Prevent memblock and I/O reserved resources to get out of sync when EFI
    memreserve is in use.

  - Don't claim a non-existing table is invalid

  - Don't warn when firmware memory is already reserved correctly

Thanks,

	tglx

------------------>
Atish Patra (1):
      efi/libstub: Fix the efi_load_initrd function description

Borislav Petkov (1):
      efi/mokvar: Reserve the table only if it is in boot services data

Marc Zyngier (1):
      firmware/efi: Tell memblock about EFI iomem reservations

Michal Suchanek (1):
      efi/tpm: Differentiate missing and invalid final event log table.


 drivers/firmware/efi/efi.c                     | 13 ++++++++++++-
 drivers/firmware/efi/libstub/efi-stub-helper.c |  4 ++--
 drivers/firmware/efi/mokvar-table.c            |  5 ++++-
 drivers/firmware/efi/tpm.c                     |  8 +++++---
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4b7ee3fa9224..847f33ffc4ae 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -896,6 +896,7 @@ static int __init efi_memreserve_map_root(void)
 static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
 {
 	struct resource *res, *parent;
+	int ret;
 
 	res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
 	if (!res)
@@ -908,7 +909,17 @@ static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
 
 	/* we expect a conflict with a 'System RAM' region */
 	parent = request_resource_conflict(&iomem_resource, res);
-	return parent ? request_resource(parent, res) : 0;
+	ret = parent ? request_resource(parent, res) : 0;
+
+	/*
+	 * Given that efi_mem_reserve_iomem() can be called at any
+	 * time, only call memblock_reserve() if the architecture
+	 * keeps the infrastructure around.
+	 */
+	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK) && !ret)
+		memblock_reserve(addr, size);
+
+	return ret;
 }
 
 int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index aa8da0a49829..ae87dded989d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -630,8 +630,8 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
  * @image:	EFI loaded image protocol
  * @load_addr:	pointer to loaded initrd
  * @load_size:	size of loaded initrd
- * @soft_limit:	preferred size of allocated memory for loading the initrd
- * @hard_limit:	minimum size of allocated memory
+ * @soft_limit:	preferred address for loading the initrd
+ * @hard_limit:	upper limit address for loading the initrd
  *
  * Return:	status code
  */
diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index d8bc01340686..38722d2009e2 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -180,7 +180,10 @@ void __init efi_mokvar_table_init(void)
 		pr_err("EFI MOKvar config table is not valid\n");
 		return;
 	}
-	efi_mem_reserve(efi.mokvar_table, map_size_needed);
+
+	if (md.type == EFI_BOOT_SERVICES_DATA)
+		efi_mem_reserve(efi.mokvar_table, map_size_needed);
+
 	efi_mokvar_table_size = map_size_needed;
 }
 
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index c1955d320fec..8f665678e9e3 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -62,9 +62,11 @@ int __init efi_tpm_eventlog_init(void)
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
 	memblock_reserve(efi.tpm_log, tbl_size);
 
-	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
-	    log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
-		pr_warn(FW_BUG "TPM Final Events table missing or invalid\n");
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
+		pr_info("TPM Final Events table not present\n");
+		goto out;
+	} else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+		pr_warn(FW_BUG "TPM Final Events table invalid\n");
 		goto out;
 	}
 

