Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22659353D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 10:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhDEI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 04:58:10 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:56931 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbhDEI5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 04:57:42 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 1358vWDK079890
        for <linux-kernel@vger.kernel.org>; Mon, 5 Apr 2021 11:57:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1617613047; x=1620205047;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BH9rkqbpEw6Ux/YR+romPrZxgh0AN8grObdmfeP55TM=;
        b=H2M4qk/jCJV7AM9vJ/DAyI42X+1w9WX4+GuCSkgZzNwRZXsWNUkMtl5HYYQuZFa3
        XztAcVOpw7zE3on8hIFNb57kxdbTMLEJ4VSKpFb3yzGSDC6ZA36pGzeoF1xtAQPw
        3W5x0gmFLJpcICbPkTkdzYcgx1QErghrORL1LWiOD3BJNMDWQ6cV6689iAA1MF32
        iyKJpCcniolEDwF4Gkf1q6vs6QgE+I0h71EPgIelNgZeImzKqtgTQMB2knZdtCpI
        fbp97qMdT7bULWaGEwRcMuN+87PdBHDtMzcvDQpP5nkPzIRu1k+koMtuVH4K/kAb
        XPwxDiTsD6JffEf5MkPE+Q==;
X-AuditID: 8b5b014d-a4c337000000209f-dc-606ad0f78f2b
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 19.77.08351.7F0DA606; Mon,  5 Apr 2021 11:57:27 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick@ics.forth.gr at ics.forth.gr
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mickflemm@gmail.com>,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH v3 5/5] RISC-V: Add crash kernel support
Date:   Mon,  5 Apr 2021 11:57:12 +0300
Message-Id: <20210405085712.1953848-6-mick@ics.forth.gr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210405085712.1953848-1-mick@ics.forth.gr>
References: <20210405085712.1953848-1-mick@ics.forth.gr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsXSHT1dWff7hawEg5adhhaXd81hs9j2uYXN
        ovndOXaL1Rd2slq8vNzDbNE2i9+BzePNy5csHjtn3WX3eLjpEpPH5iX1Hpear7N7fN4kF8AW
        xWWTkpqTWZZapG+XwJXx9dIsloKDJhXvNzxgb2B8rtXFyMkhIWAicWz+erYuRi4OIYGjjBJt
        866yQiTcJG7f3wlmswloSsy/dJAFxBYRMJdonvmaEaSBWWAGo8S6W1MZQRLCAhYSRz42s4HY
        LAKqEhs272UCsXmB4m8/PoMaKi/Rvnw7WA2ngKXEtvOLwGqEgGquH+thhKgXlDg58wnYMmag
        +uats5knMPLNQpKahSS1gJFpFaNAYpmxXmZysV5aflFJhl560SZGcEAy+u5gvL35rd4hRiYO
        xkOMEhzMSiK8DxuyEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInz8upNiBcSSE8sSc1OTS1ILYLJ
        MnFwSjUwtQjxbFg5s3Huk/J1C8IkW62rM+fE8oU2eCz7FlhTun7FazXTwhiDjtfpOzY4nrVx
        OrlW8YaRQHUO05ljR7cWfX361TlWkGObjWrT1+oL+7P2i/y90/34paypc8tV4+LkT5wrZ4Xe
        F3NpWs+i9HXJuY6bz9oZ/t/NS9K5/uLHxs97RRfyZ7Pf/VyQOXXaFpE03rD4Xe8TDuyZPSfI
        6KB25Nbg/rY9M3ks2ZenxcaWqi1XUNJf7LZB8c5r/p1JLFynRCZNPlo+RV3/XGmO5p/PBxjY
        5/rMkTPVeBfTF1r/p2kpM+ezA0WfZEyNX3guY1vjbmVZfPlLcVRiZ5us1tTi57O2TDuZcXjF
        PxELg/pZSizFGYmGWsxFxYkA3e0lhLcCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Kossifidis <mickflemm@gmail.com>

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
index 3716262ef..553c2dced 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -403,6 +403,16 @@ config KEXEC
 
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
index 07f676ad3..bd66d2ce0 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -59,6 +59,7 @@ endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-${CONFIG_KEXEC}		+= kexec_relocate.o crash_save_regs.o machine_kexec.o
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
index e71b35cec..f66011816 100644
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
@@ -606,6 +607,18 @@ static void __init reserve_crashkernel(void)
 
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
@@ -660,6 +673,26 @@ static void __init reserve_crashkernel(void)
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

