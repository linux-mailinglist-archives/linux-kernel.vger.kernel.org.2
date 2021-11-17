Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5CD454EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbhKQVF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhKQVFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:05:53 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4779C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:02:54 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y16so5072414ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p79Xp/FScKBOK1DdTtLvla9LFFi0dfV8yzNPcgUoSpM=;
        b=j6L7E/2VhafB3YXISK9ewKC/k9fDgMmotC9DnNaIsabuf5oNYRY2ZY74tsDOG8O/xV
         WqXLeKKwtApPTYcuXDG+sBngFLTWRAOjn2v4ejgsPCf+VmUf8jlgrSwEJe6N4zn0Dcdr
         zE8D6GBcXGlv/T3wzdGeVv8ZeuvbIcrexi0UMc5YPpt4ntOCke6Z62fvfbgCmXOg8LLo
         UD+uZbQMIOoUVVXkSKNv/pB11cMaiZeyAsxm7ShFwJYjJQvzApdqcot+Y4HtKHWuF42R
         K5G+9AYVsooj41o6fe5UvPNRQrrv4+nrg/dU308YJvjVJLQVZz2n4yZY0EoQz6vgt6/w
         hoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p79Xp/FScKBOK1DdTtLvla9LFFi0dfV8yzNPcgUoSpM=;
        b=Yx3Qsp2fOoQcMmIHlKHUZqTolkPbIdVgf2vOBNBoPXrZ+pBX5TfT2GFY+ClmSl1YWy
         Yi6joMskLOiu3EAErExXFnj8SciZ9d5uDaLw64xEBZC44ILyeKKkXa5pgjZHp4dh+QZx
         BH39btnQxIy2ucPZoOTh8UH+sKPnt58NIopQZOrTdmZkBve5x39aG6iwH2pIEsqIBd4x
         A2GmnbjYwOrkkEG+c4SKqFG/KGmNjqYTC6m6ZX322mNx2IcJYnLqs5MhR9KcA2Wt2MMK
         0swljOv3h6xaFoGYKkk4NHN9tDUqcZaQjU4crPjSiy4q2HZvjStI33ZQypq632RtVzMo
         izGQ==
X-Gm-Message-State: AOAM530xpImfOkwuucHAC45HKuqrBeTHV7eRDIJq5g+BagOADWpuMNzs
        WHqV/8AcU7MUjpTctK+D5amZletN2Tw=
X-Google-Smtp-Source: ABdhPJzK+gmT9BDpz8B35ahmycSSF4ahpfZFK+xkZ39Qi9EXzfnKIHYxZY9mSBUbq9OgM0K1xGomwA==
X-Received: by 2002:a6b:5c05:: with SMTP id z5mr13115639ioh.181.1637182974292;
        Wed, 17 Nov 2021 13:02:54 -0800 (PST)
Received: from localhost.localdomain (node-17-161.flex.volo.net. [76.191.17.161])
        by smtp.googlemail.com with ESMTPSA id b4sm535226iot.45.2021.11.17.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 13:02:54 -0800 (PST)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in memmove_64.S
Date:   Wed, 17 Nov 2021 15:02:45 -0600
Message-Id: <20211117210245.843374-1-goldstein.w.n@gmail.com>
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
 arch/x86/lib/memmove_64.S | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 64801010d312..910b963388b1 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -28,6 +28,8 @@ SYM_FUNC_START_WEAK(memmove)
 SYM_FUNC_START(__memmove)
 
 	mov %rdi, %rax
+	cmp $0x20, %rdx
+	jb 1f
 
 	/* Decide forward/backward copy mode */
 	cmp %rdi, %rsi
@@ -39,7 +41,17 @@ SYM_FUNC_START(__memmove)
 
 	/* FSRM implies ERMS => no length checks, do the copy directly */
 .Lmemmove_begin_forward:
-	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
+	/*
+	 * Don't use FSRM 'rep movsb' if 'dst - src' in (0, 63] or (4GB, 4GB +
+	 * 63]. It hits a slow case which is an order of magnitude slower.
+	 */
+	ALTERNATIVE "	\
+                mov %edi, %ecx;	\
+                sub %esi, %ecx;	\
+                cmp $63, %ecx;	\
+                jbe 3f	\
+                ", "", X86_FEATURE_FSRM
+
 	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
 
 	/*
@@ -89,35 +101,11 @@ SYM_FUNC_START(__memmove)
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
 	.p2align 4
 2:
-	cmp $0x20, %rdx
-	jb 1f
-	cmp $680, %rdx
-	jb 6f
-	cmp %dil, %sil
-	je 7b
-6:
 	/*
 	 * Calculate copy position to tail.
 	 */
-- 
2.25.1

