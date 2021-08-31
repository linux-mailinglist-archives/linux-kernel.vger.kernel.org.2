Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFFA3FCC9D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbhHaRxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbhHaRw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:52:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9995CC061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so73319pjz.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54J0W4fwLOE2fAqFpMciL83O+cTrA67vy7sQasyVP14=;
        b=FmV2RGONgsKalVhosVHOiHPClkEOBKyb6aCXBct7H1e2VmYKLAtj3ygVmjNMqbJh1p
         aWNcqfC9GO51dPZcIuVwshy/UL7xsgDwYZ4BkltjeBj8cez2LL2lULKIpSDziljJ2H28
         C57g4NeqnqTjUH/wSTxS95U+NZHIUCCayj36I5AYsKFPZxpq2VfdkhRmJKhiyGlAf+be
         RN8hC2V3IGo33OhBDcNZU8bFRQ3C40nx/A31VGAFxp5131sRXcyZkN0JakWjcm14yPXy
         DdIri1RjENQoCT1bGfegcrIQqlF4uBHv+6MQ2u/oNnPVsVc/zKJAqS5sBcqv1JZAHxw1
         qbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54J0W4fwLOE2fAqFpMciL83O+cTrA67vy7sQasyVP14=;
        b=W0516cpenQTo0nSixq2z49OZDx4yHFkMsjGSjCXVB7tE1DvIJtOV70obHKjaHPNyAf
         lH3kNJ1x+LQC1TPy3co7JI9mNpn9/VclSmB37sl0/ZU5aj9qMS+6eRmKsTSZaLT3NEaC
         Ru5JlzbyxCZhAVbFCCb1yRTdsCeWas3CjeD+qZqg+/Vk4GrGaP1rbf/ehtTPVYoUu/rH
         Y3orZjkeBcUtgkN7/jaOxu8lt8JYcy35zUksePz0/HvdPSPpCZvHjlrk4A0zvMLX3cXf
         uApwvxiZSx+8L8wBdPxMeWhAkS8N1oSX2ZpxT0ZmfXAk1Db1EYxrxuGAw4igdPHYEQbp
         g2ow==
X-Gm-Message-State: AOAM5305PJdMn/kxE6lfR7ZCBLjV4YDubaRoAA6xeFKF3drKl+Tu6YPc
        fKFyX+h2GYeA2baC8jI0b/TKESamKLE=
X-Google-Smtp-Source: ABdhPJymndmFn8//tt9KidwP8MweMc947A2gH7hAElLXNAandT6nNqIueUEzkkl4qpzyF8A4d/Y5zQ==
X-Received: by 2002:a17:90a:6b4b:: with SMTP id x11mr6800306pjl.157.1630432322920;
        Tue, 31 Aug 2021 10:52:02 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id c23sm21422158pgb.74.2021.08.31.10.52.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:52:02 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 15/24] x86/entry: Call paranoid_exit() in asm_exc_nmi()
Date:   Wed,  1 Sep 2021 01:50:16 +0800
Message-Id: <20210831175025.27570-16-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
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
index 24b121d2bf61..ac67a1109c9c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -921,8 +921,7 @@ SYM_CODE_END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
- * only on return from non-NMI IST interrupts that came
- * from kernel space.
+ * only on return from IST interrupts that came from kernel space.
  *
  * We may be returning to very strange contexts (e.g. very early
  * in syscall entry), so checking for preemption here would
@@ -1288,11 +1287,7 @@ end_repeat_nmi:
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
@@ -1301,31 +1296,12 @@ end_repeat_nmi:
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

