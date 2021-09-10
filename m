Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928B1407401
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhIJXmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhIJXmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:42:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E78AC061766
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f83-20020a25cf56000000b005a0445377e8so4563465ybg.20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rf8jBzZ3eApLb3r5KnUpdRGXEBCEtWsNOWspCDCC/hg=;
        b=iqyF5u4wdkWsWReDGSW9MUA+WQOiWcxgHCBVwiiDnpI0vHJQVskfCl6UZaSZqm9Scj
         7cKa+WF7J96p1yPKEOT2MtqtmpIn9oN3I2NYAV8kHk0QFOCOaZpQv9Gdtgq7fEJGvYK3
         /5HmSMj4tyiBa5Ne+wwBQcLYERfesHxGFyN2JLEgMUN6xyoe0RHNcif07jPx+MKGERUP
         XFcibR/9WZNK3guf7dCnmYs0cX7hGaMFn99TvNA61dhpxpIBt3Lze67A7ysgVkKjoJFl
         xQuCdcrgJuOBIye9Bo2d7LmH3nUJuRcYKRFlp/cjlpEi8sx6x3jXjyg+8bNliFVA0ekZ
         ogug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rf8jBzZ3eApLb3r5KnUpdRGXEBCEtWsNOWspCDCC/hg=;
        b=4327xHtMdopRQ/aI8tT3rNZMaOFP2yXfajGYc0MuD3KZ7QEyEptk45j8jAL0AWgi29
         aj/aehCaG6v0FoBjFRkxklGxbd9+9iFCPvZ8978V1R2/CwWHt/yhk/vR8ONl7RZwdgK5
         jhDZT+oWMpZfR11kyzMDD9bSVCAvIrm3riEaKI3Jz5Z/CblbKV6X9B/sady2DXNPWhgu
         Y0AXX6ZKaX0tDXdiSQb1amYo/Mix2bxaABm8VS+1ssn6j4jtfTFDrxpHkVyAw6MYLTKF
         pbq3l/EOt8iazbr/m5I9v/VTglrQq9TA3G8jVh8ruCO8QKZ/dKOWB4t2S8gYcZbZk8K/
         t3bg==
X-Gm-Message-State: AOAM533ng8oFPkqLtohpGRoAcwlxlbHaPH6zKb9HvqM1+uimWWNuLLnD
        DrHL3un9SnBfzau63btIF1gzsWglDVT9GlOTPN8=
X-Google-Smtp-Source: ABdhPJzWzEopVMUHgYzbEm//5d9xq9b3aDazQBNoqRBs7cxPv6GU3P6c/aYjtmlVCsMnxpWGfxhy4bNDsHlRSVGixQc=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2b76:71d3:b5fb:3734])
 (user=ndesaulniers job=sendgmr) by 2002:a25:c6cc:: with SMTP id
 k195mr340980ybf.153.1631317267872; Fri, 10 Sep 2021 16:41:07 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:40:44 -0700
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
Message-Id: <20210910234047.1019925-8-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 07/10] arm64: remove GCC version check for ARCH_SUPPORTS_INT128
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that GCC 5.1 is the minimally supported compiler version, this
Kconfig check is no longer necessary.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 077f2ec4eeb2..5c7ae4c3954b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -86,7 +86,7 @@ config ARM64
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_CFI_CLANG
 	select ARCH_SUPPORTS_ATOMIC_RMW
-	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
+	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
-- 
2.33.0.309.g3052b89438-goog

