Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2275B43B44A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhJZOhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbhJZOhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:37:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C10C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso2428568pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNtCgf+VFHUlZGEKV4gLDOxA8WQx4O5hZ8JXpTy4mIY=;
        b=Se0gBBeoajcNu+dE+eH19bhUO+AoeRjvw3ioZV0GMOwHpfQrb9ACEdCHxZW/NiW669
         FTZYtz2j1zPzdZt72IPx+6Wu7cvdImZtusTpIdzR9bzH0xh5NWrIkCBKrmV/jBX6wh0x
         hFr9RuEBkhrQk5kzVfxF6SAT+/VGGzOLHryGzXNewuzXANYhl6pNHomwFYsoR68K7BC8
         mAYZDBdiUAi7W2qEkiw4I0x4635PNYaLosq6/sht+h3trdv/r1ql/cxwSzGbdewkE/ex
         X5YtxQK3+tT9vr8HIV1CSWmUniIM3T8lVld1dj4dvMg4ln8Myu10jZ/tPAw6Emq/ie4J
         Y3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNtCgf+VFHUlZGEKV4gLDOxA8WQx4O5hZ8JXpTy4mIY=;
        b=6HWfRtMOM1JswPPGK4aK/aYU7yPwtFsf8yZl5EwMQ4BmoZ9ZSIqmQHR4QQgO6STFzo
         XZvoFz6J9jozFoZANtusMMFEyT61rdTZVzGa8rMns5qP53cdM3LNj/koKsDM2amRW74c
         VHi6lqRr6AWzKHCELgha0ZNigL2lASW55VUcjmnZ1OOPQ8MPYjnbmiUwi4W25tY9N6Zg
         dfAjy6nkddu+OcG3TQ9vhIfM+eBonArTrhIeUACBjXSwbpaEB9lmBV6weNIh2U0BkFXw
         0byk0Ucz3MkK/7df6DoOWMnQPo6Rx7dnh17t1cocycqTRyXsaadgaRECVaWtONS3K1vj
         2Zdg==
X-Gm-Message-State: AOAM531VWjZpmClvIc3Aw3ipizalmgA3XrOVCHdBqQl6EXqXbPP0PZRb
        nFy29kC8ZAb3RG47biIB/7ylU/WE0l8=
X-Google-Smtp-Source: ABdhPJyslmyU+SQde4kWh4CvWVR/sR6JfiAdwQPO0e8ffawXLjiBDLX6NAVhxTmUnCkpLuqn7QdOuw==
X-Received: by 2002:a17:90a:a8f:: with SMTP id 15mr29361182pjw.229.1635258911601;
        Tue, 26 Oct 2021 07:35:11 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id m10sm19185184pfk.78.2021.10.26.07.35.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:35:11 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 28/50] x86/entry: Make paranoid_exit() callable
Date:   Tue, 26 Oct 2021 22:34:14 +0800
Message-Id: <20211026143436.19071-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

