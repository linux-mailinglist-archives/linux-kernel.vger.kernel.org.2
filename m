Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72A043B464
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhJZOjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhJZOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:39:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77170C061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso2433521pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iv2xBEWgdsLbsGrbI1Ynj++RbyVyoOiqc5Pz0aTXiaA=;
        b=OtSYCdaDTSbq4RKOJJ+AV/w5/fCS7qcvuM7T4FnexJaftpDiOLW42FOvSqcTJEfDRj
         Z+PU8lmDZ7LaBN97jI1c+75rlktP2+Li7N9G8szacry90dBx3KOY5yWuFO/OBxp+mtdB
         nNCQ4Gkpj6te84rhEbE6ReDX8Ywhq9fN0ZaepJ62lnI46ycCWMkCv6vU8CC1wtqK6crd
         +cwZNPm++5ZCJFHeEZjm+KpFZ2KpZ3qJnVZAP9kTO4Pfq0s7tM0fUSnhTtwBrFCAx31r
         sVXuwxp6TWn5IZxnkOQx59mjI8tQ4uJst5e3J9a/rRZfbXSCXpzqXVETUoaD2FF1TPZt
         gzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iv2xBEWgdsLbsGrbI1Ynj++RbyVyoOiqc5Pz0aTXiaA=;
        b=0xrcWqF3+CWRlmEN544sWOfmS4Wa8C4FHkmiCgVQ/dFlLy33T4piBWTgarkdWR5QNU
         N1JPI/iK8iJ2QQUcmMYUxb4ZWoeYcS6Qnuwfs8r2iXM8zgwZgEL837V3Esl3ZFhhE3T+
         lZe9RA5X4Rrx3Ii0XFPZeuE0riKv45ljuxcQH9EFymRKV4MKdJc2xpxrcrP9qcW8Fk79
         RBdz3AS7C74A03EcXPB7kewgIbtwqSx+klELqUb2j0cm/LvHbmkN705CQ5zfNj6BlxMI
         gc1CCyvtXTBDADGlcLnPWAm8dhn8J/MjoiJrSkyKOgkLPkm3tBfvhA1ZEtkmLS2BPcQw
         3r3g==
X-Gm-Message-State: AOAM530sLru0pyOQ0ft6c1MHKG0g52haaUGmygotPUiSZudjm9mxjyis
        73aNGpCvWW9bSBMUQRiNsTVAis5jma0=
X-Google-Smtp-Source: ABdhPJygFz29MoOvCLhldjNVCyJsouKLEYn8o0P4paCo05VcFxq1maBwjvuRpjOQtTjLXLlqb4Nslg==
X-Received: by 2002:a17:90b:4a07:: with SMTP id kk7mr29054707pjb.37.1635259015801;
        Tue, 26 Oct 2021 07:36:55 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id p23sm12616547pfw.61.2021.10.26.07.36.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:36:55 -0700 (PDT)
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
Subject: [PATCH V4 44/50] x86/doublefault: Use C entry code
Date:   Tue, 26 Oct 2021 22:34:30 +0800
Message-Id: <20211026143436.19071-19-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE to emit C entry function and
use the function directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 12 ++----------
 arch/x86/include/asm/idtentry.h |  1 +
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0a1a55c8207e..57559d810785 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -575,16 +575,8 @@ SYM_CODE_START(\asmsym)
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
index c57606948433..931b689f464c 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -415,6 +415,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_DF(func)					\
+	DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE(func)			\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
 
 /**
-- 
2.19.1.6.gb485710b

