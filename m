Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF044C09A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhKJMDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhKJMDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:24 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363BDC06127A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so1481214pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAn3vfiaZfcMYiuIkw8EeNN2gx46F0qh2+zND/QhCg0=;
        b=aB0ONDNlVI2mMoUizSwACie89vO0Ppt8cD0K3LEc8GN33YFn52yhIvMueZ14zlwVa0
         faZ1TcTvW9rfuOgWzes7E8R6XzARHu0t1rbjz6nZnDKo4sAaqgOKOj9ocwArAgT0FFOI
         DYbnTGYzZmaeaoEYOvP9ZTce6KkVXSGIcmOaOOs1yDHQl3IXYJhp1diJLgVpcTU1nWWw
         eftUTVL5fg8Vr+EwUamTFtVJAhO65u+0s1OsAzUenNwS2q3XcfiBnk51RCZxEO+QvoMp
         07D9fKEdZM4TIDMMygz5vBmEU6yk2S5hSgWloAI31rKllLOkdAzUkJ1jQjmK9qeA7HOE
         DVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAn3vfiaZfcMYiuIkw8EeNN2gx46F0qh2+zND/QhCg0=;
        b=GQTxSJftcnguPJoZpQo3oi6Mc88l8j/NGP+6l8YxYAat2LJXDw742xyT1weXKyICee
         oQm4dIY1n9BxJY0lTbSPjWRfoL2Mt+60X7HzL2/hcCl3ifCLngE19dkAYh2/AiIF1/w3
         38CgaU/sayaP7bKI4oZsIl+lYw2XC6LR8u1Daf7ofsNUhDKHCC+wnTfsZ7+rX1HwhDlV
         n18pcPZIpTCdc3JlNkFTppJ332FoVeWTDjtbXI+3Glhyl1Engb6KA+P6ppKteXAasvfq
         pae4bHRwul7EvXLBgsMXtww0C5UJrtOno9MImCANhrSK2V7gAbgNGhkgGA6suVBPTRLC
         YCyw==
X-Gm-Message-State: AOAM532zXKNirhafpZvMwf2aN65Kqp7qBcm0PKSxNovVz4bu+dYq3tpZ
        GugqWmtmSGw+8I2ZEt9nIXbC5p4k6FU=
X-Google-Smtp-Source: ABdhPJyebRVQBJTGD+penwoxauJH8pfbdWAoMqAPBXsLBqaCGSPFnsKI9nYm0O9Wdsye0NeXeY7W0g==
X-Received: by 2002:a17:90b:351:: with SMTP id fh17mr16303680pjb.19.1636545636546;
        Wed, 10 Nov 2021 04:00:36 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id a11sm9235543pfh.108.2021.11.10.04.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:00:36 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 30/50] x86/entry: move PUSH_AND_CLEAR_REGS out of paranoid_entry
Date:   Wed, 10 Nov 2021 19:57:16 +0800
Message-Id: <20211110115736.3776-31-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index 3a434b179963..b6bcf7fcad34 100644
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
@@ -888,8 +897,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
@@ -1307,6 +1314,9 @@ end_repeat_nmi:
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

