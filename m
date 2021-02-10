Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE73166F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhBJMmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhBJMjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:39:46 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF2C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:39:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q72so1038989pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kKmWJ/1uSmMbRL8VLbdU43IuEw0XN7ucB3p1m9mrNk=;
        b=p3cpcZ/KOVrYtyOGMp7vqllvTv1oftb5uz61PpbAiaEQTVlLcB0+4P63zeqdw21KGD
         PItem9T1lrgTyqDESjZjZr46nE4JcVqgz0BEzcjBONDp8mwicX5SewDqBn98UBslP+EV
         5oUDrnWpYDfz+PxFuD0824puMTGB4Cxk6w5XDJo10rB0+DeDi46dPhMzEW+n4P/k+k7n
         Z6KrzmyPACYUT+yZ/hGK5Gz3lmRv7CMaMfHLSlP6A+eFUO6XMsNKkybbYUai9ALJhsT6
         kmgY3ZjujfL1bQAG28mAZIfQSmAU+lxOLN9bpbmXDPFVsy9b+3KO6gxFX2XzOi6lmnks
         3kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kKmWJ/1uSmMbRL8VLbdU43IuEw0XN7ucB3p1m9mrNk=;
        b=ubv2FGEY5xbmgmJznvvoXK6O82OUjwCEx3Q7n6etSKoX55PW9T65f7mi+Ok+nnQtRe
         5aMvL8lfV2LMWCEWfYI7Luqgg//4Gt0dJXcPLHaZZucMtXe2boA0dm6F4Xd5pMlieNwq
         tqflMtkpe8T0fzmpP3MXT8KuHMXVYniQsBZVYqQ0kBHosSDsYcVC/cIIghPKqDC1+COc
         nRfoZxI1yc71viHcMplIB3qUlcYTfxuHfZlQ1DUuK11cog9dgUUqUyN4yIgPGGalXNGk
         PRz5W8IgLCyG9DQ4HSB/+9verodrqJFCOsHhUH4xCedU+W1p5ziSHT7JfQgqDtMC40gK
         O6kg==
X-Gm-Message-State: AOAM533VCa0bNlahZepocYBDBw73AOiMerob84tjllEsWQ5IOfUnTUNG
        FRuL8ea/BCD80wKpXguZW9YYQaMYWlI=
X-Google-Smtp-Source: ABdhPJxEv7WSrGZP88deKq3+v+ahWn21scw1B5ep4+NkrrMvQNaVuS6qP/HxPj8yrnguUeCawE1z4A==
X-Received: by 2002:a17:902:ea93:b029:e2:b3fb:ca9f with SMTP id x19-20020a170902ea93b02900e2b3fbca9fmr2818083plb.4.1612960745673;
        Wed, 10 Feb 2021 04:39:05 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id ck10sm2199667pjb.5.2021.02.10.04.39.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 04:39:05 -0800 (PST)
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
Subject: [PATCH V4 4/6] x86/entry/32: Restore %fs before switching stack
Date:   Wed, 10 Feb 2021 21:39:15 +0800
Message-Id: <20210210133917.2414-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210210133917.2414-1-jiangshanlai@gmail.com>
References: <20210210133917.2414-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

entry_SYSENTER_32 saves the user %fs in the entry stack and restores the
kernel %fs before loading the task stack for stack switching, so that it
can use percpu before switching stack in the next patch.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 3e693db0963d..01f098c5b017 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -279,11 +279,13 @@
 .Lfinished_frame_\@:
 .endm
 
-.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0 unwind_espfix=0
+.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0 skip_fs=0 unwind_espfix=0
 	cld
 .if \skip_gs == 0
 	PUSH_GS
 .endif
+
+.if \skip_fs == 0
 	pushl	%fs
 
 	pushl	%eax
@@ -293,6 +295,7 @@
 	UNWIND_ESPFIX_STACK
 .endif
 	popl	%eax
+.endif
 
 	FIXUP_FRAME
 	pushl	%es
@@ -906,18 +909,27 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
 
+	/* Restore kernel %fs, so that we can use PERCPU */
+	pushl	%fs
+	movl	$(__KERNEL_PERCPU), %eax
+	movl	%eax, %fs
+
 	/* Switch to task stack */
 	movl	%esp, %eax
-	movl	(2*4+TSS_entry2task_stack)(%esp), %esp
+	movl	(3*4+TSS_entry2task_stack)(%esp), %esp
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	$0			/* pt_regs->sp (placeholder) */
-	pushl	%ss:4(%eax)		/* pt_regs->flags (except IF = 0) */
+	pushl	%ss:8(%eax)		/* pt_regs->flags (except IF = 0) */
 	pushl	$__USER_CS		/* pt_regs->cs */
 	pushl	$0			/* pt_regs->ip = 0 (placeholder) */
-	pushl	%ss:(%eax)		/* pt_regs->orig_ax */
-	SAVE_ALL pt_regs_ax=$-ENOSYS	/* save rest, stack already switched */
+	pushl	%ss:4(%eax)		/* pt_regs->orig_ax */
+	PUSH_GS				/* pt_regs->gs */
+	pushl	%ss:(%eax)		/* pt_regs->fs */
+	/* save rest, stack and %fs already switched */
+	SAVE_ALL pt_regs_ax=$-ENOSYS skip_gs=1 skip_fs=1
+	SET_KERNEL_GS %edx
 
 	/*
 	 * SYSENTER doesn't filter flags, so we need to clear NT, AC
-- 
2.19.1.6.gb485710b

