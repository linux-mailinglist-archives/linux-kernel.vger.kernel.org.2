Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A03A407400
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhIJXm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbhIJXmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:42:17 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F5CC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:06 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h10-20020a05620a284a00b003d30e8c8cb5so27885559qkp.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YZFNZaYPd/he7w5UBJM9lcDxSfmiDtcXiMqEOq338Jg=;
        b=H1UyckYemEOk1oyzIQmj7UFWuIpswTx8cNx7nsRcwyXPFRqUlG2fqYJIv6VYr9sFdm
         m3UpTxocjB8afQ4Fndfs/Jd40MQKs/2xmpSbeZdf2iseG//mSB5+io/wcS3rd3wFGgn9
         1UqtU4N6Y2ZlJgL9NOPmk38lBzuKFFqpJLw/HBzZLHmJasP5/Yzj3vzU3RqNRdeuXy5v
         w1qrW/YJvGV+NqyCIRp4PnopGcKGdchMaSwiXAgV6xpvegaR6z/6R/ATcl6bJE24AyuC
         aJKAggT4Y8ZlinnpEcy7Au1CYlRsL4DQxk7gfNTaVXpZxM8KAYxCkTTibhFVK4lE/SY5
         RFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YZFNZaYPd/he7w5UBJM9lcDxSfmiDtcXiMqEOq338Jg=;
        b=j7x6Fw7hW33oR3mmS4wsA5uD0a5E9aWysdK6874+pfrGp1/37RJmq0aN9/Diu7GJca
         XXsRvBWrCom0aTPFtzl05kOiRDDLK8RB4g3iPhq0F10jpZ7XlcWuChlUFUOTG9fWYPWb
         oQBT8Gg8ZGV9nQEdI38BhMBYRrb1s6tx7K/OvNIogGP2Bq9g9bNaBXLEDMteL5/5Zq9/
         U/xpRWA/Oitpjv16Khz4upePrKx2aTt/ScABb2Q15tMlqO399otoNdSMsdYCE7GS2UrB
         +n7sreVmSGXjGqg8V4ReV6yZO8hqYLO0TiyVoc/fCfJ+XkWQiOqvRCosLut7VVbz0ZF3
         RgKQ==
X-Gm-Message-State: AOAM531CYBUMQ1nATf2XmHDD/sbqS9GJkspfRGrFopH0oIxiDESIv55l
        Lj+t+qhdnt9A98lc1hxf3ndagPGkOydZYu/eXF8=
X-Google-Smtp-Source: ABdhPJz6ElitxYBNsJgBjhqNLSWLWIZ6PP7s4iBODM2VeYjjSbItAEn46E/9kQl8RhKTgw7exy1/gynScmufZc9jtZI=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2b76:71d3:b5fb:3734])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:9d82:: with SMTP id
 s2mr10986321qvd.23.1631317265326; Fri, 10 Sep 2021 16:41:05 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:40:43 -0700
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
Message-Id: <20210910234047.1019925-7-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 06/10] powerpc: remove GCC version check for UPD_CONSTR
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that GCC 5.1 is the minimum supported version, we can drop this
workaround for older versions of GCC. This adversely affected clang,
too.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/include/asm/asm-const.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-const.h b/arch/powerpc/include/asm/asm-const.h
index 0ce2368bd20f..dbfa5e1e3198 100644
--- a/arch/powerpc/include/asm/asm-const.h
+++ b/arch/powerpc/include/asm/asm-const.h
@@ -12,16 +12,6 @@
 #  define ASM_CONST(x)		__ASM_CONST(x)
 #endif
 
-/*
- * Inline assembly memory constraint
- *
- * GCC 4.9 doesn't properly handle pre update memory constraint "m<>"
- *
- */
-#if defined(GCC_VERSION) && GCC_VERSION < 50000
-#define UPD_CONSTR ""
-#else
 #define UPD_CONSTR "<>"
-#endif
 
 #endif /* _ASM_POWERPC_ASM_CONST_H */
-- 
2.33.0.309.g3052b89438-goog

