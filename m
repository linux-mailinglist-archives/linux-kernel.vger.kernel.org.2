Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2303166FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhBJMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhBJMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:39:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CE3C061788
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:39:10 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e12so1140599pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lp/woyl9g38D3TsPO6QESTjSQ1wDi5vbe5abltzT0qk=;
        b=VoTnSLkN+PZlhzVMlSNtS1rCTNdMyJsBCiUyAFPeMNRBo9pi1Bs72huN38WPu0Y3DP
         pZP5k/ilVVFn7KmYYhxP5b1Xx/0UtFmXmpwaEUnAn1T41BT7UWToVqPTRi+JNCUq1U7A
         RsN0PMD5at6sqV00R3ADwc/aLvOknTx16Rcw4cK34tWaZMAvdAFI1S4XQHkvBGZVpC3D
         DlgrCyXzO4NH9PLqZ9fbcJLzK7e95xAyPjmjfivIuGi7wPK0A+ZRAQMjpcvb45nLHmj1
         RdBOBDB1NdXX2iMkZORMJclhj5CeYi+3sqgUPeLImeZIueBIbrEO0lc4t+q+LLamQwLD
         +3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lp/woyl9g38D3TsPO6QESTjSQ1wDi5vbe5abltzT0qk=;
        b=ql/6LAvP3TxyaA1JTdCcn1VW2tS9mcmSzOWzWDKwmNUXfr224g3CldWB3RhH3GiV9/
         UFEtutLeJXwSUwgIBE9+BN5LPTnLeeXpOpd53q4UC8lplagMkJKzpCO3Coqj3pbBZtTE
         MEg/G/KaQbXcbE6Ip0KKdpx5LINQjabL5sWG7qKNoCbhLlNB9XgMlOQ8CjIDVaYg7Ipz
         fpH69pHSDKRSLj1QdjTnWieOsGmKAYTcjZSfI0rTnvICaV9P+bKjLRTeMpx4tzrDDxN7
         6pf9+5w/v7aSxtHOZZU9TB5HoEGbX3vYDqRCG+EeVGxQ+PUfypnQpMwUrpBQdA0T+b5s
         xP3Q==
X-Gm-Message-State: AOAM531e5QV41cbv6zn0R8Bar8HV+kUuWrDMpumxmT7NK8us5DlkNZf6
        ymr7dxejDrYFICO09NwvHjFq5Ydsh78=
X-Google-Smtp-Source: ABdhPJxuTsh6h94CZu3tKWIcUPMRZlyg8//+aU/mbOFjxnz+pbu5uZHy/N0TwJOcqApil7mgfzpIYg==
X-Received: by 2002:a17:903:114:b029:e2:d2da:8f3f with SMTP id y20-20020a1709030114b02900e2d2da8f3fmr2932958plc.81.1612960748953;
        Wed, 10 Feb 2021 04:39:08 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id d26sm2339398pfo.139.2021.02.10.04.39.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 04:39:08 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Balbir Singh <sblbir@amazon.com>,
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
Subject: [PATCH V4 5/6] x86/entry/32: Use percpu to get thread.sp0 in SYSENTER
Date:   Wed, 10 Feb 2021 21:39:16 +0800
Message-Id: <20210210133917.2414-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210210133917.2414-1-jiangshanlai@gmail.com>
References: <20210210133917.2414-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

TSS_entry2task_stack is used to refer to tss.sp1 which is a copy of
thread.sp0.

When TSS_entry2task_stack is used in entry_SYSENTER_32, the CR3 is
already kernel CR3 and the kernel %fs is loaded.

So it directly uses percpu instead of offset-calculation via
TSS_entry2task_stack.

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

