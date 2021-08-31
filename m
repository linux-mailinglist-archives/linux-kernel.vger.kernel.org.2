Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C661D3FCC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbhHaRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbhHaRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:53:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6A0C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bg1so5820349plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1oP3U2JdXU+Z0EH54sEwuWhZOymozEo9q+P44Deggqg=;
        b=aIQOhoKeoVIf3ymiT1Jp8ldQtjWpjSCSN3x+fDuHDz8p/6AthANUCkqe+Fkhj++QVw
         g6b6paonBc/BVxc8K4lQd/LzxtG8EePpVX6u2TFtBqtLAZo32FT1zTW8Kf7QxH1xTgHf
         Mz9rdF8GlIO+trmp7JT5maiTgeF9PFaRXUekYFa70vQZ3gJtb4NQn72A9FHgI3e+cTJ4
         LaNI0xAeqJ4LiXLKYic/is7ZYfBL4FT/61c3Z2dSEFPQeUHNTP1JTdY5DZq4y/Q0rjke
         zimiU51IhG8sK37p8KiEMLFMqPtBfX48KBv3T47irqo3jm27ELPTBiVFHc31IL1dGTOf
         MzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1oP3U2JdXU+Z0EH54sEwuWhZOymozEo9q+P44Deggqg=;
        b=uJJ15kZ2mvl9jgpDUt0tZr8Kl/Ey5qa0tT3FJuSsJC4spyHUy0JWCGfDiWguASnAkQ
         FHNddVwvDFb6kjobJJXkWld+ZaMTU1UTkza1z92KthMbr9AmJNNZH132iKmDc61st8MR
         rfwcXYjRsKj+jNeFNlxB7e+6kh7tzQcHg8Qma9Iv2WH6FyIWKSIgLnoRqLkrFoZx66XV
         0dCW5Z4UYCcf72bfc65Cg8d8evaZYk1ebrhNIclg+80/PMzIfO6IMzOsQkl1vIRZ/sQ0
         5qJuj+EaV1HAoTRIcJ4I0zVolble4D5I8BituCs4+QHMw06bFkhKlim/7Y4pmwx1vS4l
         5F8Q==
X-Gm-Message-State: AOAM531IMWKA2ts5XQfcBjCN26PM6ZIPxPwAQIkpIvRJiU8ZRCWRZg9I
        lnDzZpynAxfm59PQd4RSJ+5dySrFVoE=
X-Google-Smtp-Source: ABdhPJyYO1J/K/ZmmZn1T7o2rRmHBMeJtKZsqLIgZS4DfP1PnjGBmSmjLcm0lc2YZvJhtwnQPpKecw==
X-Received: by 2002:a17:90a:64c1:: with SMTP id i1mr6635234pjm.111.1630432328797;
        Tue, 31 Aug 2021 10:52:08 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id 138sm18830174pfz.187.2021.08.31.10.52.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:52:08 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 16/24] x86/entry: Use skip_rdi instead of save_ret for PUSH_AND_CLEAR_REGS
Date:   Wed,  1 Sep 2021 01:50:17 +0800
Message-Id: <20210831175025.27570-17-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It allows the user of PUSH_AND_CLEAR_REGS to use its own ways to handle
the return addr.  For example, error_entry() can save it to r12 directly
instead of moving it around and reduce two instructions.

And in later patch, it allows us to move the return addr lower and
add a little more space between pt_regs and the return addr
which consists a new type ist_regs for IST interrupts.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h  | 18 +++++-------------
 arch/x86/entry/entry_64.S | 12 ++++++++----
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 996b041e92d2..aeee1575332f 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,15 +63,11 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
-	.if \save_ret
-	pushq	%rsi		/* pt_regs->si */
-	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
-	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
-	.else
+.macro PUSH_REGS rdx=%rdx rax=%rax skip_rdi=0
+	.if \skip_rdi == 0
 	pushq   %rdi		/* pt_regs->di */
-	pushq   %rsi		/* pt_regs->si */
 	.endif
+	pushq   %rsi		/* pt_regs->si */
 	pushq	\rdx		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
@@ -86,10 +82,6 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
 	UNWIND_HINT_REGS
-
-	.if \save_ret
-	pushq	%rsi		/* return address on top of stack */
-	.endif
 .endm
 
 .macro CLEAR_REGS
@@ -114,8 +106,8 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax skip_rdi=0
+	PUSH_REGS rdx=\rdx, rax=\rax, skip_rdi=\skip_rdi
 	CLEAR_REGS
 .endm
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ac67a1109c9c..e968074046c3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -849,7 +849,10 @@ SYM_CODE_END(xen_failsafe_callback)
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
+	PUSH_AND_CLEAR_REGS skip_rdi=1
+	movq	RDI(%rsp), %rsi	/* temporarily store the return address in %rsi */
+	movq	%rdi, RDI(%rsp) /* put %rdi onto pt_regs */
+	pushq	%rsi		/* put the return address onto the stack */
 	ENCODE_FRAME_POINTER 8
 
 	/*
@@ -973,10 +976,11 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
+	PUSH_AND_CLEAR_REGS skip_rdi=1
+	movq	RDI(%rsp), %r12			/* save return addr in %12 */
+	movq	%rdi, RDI(%rsp)			/* put %rdi onto pt_regs */
+	ENCODE_FRAME_POINTER
 
-	popq	%r12				/* save return addr in %12 */
 	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
 	call	do_error_entry
 	movq	%rax, %rsp			/* switch stack */
-- 
2.19.1.6.gb485710b

