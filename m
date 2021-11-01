Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B974412CF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 05:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhKAEwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 00:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhKAEwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 00:52:36 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95537C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 21:50:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h81so11288296iof.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 21:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IpLs+mUXRqXhfPFCU91C+C1ZEBIPtuAhTb26JScwZo=;
        b=IaaO5lcT6OHYWCp0dVua4XAdPezrMHbkkAkWynIWWt9vfFKcux7CrEy3vrc4HBCJm/
         7L7fP3lPQLgMVt5JnJgp3la6IuP9DNow1SnAK4/zEnwt60nRK4CHGkf97AsGMW/yoCbH
         MNatbpwb3fIqATFeg8modHs7+cc/2CLD2e3AyeW0emEV+qVRZMVmbAuy8YG+eWOxSbsl
         E5R92lrJzEmkbcaaUa6Lg8ogqIGWeVfIpIOSFmy9kXhVEuPEdWez86P1SUTolwbJjxd3
         NamizB5cmB6jlzCOZBSgS8ULh/0VGe3W9HCnPhe1p7wMHPT3/X1uGGRJP53poQ5vNiiY
         luJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IpLs+mUXRqXhfPFCU91C+C1ZEBIPtuAhTb26JScwZo=;
        b=iMvRoZV4XYFnPRnuTgvcFaRVINWYZqafaYI6229ZORfSnf5Mz2nYnvrJdw1uNDNFBh
         UniWXzKTAzFa04wJRk5xKCWz9qxVjva61b/ehVtOngSTJ/8I5l4T1EuZTjjxRr/zOtOG
         dzyvIxlw3+q1sWcd6lOKst/vERv3PTQlYyeUwqEmtMHKPFzbdeYjrF4pLpK1eh0vvnxK
         ENHtz7BkM+gVc707bzOR+6U4ZfrTvmnPc3Jiiuph8OWtWYw2ThWlbVDayZELkkM2lxOv
         V7g17mYHDxGu+ywt2I7lKqwpjZv8ZQa9N95NN+Hz4e+zZvw9qGHhroZK7B/N5QwRJL3T
         xQOg==
X-Gm-Message-State: AOAM532VWDRWD0YAeFkgbuC0TmLrx1KkiOGIVU8OwYCuw+nS58LXre/K
        NNXpg+Z4noUkcoHfGrTrB7s=
X-Google-Smtp-Source: ABdhPJzZF/wzzjjIHkVz/4/R8pjgb7FBUMHHlNSP/GiIRqz5I2pfebWyG23jk2fbsJJLAf0wTJvAzQ==
X-Received: by 2002:a02:cddd:: with SMTP id m29mr20377261jap.113.1635742203043;
        Sun, 31 Oct 2021 21:50:03 -0700 (PDT)
Received: from localhost.localdomain (node-17-161.flex.volo.net. [76.191.17.161])
        by smtp.googlemail.com with ESMTPSA id d4sm4088107ilq.76.2021.10.31.21.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 21:50:02 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] arch/x86: Improve 'rep movs{b|q}' usage in memmove_64.S
Date:   Sun, 31 Oct 2021 23:49:55 -0500
Message-Id: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 arch/x86/lib/memmove_64.S | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 64801010d312..9d5f3ec4db04 100644
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
-- 
2.25.1

