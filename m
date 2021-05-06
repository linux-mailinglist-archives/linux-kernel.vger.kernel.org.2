Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBE2374CD8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhEFB0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 21:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEFB0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 21:26:34 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79FCC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 18:25:35 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d11-20020a0cdb0b0000b02901c0da4391d5so2995428qvk.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 18:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bZuP+FAGH6WmI1ayAzXHtNdn5xidSckeCnHh+eJccBo=;
        b=HiQOtx4+gHkW3VRRuPy7Yqjjw6ldTSDofFO417RJKYHt9WvWBncqCPanYBcrZ6n02H
         SOe564uQyK8uaTOZ03eE7wpUPTx5EW1jfL0Sfs/cbT8t89PARXH/Yoc16HrQaN8k9Lxf
         abEv8B4HuEZl0OaiGbP6k013RCWXgzeEwls9jHhxIJjl52nt7C3Np0b9JSwh7mL9Xoi4
         z35kbVmvPuVpZYGRVDFslHfpcefBAxTs58ROSI533s+ZFf1/E8iBzBEXRtlZMnVohSFm
         2PHzowC6UqvFGuY4mBkM9dt44+ZkQUxEzQzPv1oqUwdtl3CH0zaLyh5VwOujofvpUuwQ
         WcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bZuP+FAGH6WmI1ayAzXHtNdn5xidSckeCnHh+eJccBo=;
        b=Z/NkpoK2uiHXnmippV3OW0Z9HNGCa5C+D1fEfHSqIaSqRPXIB5x11v55tC9vRRIqu/
         hmlHPE+U9SIJQPKy+0ga0QDTriKUtkPqJaryCLrmFoPbxpEEBe6KMEtTxC/a88C1jo28
         jiSULq0BBscgI9APsMB6HfXN7YhQtPVlvOfYCdUDD6LC2fgm1HNCD8wDqGef9S2jOOMY
         +xEWS38E5ampMhHpcbyKTqqUT3eY6l6/AnkX6yAGvSj31apyxUe5Rtsi0PRQbWwHwv1h
         WlwmC0XP0JUrYhWdlAm+6oDL89h2zN1YB1hbl1S9AFpcTjhuqINgQLMwyCk+SFiYlBHm
         PeoQ==
X-Gm-Message-State: AOAM530akpmh1OjuPhB667AinyeR6vQsXHUQHuFuTi4W/ayTIiyVtMKH
        XY2AW5JmOkmyUvAHZnylhza8YKN/pRna
X-Google-Smtp-Source: ABdhPJzfrzZuQ0cSH1tfNNKMzm3EQSrWHOrXtl3ZE3wJK5aAG7yWtXb71mWzAOIWtEqZlInCaCVelu1d9jBO
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:1615:40c4:8c3e:9e75])
 (user=jiancai job=sendgmr) by 2002:a0c:ff06:: with SMTP id
 w6mr1629957qvt.51.1620264334850; Wed, 05 May 2021 18:25:34 -0700 (PDT)
Date:   Wed,  5 May 2021 18:25:08 -0700
Message-Id: <20210506012508.3822221-1-jiancai@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 4.19 ONLY v4] arm64: vdso: remove commas between macro name
 and arguments
From:   Jian Cai <jiancai@google.com>
To:     gregkh@linuxfoundation.org, sashal@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, nathan@kernel.org
Cc:     stable@vger.kernel.org, ndesaulniers@google.com,
        manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, Jian Cai <jiancai@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM's integrated assembler appears to assume an argument with default
value is passed whenever it sees a comma right after the macro name.
It will be fine if the number of following arguments is one less than
the number of parameters specified in the macro definition. Otherwise,
it fails. For example, the following code works:

$ cat foo.s
.macro  foo arg1=2, arg2=4
        ldr r0, [r1, #\arg1]
        ldr r0, [r1, #\arg2]
.endm

foo, arg2=8

$ llvm-mc -triple=armv7a -filetype=obj foo.s -o ias.o
arm-linux-gnueabihf-objdump -dr ias.o

ias.o:     file format elf32-littlearm

Disassembly of section .text:

00000000 <.text>:
   0: e5910001 ldr r0, [r1, #2]
   4: e5910003 ldr r0, [r1, #8]

While the the following code would fail:

$ cat foo.s
.macro  foo arg1=2, arg2=4
        ldr r0, [r1, #\arg1]
        ldr r0, [r1, #\arg2]
.endm

foo, arg1=2, arg2=8

$ llvm-mc -triple=armv7a -filetype=obj foo.s -o ias.o
foo.s:6:14: error: too many positional arguments
foo, arg1=2, arg2=8

This causes build failures as follows:

arch/arm64/kernel/vdso/gettimeofday.S:230:24: error: too many positional
arguments
 clock_gettime_return, shift=1
                       ^
arch/arm64/kernel/vdso/gettimeofday.S:253:24: error: too many positional
arguments
 clock_gettime_return, shift=1
                       ^
arch/arm64/kernel/vdso/gettimeofday.S:274:24: error: too many positional
arguments
 clock_gettime_return, shift=1

This error is not in mainline because commit 28b1a824a4f4 ("arm64: vdso:
Substitute gettimeofday() with C implementation") rewrote this assembler
file in C as part of a 25 patch series that is unsuitable for stable.
Just remove the comma in the clock_gettime_return invocations in 4.19 so
that GNU as and LLVM's integrated assembler work the same.

Link:
https://github.com/ClangBuiltLinux/linux/issues/1349

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jian Cai <jiancai@google.com>
---
Changes v1 -> v2:
  Keep the comma in the macro definition to be consistent with other
  definitions.

Changes v2 -> v3:
  Edit tags.

Changes v3 -> v4:
  Update the commit message based on Nathan's comments.

 arch/arm64/kernel/vdso/gettimeofday.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index 856fee6d3512..b6faf8b5d1fe 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -227,7 +227,7 @@ realtime:
 	seqcnt_check fail=realtime
 	get_ts_realtime res_sec=x10, res_nsec=x11, \
 		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
+	clock_gettime_return shift=1
 
 	ALIGN
 monotonic:
@@ -250,7 +250,7 @@ monotonic:
 		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
 
 	add_ts sec=x10, nsec=x11, ts_sec=x3, ts_nsec=x4, nsec_to_sec=x9
-	clock_gettime_return, shift=1
+	clock_gettime_return shift=1
 
 	ALIGN
 monotonic_raw:
@@ -271,7 +271,7 @@ monotonic_raw:
 		clock_nsec=x15, nsec_to_sec=x9
 
 	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
+	clock_gettime_return shift=1
 
 	ALIGN
 realtime_coarse:
-- 
2.31.1.607.g51e8a6a459-goog

