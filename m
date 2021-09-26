Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5573D4189C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhIZPMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhIZPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:12:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA01C061714
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 17so15287643pgp.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkZ5F7sG9MHfVaHIcK1lxXanNO9hiqWqrOqxmAVf4EI=;
        b=KzpkqNBeC9Gy4O9BjAW/7BWdhSjO4C2vTOy9aUR4SN4Kq+x1W/gWB0uQ9L+quIADvn
         kk3LRt8j2MKmKPnGWXk28GlVEKQd/mv6Ofi0ijmO19Ycato1mfUEn2EBbJoYs8EtgjVJ
         PXquO5vzOoga2feseoOn7kVFNFrXJ61WC8D4DiKqV0XHMR7B9F2WgJm49UYf4jwceWLy
         IpuTXo3qlLWsteI2MFYJkvNXwh32A+ZeSDUluCxuFoVpDJ+fmRQFEN6k/bfLaVDVxChq
         dWy5eKP1UF8ei8DMd1SLcZ/zn9ZeMwq3JdihGKf0+oU71Iuy8kWTp0dlcV4JyKlBpkOU
         y3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkZ5F7sG9MHfVaHIcK1lxXanNO9hiqWqrOqxmAVf4EI=;
        b=u9ghDS4I32JBUQrtjpU6FxT3QjBvQZ/+p4dM3isqAk2W9B5SiIIiL4/u1vipJJJBsC
         WyRk9RHM3P5eWmTiN0fsPYTgO/EUkcak3jwDdRn/GoSfU6itkF5MQT5qS7kG32GQ2hQU
         qp+gpE6hh9a0JZznq0wVzpk9WB8AG23LbcAlqDGZS4aVswhqrhPS3WXE/yfHVssoyYMz
         5IqHhBcoUF/+lgf6733hJuMwh84NqOi9mCXcFpWy1muGjLzP34WM7wMXNokOd66REbAF
         pnSSE3Dn/4LlfHrXQSoAB3AoAtx8njobHOqlEv7Iojyx1PG4s6kWFuY+xbVyRvYQbCJa
         GINw==
X-Gm-Message-State: AOAM530Rm0EYPW3TGeetfsvJAZ3Cm53dWaVgj3GEL8RGAnPmgDUS6mj2
        zBtgFaMwBxYUsFdNWjqxL6pkva0h0rIdEw==
X-Google-Smtp-Source: ABdhPJzfH4jrFKyDriqLIvn+mxTqLyvukYU+i0VPSzEX2Aogigkm3i4BU+x6gRU8qErU7HJw4+KZxA==
X-Received: by 2002:a63:f749:: with SMTP id f9mr12522276pgk.77.1632669040255;
        Sun, 26 Sep 2021 08:10:40 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id m186sm12588234pfb.165.2021.09.26.08.10.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:10:39 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 18/41] x86/entry: Call paranoid_exit() in asm_exc_nmi()
Date:   Sun, 26 Sep 2021 23:08:15 +0800
Message-Id: <20210926150838.197719-19-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index 202253c9a4f2..a0d73dc0d2f3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -922,8 +922,7 @@ SYM_CODE_END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
- * only on return from non-NMI IST interrupts that came
- * from kernel space.
+ * only on return from IST interrupts that came from kernel space.
  *
  * We may be returning to very strange contexts (e.g. very early
  * in syscall entry), so checking for preemption here would
@@ -1271,11 +1270,7 @@ end_repeat_nmi:
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
@@ -1284,31 +1279,12 @@ end_repeat_nmi:
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

