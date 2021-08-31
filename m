Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343FB3FCC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbhHaRw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbhHaRww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:52:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B038C061764
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u1so7317622plq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7+dQxLQfmmA4ZAAnNYgSfxs5bJxPUxxMrcNjVnGyYA=;
        b=gohNTTy+cywmKSJbDF7yxbqcovULtcNnyuljeUM9KAFM2p1DrYvllWWXRu20qyw2nK
         WADkLCqxowJwH3TIcqx1rZBeVEUASRnYxFmIxm2o278P5MiUmHSFKtX+WUlJF3UQ8tlz
         t7vF5pCVUmf2gc2P/V24SUX/bB1eDXeHV8avx/ZoP1YLnf2PeHjaSgLG1pCGO2Bn9OG4
         dpFcXywJGiFaUI8AhJjPEgAhOv0QgKx7j89yPIyDmk0XnJJXe4+8MPPXNx0bhn622lyA
         LU5jiVHNApyT971k2mHAOZ0MjNbUuXQYmnUupaCd69eJZhHquAatLEQx2S6SpdghUFao
         40XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7+dQxLQfmmA4ZAAnNYgSfxs5bJxPUxxMrcNjVnGyYA=;
        b=F3zrXoO4PFYSAstjF66aE9DGath67yfAzH8Wn4Hmiy9zRWXZ5ZjwEk5n0SaB7H2F4h
         PT3tn/y/J4uzHtjtbotXw+TKEeNZtn6GI9aySE2rS9o7ygu0XGROWL13jb1eko+91rp+
         Pwz9NoCf7MU1sz3zWW0/JSG8P914ba8Eih0Eyc9yFETBuHr7+44pIj+nqtJvaDMlJVeB
         TXXtzqgIH2NO7ojF+FatWUleplfFVyktIwqCoYpeqN5ipNMZ31HqeGUgEl/ERZB3aItw
         mtM8e4YorIT08zYJdUMP+EF6k40kd5y3hJNM1AFciQI5strrGjSYGi6/I64aVUVz+1Dn
         NAAw==
X-Gm-Message-State: AOAM531dMCBJz4S3klr7tuGsEJiX/9HJbpbdzcCq9fMr19newOint1e+
        leK3bihVEx2St78nWIVe4QHwYFTKRAg=
X-Google-Smtp-Source: ABdhPJwRVnhtljYEvbg0ChFEkXy5XuM40m+J6qUEWwNL3+MD8ORf87gJANuK9Y8vd6XAjxRmkDigEA==
X-Received: by 2002:a17:902:a406:b029:12b:c50a:4289 with SMTP id p6-20020a170902a406b029012bc50a4289mr5777572plq.56.1630432316664;
        Tue, 31 Aug 2021 10:51:56 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id u24sm19846765pfm.27.2021.08.31.10.51.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:51:56 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 14/24] x86/entry: Make paranoid_exit() callable
Date:   Wed,  1 Sep 2021 01:50:15 +0800
Message-Id: <20210831175025.27570-15-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
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
index bc9e2f5ad370..24b121d2bf61 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -437,7 +437,8 @@ SYM_CODE_START(\asmsym)
 
 	call	\cfunc
 
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
@@ -514,7 +515,8 @@ SYM_CODE_START(\asmsym)
 	 * identical to the stack in the IRET frame or the VC fall-back stack,
 	 * so it is definitely mapped even with PTI enabled.
 	 */
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack */
 .Lfrom_usermode_switch_stack_\@:
@@ -544,7 +546,8 @@ SYM_CODE_START(\asmsym)
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	call	\cfunc
 
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -936,7 +939,7 @@ SYM_CODE_END(paranoid_entry)
  *     Y        User space GSBASE, must be restored unconditionally
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=8
 	/*
 	 * The order of operations is important. RESTORE_CR3 requires
 	 * kernel GSBASE.
@@ -952,16 +955,17 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 
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
 
 /*
-- 
2.19.1.6.gb485710b

