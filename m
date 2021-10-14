Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3818242D152
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhJNEB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhJNEBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:01:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469A0C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:59:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so3871442pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EQoscKei5478Bl9Nsso276IAv/NKjTMOJlfZKvNRug=;
        b=h7wopKUc98MrKuXNfvZJPk6zOYgiD2cvmaQMkhUi7mCE1N87j5YzhX4FJIGyHx5ulI
         amwJOmKfo6V38g7JZLynXTIyTvfqp3UuDGPUXd7EzqjXJmdq1RZPJ4YKMm3ljy/mMhAK
         snI6jWXA23j5qLfk+lQ4iTiZZoXWDQBV+6IiADNjTZgzV5JTL5IxRv6K3owbRVLtrjpO
         dcTHG5StGlYR7jKARW0pDvlKVCmxmeQtdlHQAnGOwjB9t3tqwmrzve5v0cYQRU7/aAeO
         uAo+MwK16ObybruTE7Hlmul0N74w1WM8JQGDhVftmBSyGsm8vPKa45aTv9qX9Zc1JBNx
         bB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EQoscKei5478Bl9Nsso276IAv/NKjTMOJlfZKvNRug=;
        b=h4ZrZ+/0GNre+o4WrmPxl5EL24asV/pSJgLBNC1OPeNWmSA2TQsG+kgDlmK1ff6XGd
         uFdNSEG7PEJa8uBQW2VEwa+QaJzm1mDSrY9HAENH5Yl1dqTRccrkclaEHXUpw/3kYXiu
         3/m892vkNx0ggz9fD94fWnyjxDgAOamAAvL78yAqpMn811e4ss+sasbirMNtlU8QnaAt
         wNYycI6Tr8zsiLKKhX+bYLld2NqUJFP2OvaXxKZgAJSrZZxkOGvDcgS75VGhPn56hvPM
         yhhKinosxgK/MFgqGWHl1nzbV1XcvZAXSCyt/RungaykhD2j+AlXOJLEJfTsffSCx7q8
         jHUQ==
X-Gm-Message-State: AOAM5331/H+4PY41VRoGbmRR7aT0/wTF3mmFUoWD98N7bkWwsnrrbvwZ
        mJc3FERtnOO1S+GFSgfp+Cc9daqsiOU=
X-Google-Smtp-Source: ABdhPJz43NaibahxAubSuu3ttUw5auWp3r1wiceUO94pkSz4Y1bKFTjyBwYnBg3vd6vd9D1xx2UpJg==
X-Received: by 2002:a17:902:a385:b0:13e:99e9:17f3 with SMTP id x5-20020a170902a38500b0013e99e917f3mr2948355pla.65.1634183945637;
        Wed, 13 Oct 2021 20:59:05 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id oa4sm913498pjb.13.2021.10.13.20.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:59:05 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 47/49] x86/entry: Remove the unused ASM macros
Date:   Thu, 14 Oct 2021 11:58:33 +0800
Message-Id: <20211014035836.18401-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

