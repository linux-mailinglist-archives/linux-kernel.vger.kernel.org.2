Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB003305FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhA0PlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbhA0PeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:34:16 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577F7C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:33:36 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i7so1807610pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQVfxuwxYuSS9SB24tnB/iwuVM/zffDjeOPuAK9bZpg=;
        b=UpI+eJNV/DxtHw213IJ9pVzrqZrE/V+2RrwXcSuwvftktwDgLojtHQTeTE8Nm9uwM/
         VhqlYR2TbHWxbaZkp4E3xwSxGoJhOXZipHhvHFD69ZkkXpnm1yI65SIU5zp2G/9uGBJX
         DJdmABEJOycMjZwUX7ZH2CNrtf7blxX0xQkra8k6G1XUq7t6Xfmqrbv/2bsYXkH0nXaW
         jJ6r7FjM7PC0NVfwUn1xLr/34hzXrF3YJY2J4sgMgrIzqT6nZTwIfOsgF2N9bnmhcpuy
         tSHnQwlq3kSk9okGm7zkgg712OOcv5ILdoZP/Mt8OCFzYlxZu7DzGE/FzL+aWWsH6g6f
         J6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQVfxuwxYuSS9SB24tnB/iwuVM/zffDjeOPuAK9bZpg=;
        b=RSE1lJx7sbOL4Y6CFD2AbxW2TDGwreGrHDi4/Wdu35uFYv4dFuKwbOP55LL8hpI1/e
         k/Q5nCnK9oxTqFt6wMfY6ik3NO72AeNpzVZyqDMHO4G9+a4/JE38lHzHGF42+muHRyzm
         /3ij1hP0g9CaOphqITWBjeQJD6yrp/QYRZl9RFxqmnkEt7OGwUTj1Z/8CLkPCdIWYEzH
         luIB+eiTx/EaZIe3/NnqcuWFg6rzCZEWSN1sDyqg3hPnwhSF5q+H9sl9xZ8f6pp7CaMk
         OQoCOAaG3oOPsUsKZheLyQIaWFtblOPxY2pmsZ+oYy5qHd8HoDX6OAUEgCVLO+wGN+7y
         pAbA==
X-Gm-Message-State: AOAM5329feJSrL4kPXaRFjelpQXZDsXdmSXnuOxI6PZPmHT+OHuoC6Hb
        U41TA0+cmh2pnXJGcKiazQo8pZ0DllpuMzhE
X-Google-Smtp-Source: ABdhPJyJ1ZXNpHJfFdh27UkkLg7Dl4pWm9NP4K4OYG/xgNaMwpZHl8eYVINcEpqKn+/LDiqOXu4bpw==
X-Received: by 2002:a62:7b55:0:b029:1b9:9caa:2e62 with SMTP id w82-20020a627b550000b02901b99caa2e62mr11364280pfc.41.1611761615767;
        Wed, 27 Jan 2021 07:33:35 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id k141sm3033244pfd.9.2021.01.27.07.33.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:33:34 -0800 (PST)
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
Subject: [PATCH V3 4/6] x86_32/sysenter: restore %fs before switching stack
Date:   Thu, 28 Jan 2021 00:32:20 +0800
Message-Id: <20210127163231.12709-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210127163231.12709-1-jiangshanlai@gmail.com>
References: <20210127163231.12709-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Prepare for using percpu and removing TSS_entry2task_stack

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

