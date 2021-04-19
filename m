Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E3B3638E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 02:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbhDSA4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 20:56:32 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:46714 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbhDSA4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 20:56:31 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 13J0u09m011026
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:56:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1618793755; x=1621385755;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Opd8Luf/TIYWDEE/fDRX+p0He/q818rZmFtOAhbaGrk=;
        b=O2e5dLci+HQ52+wfFsesogpfVZJvoGfEFYFzcow72PsIRbe2KhWjqo7xCXuX1qZv
        fGOwfQoa2nsk7Md5pokmVlh9r1IFp/U9AEJXMra3C5SaZRSSTnUpLjvUSouH9AVs
        ndHKSzb30uxssX8yJRNE6TfPgwiqz669O98uCTz0k3emh66YcAPKFMQxPuY4FVxQ
        1cKqz2KDPSSpzjcs8NDVrQG2/FdUVmLMUe0uIdWYXcdVSWQb3qNOHetEPCrJUPXa
        ocgxxK67HKXdCTy1Dcpfgfn9ScWvQzFY8s3SyA+FhOLFNaulHfCjktn9HVJBiL+y
        zZTY6ttItj1aT1tZWl7n4g==;
X-AuditID: 8b5b014d-a70347000000209f-e7-607cd51bc184
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 35.FF.08351.B15DC706; Mon, 19 Apr 2021 03:55:55 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick@ics.forth.gr at ics.forth.gr
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH v4 5/5] RISC-V: Add crash kernel support
Date:   Mon, 19 Apr 2021 03:55:39 +0300
Message-Id: <20210419005539.22729-6-mick@ics.forth.gr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210419005539.22729-1-mick@ics.forth.gr>
References: <20210419005539.22729-1-mick@ics.forth.gr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsXSHT1dWVf6ak2CwZe1KhaXd81hs9j2uYXN
        ovndOXaLl5d7mC3aZvE7sHq8efmSxePhpktMHpuX1Htcar7O7vF5k1wAaxSXTUpqTmZZapG+
        XQJXxqcrB1gK9ppUzN30j7mB8a5WFyMnh4SAiUT7ofOMXYxcHEICRxklOvq7GCESbhK37+9k
        BbHZBDQl5l86yAJiiwiYSzTPfA1WwyyQIXF03y92EFtYwEJiZtNUsDiLgKrEvTOLgWwODl4B
        M4mPj+MgRspLtC/fzgZicwKNmTLhM1i5EFDJvP93mUBsXgFBiZMzn7BAjJeXaN46m3kCI98s
        JKlZSFILGJlWMQoklhnrZSYX66XlF5Vk6KUXbWIEBx6j7w7G25vf6h1iZOJgPMQowcGsJMJ7
        v7YmQYg3JbGyKrUoP76oNCe1+BCjNAeLkjgvr96EeCGB9MSS1OzU1ILUIpgsEwenVAPTbua9
        WsITt506OvNmZYN6Js9e26LfXjemzOKwnN3/tff2KqZV0gJTu2S5Z67eb8wxNXPfk3m50i3M
        8n8vVT77mbcuzO/Mg0Ndltv2horpGc7pPdQ1Qf1b36m9l6e8NN/TuHxLnNCPjDsskvHr2DWm
        bp8b9lxVLZ0r/tDdpkNMn6tMebVLov3WrHv+bnGCqb9XJV+eeX26f/nqaUFzWGOKK79JBfFf
        0r3rsPZ+n2OInIZk0Jnsrz0rBTjXXXxxusitQvno/gcXH2foif1ee/aG7dH+mm9V95TWxFww
        XH3y4lPR1wWz4nWfVM+enLjH+8viF0GyPN8cyt6ujtotPL+atVuYjVH/YNbDL0/3xkheVmIp
        zkg01GIuKk4EAEQhQEOrAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows Linux to act as a crash kernel for use with
kdump. Userspace will let the crash kernel know about the
memory region it can use through linux,usable-memory property
on the /memory node (overriding its reg property), and about the
memory region where the elf core header of the previous kernel
is saved, through a reserved-memory node with a compatible string
of "linux,elfcorehdr". This approach is the least invasive and
re-uses functionality already present.

I tested this on riscv64 qemu and it works as expected, you
may test it by retrieving the dmesg of the previous kernel
through /proc/vmcore, using the vmcore-dmesg utility from
kexec-tools.

v4:
 * Rebase on top of "fixes" branch

v3:
 * Rebase

v2:
 * Use linux,usable-memory on /memory instead of a new binding
 * Use a reserved-memory node for ELF core header

Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
---
 arch/riscv/Kconfig             | 10 ++++++++
 arch/riscv/kernel/Makefile     |  1 +
 arch/riscv/kernel/crash_dump.c | 46 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c      | 12 +++++++++
 arch/riscv/mm/init.c           | 33 ++++++++++++++++++++++++
 5 files changed, 102 insertions(+)
 create mode 100644 arch/riscv/kernel/crash_dump.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 10cc19be0..39aa18ef4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -400,6 +400,16 @@ config KEXEC
 
 	  The name comes from the similarity to the exec system call.
 
