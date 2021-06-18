Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111FD3AD5EE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 01:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhFRXc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhFRXc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:32:57 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F548C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:30:46 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o14-20020a05620a0d4eb02903a5eee61155so4804344qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GT5JptlSj0sw8R+tCH0fy57H3f0kVdV+hvtI1tBUIUc=;
        b=wVvV0Fa27Lb8Z2PV4NyLQF0JST7GyFqtwIfj5zFP8Eu3Xd2dSDFul/J5JcatnGCqBp
         WHzYKm7IJw9gZZ7RTvDfwn0Yh/hGoUEzSwjmzc1rPHCQoRrVcLOgABGbYfk5aZvmSLqd
         nG+DOtRKevSmvJQ3bhBaNDfnFORd+r4y7b9HyNathMtcpwzOUFgidNCS4w3ATAFXgbKU
         gZDXVkpQd8ENg99w2pJF6BpddYfpwMuwKQHAL512uKb8pUDS6IFhlddSTCYcNKf+TZl5
         T2q8gF1TV3Ceac2665HCszeNI48gex0VE0aHX97LJYAkY3YBmJH0eVtarlXN4h2hAzG2
         6vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GT5JptlSj0sw8R+tCH0fy57H3f0kVdV+hvtI1tBUIUc=;
        b=Vi2xJf5mTAzAFaJe0mjHZolZWlGi7gkPEDD8OdYusMBLxmQr6aNk0KeuCynnI+54Fo
         MnSFqkmIDbIT3FOzZFyGVWegFIDxOgcJr7tekuufdINhfc8fqZkJl1QQ3cdw3uYIEiAn
         khr+7vZHsNBUU9Kic0Gi77+qgy6/omO5RDxBoV0tzfaNPhjOh/iVaGaBQuhOlXATqVNu
         pKaZdbHwk3x3/HTX/DnxX3R4bT3spfe0yKYjxJWbvL/tDoY6GNtJoub+fx2GSD/8YGp0
         VnoSqhS8jT+AAjS9ho6v2PeIEhSDiReZD835cy9Qyt30YGIGS/b+qV7knot+94mETLev
         EEXQ==
X-Gm-Message-State: AOAM530cV1rQbJsafeal/3w663ghut6R7GesSzk4dXJoRNKCRPlK87Wv
        xo5muygC5u51B3Uh2Slhv8sLaoNQhI2sRltQ0Vo=
X-Google-Smtp-Source: ABdhPJzxlJWcj8oyBsJfqxL8nOlQwZvVqBAOvLuh7YDYpvbPPeYy1z90tcGn2hRA4kY1Kr+cbeWpGFgv0DeVM1hOqr0=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:7c41:e84c:8fcb:6664])
 (user=ndesaulniers job=sendgmr) by 2002:a25:bb08:: with SMTP id
 z8mr17100019ybg.188.1624059045337; Fri, 18 Jun 2021 16:30:45 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:30:22 -0700
In-Reply-To: <20210618233023.1360185-1-ndesaulniers@google.com>
Message-Id: <20210618233023.1360185-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210618233023.1360185-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 1/2] compiler_attributes.h: define __no_profile, add to noinstr
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Bill Wendling <wcw@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Martin Liska <mliska@suse.cz>, Marco Elver <elver@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Fangrui Song <maskray@google.com>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        johannes.berg@intel.com, linux-toolchains@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

noinstr implies that we would like the compiler to avoid instrumenting a
function.  Add support for the compiler attribute no_profile to
compiler_attributes.h, then add __no_profile to the definition of
noinstr.

Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Link: https://lore.kernel.org/lkml/20210614162018.GD68749@worktop.programming.kicks-ass.net/
Link: https://reviews.llvm.org/D104475
Link: https://reviews.llvm.org/D104257
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80223
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler_attributes.h | 12 ++++++++++++
 include/linux/compiler_types.h      |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index c043b8d2b17b..cf584a1908b3 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -33,6 +33,7 @@
 # define __GCC4_has_attribute___externally_visible__  1
 # define __GCC4_has_attribute___no_caller_saved_registers__ 0
 # define __GCC4_has_attribute___noclone__             1
+# define __GCC4_has_attribute___no_profile            0
 # define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
 # define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
@@ -237,6 +238,17 @@
 # define __nonstring
 #endif
 
+/*
+ * Optional: only supported since clang >= 13
+ *      gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80223
+ *    clang: https://clang.llvm.org/docs/AttributeReference.html#no_profile
+ */
+#if __has_attribute(__no_profile__)
+# define __no_profile                  __attribute__((__no_profile__))
+#else
+# define __no_profile
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noreturn-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#noreturn
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d29bda7f6ebd..d509169860f1 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -210,7 +210,7 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address
+	__no_kcsan __no_sanitize_address __no_profile
 
 #endif /* __KERNEL__ */
 
-- 
2.32.0.288.g62a8d224e6-goog

