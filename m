Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E0B4189E1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhIZPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhIZPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:14:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8851C06176D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:13:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y8so13406328pfa.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EQoscKei5478Bl9Nsso276IAv/NKjTMOJlfZKvNRug=;
        b=g2isk0TymxwUNuAXoAHtpabKkYZM7mJHo/hz4pUIw5KPn5ok4qzMJJszUKR4GZavQM
         udZsViCQAscyPqugjLKLHVptOF92fUu56Zcd7u6aESd6XVadsVMVyzGjVeU2/meDHx7m
         sERDEqVXnfDy6WYBIxOl7A5YEG7Qnao2K+t3ewer+89WR2lAYFKOKV+7Tf1hsNz+7sxS
         gzldNY/++rrx1L3qPDbV7wuMh7BgqL27IHYIzdTdJydWUCHeQ+ZFolwrpRfGJDH9KC3U
         5Tta4g6PqWSNekRN1fKyT0gxxiDp4EhfYeEhG69+gtY6LXNHMnjvFFkLCnkCjisMFxST
         pk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EQoscKei5478Bl9Nsso276IAv/NKjTMOJlfZKvNRug=;
        b=vXF+ayiNmw/Gtyl3v9X5d8xy9QEMnp4Y1PpW7+moQwpEbhe/FmspzvgCH8Sb4WR17z
         TLJsyHTfbD2BtK3fdrJJ57/SsAv2Uzv28imlxisphmFzkVGOK3gmu9MoB8futGrznh40
         CsAEJzdq9ilex9NXjOdXGnFIxKC7F9CX2AnAGtvlS3+Ug0/pPHm62nAfgGYBgYyyufDI
         dsAze7c61iCAQ+NHhFiEUknIopDMl9zhIumQOB2WvgTeheYT7XTdJcWpExsZ/uE6ZrMl
         5ShILwZ3KppTZgFclxqHLxZrlpZNiXK+CaIWKkDHnhaCyLfKe/Li8lV6XSrZVoqEMJBB
         NXNw==
X-Gm-Message-State: AOAM533HptNi4eVz81QrTkKaJcOYSrV3m06i4k/08bQCDIqNmmrHVOW6
        sqOMUt3mxTWJV1bgHd4JqeUdLTHRbNOehQ==
X-Google-Smtp-Source: ABdhPJwBjdZxt8/0YIs5fASTkzfnYUL5jfpiAP8mC15OwikNsm5baKsffkCKyMbxVrEOlwMBzUMyXA==
X-Received: by 2002:a05:6a00:15c8:b0:441:b4f1:652e with SMTP id o8-20020a056a0015c800b00441b4f1652emr19624915pfu.74.1632669186871;
        Sun, 26 Sep 2021 08:13:06 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id n18sm14323137pfa.42.2021.09.26.08.13.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:13:06 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 39/41] x86/entry: Remove the unused ASM macros
Date:   Sun, 26 Sep 2021 23:08:36 +0800
Message-Id: <20210926150838.197719-40-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

They are implemented and used in C code.  The ASM version is not needed
any more.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h | 106 ---------------------------------------
 1 file changed, 106 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 996b041e92d2..d42012fc694d 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -210,60 +210,6 @@ For 32-bit we have the following conventions - kernel is built with
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
-	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
-
-	/*
-	 * KERNEL pages can always resume with NOFLUSH as we do
-	 * explicit flushes.
-	 */
-	bt	$PTI_USER_PGTABLE_BIT, \save_reg
-	jnc	.Lnoflush_\@
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
-	/*
-	 * The CR3 write could be avoided when not changing its value,
-	 * but would require a CR3 read *and* a scratch register.
-	 */
-	movq	\save_reg, %cr3
-.Lend_\@:
-.endm
-
 #else /* CONFIG_PAGE_TABLE_ISOLATION=n: */
 
 .macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
@@ -272,10 +218,6 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 .macro SWITCH_TO_USER_CR3_STACK scratch_reg:req
 .endm
-.macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
-.endm
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
-.endm
 
 #endif
 
@@ -284,17 +226,10 @@ For 32-bit we have the following conventions - kernel is built with
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
@@ -304,12 +239,6 @@ For 32-bit we have the following conventions - kernel is built with
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
@@ -320,38 +249,3 @@ For 32-bit we have the following conventions - kernel is built with
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

