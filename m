Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9193D013C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhGTR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhGTRYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:24:19 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17114C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 11:04:57 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id j16-20020ac855100000b029025bf786be09so110485qtq.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KpjJ2bgzMnvEH9mKSz/O9+Gc9lp8UavDthS0xl+uBNU=;
        b=tHHakVBUV5NtXlpHBk9g8GZhujitIm2/Fe4p6WzMYdopefAuN0E+OQb1ktdkayU2lJ
         i/RZuCOR0PzTbvbuSWEOn0lE3T3Mij+jCChhSHnltbu3reHtPMZlHZk7Q8iFMvSeygyq
         9zGKh1fSsQoOO3TIN/LhTGDFUpJ5JyvfPTpL2s9K56FOAbfqlmclBiy8R+zC0NoojcZs
         Vep/LeEaqWu/vHVfYGT9s31CcjnraGJRTCkYwieFH9ZYyWZij94T/IXMhxayse6esB3C
         sGvputFs4rVY5zxPSqEpBr15BJSmdlJ+nyp6j+PW52HQ5oPZg1YUnI72nKw/8xuVTyQV
         etcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KpjJ2bgzMnvEH9mKSz/O9+Gc9lp8UavDthS0xl+uBNU=;
        b=eo/P7Z9hSt6BpbW1LIBxzkYgqsBE26cmzaDOAQ0kRyprcBBkmZnsTBjr1YlcfedgpM
         C5d0tHrZm3dQdX2qXWiCR6BIrZvZfTeNs7NLC2i7nrjJf2lAjbKh29bw34O5+XvdcuKh
         e7Ha586iDCSY+Z3mIHuUDVB3r2EYyz+lmwr0af4FrJPKjE8cYJwxaw38yZ4OoYVZ8Wsu
         goXTv5LmwLdSuVl0Gt4vsRidwn8Kn2LC+/zovjl1ubZyWWRa98Vk7QEGmBbv4cINKbN+
         /ONdjozy+nLeVl8IIFBnUtEVt4bsR28gbg5FApfFnurTJhAyMYHq5F26GSLre1Zf9VOc
         lHmw==
X-Gm-Message-State: AOAM531w9Pbxa63SJ5X4bpDDKSAjq6/LZkEKaU1DKxwsN7fNTZqoDw6Z
        GRMHtK1bQHs42fFl4RgzVKCb1tfOoeyy3KDfKf0=
X-Google-Smtp-Source: ABdhPJyG6gXxyffBtwiODm4A5mH5hO9XBe1bOzOSD21KCICgsHntOhVKHUdvMWozhfLhhzW8E4zHMS/dovRsP5UFFgQ=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:cf0d:433d:7377:6a13])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:f0b:: with SMTP id
 gw11mr13341000qvb.10.1626804296133; Tue, 20 Jul 2021 11:04:56 -0700 (PDT)
Date:   Tue, 20 Jul 2021 11:04:34 -0700
Message-Id: <20210720180441.2893919-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH] compiler_attributes.h: move __compiletime_{error|warning}
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on adding support for __attribute__((__error__(""))) and
__attribute__((__warning__(""))) to Clang. To make use of these in
__compiletime_error and __compiletime_warning (as used by BUILD_BUG and
friends) for newer clang and detect/fallback for older versions of
clang, move these to compiler_attributes.h and guard them with
__has_attribute preprocessor guards.

Link: https://reviews.llvm.org/D106030
Link: https://bugs.llvm.org/show_bug.cgi?id=16428
Link: https://github.com/ClangBuiltLinux/linux/issues/1173
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Note that this feature hasn't landed yet in clang! I expect it to land
in clang-13 though soon. We can still move this in anticipation of the
feature landing, though perhaps the versions might not be precise if it
slips to clang-14 (though I don't anticipate that).

 include/linux/compiler-gcc.h        |  3 ---
 include/linux/compiler_attributes.h | 30 ++++++++++++++++++++++++++---
 include/linux/compiler_types.h      |  6 ------
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index cb9217fc60af..21c36b69eb06 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -43,9 +43,6 @@
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
-#define __compiletime_warning(message) __attribute__((__warning__(message)))
-#define __compiletime_error(message) __attribute__((__error__(message)))
-
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 #define __latent_entropy __attribute__((latent_entropy))
 #endif
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 2487be0e7199..5f474b593425 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -30,14 +30,16 @@
 # define __GCC4_has_attribute___assume_aligned__      1
 # define __GCC4_has_attribute___copy__                0
 # define __GCC4_has_attribute___designated_init__     0
+# define __GCC4_has_attribute___error__               1
 # define __GCC4_has_attribute___externally_visible__  1
+# define __GCC4_has_attribute___fallthrough__         0
 # define __GCC4_has_attribute___no_caller_saved_registers__ 0
-# define __GCC4_has_attribute___noclone__             1
 # define __GCC4_has_attribute___no_profile_instrument_function__ 0
-# define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ 1
 # define __GCC4_has_attribute___no_sanitize_undefined__ 1
-# define __GCC4_has_attribute___fallthrough__         0
+# define __GCC4_has_attribute___noclone__             1
+# define __GCC4_has_attribute___nonstring__           0
+# define __GCC4_has_attribute___warning__             1
 #endif
 
 /*
@@ -137,6 +139,17 @@
 # define __designated_init
 #endif
 
+/*
+ * Optional: only supported since clang >= 13.0
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-error-function-attribute
+ */
+#if __has_attribute(__error__)
+# define __compiletime_error(msg)       __attribute__((__error__(msg)))
+#else
+# define __compiletime_error(msg)
+#endif
+
 /*
  * Optional: not supported by clang
  *
@@ -298,6 +311,17 @@
  */
 #define __must_check                    __attribute__((__warn_unused_result__))
 
+/*
+ * Optional: only supported since clang >= 13.0
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warning-function-attribute
+ */
+#if __has_attribute(warning)
+# define __compiletime_warning(msg)     __attribute__((__warning__(msg)))
+#else
+# define __compiletime_warning(msg)
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e4ea86fc584d..b6ff83a714ca 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -294,12 +294,6 @@ struct ftrace_likely_data {
 #ifndef __compiletime_object_size
 # define __compiletime_object_size(obj) -1
 #endif
-#ifndef __compiletime_warning
-# define __compiletime_warning(message)
-#endif
-#ifndef __compiletime_error
-# define __compiletime_error(message)
-#endif
 
 #ifdef __OPTIMIZE__
 # define __compiletime_assert(condition, msg, prefix, suffix)		\
-- 
2.32.0.402.g57bb445576-goog

