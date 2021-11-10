Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4349144C0AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhKJMFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhKJMF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:05:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0954AC06120D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:38 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n8so2818077plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GngOxReVA58jxFm4o8DBzLFQDbGENrJS7+p49FzXUf4=;
        b=QqmSrxONKFhryQRKUYtU0hKma6dZjQtmP3R/usu9hxXst1+owpaBwi2z57VsNfHyG0
         hA2iXMHaW+eypRCEWmOMfutOpjzWaoe/ynXw8TIcGIM04ohgUxc8pi1pjxhgqMesC0jn
         IkUwcGj2GKj2Ot0Qxr03ELhYyXIymIZp3xQDUFNjPojsYjATrlKgtXRCJe1zB++0IF5V
         v8ExHusGH3dcJ2jHAHJV7L7zcsQVIbwSsLE3NT3YsaTQLahK1/yMtfqwUfh8Dck6YnUO
         T0g3LHlrxZI/aDYRMnUsQeKaf3e6hz8ZBqJ95rm3tZDEDnji2u2auQF0vIhy6b6AnLlW
         uR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GngOxReVA58jxFm4o8DBzLFQDbGENrJS7+p49FzXUf4=;
        b=r9+uzTeNO+Pt6sU0/uMO5jyY3Q4Mmk1y8DKcTunhyMXdznuwT3Nvk+jmlbVkWRcgJh
         1mdvqbFGrKcSe8QHPY7QVBbuZCVHC0X2OmbRgC5DGmvv7edceoFoC1cg9//kDHD0QwR3
         qT1QDc5jMVrdp+fJdO2UIhznBEcJjc7CF84FYLrsRIaLEBzW+LZFvptkjhu5Q/1FNiDV
         LeXYoDSxR995svhDe6HwsTcNIeY9oP73uZeK70bkPYZps5jspTwsyPdggqzWASthaumL
         eNQQQSBl/lsd/sYNcAGsasfj6U+3xQ6S/Mk56ZhZR/fyo1VXHe9wxvQrNEWkhG172lIr
         EHUw==
X-Gm-Message-State: AOAM530UAq++hJBpWvJyCjK6ONepXpG39w8mMkch2gnoUCEDh2zQjB0g
        DRcPzryXtYkp057DLXcIZsIFO/OuQxA=
X-Google-Smtp-Source: ABdhPJyinXro4cQFXqVr97AdXArT5F9+0yp9yJdknS0a4CZU1Rra2n5aWN8WyyNddHUaF7RHzhjXyA==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr16276681pjb.243.1636545757220;
        Wed, 10 Nov 2021 04:02:37 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id u10sm21908679pfh.49.2021.11.10.04.02.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:02:36 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 48/50] x86/entry: Remove the unused ASM macros
Date:   Wed, 10 Nov 2021 19:57:34 +0800
Message-Id: <20211110115736.3776-49-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

They are implemented and used in C code.  The ASM version is not needed
any more.

FENCE_SWAPGS_USER_ENTRY is not removed because it is still being used
in the nmi userspace path.  It could be possible to be removed in
future entry code enhancement.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h | 99 ----------------------------------------
 1 file changed, 99 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9065c31d2875..d42012fc694d 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -210,53 +210,6 @@ For 32-bit we have the following conventions - kernel is built with
 	popq	%rax
 .endm
 
