Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705CE3E32B4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 04:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhHGCXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 22:23:52 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:65010 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhHGCXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:23:48 -0400
Received: from chmeee (unknown [10.95.67.60])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id 116644136DB;
        Fri,  6 Aug 2021 19:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1628303011;
        bh=fZhd01tP7ALbKlnQm00zcn/zBNSBzBkMKjAsOhzhmJE=;
        h=From:To:Cc:Subject:Date:From;
        b=ShXkfAvK0Y3cwRO4uDS01UyRpdPQIsk50+MPaeiHJb/uaIOJDL3FFj3KjPOFlh0OZ
         ZAhFhdDIQzttDv+tben7vI8fXBBFv8mK0mIbiv1qdmkdsq9J2MCbAFG9atamWPTXyO
         Gi2dw4wRdMhYQpGID9fP3/lroqdhNr74AkwrSi4czsClD+zxLL+rEgI+Z5ltYlvw0V
         bLiCtIlPk9l9o0eiggcP+J8V+RvqYbuHvi7wWZnFjV90tIpPTgFnk4+Hft3y9O24jp
         82/n6q1yJn09LM1iy63cy5iP2hLnSzLVMCHx0Py65X6lrpTe6d7h5Ors9cmyffU5PH
         7qJ782DXudppg==
Received: from kevmitch by chmeee with local (Exim 4.94.2)
        (envelope-from <kevmitch@chmeee>)
        id 1mCBzl-001mhu-Gd; Fri, 06 Aug 2021 19:23:29 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
Cc:     dyoung@redhat.com, kexec@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, Kevin Mitchell <kevmitch@arista.com>
Subject: [PATCH] x86: allow i386 kexec to load x86_64 bzImage anywhere
Date:   Fri,  6 Aug 2021 19:21:54 -0700
Message-Id: <20210807022154.425449-1-kevmitch@arista.com>
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-5.2, the following commit allows the kdump kernel to be loaded
at a higher address than 896M

9ca5c8e632ce ("x86/kdump: Have crashkernel=X reserve under 4G by
default")

While this limit does indeed seem unnecessary for x86_64 kernels, it
still is required to boot to or from i386 kernels. Therefore,
kexec-tools continues to enforce it when using the i386 bzImage loader.

However, the i386 bzImage loader may also be used to load an x86_64
kernel from i386 user space to be kexeced by an x86_64 kernel. In this
case, the limit was incorrectly enforced.

This commit adds an additional check for an x86_64 image kexeced by an
x86_64 kernel in the i386 loader and bumps the limit to the maximum
addressable 4G in that case.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 kexec/arch/i386/kexec-bzImage.c | 41 ++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index df8985d..7b8e36e 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -22,6 +22,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -114,6 +115,7 @@ int do_bzImage_load(struct kexec_info *info,
 	struct entry32_regs regs32;
 	struct entry16_regs regs16;
 	unsigned int relocatable_kernel = 0;
+	unsigned int kernel64 = 0;
 	unsigned long kernel32_load_addr;
 	char *modified_cmdline;
 	unsigned long cmdline_end;
@@ -155,6 +157,13 @@ int do_bzImage_load(struct kexec_info *info,
 		dbgprintf("bzImage is relocatable\n");
 	}
 
+	if ((setup_header.protocol_version >= 0x020C) &&
+	    (info->kexec_flags & KEXEC_ARCH_X86_64) &&
+	    (setup_header.xloadflags & 1)) {
+		kernel64 = 1;
+		dbgprintf("loading x86_64 bzImage from an x86_64 kernel\n");
+	}
+
 	/* Can't use bzImage for crash dump purposes with real mode entry */
 	if((info->kexec_flags & KEXEC_ON_CRASH) && real_mode_entry) {
 		fprintf(stderr, "Can't use bzImage for crash dump purposes"
@@ -197,17 +206,17 @@ int do_bzImage_load(struct kexec_info *info,
 	/* Load the trampoline.  This must load at a higher address
 	 * than the argument/parameter segment or the kernel will stomp
 	 * it's gdt.
-	 *
-	 * x86_64 purgatory code has got relocations type R_X86_64_32S
-	 * that means purgatory got to be loaded within first 2G otherwise
-	 * overflow takes place while applying relocations.
 	 */
-	if (!real_mode_entry && relocatable_kernel)
+	if (!real_mode_entry && relocatable_kernel) {
+		/* x86_64 purgatory could be anywhere */
+		unsigned long purg_max_addr = kernel64 ? ULONG_MAX : 0x7fffffff;
+
 		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
-					0x3000, 0x7fffffff, -1, 0);
-	else
+					0x3000, purg_max_addr, -1, 0);
+	} else {
 		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
 					0x3000, 640*1024, -1, 0);
+	}
 	dbgprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
 
 	/* The argument/parameter segment */
@@ -277,14 +286,20 @@ int do_bzImage_load(struct kexec_info *info,
 	if (real_mode->protocol_version >=0x0205 && relocatable_kernel) {
 		/* Relocatable bzImage */
 		unsigned long kern_align = real_mode->kernel_alignment;
-		unsigned long kernel32_max_addr = DEFAULT_BZIMAGE_ADDR_MAX;
+		unsigned long kernel_max_addr = DEFAULT_BZIMAGE_ADDR_MAX;
 
-		if (kernel32_max_addr > real_mode->initrd_addr_max)
-			kernel32_max_addr = real_mode->initrd_addr_max;
+		/*
+		 * x86_64 kernels can be kexeced by an x86_64 kernel
+		 * from any addressable location
+		 */
+		if (kernel64)
+			kernel_max_addr = ULONG_MAX;
+		else if (kernel_max_addr > real_mode->initrd_addr_max)
+			kernel_max_addr = real_mode->initrd_addr_max;
 
 		kernel32_load_addr = add_buffer(info, kernel + kern16_size,
 						size, size, kern_align,
-						0x100000, kernel32_max_addr,
+						0x100000, kernel_max_addr,
 						1);
 	}
 	else {
@@ -296,9 +311,9 @@ int do_bzImage_load(struct kexec_info *info,
 	dbgprintf("Loaded 32bit kernel at 0x%lx\n", kernel32_load_addr);
 
 	/* Tell the kernel what is going on */
-	setup_linux_bootloader_parameters(info, real_mode, setup_base,
+	setup_linux_bootloader_parameters_high(info, real_mode, setup_base,
 		kern16_size_needed, command_line, command_line_len,
-		initrd, initrd_len);
+		initrd, initrd_len, kernel64); /* put x86_64 initrd high too */
 
 	if (real_mode_entry && real_mode->protocol_version >= 0x0201) {
 		real_mode->loader_flags |= 0x80; /* CAN_USE_HEAP */
-- 
2.32.0

