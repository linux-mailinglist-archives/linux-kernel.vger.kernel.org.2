Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1E3877D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbhERLkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:40:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:41632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241908AbhERLkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:40:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05DADAD6C;
        Tue, 18 May 2021 11:39:03 +0000 (UTC)
Date:   Tue, 18 May 2021 13:39:01 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org
Subject: [PATCH stable-5.10,5.11,5.12] x86/boot/compressed/64: Check SEV
 encryption in the 32-bit boot-path
Message-ID: <YKOnVYLRxk9CUzTc@suse.de>
References: <20210508032224.039CF613ED@mail.kernel.org>
 <YJZnYDty7Siyo68k@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJZnYDty7Siyo68k@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fef81c86262879d4b1176ef51a834c15b805ebb9 ]

Check whether the hypervisor reported the correct C-bit when running
as an SEV guest. Using a wrong C-bit position could be used to leak
sensitive data from the guest to the hypervisor.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210312123824.306-8-joro@8bytes.org
---
 arch/x86/boot/compressed/head_64.S | 85 ++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e94874f4bbc1..ae1fe558a2d8 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -172,11 +172,21 @@ SYM_FUNC_START(startup_32)
 	 */
 	call	get_sev_encryption_bit
 	xorl	%edx, %edx
+#ifdef	CONFIG_AMD_MEM_ENCRYPT
 	testl	%eax, %eax
 	jz	1f
 	subl	$32, %eax	/* Encryption bit is always above bit 31 */
 	bts	%eax, %edx	/* Set encryption mask for page tables */
+	/*
+	 * Mark SEV as active in sev_status so that startup32_check_sev_cbit()
+	 * will do a check. The sev_status memory will be fully initialized
+	 * with the contents of MSR_AMD_SEV_STATUS later in
+	 * set_sev_encryption_mask(). For now it is sufficient to know that SEV
+	 * is active.
+	 */
+	movl	$1, rva(sev_status)(%ebp)
 1:
+#endif
 
 	/* Initialize Page tables to 0 */
 	leal	rva(pgtable)(%ebx), %edi
@@ -261,6 +271,9 @@ SYM_FUNC_START(startup_32)
 	movl	%esi, %edx
 1:
 #endif
+	/* Check if the C-bit position is correct when SEV is active */
+	call	startup32_check_sev_cbit
+
 	pushl	$__KERNEL_CS
 	pushl	%eax
 
@@ -786,6 +799,78 @@ SYM_DATA_START_LOCAL(loaded_image_proto)
 SYM_DATA_END(loaded_image_proto)
 #endif
 
+/*
+ * Check for the correct C-bit position when the startup_32 boot-path is used.
+ *
+ * The check makes use of the fact that all memory is encrypted when paging is
+ * disabled. The function creates 64 bits of random data using the RDRAND
+ * instruction. RDRAND is mandatory for SEV guests, so always available. If the
+ * hypervisor violates that the kernel will crash right here.
+ *
+ * The 64 bits of random data are stored to a memory location and at the same
+ * time kept in the %eax and %ebx registers. Since encryption is always active
+ * when paging is off the random data will be stored encrypted in main memory.
+ *
+ * Then paging is enabled. When the C-bit position is correct all memory is
+ * still mapped encrypted and comparing the register values with memory will
+ * succeed. An incorrect C-bit position will map all memory unencrypted, so that
+ * the compare will use the encrypted random data and fail.
+ */
+	__HEAD
+	.code32
+SYM_FUNC_START(startup32_check_sev_cbit)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	pushl	%eax
+	pushl	%ebx
+	pushl	%ecx
+	pushl	%edx
+
+	/* Check for non-zero sev_status */
+	movl	rva(sev_status)(%ebp), %eax
+	testl	%eax, %eax
+	jz	4f
+
+	/*
+	 * Get two 32-bit random values - Don't bail out if RDRAND fails
+	 * because it is better to prevent forward progress if no random value
+	 * can be gathered.
+	 */
+1:	rdrand	%eax
+	jnc	1b
+2:	rdrand	%ebx
+	jnc	2b
+
+	/* Store to memory and keep it in the registers */
+	movl	%eax, rva(sev_check_data)(%ebp)
+	movl	%ebx, rva(sev_check_data+4)(%ebp)
+
+	/* Enable paging to see if encryption is active */
+	movl	%cr0, %edx			 /* Backup %cr0 in %edx */
+	movl	$(X86_CR0_PG | X86_CR0_PE), %ecx /* Enable Paging and Protected mode */
+	movl	%ecx, %cr0
+
+	cmpl	%eax, rva(sev_check_data)(%ebp)
+	jne	3f
+	cmpl	%ebx, rva(sev_check_data+4)(%ebp)
+	jne	3f
+
+	movl	%edx, %cr0	/* Restore previous %cr0 */
+
+	jmp	4f
+
+3:	/* Check failed - hlt the machine */
+	hlt
+	jmp	3b
+
+4:
+	popl	%edx
+	popl	%ecx
+	popl	%ebx
+	popl	%eax
+#endif
+	ret
+SYM_FUNC_END(startup32_check_sev_cbit)
+
 /*
  * Stack and heap for uncompression
  */
-- 
2.31.1

