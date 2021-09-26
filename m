Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1FF4189C5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhIZPMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhIZPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:12:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9CEC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so1748290pjv.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jUcN2gDXPlrD+aT/ViRiDBQMG99yASghsdP3OPqdVQ8=;
        b=DoYQgMbGvPFrn7bDn7sTO4WXzSliH7TxvbZJkezJHrivjooHnRqJ0yqCrnrNFS2Qv5
         TdiK91SK6EJT2DKNA6xNZ0kIgCC1XE9TmIEesXXEWl9Pq8oF96c+De5bzWClXodRauXs
         9ZbNgxRaLmcgGYCy6LTvBd1dB/zZm5vXmIgAHd/5ElY0pYWUwAYo1U9RO2MmA5ErfVcd
         bn8aDgG8PVB15MOdBDNEjPqiLtlbPmXO+xzH7O+EHYmiFcpeqjKW78Cp+UgCL+iXa6JI
         gTVibPPXcF0t0ZuYM1SgA9u8s6BhyXT8ziP0b+bSGZru+N1Tcl8KeW9ywodbo/C4fJO9
         uFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUcN2gDXPlrD+aT/ViRiDBQMG99yASghsdP3OPqdVQ8=;
        b=Tpi7WBUH183QmgpXG/mt2557yKLNWihTkaFySoclJc8b5vfOgdmaXbRmxkfnCPVrBP
         3l6RLnxvOcqzFs+SdKCOSDii0awcgF3YOjeTjsHO0M4apjUbsSnGxBZdmiHzyQDA0Z0Q
         deWIo55HBQbb8F/zYEdrh+4ThRNzii5hOcpECRlIVtXQcG/E6XHc9XhYgieEoCDYlI14
         6GPU/oJfLDVq8l1haNoH2FQiF6LdN4y336FePsK4+DVDU94WFw0VI2occOibhwYO/QRg
         ncE/lc6e0NKhuTM0n3oue6rdv5cdUVF49LKfFVJFkwj16Nj3PPygUKEFpWfenIBSYV7w
         WINg==
X-Gm-Message-State: AOAM533iAQ9/r+G0zZ04i+UrnEyZfOZhziLDsNY8uDmvPX34AvSbCbVU
        tvvV0vBL2WLNS/GwfLYEoI6RpWJXjYfdZQ==
X-Google-Smtp-Source: ABdhPJyEozEP24kwzcr7gqtS7Hex4Jum2gcvZJo/Vo3aw3+ga1qz35Dia0wmmKtcDCkZwc3OHBRJjA==
X-Received: by 2002:a17:90a:f00a:: with SMTP id bt10mr7724348pjb.96.1632669046366;
        Sun, 26 Sep 2021 08:10:46 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id z17sm14623268pfa.148.2021.09.26.08.10.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:10:45 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 19/41] x86/entry: move PUSH_AND_CLEAR_REGS out of paranoid_entry
Date:   Sun, 26 Sep 2021 23:08:16 +0800
Message-Id: <20210926150838.197719-20-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It is prepared for converting the whole paranoid_entry() into C code.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index a0d73dc0d2f3..bd6bce341360 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -322,9 +322,6 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
-
 	movq	%rsp, %rdi
 	call	error_entry
 	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
@@ -376,6 +373,9 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	idtentry_body \cfunc \has_error_code
 
 _ASM_NOKPROBE(\asmsym)
@@ -427,11 +427,14 @@ SYM_CODE_START(\asmsym)
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
 	 * a normal entry.
 	 */
-	testb	$3, CS-ORIG_RAX(%rsp)
+	testb	$3, CS(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
@@ -481,11 +484,14 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ASM_CLAC
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
 	 * a normal entry.
 	 */
-	testb	$3, CS-ORIG_RAX(%rsp)
+	testb	$3, CS(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
 	/*
@@ -543,6 +549,9 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ASM_CLAC
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 	UNWIND_HINT_REGS
@@ -855,8 +864,6 @@ SYM_CODE_END(xen_failsafe_callback)
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
@@ -1269,6 +1276,9 @@ end_repeat_nmi:
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	/*
 	 * Use paranoid_entry to handle SWAPGS and CR3.
 	 */
-- 
2.19.1.6.gb485710b

