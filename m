Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB342D10D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJNDiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhJNDiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:38:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00388C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23so3806941pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qdPX6leSrxZFRthtIVsp8vJTUvVJ0ZjU2fXlZEYPiA=;
        b=BiWvxTQjs4ZIO9YAKSkRdOArPks/CujmsJ2NRgRAJykNjbSynP4367pQkVcN7Z1Y21
         w4WQVqSNFERwdlPWhqpnFcyVaA1XLm8arGKnRtQCfjJVczEURjLkqwwI8f/KNID0QxGa
         ZOsMEAYKpnSUq4pq4PX1XJYZY8VYY65P1xNT56UNjA13XJDWB7mq06DzJtW9ghaMJU4q
         SPWgkn2+jbQYwTAggIO6zTkVRkjhOMBs52zPFvyfpkEHBnYEzL7goOvJLfMyRECMaumm
         7SAXGJ7V5svgJ8IZISDPqR3RDw+BEH+yDPQX49LzJWPpmT1TIJ52AH/NpPa7helpyM/0
         7kgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qdPX6leSrxZFRthtIVsp8vJTUvVJ0ZjU2fXlZEYPiA=;
        b=4v68Db0N6da/cw9ZUg7ZvT/OSbI63At17kXNFNLyNanMU3Zdyq8H+P3sP5MYoh0PYf
         QCLWvS3EMesqsYp3iq+BTVOhxmvWBKWSQRbedZYMRqI6TGGTl4w2tucTdAap//hMpfYn
         RWMrwjeT1J8NM6jzA8N6cnMMst21dlOGzsgyq/XLQDPYa1wLIrGcOCMW8IRSBnQkEObQ
         uOeigiLhQQFzZZuFQbWdMMYOv/+kt6emXr4tMCiDmho7a3GMqjc0HQRNIpsnSnh71xj9
         pQS9LT+eFvNhEUpzEnWpd4G4r7RRJb1ABZR9xy5HVfBKBbMGcpy9zg6LJ9iNrcOyM328
         oDxw==
X-Gm-Message-State: AOAM530u2JNL08iS0LthaOwhA3WLhaMRD2M/1mKS1fsBu2yyM8agiIE7
        pTNQHJgMDHGqFmhfW8E5JX+h2QEsDH4=
X-Google-Smtp-Source: ABdhPJwiAjqivvIwXLX+6a/6EKYLuk9USz4b6p35H2VoG2MImS1eTw59gkNowCiJo45igHD8gizpDA==
X-Received: by 2002:a17:90b:1283:: with SMTP id fw3mr935041pjb.99.1634182564399;
        Wed, 13 Oct 2021 20:36:04 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id i18sm837448pfq.198.2021.10.13.20.36.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:36:04 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 21/49] x86/entry: Move cld to the start of idtentry
Date:   Thu, 14 Oct 2021 11:33:44 +0800
Message-Id: <20211014033414.16321-16-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Make it next to CLAC

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1ec87d9e685d..52a08c4a0171 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -357,6 +357,7 @@ SYM_CODE_END(ret_from_fork)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ASM_CLAC
+	cld
 
 	.if \has_error_code == 0
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -424,6 +425,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ASM_CLAC
+	cld
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
@@ -479,6 +481,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ASM_CLAC
+	cld
 
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
@@ -540,6 +543,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ASM_CLAC
+	cld
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
@@ -852,7 +856,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -977,7 +980,6 @@ SYM_CODE_END(paranoid_exit)
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
-	cld
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1112,6 +1114,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	ASM_CLAC
+	cld
 
 	/* Use %rdx as our temp variable throughout */
 	pushq	%rdx
@@ -1131,7 +1134,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	swapgs
-	cld
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-- 
2.19.1.6.gb485710b

