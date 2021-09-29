Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8241CC56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346431AbhI2TKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346437AbhI2TKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:10:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF081C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:08:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d81-20020a251d54000000b005b55772ca97so4687338ybd.19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2eiaoE39I+Y5USofHF5+1Zs2VxE4hHgvlRkoEd7CIRQ=;
        b=KSrPbkIQ6OQGiDM2rTJO7WdVzBUK3NiB43o6MbpAOmawS88BI7uRZbvF09yVFmUVEw
         sXrdN3mntfbhYB0B0+/K6vSiFcCAG344fHVF40bec51rOa8zjFMohnD/v9QX+0PJ7LHF
         pcr8/D4aCOrRFW82MBxn6JYULwgovVEP8p1t+vvdNZWfc3TFR4QcaQSUla6ZePTCg8jN
         cjWhE817yZzuI247eWhRvJ4VU6sPDapng4w1FpxenIXS8pRbAPMedOXmSCFmBjbVgpz+
         str6GLmP5ERAFqtmzpWPPpmq6bkzbAdIxjoS3SfqzWWE0Wyi26CAVbkK7oCIaZJbc0A3
         GDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2eiaoE39I+Y5USofHF5+1Zs2VxE4hHgvlRkoEd7CIRQ=;
        b=AQokyWnk2Bb+tYRREwzWVU4uGWACpQyRlMkA84lPZTEsIQU0MtgZ9lP33H+5thTn6U
         UWwotUa+k8QGQDTEWXIIl8xsMrhTwNGpF7FjMArgBdch5AA0AxNDv9MVP3t/III+d8EF
         dFSxDfFa5PAeKohxydk9cooJGRKOxYgu8MbMExakyMblZZ5X7bkesiZLULDAoiIfDDir
         UGT6VZ0bMav7B+e/ZViJ2S9MEnaL05kVL7jlm4UNC19ffY0YwH3VEvBbqsDN79ZsoJ2m
         XCSWgDnQp32t3GyAikUtIM3W9T0v9vxc7wEbG7YLEFhck+ZiaIu6InshXXjrBbKjn4Tu
         QUvA==
X-Gm-Message-State: AOAM533G1odduZsGO6sOtJpZrK0VZPkIVJ41Bvlke9rtio7rc+umQlRC
        PH/7nvTzwTwshJDfEk3PvOEXD0MYey0hULTcZsg=
X-Google-Smtp-Source: ABdhPJzcZTbQ1Oy3tQ3gFxSCJf3+SQLANXJ4xpBT1sdUk08dMyKduiPDL8QbtxfJsMs80UeqyJZwcukRQ+r1mgO51Zs=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:da31:1dfd:2e69:dc82])
 (user=ndesaulniers job=sendgmr) by 2002:a25:1285:: with SMTP id
 127mr1846238ybs.299.1632942498030; Wed, 29 Sep 2021 12:08:18 -0700 (PDT)
Date:   Wed, 29 Sep 2021 12:08:05 -0700
Message-Id: <20210929190810.1597399-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH] ARM: mm: proc-macros: ensure *_tlb_fns are 4B aligned
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" 
        <u.kleine-koenig@pengutronix.de>,
        Dave Martin <dave.martin@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QEMU 6.1.0 is more correct about trapping on misaligned accesses. A
kernel built with CONFIG_THUMB2_KERNEL=y and using clang as the
assembler could generate non-naturally-aligned v7wbi_tlb_fns which
results in a boot failure. The original commit adding the macro missed
the .align directive on this data.

Fixes: 66a625a88174 ("ARM: mm: proc-macros: Add generic proc/cache/tlb struct definition macros")
Link: https://github.com/ClangBuiltLinux/linux/issues/1447
Link: https://lore.kernel.org/all/0699da7b-354f-aecc-a62f-e25693209af4@linaro.org/
Debugged-by: Ard Biesheuvel <ardb@kernel.org>
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Debugged-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/Kconfig          | 1 +
 arch/arm/mm/proc-macros.S | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc196421b2ce..b760dd45b734 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -92,6 +92,7 @@ config ARM
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
+	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index e2c743aa2eb2..d9f7dfe2a7ed 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -340,6 +340,7 @@ ENTRY(\name\()_cache_fns)
 
 .macro define_tlb_functions name:req, flags_up:req, flags_smp
 	.type	\name\()_tlb_fns, #object
+	.align 2
 ENTRY(\name\()_tlb_fns)
 	.long	\name\()_flush_user_tlb_range
 	.long	\name\()_flush_kern_tlb_range
-- 
2.33.0.685.g46640cef36-goog

