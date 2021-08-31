Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4173FCCA6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhHaRxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbhHaRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:53:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so1706552plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8MSv/vocAmnCKOufSpVeAHEo9INASvk9t2X+CSQ4SFM=;
        b=S5iQdu5WWl84vFkJyQv6vUT9JHWF+PsgIUpGo3TL5Unpszw4VdY+W71cPJpTsUAnol
         JqRGhOHBSLt/pGKPGsnIELwR+Ki1IGttLKjzZjEdi85UE/zyY/cDGl9y30VuJAs63dYo
         V3u/0pGoZYiY10Gnybp2Nu39OVejCdAdt8jt/ptZTaiYqvDHlW02bXyUpPfAHg5r97Mc
         /wuuCpF/D5V8vcKMA09tGqKPGPVsWKRErbHgYWNHc50G4kRC0CszNh5zcOuTjf+Os9J1
         Fr2msrke8ba3kRztYXZmPPwH3lZYd+3Lo1YtLiRlAbiZDBdtIJeOt2WYHjtKbAP+BiWG
         ktLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MSv/vocAmnCKOufSpVeAHEo9INASvk9t2X+CSQ4SFM=;
        b=bshD7kAMZxmI/BdGs7B5D+BtB0zDHdGW4LVFExnwo14Os/31C/KhfPRi/1T5D7cTvn
         LiCORiVjIzVvgSRl91pU95yRXzwzVbDDlGXH/VUpwEO6Hnv7Tl5rdNVGLqZ/67DbAcqW
         EyZbL9E7Y0VYdp3GPkNXu4UptYOI4DnPi6WNM32Q013X6aZR6NTFg8mTTK4Uvp4le1g6
         YgI+i3SIW+nDvyZ4HFxnEa8l92zcIWCH8Pjr6GSGwa79PevHZQZ9aEdL03vRScMCMjVv
         VfVCcWxS5tN1hA/ySgNslE0aI1dFRg/PA6lMGF5ZLr4JhUV2/MlIIVwG/ixJ2Qa/Gu7X
         dY0g==
X-Gm-Message-State: AOAM531gTj2yQtzjFr+UfzMGKSxULA4OqHwGnAYWS3+CPuBHqtiFIkaL
        9aHfxTN0wG/LMmg5Xax4RhaXs/xiRiE=
X-Google-Smtp-Source: ABdhPJxrBsK9J/m/b67KSSxWwN3nGO7X6GvtiQTSvpR99Tp0vh0jyRM55HfqPycOij3QfpPqTSB1sw==
X-Received: by 2002:a17:902:ab18:b0:138:a41d:c7a0 with SMTP id ik24-20020a170902ab1800b00138a41dc7a0mr5744139plb.6.1630432374278;
        Tue, 31 Aug 2021 10:52:54 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id l127sm8182920pfl.99.2021.08.31.10.52.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:52:54 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 23/24] x86/entry: Remove the unused ASM macros
Date:   Wed,  1 Sep 2021 01:50:24 +0800
Message-Id: <20210831175025.27570-24-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

They are implemented and used in traps.c.  The ASM version is not needed
any more.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h | 106 ---------------------------------------
 1 file changed, 106 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index aeee1575332f..3243d67ea7c8 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -202,60 +202,6 @@ For 32-bit we have the following conventions - kernel is built with
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
@@ -264,10 +210,6 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 .macro SWITCH_TO_USER_CR3_STACK scratch_reg:req
 .endm
-.macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
-.endm
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
-.endm
 
 #endif
 
@@ -276,17 +218,10 @@ For 32-bit we have the following conventions - kernel is built with
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
@@ -296,12 +231,6 @@ For 32-bit we have the following conventions - kernel is built with
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
@@ -312,38 +241,3 @@ For 32-bit we have the following conventions - kernel is built with
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

