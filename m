Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE5245EB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377061AbhKZK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376901AbhKZK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45BEC0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:54 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y8so6393074plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMH5LK0qrRMkjGKFSQTYK0+k95zIdQDBEISZKE0N4fw=;
        b=Vpkj86Ln2zZTpnoskALFNnHjHraxQMcJ+yMs+WjbZs35DqAhZ+TdUJZ+sEuFUvqmK7
         PRntZAAq87m1c2P1gqCpuujX0+9n33m51QhFAEu2Oy7/lLkM2TbKyq69KADXVHKhFhpS
         jmo1W2pszZtuK7d38eM6uhhhyPtIPylbm87FGdPYFNtufYEGz7ld3jvanAk0j1gI7QLB
         tFqPVzvdX0rPOpY+eVYQtDn2+ILBUhmf5J/B9lrpv9+PUAtjbsWCUYCyHMPoe7Z1+7tc
         ZXvnOGTIYbRteHo65H1rkkT3jVvHeVFaUtoiuGIoOnLaPzsO+nsmuwSJGHJ159lKYsEV
         dUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMH5LK0qrRMkjGKFSQTYK0+k95zIdQDBEISZKE0N4fw=;
        b=SpdNHj+4r6I0qvkppiwPXkQ7uZzEpRJYRWjFZ50aBRnJPvaULj9/Boa81vzN8fvxpU
         yGnwyvr8INBoG3w9douJU+NJRDDNX83Geb4+veLCenyIQmNJajFF5fUFupLNVh2Wi7po
         XXv2xdL5uQKdEcVCKJPD1VC4Mjxxo6QvNS1j95QJtp126/uZvRPHBHbtV1VCd1WTJm9b
         3X90Gfex4q7K/GN27RCmtCQ9EwXoLkScgd3HIn6nnT2MIt0EETsY97hmQqbCmlybZpHw
         YntRYvsvKD57y75LpEmk2FR4280Sx10Cz8o/15iepyxeVVMU800Kw/WoDS+GmViacTN1
         dxeQ==
X-Gm-Message-State: AOAM5331MyX1BKBFJ8/tZG0el5mhktcUs7g13JRDI4ZvZxdaKE1JRO6U
        j5cG6rRFrZkU/uw2Wo0R+jbCF0wD6ic=
X-Google-Smtp-Source: ABdhPJxI2PRI0tR3xwJgZ3bz5eGvy1Psk5fn+LnV99rPLSE4q/8KoDU/H0zrWx4L5u663Kso1gRqDw==
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr14441003pjb.142.1637921694087;
        Fri, 26 Nov 2021 02:14:54 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id s28sm6910558pfg.147.2021.11.26.02.14.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:14:53 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 28/49] x86/entry: Call paranoid_exit() in asm_exc_nmi()
Date:   Fri, 26 Nov 2021 18:11:48 +0800
Message-Id: <20211126101209.8613-29-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The code between "call exc_nmi" and nmi_restore is as the same as
paranoid_exit(), so we can just use paranoid_exit() instead of the open
duplicated code.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 897892dc563c..9fda034f3e92 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -957,8 +957,7 @@ SYM_CODE_END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
- * only on return from non-NMI IST interrupts that came
- * from kernel space.
+ * only on return from IST interrupts that came from kernel space.
  *
  * We may be returning to very strange contexts (e.g. very early
  * in syscall entry), so checking for preemption here would
@@ -1306,11 +1305,7 @@ end_repeat_nmi:
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 
 	/*
-	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
-	 * as we should not be calling schedule in NMI context.
-	 * Even with normal interrupts enabled. An NMI should not be
-	 * setting NEED_RESCHED or anything that normal interrupts and
-	 * exceptions might do.
+	 * Use paranoid_entry to handle SWAPGS and CR3.
 	 */
 	call	paranoid_entry
 	UNWIND_HINT_REGS
@@ -1319,31 +1314,12 @@ end_repeat_nmi:
 	movq	$-1, %rsi
 	call	exc_nmi
 
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
-
 	/*
-	 * The above invocation of paranoid_entry stored the GSBASE
-	 * related information in R/EBX depending on the availability
-	 * of FSGSBASE.
-	 *
-	 * If FSGSBASE is enabled, restore the saved GSBASE value
-	 * unconditionally, otherwise take the conditional SWAPGS path.
+	 * Use paranoid_exit to handle SWAPGS and CR3, but no need to use
+	 * restore_regs_and_return_to_kernel as we must handle nested NMI.
 	 */
-	ALTERNATIVE "jmp nmi_no_fsgsbase", "", X86_FEATURE_FSGSBASE
-
-	wrgsbase	%rbx
-	jmp	nmi_restore
-
-nmi_no_fsgsbase:
-	/* EBX == 0 -> invoke SWAPGS */
-	testl	%ebx, %ebx
-	jnz	nmi_restore
-
-nmi_swapgs:
-	swapgs
+	call	paranoid_exit
 
-nmi_restore:
 	POP_REGS
 
 	/*
-- 
2.19.1.6.gb485710b

