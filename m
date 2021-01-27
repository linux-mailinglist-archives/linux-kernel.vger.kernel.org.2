Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B954305FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhA0Pko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhA0Pea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:34:30 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F59C061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:33:49 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z21so1819209pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/Abzz1MNa7Fco9CCxROMcrjIASvEPo3uvH/rl5fP8w=;
        b=lgvsSDlTubmyorSP8tcLtES6Ntf/cUa6NqNpz49HlFQkH4MNDgh/1tTLdAU6RHudFn
         SU2TeG0549Bzqgh/hzEoUgUf8EiXs426sVOq7D7Nxhg2/gIJj8W6ZZ/k69Icv+riCY9y
         XKyrh0pks9XS8LRJpStHa/x40sGpsOsYgk9Od2ezRX83vFvr2+13qU3/mEPhAmcd5fZ+
         fSL5o8+616UIWi6KLKgdwi3qJTj4iQaZXaKhm7rPIThE07cMAdlZaQQX9l1nLR6I4rU1
         pU6l5vaZscF10VfCR4p2GUpszjDX0k8tMFSwSNSJ/LvRjKe3k6+TXT/lGdxp/iammv3z
         2YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/Abzz1MNa7Fco9CCxROMcrjIASvEPo3uvH/rl5fP8w=;
        b=dVm13F5+q8RkwzDABFCBvSTbo6cI92t+6dvD5adGOZxNn/I6DHzhWFzuZEleff0kA4
         OwTgrVR2g0N4lBTQ6KBur/eLH1pNkwzTH4YUpvgv/t2mnAZpH6q5j1insVzruKaX+m63
         K0+i2iL1wEJBaouY1IOEeE6EK4bjKdmOyv/3E60ZDRlAcmBlCm4q8cDkqvK2f/Q02LLI
         bRlkpCxUCvz7lDm8Xqwar4SGchnyHn6xoFcc0k4fnJXFMXjIkB00Fl/cBT/my2weXeji
         eipFq/3CKlddF5IfsLxTIec7NUJUd1qtsxeNG+xgoWP8K+vsYxQ39/mCk7swP/LV+v3z
         QQ5Q==
X-Gm-Message-State: AOAM530NjlfldeTuPiyOlbMAU8RaAUhIFl31eG1vMjkNrG24YyIdSuyn
        ac1ezJa6h221Zo9rcMUQIcl+/x1T5kUVVg==
X-Google-Smtp-Source: ABdhPJzgRH4brtZujhvF+IU29JCCHe2KpHNDkBDPiafDtrAPFfac37zeU9JwHmtkItEUAlvXZF1fjQ==
X-Received: by 2002:a62:a204:0:b029:1c3:fb27:16f3 with SMTP id m4-20020a62a2040000b02901c3fb2716f3mr9466063pff.61.1611761629253;
        Wed, 27 Jan 2021 07:33:49 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id c19sm2727152pfc.122.2021.01.27.07.33.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:33:48 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V3 5/6] x86_32/sysenter: use percpu to get thread.sp0 when sysenter
Date:   Thu, 28 Jan 2021 00:32:21 +0800
Message-Id: <20210127163231.12709-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210127163231.12709-1-jiangshanlai@gmail.com>
References: <20210127163231.12709-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

TSS_entry2task_stack is used to refer to tss.sp1 which is stored the value
of thread.sp0.

At the code where TSS_entry2task_stack is used in sysenter, the CR3 is
already kernel CR3 and kernel segments is loaded.

So that we can directly use percpu for it instead of offset-calculation.

And we remove the unused TSS_entry2task_stack.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S        |  2 +-
 arch/x86/kernel/asm-offsets_32.c | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 01f098c5b017..d5b5b43fd0c0 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -916,7 +916,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Switch to task stack */
 	movl	%esp, %eax
-	movl	(3*4+TSS_entry2task_stack)(%esp), %esp
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %esp
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index 6e043f295a60..6d4143cfbf03 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -43,16 +43,6 @@ void foo(void)
 	OFFSET(saved_context_gdt_desc, saved_context, gdt_desc);
 	BLANK();
 
-	/*
-	 * Offset from the entry stack to task stack stored in TSS. Kernel entry
-	 * happens on the per-cpu entry-stack, and the asm code switches to the
-	 * task-stack pointer stored in x86_tss.sp1, which is a copy of
-	 * task->thread.sp0 where entry code can find it.
-	 */
-	DEFINE(TSS_entry2task_stack,
-	       offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
-	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
-
 #ifdef CONFIG_STACKPROTECTOR
 	BLANK();
 	OFFSET(stack_canary_offset, stack_canary, canary);
-- 
2.19.1.6.gb485710b

