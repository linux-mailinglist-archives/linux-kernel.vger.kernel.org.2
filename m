Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7701A4189D1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhIZPNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhIZPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:13:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3804FC061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t1so15312898pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DT+e9M2eK0NHomO+EEj3+9HCUC38iBv51he10nC9V1Q=;
        b=ThQgUryISb41xRJpkZAp2G2ZzA/f3yvTXRk2tEIx+XkkTrY2GuemTZTfh6lAnFPMS7
         Fkn8m0yTq83pwFDC8CdEQ5cqPyoLffvBSyB+22Zw9DD6kQZ5rb7Ud1yLudJJW1+CYgyk
         Gv5mrNYyviZ9BiJmadJBIdASmQkU2LTVfDeUSzByYxhCHQSCCnXXtjWH2/B7FZHmSoUU
         Z8iTgx0zd76osaGuYCiywSLSemwh6B4n2looW1D49gjXxINQRqA85ejkPoJkK79OzAFS
         EyxafXS49Oda8dDqvwbTNrVyjUzNxljgUNVz9wg9ZhPdepNIzwTMJ2ZTaw6a82bkdmh/
         kU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DT+e9M2eK0NHomO+EEj3+9HCUC38iBv51he10nC9V1Q=;
        b=y80pMMld2LLdbZQ8R92FmlDVvwvdh5p6mWXJljcizAvB7rvbog7qkhnA4wSerEMF77
         yb1f2/5Fl+ZglQnQSLtqP8VQe55nSMnxNjEWy6w4S8cn0OG0o3xxuorwULKUwSLW0389
         uTQtSvu6Ue07DPp7DbMBemm9V6PRmVevSnMNC46WErBUo+aDvqVCflB2sOBoECT8GrzZ
         HIAbVA9SCptSCySH/qfSKxaOcPqBTpHRBhEs3L2u14yJcGBTFjbn3RLz+8uIsYQA5xd0
         6PNFTBSgIQAU+Pmfoo2XlwvcEhdYKtIG7Lwu5m9YYrDtciiHvZI1lcttEGX1WloEANEJ
         1wPA==
X-Gm-Message-State: AOAM531H3tz3WKIxaN1gKzzdYbgjCsNoaUZJwBFyDlJv4g8KVxTA4otw
        Ss51TCZRUPr5I++Ts7u+trHxk8DSHUN2sA==
X-Google-Smtp-Source: ABdhPJwLzelb0RltxSWto7BRweUQmlOtjuWDO5bMGg2LUYv1YuUy+8dg4crRNDB5pZttEKckaCmz0w==
X-Received: by 2002:a63:ea58:: with SMTP id l24mr12766254pgk.334.1632669106670;
        Sun, 26 Sep 2021 08:11:46 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id b13sm13379929pfp.82.2021.09.26.08.11.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:11:46 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>
Subject: [PATCH V2 28/41] x86/debug, mce: Use C entry code
Date:   Sun, 26 Sep 2021 23:08:25 +0800
Message-Id: <20210926150838.197719-29-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY to emit C entry function and use the function
directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 10 +---------
 arch/x86/include/asm/idtentry.h |  1 +
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index bd6bce341360..0ba788bb9857 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -437,16 +437,8 @@ SYM_CODE_START(\asmsym)
 	testb	$3, CS(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
-	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
-	call	paranoid_entry
-
-	UNWIND_HINT_REGS
-
 	movq	%rsp, %rdi		/* pt_regs pointer */
-
-	call	\cfunc
-
-	call	paranoid_exit
+	call	ist_\cfunc
 	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack and use the noist entry point */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b33e96e983c0..babe530cfa77 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -344,6 +344,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW
  */
 #define DEFINE_IDTENTRY_IST(func)					\
+	DEFINE_IDTENTRY_IST_ETNRY(func)					\
 	DEFINE_IDTENTRY_RAW(func)
 
 /**
-- 
2.19.1.6.gb485710b

