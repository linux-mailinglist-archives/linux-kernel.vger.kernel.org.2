Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB8B362982
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhDPUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbhDPUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50EAC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n13so7447471ybp.14
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J/3dnbJfzRIYPiLZ29JeQVmGqxNfmSrQVz3MPRfXLik=;
        b=C1v0nYpduTETBzAnfgkloqCZcO6Q97ocPxTXwj9rz0cYRY1dSeCrIo8x6XrDSS122V
         VJjSz9XLtPk0uN1M0YsByoXHb8rT8SVmZvaEdCP+Xem1YERoiy+SeqmSQBJxMeJe3/dM
         /KbpqMGJcGAPkCNc+0HeMq5pSfKRC2vEEA4sLcaqdR8dZ5HuCSA1VpRTGjMcxL7EFAX7
         pS6bZvDioUkNGAXCeCLKq3cc9TQtXI5m1Wkt57+kKfk68CGbe4EnisAGXfcTr7MeYTaS
         fISLtNo26AcbMWxaQqaIJhU8AAfRWVDgpJCXhIfKMxuREyB7HoL5PvGIFu6lXVBc5YX+
         gxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J/3dnbJfzRIYPiLZ29JeQVmGqxNfmSrQVz3MPRfXLik=;
        b=VIKp6Pd+3YpR4iC8m8GqE44usI7JMQcDfz56LIwvMobJfMFwrSI+dWtKvzadoMVo39
         EUKVV8MSCEBvUM1z7/k41/gj7Db+ojYtVR7d9nQteJZ5MFLkAW+ab892YrHh3lLTb76o
         Wd6dpFxhljazT6GM3QMkZdhii3wUw3M2cTXIwkM48IuX+COsaIDVO7BTHbtcLCHWZOlr
         RiT6y098tQbh0RpHM5bCjkpkzsop+WNzgZFMir2SF+NBWBK6yvG7kX3TTEBjnyFY7eBg
         2HBITnD4yt1g1Qxgv7giEZ2eKEVTQ9MaWhx8IWncLbYnMKmNZF9cdlFHMxq6MJmeV+jE
         RRfg==
X-Gm-Message-State: AOAM530+oXbD4WTUtKfypw7avuqgx28a6tGI1Dd/adDCwfsR0ygwbqgZ
        hIQaMiFgpulFaJu3pLNXw9BHB6o7QWprNCx8m9o=
X-Google-Smtp-Source: ABdhPJyGkURYC9hpCmMRic8vWKlPFMV4UVmYBjgU6nnKa+YbMY5uJGuz8n+jOaVSP0ulbCEmSFkr4i0o/RLDruB8Glg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a5b:94d:: with SMTP id
 x13mr1332772ybq.368.1618605544016; Fri, 16 Apr 2021 13:39:04 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:38 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 09/15] x86/alternatives: Use C int3 selftest but disable KASAN
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Instead of using inline asm for the int3 selftest (which confuses the
Clang's ThinLTO pass), this restores the C function but disables KASAN
(and tracing for good measure) to keep the things simple and avoid
unexpected side-effects. This attempts to keep the fix from commit
ecc606103837 ("x86/alternatives: Fix int3_emulate_call() selftest stack
corruption") without using inline asm.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/alternative.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6974b5174495..669a23454c09 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -496,23 +496,10 @@ extern struct paravirt_patch_site __start_parainstructions[],
  *
  * See entry_{32,64}.S for more details.
  */
-
-/*
- * We define the int3_magic() function in assembly to control the calling
- * convention such that we can 'call' it from assembly.
- */
-
-extern void int3_magic(unsigned int *ptr); /* defined in asm */
-
-asm (
-"	.pushsection	.init.text, \"ax\", @progbits\n"
-"	.type		int3_magic, @function\n"
-"int3_magic:\n"
-"	movl	$1, (%" _ASM_ARG1 ")\n"
-"	ret\n"
-"	.size		int3_magic, .-int3_magic\n"
-"	.popsection\n"
-);
+static void __init __no_sanitize_address notrace int3_magic(unsigned int *ptr)
+{
+	*ptr = 1;
+}
 
 extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
 
-- 
2.31.1.368.gbe11c130af-goog

