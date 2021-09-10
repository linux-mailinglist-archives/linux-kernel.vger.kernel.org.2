Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C956407404
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhIJXnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhIJXmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:42:25 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB4DC061762
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:13 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u19-20020a05620a121300b0042665527c3bso27689360qkj.14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KI6FERE75H2tLRM3WxhJHGnTaCX1rYLoA1+YNY2WdtU=;
        b=Wneq6nLtY2fi7biw5FFUeksmuAgLQ4myMnnpQuCOxbV7kuPgGZxYfQLwj/OHwDFAhI
         3WwF5caRL+QBMX7buPsJ5GNPXZ6nwvD21XfRKDyqnLP+1Kxyq+adTa0QBBIuBcIl5Iok
         H3AlVPnVRCJPBDGaof0KjO6nGE78IT40dK8lz4gZV2qOdYSjGPA5XlCzKNDJ7QvzdM48
         BRmFkyse7bykq84YCUdxr4Xmd9MA253Fgw/lROZLx+LPWQkIvRxPKODFP/ip1f/9nAn+
         sVFu0khIQOmEMrVfDdNjK3dTR2rvPvGygSxpDjjl1+zpynlaoGeo+WDypDPtIenpLYIG
         tJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KI6FERE75H2tLRM3WxhJHGnTaCX1rYLoA1+YNY2WdtU=;
        b=uAL5PJB9Kq8Qqf91q4/Mx3DyziSi0SV09DO7SBLPe+2WJnv676p3HV5Otq7npnRxO/
         iVKNUlnXV8tM0xhK0zAV+Db3/IWg5kqFnFp/UEQ6E+5uPzhxqLQkfTrOiS0bBoxqctXd
         i3RFA8r3TBMGmgmExOu+Tuw9dwb3Ms+iwn1IxzjeISiOESA/nGccPxH+mj76VSbTQHMa
         pfQ9AVNAHFCEOgnI41eKA043IvVDNcOv+66RghxHUf3qRSl5BcipPUvftWkRScEmcWRY
         ZKqrPAvML27TRS1jFdFAiAInDo5rJMvvG+57HXevWY6hbgA4FDQuiOHo5swSaeCPyGcE
         yqJA==
X-Gm-Message-State: AOAM532qNplXS0fyk1DnBqvcQ46KW8L9kIq4nNc70NWfSGUFsIzkYvIv
        3QbFQFJoia5xViV0h8Dzyy8Bcixs72BB8wHVRzI=
X-Google-Smtp-Source: ABdhPJzKFYeyaWGf3gYR0EgtJzV4X0Xdp1dLJmFHxl1G2QvKxUR474k0YH7ZXkNoArEsMndUfbKJ/SG5cTxsuGxiYCU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2b76:71d3:b5fb:3734])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:1843:: with SMTP id
 d3mr11020849qvy.10.1631317272617; Fri, 10 Sep 2021 16:41:12 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:40:46 -0700
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
Message-Id: <20210910234047.1019925-10-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 09/10] compiler-gcc.h: drop checks for older GCC versions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that GCC 5.1 is the minimally supported default, drop the values we
don't use.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler-gcc.h       | 4 +---
 tools/include/linux/compiler-gcc.h | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 3f7f6fa0e051..fd82ce169ce9 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -98,10 +98,8 @@
 
 #if GCC_VERSION >= 70000
 #define KASAN_ABI_VERSION 5
-#elif GCC_VERSION >= 50000
+#else
 #define KASAN_ABI_VERSION 4
-#elif GCC_VERSION >= 40902
-#define KASAN_ABI_VERSION 3
 #endif
 
 #if __has_attribute(__no_sanitize_address__)
diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index a590a1dfafd9..43d9a46d36f0 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -16,9 +16,7 @@
 # define __fallthrough __attribute__ ((fallthrough))
 #endif
 
-#if GCC_VERSION >= 40300
-# define __compiletime_error(message) __attribute__((error(message)))
-#endif /* GCC_VERSION >= 40300 */
+#define __compiletime_error(message) __attribute__((error(message)))
 
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
-- 
2.33.0.309.g3052b89438-goog

