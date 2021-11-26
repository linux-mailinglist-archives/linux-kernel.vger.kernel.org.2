Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5436645EB93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377104AbhKZKcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbhKZKaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:30:12 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3D7C0619EC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:17:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id iq11so6891670pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GngOxReVA58jxFm4o8DBzLFQDbGENrJS7+p49FzXUf4=;
        b=WRLQ1iQNyzyfcK7C/wxhXEt2BDjrAG1ObiySwjPfJxTdLytSvfGzrJEGQPDxqIdnUm
         w7SD+a6z7Jb0UPPedeyibIGRoF/gYxXznYb0zYaurhkq8t4uD0ga2ne4yqM02xzuAPWp
         yNsDboXzqWzdg3tiWJAqkecfYPMq8Eglb0e53f3GXnSvmEFKEXTWaRpqd4e+R8JG/5R/
         48DSCVjwnRlhGwudjmFqeorGisXGSnrwblsvl4zcldO+aO2xljSxpxuDOcsXPQGjFfJn
         vsIzeTS/O/yhvMfq+yyOL6Z1uoKv61dcufCqzHzhnjsFHqaV5rMOA8g965w5YDxA4zgB
         nyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GngOxReVA58jxFm4o8DBzLFQDbGENrJS7+p49FzXUf4=;
        b=hftfeJOf6Z85LST0g844HQXLVnQPdbITuXMINnjKv8IjR8CU2uIyee095putTdErUZ
         jRd0KaXfYze2aPUOaSGXbeHYad0IPr2GACh+xMK/68+AAWzNr+/ZixbUecorZfRYjt6d
         ro2lEZcJWwTOch83h1asp4J5bTwAG1cgzCFC6Xo6a3EVIhUg1TYYm9faGVXlKBc/fz2A
         0S46KFyWOk3u5yUlmeJrWujN2opkQKYekA302avzQg26u8e8kUbuCQaxumSIl36RDEHN
         AwwDyWGcnAPZZiGRRbGQDwhQL2t4HV7mkDk4nkdh/cYkBwxHtvChKVOxxi4+JgczxIeT
         gk2g==
X-Gm-Message-State: AOAM533SlMHSa4RN1gZVKpixlt2v1xsyviJ96VIE8UvppQ7XUk5eYd7k
        yxLeM9KimK+sxGVDtzC8CYwU1Ebh4tE=
X-Google-Smtp-Source: ABdhPJxM5P72yP53M+lCPKXzYX4KvzDALWWNKs2IMX9Bs9uX/USe8Akr6GHpYVdB6hkmKwaKqJaPCw==
X-Received: by 2002:a17:90b:4a43:: with SMTP id lb3mr14536900pjb.222.1637921819397;
        Fri, 26 Nov 2021 02:16:59 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id p14sm5352901pjl.32.2021.11.26.02.16.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:16:59 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 47/49] x86/entry: Remove the unused ASM macros
Date:   Fri, 26 Nov 2021 18:12:07 +0800
Message-Id: <20211126101209.8613-48-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

