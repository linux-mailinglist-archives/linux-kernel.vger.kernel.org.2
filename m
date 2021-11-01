Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4AD44206C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhKATDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhKATD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:03:27 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E86C061766
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 12:00:24 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id f10so14981240ilu.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BI1t6N4/Dv1CDbuDSlkxaD99yT0h6PRCgahTfjTQ7QA=;
        b=iY6PFKUsJYjYcVi3mHqsbTNol8UO2NVHRSUgO/P37LnNcysIhu2LOZPf02LkhHg6NO
         FWxMijNm/3LNserAzoHRvMckvVU0R7muDcnkx3YT/HpPvxBS7UZccdOsWxEKUCwxg6Dk
         XpBIz37NXPJiry3u+m5HwcvYvfysWiO0AoxMVxMW1swTQfMZucXOYxQSBjLC0ocV6cg+
         52pyqLju+AAKmpfPDrr8LYEwUlX/EoKLHKZ4HL7XXoTSQczzVs3ZeQMa5iW2y6MlKrfN
         qnuAlMfx7+t1/bXZxmnUklHMto9HVhaLLMoUWVXO3t/QbEbZluUegGLT3YvZER/vPxpE
         7uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BI1t6N4/Dv1CDbuDSlkxaD99yT0h6PRCgahTfjTQ7QA=;
        b=29Bqd6zW1Ed+jTJCVACCP18IlXh7kDfntzLknFvFGb8PggBhj68QZhN6g9Zl3ZDGZ4
         bPNJ4M7IsI2k5RNfQqrQd4Jj9CVNyV5iZYM7BMj+1Sgp/XKIsnsDu/lPmGemAn+AzaiY
         l2+4bynDXaS7lcfg46EKSoD0yXq84kitoRzFBrAHj10+q/ujgLXBN1lNWqf9ZayqElAJ
         mkIIFYJR07DXRvd61u69Z+g72+zcE9raVjyosZBTV4RjgOGweIVF737nRfegCKEPWKuf
         6lFeqbVrlSRlyyliaxt+C+y2yi5fOpXjjz0uB3Vz/cj+wXOOrAAEKWy/tqp4TR37tX/I
         oaWw==
X-Gm-Message-State: AOAM530O+D0QNWqe5iaoj7LE7TXxKTKYCGSr8dBvX4dS64yXOE5gzzQ5
        LOtsYKwaRo7iT+ocbJs4cKo=
X-Google-Smtp-Source: ABdhPJzkpByWVzLC/uS+oz29qOiX3ILQ606VezhODcbH4HvtWLKBszmvtqE91IcI/ttW9O9BT4Z5Ow==
X-Received: by 2002:a92:d64d:: with SMTP id x13mr14143088ilp.42.1635793223741;
        Mon, 01 Nov 2021 12:00:23 -0700 (PDT)
Received: from localhost.localdomain (node-17-161.flex.volo.net. [76.191.17.161])
        by smtp.googlemail.com with ESMTPSA id g11sm9139531ioo.3.2021.11.01.12.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:00:23 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arch/x86: Improve 'rep movs{b|q}' usage in memmove_64.S
Date:   Mon,  1 Nov 2021 13:59:33 -0500
Message-Id: <20211101185932.2367578-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
References: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for "short distance movsb" for forwards FSRM usage and
entirely remove backwards 'rep movsq'. Both of these usages hit "slow
modes" that are an order of magnitude slower than usual.

'rep movsb' has some noticeable VERY slow modes that the current
implementation is either 1) not checking for or 2) intentionally
using.

All times are in cycles and measuring the throughput of copying 1024
bytes.

1. For FSRM, when 'dst - src' is in (1, 63] or (4GB, 4GB + 63] it is
   an order of magnitude slower than normal and much slower than a 4x
   'movq' loop.

    FSRM forward (dst - src == 32)   -> 1113.156
    FSRM forward (dst - src == 64)   -> 120.669

    ERMS forward (dst - src == 32)   -> 209.326
    ERMS forward (dst - src == 64)   -> 118.22

2. For both FSRM and ERMS backwards 'rep movsb' is always slow. Both
   of the times below are with dst % 256 == src % 256 which mirrors
   the usage of the previous implementation.

    FSRM backward                    -> 1196.039
    ERMS backward                    -> 1191.873

As a reference this is how a 4x 'movq' performances:

    4x Forward (dst - src == 32)     -> 128.273
    4x Backward                      -> 130.183

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
Mistake in V1. Had forgotten to remove the logic jumping to backwards
'rep movsq'.
 arch/x86/lib/memmove_64.S | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 64801010d312..90eb2487fde2 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -39,7 +39,16 @@ SYM_FUNC_START(__memmove)
 
 	/* FSRM implies ERMS => no length checks, do the copy directly */
 .Lmemmove_begin_forward:
-	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
+	/*
+	 * Don't use FSRM 'rep movsb' if 'dst - src' in (0, 63] or (4GB, 4GB +
+	 * 63]. It hits a slow case which is an order of magnitude slower.
+	 */
+	ALTERNATIVE "cmp $0x20, %rdx;"
+				"jb 1f;"
+				"mov %edi, %ecx;"
+				"sub %esi, %ecx;"
+				"cmp $63, %ecx;"
+				"jb 3f;", "", X86_FEATURE_FSRM
 	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
 
 	/*
@@ -89,23 +98,6 @@ SYM_FUNC_START(__memmove)
 	jmp 13f
 .Lmemmove_end_forward:
 
-	/*
-	 * Handle data backward by movsq.
-	 */
-	.p2align 4
-7:
-	movq %rdx, %rcx
-	movq (%rsi), %r11
-	movq %rdi, %r10
-	leaq -8(%rsi, %rdx), %rsi
-	leaq -8(%rdi, %rdx), %rdi
-	shrq $3, %rcx
-	std
-	rep movsq
-	cld
-	movq %r11, (%r10)
-	jmp 13f
-
 	/*
 	 * Start to prepare for backward copy.
 	 */
@@ -113,11 +105,7 @@ SYM_FUNC_START(__memmove)
 2:
 	cmp $0x20, %rdx
 	jb 1f
-	cmp $680, %rdx
-	jb 6f
-	cmp %dil, %sil
-	je 7b
-6:
+
 	/*
 	 * Calculate copy position to tail.
 	 */
-- 
2.25.1

