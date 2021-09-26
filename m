Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1774189C3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhIZPMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhIZPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:12:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE99AC06176A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c1so13364795pfp.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6k/vpXKl5/A5yIkKjP2j+GxOFQu3zWClqI6gIZ99hQ=;
        b=go/6/QMR1PWgfJp5JP0CXTdtOMjQ8u8Xv10ajUep/A4dhXImZtMjx+rXvyqvaizbW+
         v1e4Cl8vbRRiLgdtmgyaIfNck1HAR/oPAtTXaHw4HmoYKj4Rr/lx6Y62lZLec7cVIKlQ
         WOjQ0bj8P9zXma9PNBcscNpn8W3IfN23Kb6b8BFle9pA2Sli2nClvq74clYnvcysqKA0
         0QReeoIKQrkPEB08vGoQ/iIGsRKes7FC/6Quh/vUNqwi3GBHNtKQrluD7wTzWmQZ4xJ1
         F7ndiLB9AeMXGP1bwcTLDDbeir/0Rm03Nqcnj0vDSHwFRXaKnWBSN6KF0WeiyOvZ6+an
         YnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6k/vpXKl5/A5yIkKjP2j+GxOFQu3zWClqI6gIZ99hQ=;
        b=Mau82cC1w37IBcmcQ/AV3MZuvRgjL2qnYUQYfpO+nfwXlMC4FjdqsjADuRetw+0fyu
         9OwCYlauFUozdQ7r/uKauJ6mP1T+wchrWl6Un8SRMOHKmRfiF2pzagmOBfinPVkeut/0
         UzemmZS8Ulb9EAihpuAEUCE6W7LnTCIWEtJsZP/TXE3fzesu95VbCOsbubApC8bO+hQA
         ksMkdRmJrW/UBdmVcuWFU5Si3QYWP8Ng2DAMJFjajNUGXCIrePVTDhAMeExiqsRp0xIi
         J+g5h24Z1ZyBIa2q1sbuMBlnsaRVTcjtu9j93Im9APCrr/YjUkkpTOU9DKUy9EI9BMIa
         vsdw==
X-Gm-Message-State: AOAM531IdzicjeHJQt6cf+cR8mH/8vkpgGsShmnbL33VgehnjqjCJn/X
        KmjOadY3f75dQsytdGPUIF7AS3PKZCsbTg==
X-Google-Smtp-Source: ABdhPJxLcEF+W4k3aPk891UsO3420yZ7kQsfECykIQdJejY88r5CRzpYUKpCP6ezc/Ltn/D2AR52XA==
X-Received: by 2002:a63:555d:: with SMTP id f29mr12837824pgm.33.1632669034130;
        Sun, 26 Sep 2021 08:10:34 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id w12sm6557385pjf.27.2021.09.26.08.10.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:10:33 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 17/41] x86/entry: Make paranoid_exit() callable
Date:   Sun, 26 Sep 2021 23:08:14 +0800
Message-Id: <20210926150838.197719-18-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index 169ee14cc2d6..202253c9a4f2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -443,7 +443,8 @@ SYM_CODE_START(\asmsym)
 
 	call	\cfunc
 
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
@@ -520,7 +521,8 @@ SYM_CODE_START(\asmsym)
 	 * identical to the stack in the IRET frame or the VC fall-back stack,
 	 * so it is definitely mapped even with PTI enabled.
 	 */
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack */
 .Lfrom_usermode_switch_stack_\@:
@@ -550,7 +552,8 @@ SYM_CODE_START(\asmsym)
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	call	\cfunc
 
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -937,7 +940,7 @@ SYM_CODE_END(paranoid_entry)
  *     Y        User space GSBASE, must be restored unconditionally
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=8
 	/*
 	 * The order of operations is important. RESTORE_CR3 requires
 	 * kernel GSBASE.
@@ -953,16 +956,17 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 
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