+config CRASH_DUMP
+	bool "Build kdump crash kernel"
+	help
+	  Generate crash dump after being started by kexec. This should
+	  be normally only set in special crash dump kernels which are
+	  loaded in the main kernel with kexec-tools into a specially
+	  reserved region and then later executed after a crash by
+	  kdump/kexec.
+
+	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
 endmenu
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 41a1469b2..d3081e4d9 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -60,6 +60,7 @@ endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_KEXEC)		+= kexec_relocate.o crash_save_regs.o machine_kexec.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
diff --git a/arch/riscv/kernel/crash_dump.c b/arch/riscv/kernel/crash_dump.c
new file mode 100644
index 000000000..86cc0ada5
--- /dev/null
+++ b/arch/riscv/kernel/crash_dump.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This code comes from arch/arm64/kernel/crash_dump.c
+ * Created by: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ * Copyright (C) 2017 Linaro Limited
+ */
+
+#include <linux/crash_dump.h>
+#include <linux/io.h>
+
+/**
+ * copy_oldmem_page() - copy one page from old kernel memory
+ * @pfn: page frame number to be copied
+ * @buf: buffer where the copied page is placed
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page
+ * @userbuf: if set, @buf is in a user address space
+ *
+ * This function copies one page from old kernel memory into buffer pointed by
+ * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
+ * copied or negative error in case of failure.
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
+			 size_t csize, unsigned long offset,
+			 int userbuf)
+{
+	void *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
+	if (!vaddr)
+		return -ENOMEM;
+
+	if (userbuf) {
+		if (copy_to_user((char __user *)buf, vaddr + offset, csize)) {
+			memunmap(vaddr);
+			return -EFAULT;
+		}
+	} else
+		memcpy(buf, vaddr + offset, csize);
+
+	memunmap(vaddr);
+	return csize;
+}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 31866dce9..ff398a3d8 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -66,6 +66,9 @@ static struct resource code_res = { .name = "Kernel code", };
 static struct resource data_res = { .name = "Kernel data", };
 static struct resource rodata_res = { .name = "Kernel rodata", };
 static struct resource bss_res = { .name = "Kernel bss", };
+#ifdef CONFIG_CRASH_DUMP
+static struct resource elfcorehdr_res = { .name = "ELF Core hdr", };
+#endif
 
 static int __init add_resource(struct resource *parent,
 				struct resource *res)
@@ -169,6 +172,15 @@ static void __init init_resources(void)
 	}
 #endif
 
+#ifdef CONFIG_CRASH_DUMP
+	if (elfcorehdr_size > 0) {
+		elfcorehdr_res.start = elfcorehdr_addr;
+		elfcorehdr_res.end = elfcorehdr_addr + elfcorehdr_size - 1;
+		elfcorehdr_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+		add_resource(&iomem_resource, &elfcorehdr_res);
+	}
+#endif
+
 	for_each_reserved_mem_region(region) {
 		res = &mem_res[res_idx--];
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8b2b85a57..9c048fccb 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -13,6 +13,7 @@
 #include <linux/swap.h>
 #include <linux/sizes.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/libfdt.h>
 #include <linux/set_memory.h>
 #include <linux/dma-map-ops.h>
@@ -605,6 +606,18 @@ static void __init reserve_crashkernel(void)
 
 	int ret = 0;
 
+	/*
+	 * Don't reserve a region for a crash kernel on a crash kernel
+	 * since it doesn't make much sense and we have limited memory
+	 * resources.
+	 */
+#ifdef CONFIG_CRASH_DUMP
+	if (is_kdump_kernel()) {
+		pr_info("crashkernel: ignoring reservation request\n");
+		return;
+	}
+#endif
+
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
 	if (ret || !crash_size)
@@ -653,6 +666,26 @@ static void __init reserve_crashkernel(void)
 }
 #endif /* CONFIG_KEXEC_CORE */
 
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * We keep track of the ELF core header of the crashed
+ * kernel with a reserved-memory region with compatible
+ * string "linux,elfcorehdr". Here we register a callback
+ * to populate elfcorehdr_addr/size when this region is
+ * present. Note that this region will be marked as
+ * reserved once we call early_init_fdt_scan_reserved_mem()
+ * later on.
+ */
+static int elfcore_hdr_setup(struct reserved_mem *rmem)
+{
+	elfcorehdr_addr = rmem->base;
+	elfcorehdr_size = rmem->size;
+	return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
+#endif
+
 void __init paging_init(void)
 {
 	setup_vm_final();
-- 
2.26.2

