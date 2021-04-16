Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2BE362966
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbhDPUfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbhDPUfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:35:52 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C1C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:35:26 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w3-20020a05621412e3b029019a7b97dd69so4946031qvv.14
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=Q8aau1UBqJXGOugSq4JjsK2GmL5sgcCnZiQBPgmr8g8=;
        b=sV4uzzHjkUs767u8LSJDe2EEyB8nEWkAdKuccwVxsSuKhlm+K0SrC9kAfpfS0J3B5A
         8/F4pJIh/JBrv1dtYN+MyibvnL1iMLoytfTG9GyNCkzvFHJG1J9iTrT2wOTAUhsMdrwY
         D6+FY4M0G2f2wXZzXhMn48tVjxymClzfdy4sKCFUKEkvptF/EEWg5qd4ujGJBmuoyz7U
         eAPszhi+dxgmH1ntQ/7IFHyNTMQFJlCDiDMvKxRuQ+fvT1ezshHnx0CVhIehOrMaa3jM
         nV3h6ITf1jtfB2m5KP1lC4yp1CRs+vg1ySfN6ua4njHZDgVC1w0BDoLaEeKoGwxnljZW
         GQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=Q8aau1UBqJXGOugSq4JjsK2GmL5sgcCnZiQBPgmr8g8=;
        b=PTGIe4SWwi6IwClXmVW2m9ABH0AlkWml9G/7OL02IM/a/NaHYWEecg5BFwM1Tznd3M
         dgmp1RKrhI+HhuaYFccVSAYbz1GhNM1rwRxfx68kfj1ryw0ngUj5kyq3AVcFO5/G7aC2
         0+LRl65iXRoa8BL8+SgOTZDah12cBkl+pCi4G0ynp+vfZhueEV0gOBaGMsHok7pZUhNq
         lOmKVVVnO0Y8y6cBPzVZ8h75pbp0oRLcIJEOw62BYpmXHWkrJfKkYaZevHGIEzPxYxGW
         qq5BNAMGCxMkDoS7T7fo2vF/7qz74Cw/1hwFEQ80eGdXsXvLmd5ZRDc6B7VSGAh1FgUB
         oGFg==
X-Gm-Message-State: AOAM531gVJ4q3hnj4etcOOl1BybFuYsTK2uUtH3DezVKvncWvLMxdBuC
        hryJYoXqTyzhfb9zxVswTT8Ifw+BS1Hz
X-Google-Smtp-Source: ABdhPJzvyYpeO+bjD50fx+JSx7mt0QB2dcO4rSN29yNXOgFwiiVFWiAn0/Q2yZCLnvhRfbXv7sKNr4v7ZWe6
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:a547:67f6:5e32:5814])
 (user=jiancai job=sendgmr) by 2002:a0c:c707:: with SMTP id
 w7mr10808461qvi.11.1618605325023; Fri, 16 Apr 2021 13:35:25 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:35:21 -0700
In-Reply-To: <20210416181421.2374588-1-jiancai@google.com>
Message-Id: <20210416203522.2397801-1-jiancai@google.com>
Mime-Version: 1.0
References: <20210416181421.2374588-1-jiancai@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2] arm64: vdso: remove commas between macro name and arguments
From:   Jian Cai <jiancai@google.com>
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        sashal@kernel.org, ndesaulniers@google.com,
        natechancellor@gmail.com, manojgupta@google.com,
        llozano@google.com, clang-built-linux@googlegroups.com,
        Jian Cai <jiancai@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jian Cai <jiancai@google.com>
---

Changes v1 -> v2:
  Keep the comma in the macro definition to be consistent with other
  definitions.

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

