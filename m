Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102A23FBE67
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhH3Vjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhH3Vjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:39:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E23C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:38:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o76-20020a25414f000000b0059bb8130257so3164038yba.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HL0bHPC7fRhw8NveiezJuSyRlf1c6pLI+gcpO0vq9Sg=;
        b=Vw0YkpLrhfKJfwJ/o+LiWW8iYhrqyu75s/mnuCG5dXhDSWakhU7/UrE0jtlsGXxnwG
         iXFjlGLD5voK5KlOSCK4ZCoSlj7CQb/vgAiUU20YSaLD1eCtY9Y8Y0MV1Z0BvQUN7ARe
         1m4VWFO7TQ32kIW91EXtJG1/9i6D5BtObjDDH1vqFc97HUye4X8oEo977sE3ieasNCwJ
         h1AY4zPaCQQkAR1W8AtIL1AFSHIAYEmD6Uu8sZREtW+Na0a/uHt6bCxqGuxezMU9dONu
         ZA6yM9sdwleWHTm1cx4DQmqGcwuFbjnHsanXtMOk5PE79GHtMzBcZl/wlo19kVyeUtGD
         eUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HL0bHPC7fRhw8NveiezJuSyRlf1c6pLI+gcpO0vq9Sg=;
        b=GFlvAuXw/cLIrJJR5p+W9AdvmWx22p+qKtPPYWvtnPGtaRoGpfCXpnmwVXm9y3B7Kd
         A0ARGoc14ociYGtz0maaS/a6HzB5blGoF042GY7Hto7NJ97Ti/C9R+aBmko+acal1zp7
         PoV4Hz45GwKbWbhkmEw+6bgaFzB8go3+tf2ITiI4w1BfcsF1L9BdQ6G14cmHNMqWVzNZ
         IYJ9eptramkghW/fq1AZaKQSZjRXMmD23B5LlYKv93vwiWFHR5cgxHXZOQ03Ka784VvH
         vS8oFHyLGJJIkqCjEHKN6rq1Nu6UD+vvVpH8B9AjahtrtFzIfeuWuHK6UV2G7OevLCjP
         g/IA==
X-Gm-Message-State: AOAM533t4WeAS4EN5/hhf4veDI+B4+stSvTqLqZkQWUi4ffOOaZXgBm/
        voI1Pwr+twwpaG1T5evPiQ/F0/KqdDcyGpjIJtw=
X-Google-Smtp-Source: ABdhPJwIA5lJ67dNvJNzo05E+2L82lp32fjkWAPFbwD9w2A4+dtklq/RlB9I1vIcCowqPvM40IWGjkRYSiC3hSZi58c=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:266b:6ef5:38a3:394c])
 (user=ndesaulniers job=sendgmr) by 2002:a25:74cd:: with SMTP id
 p196mr15254588ybc.454.1630359531173; Mon, 30 Aug 2021 14:38:51 -0700 (PDT)
Date:   Mon, 30 Aug 2021 14:38:43 -0700
Message-Id: <20210830213846.2609349-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH] ARM: select HAVE_FUTEX_CMPXCHG
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" 
        <u.kleine-koenig@pengutronix.de>, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tglx notes:
  This function [futex_detect_cmpxchg] is only needed when an
  architecture has to runtime discover whether the CPU supports it or
  not.  ARM has unconditional support for this, so the obvious thing to
  do is the below.

Fixes linkage failure from Clang randconfigs:
kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
and boot failures for CONFIG_THUMB2_KERNEL.

Link: https://github.com/ClangBuiltLinux/linux/issues/325
Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.33.0.259.gc128427fd7-goog

