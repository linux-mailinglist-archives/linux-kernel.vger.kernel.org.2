Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DB1443965
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhKBXSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhKBXSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:18:39 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A74C061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 16:16:04 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id f10so711735ilu.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hh84rK9swenA+4tuK535O19jOyl4tGcN/r5eWGH5fg0=;
        b=WwJLbGGb3hLEgzdz3uPuXRFXv0XybtbGh5XxRKxk8bNB5YbDT3uuMtcWCu9NG3NV88
         wbneC4CF+nlXdFdrgQ6LqhMF6e7PgAKk+FjvP1PdizdV247+DQfpMMmdELAD2XJ6L4Go
         w+ZxjY0qr7iKPVUc/DbRDElK6xXQZLOSIk0NIq8C+N2GFq0z7yj6ia9OO6ShrblAlfX2
         y5aOc3fh41A/lVyveJBGxyj2SyB67rX7RC3NWA7TM70SZFXCiCxiD3YlyhMfIdsCv13X
         gZ/kS3wEvad78RYsGgXXJUub33ZrNLsP08iZFexz30Bs6cufpGRZLJ/OVhiG1rOrkLq7
         ECNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hh84rK9swenA+4tuK535O19jOyl4tGcN/r5eWGH5fg0=;
        b=gg9vec9fkpq783pc6sJqvCqjapLp98+neSEiYvotgHBBCfSnaSIp7Q1xgd7DzoKXF8
         7+c70VQ3/fx6oEmgGcBMGG9stlvdTgyGADGoB4M5fCwSvyuzJsZHwi66/1m/Hpu2nkOd
         hyPVQh/gPchfBEpWfUYeAnQoDjpKltDsb20l5vIeQnChn+KqaVLbCyUTrYS14aqJK/WC
         LSc4GogFTXHnobHFGwvrUuJ6kJ1xJP4cPb+CZVAkmyBNNGYvcwd3jjr8LGr5gNEmQuk4
         UW4bgtn073DZobqTppelxAGep+tUcLp5E25ZIzzZE+dMA+OT9K+n2BQkxnt4NDOBcDTD
         lZmA==
X-Gm-Message-State: AOAM5315LElTka+sP7an2JXVH1xA9wOg3Y41a3Zj2yuxEmgztJAjNlU3
        eSlmYnbDFnUXPuhL7pNR3rU=
X-Google-Smtp-Source: ABdhPJzPva0stEF2D0e6v9dD7VQmYMkCp2qzi/X+P4bm/F7B9KgnkguHtlCYXuC2yT2iDpC0Y9XyFA==
X-Received: by 2002:a05:6e02:174e:: with SMTP id y14mr19111606ill.89.1635894963900;
        Tue, 02 Nov 2021 16:16:03 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-38.near.illinois.edu. [130.126.255.38])
        by smtp.googlemail.com with ESMTPSA id d14sm295955ilv.2.2021.11.02.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 16:16:03 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] arch/x86: Improve 'rep movs{b|q}' usage in memmove_64.S
Date:   Tue,  2 Nov 2021 18:15:32 -0500
Message-Id: <20211102231531.2928510-1-goldstein.w.n@gmail.com>
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
Appears the included assembly needs to all be on one line.
 arch/x86/lib/memmove_64.S | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 64801010d312..8fb16a7d0ea2 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -39,7 +39,11 @@ SYM_FUNC_START(__memmove)
 
 	/* FSRM implies ERMS => no length checks, do the copy directly */
 .Lmemmove_begin_forward:
-	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
+	/*
+	 * Don't use FSRM 'rep movsb' if 'dst - src' in (0, 63] or (4GB, 4GB +
+	 * 63]. It hits a slow case which is an order of magnitude slower.
+	 */
+	ALTERNATIVE "cmp $0x20, %rdx; jb 1f; mov %edi, %ecx; sub %esi, %ecx; cmp $63, %ecx; jbe 3f;", "", X86_FEATURE_FSRM
 	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
 
 	/*
@@ -89,23 +93,6 @@ SYM_FUNC_START(__memmove)
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
@@ -113,11 +100,7 @@ SYM_FUNC_START(__memmove)
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

