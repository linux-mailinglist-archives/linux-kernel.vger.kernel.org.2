Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6D362BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhDPXYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbhDPXYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:24:10 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7716CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:23:45 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id h4-20020ac858440000b029019d657b9f21so7002126qth.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=DVncHoPx5+EyUufkGwgaIquQ4C3Uhbgcu8/fDiLmXpU=;
        b=o/UXDDFc9FYZj9YyDM3cIDhO1QRS3vvJjip5B7ugMfyGEo/zyvMjiZcTxz/PN+S3Gb
         +7/GjcY5Y5aJYO82ZJ7SPD1PK7UWvfR1pFeTicvyreqTYOtoBzOt/XOhG0H7xF8UyVje
         LG8ZREvaXgrorm4+3mOaOPldP0QcN307vBw2aR/e+rxzMDsp7B3N35o8CIUspY9h+/fA
         SrbVf4lzPxMwuJYyhCJiSHEUV4Kz6sXx/S8htvgawvdh5kWc1qjBR67v8qvpb7g8ho1+
         F08h611JPuQzXCHTgHG/QNm3sPp5L0yVpczYu9eJx0uIm/G8bA9qutVLiPiFAuAi/mSM
         BFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=DVncHoPx5+EyUufkGwgaIquQ4C3Uhbgcu8/fDiLmXpU=;
        b=Qx886zQc8JDt88IF/X7MwH74UO2mOdQa1DjtYPbkArW386zVuMJ7zSNB/ysIo5krh5
         KLdLpTAOaYP8Ru0Pwz2s9wY3wvd8QY0h3NzAxh1sav785BH2+AOkq+YBgl8zTLyw+F2D
         qBbWusMjAqNUIUz3IdVR600M7Z2P7EfvTyhTc/xCdEKjq9fxt5MbpiW/bukWCN+mxlbr
         +/GaCfNTLstK0vgvtW5zjajrn3rMB8Mm2w4WznbA241cU5I84Pi22tMsLhi3HT77mzZ5
         HirbTF6BTxRxLW9yVaFq8z388f5BDOzQ4R8ftJDPLJ6EOjZLF0cckd4RpfF3SShcM7gR
         s7+g==
X-Gm-Message-State: AOAM5312CEqL8cMroXJdDbbKzE1uhlKOqLV/s5x4uzrEerHb8+iq6CJi
        6S7qn8KovIi6kIQBar0KSyRTtxdzzSkY
X-Google-Smtp-Source: ABdhPJwJxehnHbNtxsD0d2q2fZxAAC4XTR7QeHRMNRnbUsoOFnaHHFlFFVcG2QaBGrVd8u2xGfWV7gMpFQwA
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:a547:67f6:5e32:5814])
 (user=jiancai job=sendgmr) by 2002:ad4:4e02:: with SMTP id
 dl2mr11045753qvb.27.1618615424541; Fri, 16 Apr 2021 16:23:44 -0700 (PDT)
Date:   Fri, 16 Apr 2021 16:23:41 -0700
In-Reply-To: <20210416203522.2397801-1-jiancai@google.com>
Message-Id: <20210416232341.2421342-1-jiancai@google.com>
Mime-Version: 1.0
References: <20210416203522.2397801-1-jiancai@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3] arm64: vdso: remove commas between macro name and arguments
From:   Jian Cai <jiancai@google.com>
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        sashal@kernel.org, ndesaulniers@google.com,
        natechancellor@gmail.com, manojgupta@google.com,
        llozano@google.com, clang-built-linux@googlegroups.com,
        Jian Cai <jiancai@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM's integrated assembler does not support using commas separating
the name and arguments in .macro. However, only spaces are used in the
manual page. This replaces commas between macro names and the subsequent
arguments with space in calls to clock_gettime_return to make it
compatible with IAS.

Link:
https://sourceware.org/binutils/docs/as/Macro.html#Macro
https://github.com/ClangBuiltLinux/linux/issues/1349

Signed-off-by: Jian Cai <jiancai@google.com>
---

Changes v1 -> v2:
  Keep the comma in the macro definition to be consistent with other
  definitions.

Changes v2 -> v3:
  Edit tags.

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
2.31.1.368.gbe11c130af-goog

