Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E8440710
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 05:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhJ3DTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 23:19:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26210 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJ3DTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 23:19:20 -0400
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Hh4DW4DwVz8tbV;
        Sat, 30 Oct 2021 11:15:23 +0800 (CST)
Received: from huawei.com (10.67.174.53) by dggeme706-chm.china.huawei.com
 (10.1.199.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Sat, 30
 Oct 2021 11:16:47 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <ebiederm@xmission.com>,
        <mick@ics.forth.gr>, <jszhang@kernel.org>,
        <guoren@linux.alibaba.com>, <penberg@kernel.org>,
        <sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>,
        <changbin.du@intel.com>, <alex@ghiti.fr>
CC:     <liaochang1@huawei.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
Subject: [PATCH 3/3] RISC-V: Add kexec_file support
Date:   Sat, 30 Oct 2021 11:18:32 +0800
Message-ID: <20211030031832.165457-4-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211030031832.165457-1-liaochang1@huawei.com>
References: <20211030031832.165457-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for kexec_file on RISC-V. I tested it on riscv64
QEMU with busybear-linux and single core along with the OpenSBI firmware
fw_jump.bin for generic platform.

On SMP system, it depends on CONFIG_{HOTPLUG_CPU, RISCV_SBI} to
resume/stop hart through OpenSBI firmware, it also needs a OpenSBI that
support the HSM extension.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/riscv/Kconfig                     |  11 ++
 arch/riscv/include/asm/kexec.h         |   4 +
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/elf_kexec.c          | 180 +++++++++++++++++++++++++
 arch/riscv/kernel/machine_kexec_file.c |  14 ++
 5 files changed, 210 insertions(+)
 create mode 100644 arch/riscv/kernel/elf_kexec.c
 create mode 100644 arch/riscv/kernel/machine_kexec_file.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 301a54233c7e..5ebe8272dec7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -410,6 +410,17 @@ config KEXEC
 
 	  The name comes from the similarity to the exec system call.
 
+config KEXEC_FILE
+	bool "kexec file based systmem call"
+	select KEXEC_CORE
+	select KEXEC_ELF
+	select HAVE_IMA_KEXEC if IMA
+	help
+	  This is new version of kexec system call. This system call is
+	  file based and takes file descriptors as system call argument
+	  for kernel and initramfs as opposed to list of segments as
+	  accepted by previous system call.
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index e4e291d40759..206217b23301 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -53,4 +53,8 @@ typedef void (*riscv_kexec_method)(unsigned long first_ind_entry,
 
 extern riscv_kexec_method riscv_kexec_norelocate;
 
+#ifdef CONFIG_KEXEC_FILE
+extern const struct kexec_file_ops elf_kexec_ops;
+#endif
+
 #endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 3397ddac1a30..8a27639d512a 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -60,6 +60,7 @@ endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_KEXEC)		+= kexec_relocate.o crash_save_regs.o machine_kexec.o
+obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
new file mode 100644
index 000000000000..269be9f9edb8
--- /dev/null
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Load ELF vmlinux file for the kexec_file_load syscall.
+ *
+ * Copyright (C) 2021 Huawei Technologies Co, Ltd.
+ *
+ * Author: Liao Chang (liaochang1@huawei.com)
+ *
+ * Based on kexec-tools' kexec-elf-riscv.c, heavily modified
+ * for kernel.
+ */
+
+#define pr_fmt(fmt)	"kexec_image: " fmt
+
+#include <linux/elf.h>
+#include <linux/kexec.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/libfdt.h>
+#include <linux/types.h>
+
+static int riscv_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
+				struct kexec_elf_info *elf_info, unsigned long old_pbase,
+				unsigned long new_pbase)
+{
+	int i;
+	int ret = 0;
+	size_t size;
+	struct kexec_buf kbuf;
+	const struct elf_phdr *phdr;
+
+	kbuf.image = image;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &elf_info->proghdrs[i];
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		size = phdr->p_filesz;
+		if (size > phdr->p_memsz)
+			size = phdr->p_memsz;
+
+		kbuf.buffer = (void *) elf_info->buffer + phdr->p_offset;
+		kbuf.bufsz = size;
+		kbuf.buf_align = phdr->p_align;
+		kbuf.mem = phdr->p_paddr - old_pbase + new_pbase;
+		kbuf.memsz = phdr->p_memsz;
+		kbuf.top_down = false;
+		ret = kexec_add_buffer(&kbuf);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+/*
+ * Go through the available phsyical memory regions and find one that hold
+ * an image of the specified size.
+ */
+static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
+				struct elfhdr *ehdr, struct kexec_elf_info *elf_info,
+				unsigned long *old_pbase, unsigned long *new_pbase)
+{
+	int i;
+	int ret;
+	struct kexec_buf kbuf;
+	const struct elf_phdr *phdr;
+	unsigned long lowest_paddr = ULONG_MAX;
+	unsigned long lowest_vaddr = ULONG_MAX;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &elf_info->proghdrs[i];
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		if (lowest_paddr > phdr->p_paddr)
+			lowest_paddr = phdr->p_paddr;
+
+		if (lowest_vaddr > phdr->p_vaddr)
+			lowest_vaddr = phdr->p_vaddr;
+	}
+
+	kbuf.image = image;
+	kbuf.buf_min = lowest_paddr;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.buf_align = PAGE_SIZE;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
+	kbuf.top_down = false;
+	ret = arch_kexec_locate_mem_hole(&kbuf);
+	if (!ret) {
+		*old_pbase = lowest_paddr;
+		*new_pbase = kbuf.mem;
+		image->start = ehdr->e_entry - lowest_vaddr + kbuf.mem;
+	}
+	return ret;
+}
+
+static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
+							unsigned long kernel_len, char *initrd,
+							unsigned long initrd_len, char *cmdline,
+							unsigned long cmdline_len)
+{
+	int ret;
+	unsigned long old_kernel_pbase = ULONG_MAX;
+	unsigned long new_kernel_pbase = 0UL;
+	unsigned long initrd_pbase = 0UL;
+	void *fdt;
+	struct elfhdr ehdr;
+	struct kexec_buf kbuf;
+	struct kexec_elf_info elf_info;
+
+	ret = kexec_build_elf_info(kernel_buf, kernel_len, &ehdr, &elf_info);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = elf_find_pbase(image, kernel_len, &ehdr, &elf_info,
+						&old_kernel_pbase, &new_kernel_pbase);
+	if (ret)
+		goto out;
+	pr_notice("The entry point of kernel at 0x%lx\n", image->start);
+
+	/* Add the kernel binary to the image */
+	ret = riscv_kexec_elf_load(image, &ehdr, &elf_info,
+							old_kernel_pbase, new_kernel_pbase);
+	if (ret)
+		goto out;
+
+	kbuf.image = image;
+	kbuf.buf_min = new_kernel_pbase + kernel_len;
+	kbuf.buf_max = ULONG_MAX;
+	/* Add the initrd to the image */
+	if (initrd != NULL) {
+		kbuf.buffer = initrd;
+		kbuf.bufsz = kbuf.memsz = initrd_len;
+		kbuf.buf_align = PAGE_SIZE;
+		kbuf.top_down = false;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+		ret = kexec_add_buffer(&kbuf);
+		if (ret)
+			goto out;
+		initrd_pbase = kbuf.mem;
+		pr_notice("Loaded initrd at 0x%lx\n", initrd_pbase);
+	}
+
+	/* Add the DTB to the image */
+	fdt = of_kexec_alloc_and_setup_fdt(image, initrd_pbase,
+									initrd_len, cmdline, 0);
+	if (!fdt) {
+		pr_err("Error setting up the new device tree.\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fdt_pack(fdt);
+	kbuf.buffer = fdt;
+	kbuf.bufsz = kbuf.memsz = fdt_totalsize(fdt);
+	kbuf.buf_align = PAGE_SIZE;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.top_down = true;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret) {
+		pr_err("Error add DTB kbuf ret=%d\n", ret);
+		goto out_free_fdt;
+	}
+	pr_notice("Loaded device tree at 0x%lx\n", kbuf.mem);
+	goto out;
+
+out_free_fdt:
+	kvfree(fdt);
+out:
+	kexec_free_elf_info(&elf_info);
+	return ret ? ERR_PTR(ret) : NULL;
+}
+
+const struct kexec_file_ops elf_kexec_ops = {
+	.probe = kexec_elf_probe,
+	.load  = elf_kexec_load,
+};
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..b0bf8c1722c0
--- /dev/null
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_file for riscv, use vmlinux as the dump-capture kernel image.
+ *
+ * Copyright (C) 2021 Huawei Technologies Co, Ltd.
+ *
+ * Author: Liao Chang (liaochang1@huawei.com)
+ */
+#include <linux/kexec.h>
+
+const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&elf_kexec_ops,
+	NULL
+};
-- 
2.17.1

