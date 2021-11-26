Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9332345EB73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376932AbhKZK3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhKZK1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:18 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFE8C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:49 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u80so8472115pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7nHJlAEdpwEWbxOq+QPN5EsxUh0AmNUUhCvzRwlkm4=;
        b=k0T28vxf5HNyoiCpzUtendsy0ySNKTyWbcoY6pcdGqU2jrE9i4A/T3giI2s2BLybNv
         eJXc75LcYVyBkpZbWH5VqoNriRWqYVGPxuUe88q0NPTiNkcf0i2ksDOt2o7OyR9ot0OU
         ukzDV/sR4/hE6kjmi2NIkL8UiJBlnxx0SRmi7G7bAvWqLpn+6FK2kSXnb7uYtIqQQP+I
         OgdCvHWIDceO7O7qH6Bk8rDImD4U2MRTVVv/d2AFna7SBQdN50B1WjC+CKjOFn5+DGZy
         ieSDNtigubDPZ46JwBjZfmaXG6AQ9D+0qp4s/zOtFEHE/Dxv7Fp71bzMSus663e37UUv
         kXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7nHJlAEdpwEWbxOq+QPN5EsxUh0AmNUUhCvzRwlkm4=;
        b=t4C2/1Uez6+UIZO9z8uOeB0G1Mfl+mXbVrCr4nzs0vE51HRkPrPPZWC9x0yclq1Z0i
         h8fRFRnIDss17vGEOv4yRvT2JKHY0OjhVDo6UT+e5BJWkEs4K3w+Qjr/xW4pWBnc/lq+
         yKVAiXltY5MR0uOzaqnY+u5f2PqB8AHpWK1zYkKb9v50wIeX7EpELwx7oNEZdELlxTPM
         Oaid16RCikmOpBtaCSD+2byW64skTrZG+KeaLnCLpSNZnHeVOxBRyj9TgtBFFzJTqmmi
         36ZqhFjShDRSGTzAbiTQIqDpjlF//9C4NTctGAiwKYFR6gQUpP9vLM1qAb+fs6NNeuqC
         hGBA==
X-Gm-Message-State: AOAM533fSmEBNo2CukzIEKqr3mIKGfHoK+1TQdSqnqybwjoehe3D5t8m
        18FYibaqEUNiGDXFG70p3wTo0u/zoWU=
X-Google-Smtp-Source: ABdhPJyz+gP8O9g8D24JOcVHOda+4Cj5Kl19+rNTgWMwJsiUV65O4MyTJudUviQPaZI/DNDudZoHaA==
X-Received: by 2002:a62:4e0a:0:b0:4a0:4127:174b with SMTP id c10-20020a624e0a000000b004a04127174bmr20209126pfb.41.1637921688878;
        Fri, 26 Nov 2021 02:14:48 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id q9sm7008570pfj.114.2021.11.26.02.14.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:14:48 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 27/49] x86/entry: Make paranoid_exit() callable
Date:   Fri, 26 Nov 2021 18:11:47 +0800
Message-Id: <20211126101209.8613-28-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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
index dd0cb43627a3..897892dc563c 100644
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
@@ -972,7 +975,7 @@ SYM_CODE_END(paranoid_entry)
  *     Y        User space GSBASE, must be restored unconditionally
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=8
 	/*
 	 * The order of operations is important. RESTORE_CR3 requires
 	 * kernel GSBASE.
@@ -988,16 +991,17 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 
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

