Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1244C098
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhKJMDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhKJMDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A895C06120D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gt5so1393048pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6RPiwJm9gP2VhPlBztjb1HevKRF3AQRhxbs5HYylv8=;
        b=QTuHlKuTmtultOGAO+50fCrLh2mKx2nQpnmHSoKXP2PlxNFE9EygHWDe1ZG/EK39w+
         EPcLTBSpfiDGxTOToq870cjvZDLqID/e+d2dJkLQdWfhRSvAyRnvVzj50/3xMQBu26eZ
         riJt7WF/NNwsymd6wg0Ke1VvcAxhUx4z320Gs5FJwoOnOgOHJPuSEwJNYd+rRYgOYs9Y
         fUAQ3gG+RLWx5zYck9zTV3aMe2O3jpO4JQeSE0Ksfqg28+C2odPCUizvdzY5g+//TBeT
         Jol3raGrAyE7CNGG6f8myhFgiHpnTU0CB1sam8hF5caqSvz2MgXudeeCHc9JC15iUbM2
         /iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6RPiwJm9gP2VhPlBztjb1HevKRF3AQRhxbs5HYylv8=;
        b=d+G6bJ9rxx4N8Hp+SOCUb6zunTMWDIA+dCvL3VfUpdubU0HElnmV344U7tWSlffLZ7
         VMsMmPl64sIRGYf5VPWRF6iOVqHbA97vINtjigPvQfb8G7fy0LM1YmekmLzQbLOOWjwq
         kCp0nK8tJDdoB8+pSjfjcRe7sz5VpTcmK6tCcJiS7xr3MF6VLiDOLnO37alIPxlvYP8Z
         BnkNU/CPyzInkUq5gjfFtmhrP9M6MTdEEnghQJJ8qp284SeC1f3k2wLY+hJuD7R+1MLq
         xgDduglDz4ISIgAXv4lGVJR6DDyVRSFLuMnkfBwBedRa5Mgjpe521kjSQo9uaRaL3qJK
         GATg==
X-Gm-Message-State: AOAM5329trnT8X674biYxgMeAuP1co4b22Cl5d8/LFgBTGLMsqUEZtKX
        DYo5576t/N0B6V6KS1ezRM43p1sJRqw=
X-Google-Smtp-Source: ABdhPJxpZMihbmBrBkxjy8WZYCSSH8uzDkpNYqWQtedKSxF1PWesBLWQQqMVfoFuGKNH5fnhhl9r1Q==
X-Received: by 2002:a17:902:744b:b0:142:46fe:7fbf with SMTP id e11-20020a170902744b00b0014246fe7fbfmr14715442plt.83.1636545625645;
        Wed, 10 Nov 2021 04:00:25 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id oj11sm2456529pjb.46.2021.11.10.04.00.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:00:25 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 28/50] x86/entry: Make paranoid_exit() callable
Date:   Wed, 10 Nov 2021 19:57:14 +0800
Message-Id: <20211110115736.3776-29-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index d8a0a40706b6..e6e655a1764a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -471,7 +471,8 @@ SYM_CODE_START(\asmsym)
 
 	call	\cfunc
 
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
@@ -549,7 +550,8 @@ SYM_CODE_START(\asmsym)
 	 * identical to the stack in the IRET frame or the VC fall-back stack,
 	 * so it is definitely mapped even with PTI enabled.
 	 */
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack */
 .Lfrom_usermode_switch_stack_\@:
@@ -580,7 +582,8 @@ SYM_CODE_START(\asmsym)
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	call	\cfunc
 
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -975,7 +978,7 @@ SYM_CODE_END(paranoid_entry)
  *     Y        User space GSBASE, must be restored unconditionally
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=8
 	/*
 	 * The order of operations is important. RESTORE_CR3 requires
 	 * kernel GSBASE.
@@ -991,16 +994,17 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 
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

