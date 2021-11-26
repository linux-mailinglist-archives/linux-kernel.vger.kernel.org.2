Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F145EB8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376958AbhKZKbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377245AbhKZK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:29:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C2C0619E0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt5so6900475pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fn/owdtCCLGBwCXkQpr07Epfpgmly+vET3fJ1jsOIGM=;
        b=FkAY+szpsNOQEIcvSBZzixc6MbrUZlgDVE8JzZhA5Au89kXEZpRp1WIgtxwjisyO2N
         ERlHR5CCjLLYbr/mLTfULMxMXHCyl0UqcqagqIIXssDgpCwkQS52xjQoryV0iCvuhiz7
         o1D4s4vbeYazsqK5YX1NpvzSFqjMTuUi4gFSMWohFoGPSelZs1/0lL1TVrxi51teY6/3
         qZNjbWkF4es/TbaRfUUa/2lqzu33aTQbWbeFjbRKs7ieRTr85K4hSRkumIbvxltVBNy5
         fAtbrb3DR9yZyHRNLnaQLfwyjjNJ3BQuzC1cjayiEHE/F1xf9+vD2qqGyM2IJm7BJEAp
         uk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fn/owdtCCLGBwCXkQpr07Epfpgmly+vET3fJ1jsOIGM=;
        b=8C+Lgm56Nck6cuN9PE8vj7lCcNQC33kUSPctoa/6aj/kRuTja/78d9JZSN5Bh/wek5
         1VujjJVJwtnYwYx/MmGsbqxZ9RRN9aj39YjCZdkhe99/jJYbCLtmMysMs/sHeG7gY2ln
         V7kDAX94boWYSi0un3k+flXjc1WZeA1EovppdhB40tGnj9QIbDjz/Nz02ElGzcoEqpu+
         SsWdBcyLBNs8wfFhUllLch0AvmG5IZWu3OnLv/DT+wJ3xCBbc2FifWsE/wv8mX+dbFih
         moUGkw/QvTWJlpLvx5eMNRJY2RITiEvsUU8gDpdLUFAHY/gF9W40hflr55WXW71hy2te
         wqsw==
X-Gm-Message-State: AOAM531y1yrLQ4bZMT/ygazOkPM5zvvhnOGYrdjRx8BgSfE2M46/pyMb
        Zqt7nmy+fgRYAT7ClKfgy+YYT3yiq+U=
X-Google-Smtp-Source: ABdhPJyjxh0v9oYwxwvnE2UAG5PG9eUv13HsI/bbieMbtSQhU+fUnPRCHLKpykkMVEYTlyn/WayWrA==
X-Received: by 2002:a17:902:b718:b0:143:72b7:409e with SMTP id d24-20020a170902b71800b0014372b7409emr36089472pls.28.1637921791007;
        Fri, 26 Nov 2021 02:16:31 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id nv17sm11380599pjb.55.2021.11.26.02.16.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:16:30 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V6 43/49] x86/doublefault: Use C entry code
Date:   Fri, 26 Nov 2021 18:12:03 +0800
Message-Id: <20211126101209.8613-44-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ENTRY_ERRORCODE to emit C entry function and
use the function directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 12 ++----------
 arch/x86/include/asm/idtentry.h |  1 +
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cc552e23d691..5a9738218722 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -574,16 +574,8 @@ SYM_CODE_START(\asmsym)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
-	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
-	call	paranoid_entry
-	UNWIND_HINT_REGS
-
-	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-	call	\cfunc
-
-	call	paranoid_exit
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	ist_\cfunc
 	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 46b2ef021992..144f3a6d875a 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -415,6 +415,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_DF(func)					\
+	DEFINE_IDTENTRY_IST_ENTRY_ERRORCODE(func)			\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
 
 /**
-- 
2.19.1.6.gb485710b

