Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A891D3DE09E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 22:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhHBUXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 16:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHBUXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:23:48 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F1DC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 13:23:38 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q9-20020a05620a0c89b02903ba3e0f08d7so13952664qki.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 13:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=quBrtaOgjAqR5zBsPoxqwYQ7Dgoy04UF3Qc7dSvcQS4=;
        b=KjdDl7F1qjkZMvJSMo8co3v9t2uvyS6MH7doDW+Q+phYRB7qBgswVWmwdDfHgDl6gG
         OPZWFYTb45J5CmNDf7+T8ozjloBAbuKR3P6JvogVbk3wZQTFj72o3FAPk7gEnTXqiHZe
         lgtggXi+Gdv+wegMQcYFr5MjylaY4hUv4Q4FaahAaiLkdjDSc5jmSCiQuQf6nm2POS76
         3d2LixcFaSZef1a8LXeZyioExDS/hDfJ95BOL5zApspS22Zy6LfHk3onKMGWijWT98iH
         ckNZF13xwsr0iViX9EUUFYboTf8BMGitTzOhW5CjhTNoTSvKKl3Ve0KpVfEv/6VuKfm6
         7FNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=quBrtaOgjAqR5zBsPoxqwYQ7Dgoy04UF3Qc7dSvcQS4=;
        b=G7Z63KxgoWNeCD0XaaTiRX5DkRr6KR7Ezg1+CXIMAxeCcWcvFz0MicRDKXA6ADEvim
         YhwqXaKOWRND6OCE/eMPT9iBOis74+S1kai4gqV+c82FAWFcDmETNuF7UwK4gukMBNxE
         N/bN58xumbwJh68kR4sRvutGhx4UhCOokEIrkUMGbKIHcSO6TGknXwFBfwpPf0W86oXK
         L38e9AA03oATFCYdWmHVbxioVeWGzwboN0LoHTE3KUsRn+4mdrGeLEDKDgjwAYRYm4sI
         E2eJ43w1BqpdSSKT+YuWNxvxIrz85sikbE2v00FnBY6JsFy/wBPm2KGBnHTODyVMarK+
         D6WA==
X-Gm-Message-State: AOAM533gYdq6TbXeHm1bmwuuXyljseJ/FztjljUh7NRRZKAIsfmzZjQp
        JokVCBEPw4P/wg8+XM1vu45mviSAS2KHu0lNl64=
X-Google-Smtp-Source: ABdhPJwigrBubrndrKFDrxT6WVgfac5ftF9BwiF9ExJ/Q+35W8R8RwFhc5veoITKngyKKlVPSjXr+DLABaJPTXtBTPU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:3db0:42c:8665:a4ae])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:b408:: with SMTP id
 u8mr7832672qve.33.1627935817494; Mon, 02 Aug 2021 13:23:37 -0700 (PDT)
Date:   Mon,  2 Aug 2021 13:23:20 -0700
Message-Id: <20210802202326.1817503-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2] compiler_attributes.h: move __compiletime_{error|warning}
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
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
Changes v1 -> v2:
* Use __warning__ rather than warning in __has_attribute check, as per
  Nathan.
* Don't sort existing __GCC4_has_attribute_* defines.

 include/linux/compiler-gcc.h        |  3 ---
 include/linux/compiler_attributes.h | 24 ++++++++++++++++++++++++
 include/linux/compiler_types.h      |  6 ------
 3 files changed, 24 insertions(+), 9 deletions(-)

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
index 67c5667f8042..fb08b843ab47 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -30,6 +30,7 @@
 # define __GCC4_has_attribute___assume_aligned__      1
 # define __GCC4_has_attribute___copy__                0
 # define __GCC4_has_attribute___designated_init__     0
+# define __GCC4_has_attribute___error__               1
 # define __GCC4_has_attribute___externally_visible__  1
 # define __GCC4_has_attribute___no_caller_saved_registers__ 0
 # define __GCC4_has_attribute___noclone__             1
@@ -39,6 +40,7 @@
 # define __GCC4_has_attribute___no_sanitize_undefined__ 1
 # define __GCC4_has_attribute___no_sanitize_coverage__ 0
 # define __GCC4_has_attribute___fallthrough__         0
+# define __GCC4_has_attribute___warning__             1
 #endif
 
 /*
@@ -138,6 +140,17 @@
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
@@ -299,6 +312,17 @@
  */
 #define __must_check                    __attribute__((__warn_unused_result__))
 
+/*
+ * Optional: only supported since clang >= 13.0
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warning-function-attribute
+ */
+#if __has_attribute(__warning__)
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
2.32.0.554.ge1b32706d8-goog

