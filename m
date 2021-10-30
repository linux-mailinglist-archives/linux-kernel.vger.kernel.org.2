Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE8C440711
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 05:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhJ3DT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 23:19:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26136 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhJ3DTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 23:19:21 -0400
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Hh4Cr3z0Kz1DHpk;
        Sat, 30 Oct 2021 11:14:48 +0800 (CST)
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
Subject: [PATCH 1/3] kexec_file: Fix kexec_file.c build error for riscv platform
Date:   Sat, 30 Oct 2021 11:18:30 +0800
Message-ID: <20211030031832.165457-2-liaochang1@huawei.com>
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

When CONFIG_KEXEC_FILE is set for riscv platform, the compilation of
kernel/kexec_file.c generate build error:

kernel/kexec_file.c: In function 'crash_prepare_elf64_headers':
./arch/riscv/include/asm/page.h:110:71: error: request for member 'virt_addr' in something not a structure or union
  110 |  ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < kernel_map.virt_addr))
      |                                                                       ^
./arch/riscv/include/asm/page.h:131:2: note: in expansion of macro 'is_linear_mapping'
  131 |  is_linear_mapping(_x) ?       \
      |  ^~~~~~~~~~~~~~~~~
./arch/riscv/include/asm/page.h:140:31: note: in expansion of macro '__va_to_pa_nodebug'
  140 | #define __phys_addr_symbol(x) __va_to_pa_nodebug(x)
      |                               ^~~~~~~~~~~~~~~~~~
./arch/riscv/include/asm/page.h:143:24: note: in expansion of macro '__phys_addr_symbol'
  143 | #define __pa_symbol(x) __phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
      |                        ^~~~~~~~~~~~~~~~~~
kernel/kexec_file.c:1327:36: note: in expansion of macro '__pa_symbol'
 1327 |   phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);

This occurs is because the "kernel_map" referenced in macro
is_linear_mapping()  is suppose to be the one of struct kernel_mapping
defined in arch/riscv/mm/init.c, but the 2nd argument of
crash_prepare_elf64_header() has same symbol name, in expansion of macro
is_linear_mapping in function crash_prepare_elf64_header(), "kernel_map"
actually is the local variable.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 include/linux/kexec.h | 2 +-
 kernel/kexec_file.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..25b91cca8077 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -221,7 +221,7 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 				       void **addr, unsigned long *sz);
 #endif /* CONFIG_KEXEC_FILE */
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 33400ff051a8..0837d8c0e792 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1255,7 +1255,7 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
@@ -1319,7 +1319,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 	phdr++;
 
 	/* Prepare PT_LOAD type program header for kernel text region */
-	if (kernel_map) {
+	if (need_kernel_map) {
 		phdr->p_type = PT_LOAD;
 		phdr->p_flags = PF_R|PF_W|PF_X;
 		phdr->p_vaddr = (unsigned long) _text;
-- 
2.17.1

