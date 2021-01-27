Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5347E30604A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhA0PzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbhA0PeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:34:02 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC48C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:33:21 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y205so1415664pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gzd3Dp/+VHSzpJTGQlFs5VyCFVUKNbcwISoSaILa1S0=;
        b=QCDhFSttFL/H04IWzwRAWS1jc/iZOLbl9BJK6bV94lPQ048I6I15eT/iaIMz1FntO5
         VoY5LbzMcfbU5nmMI12eexMKfUAkgQNB4ZKow5bPPly0WKEt4+eU8M3q+Sjk/h8QGMKL
         8Z0AqYTB65B+3cSYpRFmA99tVITkTu0wK8tldPTbloijxyrdyodwGJnmAsenf6VT6lbK
         r+DE1ivVUXoiFj7gD1SqywKZWEPJ6rbGAmY4LVSUGJ9Mi/Yd2MaYEO055OOfxOo/fG4L
         gxlcOTSHFYgPrKHF6YU9jg7h42jNBsRgSXysEqfk02XRISQDoTUrFvOj4Sevysr9vIMd
         Mqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gzd3Dp/+VHSzpJTGQlFs5VyCFVUKNbcwISoSaILa1S0=;
        b=kr0q+h4B1Ezni19oLGu+hD3p4E7xDUHfzjFgUg69g3jF7g+ZL1EAixK6OwZhx1tN7U
         roltiEFNVh1YggeqlDMKxFelaqIJpmtQedz9ithPvT5KbBrwo6bFsSSpXE/rI1z7+Etl
         AfhGms+kBhLEfznBxP4JsULKBpixEJTSX6xcJleXZUyY6WN5EJKg+GyfteoigWG2MTwr
         OJA7qHgZXVwOrf+aLcv6h+smoRxHjlGD1EpldHn3WnEVhoStXexZdgh88stGo+jbOHAT
         1ECDhT4j7nCgeDWwUsxK0FtiYmQ9NRp297jJA1bYuG1/ClrIjk2QbvmaLRrUeoLese21
         gRuw==
X-Gm-Message-State: AOAM530r4govyUcEqCzjhLMa4BS0XCq9mDcMgaoLl+Wn7sc5l/ssRs0a
        2fWSSYvmTcXiZ7ajBPqvpdscg+tCVZAkTC6L
X-Google-Smtp-Source: ABdhPJxFjWcUgYNwtqJuXchBUnd2fixEZZIzBRSpZutKKX4E9JQn4mZXeGMUmzod7j3vSlGvmFbYYQ==
X-Received: by 2002:a63:bd4a:: with SMTP id d10mr9415297pgp.18.1611761600721;
        Wed, 27 Jan 2021 07:33:20 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id 123sm2865222pfd.91.2021.01.27.07.33.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:33:19 -0800 (PST)
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
Subject: [PATCH V3 3/6] x86_32/sysenter: switch to the task stack without emptying the entry stack
Date:   Thu, 28 Jan 2021 00:32:19 +0800
Message-Id: <20210127163231.12709-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210127163231.12709-1-jiangshanlai@gmail.com>
References: <20210127163231.12709-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Like the way x86_64 uses the "old" stack, we can save the entry stack
pointer to a register and switch to the task stack.  So that we have
space on the "old" stack to save more things or scratch registers.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 3b4d1a63d1f0..3e693db0963d 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -905,19 +905,18 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	pushl	%eax
 	BUG_IF_WRONG_CR3 no_user_check=1
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
-	popl	%eax
-	popfl
 
-	/* Stack empty again, switch to task stack */
-	movl	TSS_entry2task_stack(%esp), %esp
+	/* Switch to task stack */
+	movl	%esp, %eax
+	movl	(2*4+TSS_entry2task_stack)(%esp), %esp
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	$0			/* pt_regs->sp (placeholder) */
-	pushfl				/* pt_regs->flags (except IF = 0) */
+	pushl	%ss:4(%eax)		/* pt_regs->flags (except IF = 0) */
 	pushl	$__USER_CS		/* pt_regs->cs */
 	pushl	$0			/* pt_regs->ip = 0 (placeholder) */
-	pushl	%eax			/* pt_regs->orig_ax */
+	pushl	%ss:(%eax)		/* pt_regs->orig_ax */
 	SAVE_ALL pt_regs_ax=$-ENOSYS	/* save rest, stack already switched */
 
 	/*
-- 
2.19.1.6.gb485710b