-.macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
-	ALTERNATIVE "jmp .Ldone_\@", "", X86_FEATURE_PTI
-	movq	%cr3, \scratch_reg
-	movq	\scratch_reg, \save_reg
-	/*
-	 * Test the user pagetable bit. If set, then the user page tables
-	 * are active. If clear CR3 already has the kernel page table
-	 * active.
-	 */
-	bt	$PTI_USER_PGTABLE_BIT, \scratch_reg
-	jnc	.Ldone_\@
-
-	ADJUST_KERNEL_CR3 \scratch_reg
-	movq	\scratch_reg, %cr3
-
-.Ldone_\@:
-.endm
-
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
-	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
-
-	/* No need to restore when the saved CR3 is kernel CR3. */
-	bt	$PTI_USER_PGTABLE_BIT, \save_reg
-	jnc	.Lend_\@
-
-	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
-
-	/*
-	 * Check if there's a pending flush for the user ASID we're
-	 * about to set.
-	 */
-	movq	\save_reg, \scratch_reg
-	andq	$(0x7FF), \scratch_reg
-	bt	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jnc	.Lnoflush_\@
-
-	btr	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jmp	.Lwrcr3_\@
-
-.Lnoflush_\@:
-	SET_NOFLUSH_BIT \save_reg
-
-.Lwrcr3_\@:
-	movq	\save_reg, %cr3
-.Lend_\@:
-.endm
-
 #else /* CONFIG_PAGE_TABLE_ISOLATION=n: */
 
 .macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
@@ -265,10 +218,6 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 .macro SWITCH_TO_USER_CR3_STACK scratch_reg:req
 .endm
-.macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
-.endm
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
-.endm
 
 #endif
 
@@ -277,17 +226,10 @@ For 32-bit we have the following conventions - kernel is built with
  *
  * FENCE_SWAPGS_USER_ENTRY is used in the user entry swapgs code path, to
  * prevent a speculative swapgs when coming from kernel space.
- *
- * FENCE_SWAPGS_KERNEL_ENTRY is used in the kernel entry non-swapgs code path,
- * to prevent the swapgs from getting speculatively skipped when coming from
- * user space.
  */
 .macro FENCE_SWAPGS_USER_ENTRY
 	ALTERNATIVE "", "lfence", X86_FEATURE_FENCE_SWAPGS_USER
 .endm
-.macro FENCE_SWAPGS_KERNEL_ENTRY
-	ALTERNATIVE "", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL
-.endm
 
 .macro STACKLEAK_ERASE_NOCLOBBER
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
@@ -297,12 +239,6 @@ For 32-bit we have the following conventions - kernel is built with
 #endif
 .endm
 
-.macro SAVE_AND_SET_GSBASE scratch_reg:req save_reg:req
-	rdgsbase \save_reg
-	GET_PERCPU_BASE \scratch_reg
-	wrgsbase \scratch_reg
-.endm
-
 #else /* CONFIG_X86_64 */
 # undef		UNWIND_HINT_IRET_REGS
 # define	UNWIND_HINT_IRET_REGS
@@ -313,38 +249,3 @@ For 32-bit we have the following conventions - kernel is built with
 	call stackleak_erase
 #endif
 .endm
-
-#ifdef CONFIG_SMP
-
-/*
- * CPU/node NR is loaded from the limit (size) field of a special segment
- * descriptor entry in GDT.
- */
-.macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
-	movq	$__CPUNODE_SEG, \reg
-	lsl	\reg, \reg
-.endm
-
-/*
- * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
- * We normally use %gs for accessing per-CPU data, but we are setting up
- * %gs here and obviously can not use %gs itself to access per-CPU data.
- *
- * Do not use RDPID, because KVM loads guest's TSC_AUX on vm-entry and
- * may not restore the host's value until the CPU returns to userspace.
- * Thus the kernel would consume a guest's TSC_AUX if an NMI arrives
- * while running KVM's run loop.
- */
-.macro GET_PERCPU_BASE reg:req
-	LOAD_CPU_AND_NODE_SEG_LIMIT \reg
-	andq	$VDSO_CPUNODE_MASK, \reg
-	movq	__per_cpu_offset(, \reg, 8), \reg
-.endm
-
-#else
-
-.macro GET_PERCPU_BASE reg:req
-	movq	pcpu_unit_offsets(%rip), \reg
-.endm
-
-#endif /* CONFIG_SMP */
-- 
2.19.1.6.gb485710b

