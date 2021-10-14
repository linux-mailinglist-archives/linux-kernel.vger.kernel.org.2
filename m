Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF142D115
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhJNDi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhJNDiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:38:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF27AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d23so4239012pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNtCgf+VFHUlZGEKV4gLDOxA8WQx4O5hZ8JXpTy4mIY=;
        b=fNQneHAI7iTkLPZtJmxmT6GK1pDSnHu5Dw+sWE/mB1ngh5pG6aDU8a9hqj+0x9PM5F
         I1BLLpikK+dRIjRIJpl4CTuVt9QN5EAQE1AwKYa4ep6FWgUPMzcg4Bx+eVIBC7sIdtyD
         o0+HxLryXIW9YhZo/BSIiMp+DLeja4bzBRjLCSABsaC9s6tifdZBrXjgn15jIxsmIRZo
         Luihx2sK9AEXm4DVx2sd21YzK4lxYhQBakqiWc0/dH9LAGlPRB8nVslraSirqXYHpWuU
         ELdx13aAEF4ZG/Mq7nCeAwhSZDTVcq7MVsucUyoS4zYN0comVHMorsx0BwrjTbCpKtWT
         Q7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNtCgf+VFHUlZGEKV4gLDOxA8WQx4O5hZ8JXpTy4mIY=;
        b=ygqW3lL0Izk5BUOiIDmj8kj3xRVAyfSAQr583uDuxzfis7c1ruzhGDoPSgIpOOCZve
         mZVm/iGBLozBDXSRqacTzeTEJErDCEp4s0phALk/PG7sXmhMVpes002n4nEItORPJMsT
         wRLxo51A7An73tfCzHW+mpZrYWv+O+fLPmdMuAj5KLZF/BQvB4m3XIhcHd1dGcfLfOSk
         ZDeipUpaNekyTPjsu0yjiDzz1d8sebkUgFxgFZOC6dfthZP25CvSw2aEkvKSx5jpp7Z+
         mbzmXhl5LlxPpmwKkaUFQ0jKTIi+Lv8OFEtfdvBfvlkVR2av+6WhX0U6xXsDrVrOwNjt
         1/xw==
X-Gm-Message-State: AOAM530K1JtojsjMySvkNH2Z2qGIVlH8a7mNTwc93RI1udHf0jPtDdDr
        +XZKFJyO6RVZuCL93qqcENFE+ejnPak=
X-Google-Smtp-Source: ABdhPJxT3Uz0z2kOPoxY+aKwuZHCFL2RzLP5bo4W8yR+KDE3eIV5KNc1nf9TNDx6VYXueFMfvZGM3Q==
X-Received: by 2002:a05:6a00:2388:b0:44d:4b5d:d5e with SMTP id f8-20020a056a00238800b0044d4b5d0d5emr2857796pfc.80.1634182610200;
        Wed, 13 Oct 2021 20:36:50 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id x27sm887281pfo.90.2021.10.13.20.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:36:49 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 28/49] x86/entry: Make paranoid_exit() callable
Date:   Thu, 14 Oct 2021 11:33:51 +0800
Message-Id: <20211014033414.16321-23-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Move the last JMP out of paranoid_exit() and make it callable.

Allow paranoid_exit() to be re-written in C later and also allow
asm_exc_nmi() to call it to avoid duplicated code.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 79934c5ee9a1..8790bf41edd4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -472,7 +472,8 @@ SYM_CODE_START(\asmsym)
 
 	call	\cfunc
 
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
@@ -550,7 +551,8 @@ SYM_CODE_START(\asmsym)
 	 * identical to the stack in the IRET frame or the VC fall-back stack,
 	 * so it is definitely mapped even with PTI enabled.
 	 */
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack */
 .Lfrom_usermode_switch_stack_\@:
@@ -581,7 +583,8 @@ SYM_CODE_START(\asmsym)
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	call	\cfunc
 
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -974,7 +977,7 @@ SYM_CODE_END(paranoid_entry)
  *     Y        User space GSBASE, must be restored unconditionally
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=8
 	/*
 	 * The order of operations is important. RESTORE_CR3 requires
 	 * kernel GSBASE.
@@ -990,16 +993,17 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 
 	/* With FSGSBASE enabled, unconditionally restore GSBASE */
 	wrgsbase	%rbx
-	jmp		restore_regs_and_return_to_kernel
+	ret
 
 .Lparanoid_exit_checkgs:
 	/* On non-FSGSBASE systems, conditionally do SWAPGS */
 	testl		%ebx, %ebx
-	jnz		restore_regs_and_return_to_kernel
+	jnz		.Lparanoid_exit_done
 
 	/* We are returning to a context with user GSBASE */
 	swapgs
-	jmp		restore_regs_and_return_to_kernel
+.Lparanoid_exit_done:
+	ret
 SYM_CODE_END(paranoid_exit)
 
 SYM_CODE_START_LOCAL(error_return)
-- 
2.19.1.6.gb485710b

