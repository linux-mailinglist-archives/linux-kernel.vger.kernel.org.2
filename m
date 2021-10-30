Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CDE44070E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 05:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhJ3DTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 23:19:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14881 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhJ3DTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 23:19:19 -0400
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hh4G20D8pz8vfp;
        Sat, 30 Oct 2021 11:16:42 +0800 (CST)
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
Subject: [PATCH 0/3] riscv: kexec: add kexec_file_load() support
Date:   Sat, 30 Oct 2021 11:18:29 +0800
Message-ID: <20211030031832.165457-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implement kexec_file_load() support on riscv, Most of the
code is based on the kexec-tool-patch repo developed by Nick Kossifids.

This patch series enables us to load the riscv vmlinux by specifying
its file decriptor, instead of user-filled buffer via kexec_file_load()
syscall.

Contrary to kexec_load() system call, we reuse the dt blob of the first
kernel to the 2nd explicitly.

To use kexec_file_load() system call, instead of kexec_load(), at kexec
command, '-s' options must be specified. The patch for kexec_tools has
to be apply to riscv architecture source like this:

int elf_riscv_load(int argc, char **argv, const char *buf, off_t len,
	...
	if (info->file_mode) {
		return prepare_kexec_file_options(info);
	}
	...

Add following routine to prepare cmdline_ptr, cmdline_len and initrd_fd
for syscall kexec_file_load:

int prepare_kexec_file_options(struct kexec_info *info)
{
	int fd;
	ssize_t result;
	struct stat stats;

	if (arch_options.cmdline) {
		info->command_line = (char *)arch_options.cmdline;
		info->command_line_len = strlen(info->command_line) + 1;
	}

	if (!arch_options.initrd_path) {
		info->initrd_fd = -1;
		return 0;
	}

	fd = open(arch_options.initrd_path, O_RDONLY | _O_BINARY);
	if (fd < 0) {
		fprintf(stderr, "Cannot open `%s': %s\n", arch_options.initrd_path,
				strerror(errno));
		return -EINVAL;
	}
	result = fstat(fd, &stats);
	if (result < 0) {
		close(fd);
		fprintf(stderr, "Cannot stat: %s: %s\n", arch_options.initrd_path,
				strerror(errno));
		return -EINVAL;
	}
	info->initrd_fd = fd;
	return 0;
}

The basic usage of kexec_file is:
1) Reload capture kernel image:
$ kexec -s -l <riscv-vmlinux> --reuse-cmdline

2) Startup capture kernel:
$ kexec -e

For future work:
* Support for kdump and purgatory.
* Support for kernel image verification.
* Support physical address randomization.

Liao Chang (3):
  kexec_file: Fix kexec_file.c build error for riscv platform
  RISC-V: use memcpy for kexec_file mode
  RISC-V: Add kexec_file support

 arch/riscv/Kconfig                     |  11 ++
 arch/riscv/include/asm/kexec.h         |   4 +
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/elf_kexec.c          | 189 +++++++++++++++++++++++++
 arch/riscv/kernel/machine_kexec.c      |   5 +-
 arch/riscv/kernel/machine_kexec_file.c |  14 ++
 include/linux/kexec.h                  |   2 +-
 kernel/kexec_file.c                    |   4 +-
 8 files changed, 226 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/kernel/elf_kexec.c
 create mode 100644 arch/riscv/kernel/machine_kexec_file.c

-- 
2.17.1

