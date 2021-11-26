Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1D45EB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376978AbhKZK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376902AbhKZK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA382C0617A5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:59 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x7so6929448pjn.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rCkRBT1ewWNs7zRxZWpMWeOlOvzrg8b7n2lNR24YNW8=;
        b=aai6qHJU3U7D9+mNS/EruHIPVuuFJpvNJuN6PASmbXoqMLe2qheQPVO1IiHamuHWky
         Vqu/905ViVb2wG4zqBtIcUycjrmhpp2yijve716lXTIcyFO/aM35McG+a2rPP3jnss2r
         Wem7HYXEvCxO5vSy4gjal2Y9JKWsk68GmdqwSt5a8TRG7b4W2nzR82jOIfKIkVe/HzCI
         54Vvu7AOC1+mFQfKFPIdTbaLMcFj0/Ao20s+EbFtzDbd9cq3yjRL0JVnv/xhGveXQTKN
         lMFfCVB/0yG6JWJL6TYf8h1Y1yinHIEPMRLeBUj3YZrR8yViVvpvNi+msll1gmMjpO2+
         8rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCkRBT1ewWNs7zRxZWpMWeOlOvzrg8b7n2lNR24YNW8=;
        b=4MBOoILo3LYzq9WhF7tgp38lep4Klgi4lgrbfDOMCVmzvRLxpr4WV3ATKjtbJ5Tjea
         PWT2UwFQsKYr/iczMtOQ+2uZLbgkzn/Fy4nb7XtSH9cVRKC9LgkfjXtE39Ay2ZXlYsiF
         q8HhXkBvjygsEGNW1Qiaibjzj5QT6YFEMRNmBUvkUiOD00LD2OMDw0ygAbCyV91T4ud/
         /GkaqXzFOw6ztuKPJBrNwQR2veXO6li3/UyoZgVdFOGMfmfSNcm9RkdqrE4MdMtsJD/A
         3MWRNAtTz6jXWrUW44nfO0NSCC2tLRrChyVP7tQwgOu4gttv3aMnZR8hzuUwGyncuzkJ
         iRvA==
X-Gm-Message-State: AOAM531ROPLIbp2ghrzit/PMMjxeLwOsjm1ldX7AXuuRtzf7go/xqTFZ
        qdJcv9VBZ9J6W+INzsnmYOfAr0EmpYI=
X-Google-Smtp-Source: ABdhPJy9bx4D2rGSvFKuhwzb7jSfZpTy05IPmcSFHPY0+iu1z7bmcIhRhekzPAVNLE9wLUnDqjY7ew==
X-Received: by 2002:a17:903:4043:b0:142:4f21:6976 with SMTP id n3-20020a170903404300b001424f216976mr37213900pla.62.1637921699172;
        Fri, 26 Nov 2021 02:14:59 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id f2sm6798328pfe.132.2021.11.26.02.14.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:14:58 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 29/49] x86/entry: move PUSH_AND_CLEAR_REGS out of paranoid_entry
Date:   Fri, 26 Nov 2021 18:11:49 +0800
Message-Id: <20211126101209.8613-30-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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
index 9fda034f3e92..bd5e005316a3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -322,9 +322,6 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
-
 	/*
 	 * Call error_entry and switch stack settled by sync_regs().
 	 *
@@ -403,6 +400,9 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	idtentry_body \cfunc \has_error_code
 
 _ASM_NOKPROBE(\asmsym)
@@ -455,11 +455,14 @@ SYM_CODE_START(\asmsym)
 
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
@@ -510,11 +513,14 @@ SYM_CODE_START(\asmsym)
 	ASM_CLAC
 	cld
 
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
@@ -573,6 +579,9 @@ SYM_CODE_START(\asmsym)
 	ASM_CLAC
 	cld
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 	UNWIND_HINT_REGS
@@ -887,8 +896,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
@@ -1304,6 +1311,9 @@ end_repeat_nmi:
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

