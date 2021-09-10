Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012404073FF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhIJXm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbhIJXmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:42:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA7EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 124-20020a251182000000b005a027223ed9so4553268ybr.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YcybJ36BhVQqnQ/Zp3BgBUwuPlp4Dytcf9sCPFcMjQI=;
        b=YgJpLsayXI0kRA30Qyay/Kq/6VBc852ZzPTDo9EzTjJTNtF9D0UVBAUgqY/mnDPOl+
         pGTUFD61EqoICDCAXs//AXw0PdPDQ06DEbrW0h4xmAfxhA1egiPkgqeuA7aKa8DqjerJ
         PkrJtScmhKJbvHhlEWfI0lnnSj1rsD/G/nSp5hmtW+wkXtRhBg9B1Pr1u9QjmvKsjABP
         4t5hd33qwRgzZ8nO7gWCYz+rmQJH3tPDL9uozMFUhmmG0u0lAtZvjl2tiHD4Tt+my1V7
         m0LFoef1gwGQFGCuSx+R+cF4s5MbzwcLeEGELfhig5F8S/YsXDwM6cw+dQEFKnbIgIYN
         tP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YcybJ36BhVQqnQ/Zp3BgBUwuPlp4Dytcf9sCPFcMjQI=;
        b=5sTTnG0gcHEQ3ycSKI8wIzY57yArOdbrUhWIguE1uXj5xEkjJEEi3bDequcDa1E7/Q
         GvWKxyHeYIAnPgUEbisBBc5FCIbmb7IWOteKSGxi6UWJyYdF1mnJaLx7gvZAY9FIQ2YW
         RKgPO+wn6CUlO1ZVqlri5JLOimsA60E9dPpW+8uY0IEZJacQ5igjgcgKP2ScP6/5eDJW
         C4ioQKJ59XiHlnyHSDjJeT+vpjRurVMIjJBnYXP5VHCXXEUZYeqZcBPjr43iEE/jiHrG
         mj9feJ4moaatVP8cBpZlp5J405szFFkA/SerxIRLzV2B34YNKzPt6J7VGihSY2gaF17G
         A8ig==
X-Gm-Message-State: AOAM532VV0b+YbhsyCB3EzRr2fZW8mSVm4Av2IVUUArW1AJpH2yuX/gC
        3IeCDRCa0xJsoVkbrc5qk82scQDrCHgG7ikVfqU=
X-Google-Smtp-Source: ABdhPJw0Jp3nHTv3ruhAHm4RkeseXcb8gI25D2fzseDBVW5d8S8nqZvDZTYEl37UNWxcGpM+JEUlWwmPxuiXFe7eVe0=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2b76:71d3:b5fb:3734])
 (user=ndesaulniers job=sendgmr) by 2002:a25:2302:: with SMTP id
 j2mr315979ybj.507.1631317263067; Fri, 10 Sep 2021 16:41:03 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:40:42 -0700
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
Message-Id: <20210910234047.1019925-6-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 05/10] riscv: remove Kconfig check for GCC version for ARCH_RV64I
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimum supported version of GCC is now 5.1. The check wasn't
correct as written anyways since GCC_VERSION is 0 when CC=clang.

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c79955655fa4..5fc1d0cc82e1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -235,7 +235,7 @@ config ARCH_RV32I
 config ARCH_RV64I
 	bool "RV64I"
 	select 64BIT
-	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
+	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
-- 
2.33.0.309.g3052b89438-goog

