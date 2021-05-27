Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5480439367D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhE0Tqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhE0Tq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:46:29 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E88C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:44:54 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id f141-20020a1c1f930000b029017ce5240ed6so533597wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XdQqGBQo4mWdmTmqfcsPAW5aXAD9T8KofAFcju284Qk=;
        b=tiNPJmmIXfTSM2TLeNX/imcAEnBziXYVqg6MNx5SAEo//+ALsw4k8LLPpbxEu6jzoI
         ovHhUBLMD3dLTXG6HYp4qxfPv3SdUu7Lcrbs8J8jaI6PSCCdWowGibsEgJeEfdeTrMeB
         j3CK7VlOMIYblSu6kKPVVf1mrY+txbZoHpzjd7GykFyfjpibmRp25I99AGKGvqDYaFeH
         NVV32DyqVyaA6LpPnBK+B+yJzfKYLO5+6d/de3k2qT6jw6+DN82fmzWuRSBOeAqzHjqE
         uaW+PmTrpV89/czHfCp5OZVEsCHJ7uHqyla1cyE5YVrLlf1k+Y281cMT20yHIGvjo0zn
         mO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XdQqGBQo4mWdmTmqfcsPAW5aXAD9T8KofAFcju284Qk=;
        b=Yh0if8+hbn8xpRweBKlXKviaRrkv7QFNQYaOIDxHwFWu2q5EB8RJQGgoOH6AFI840Z
         xGklLRSqzO8B+u9phA74dU4aiw8pFqAcxAaFg5ou8nD/gASP9LOUdWxL4f7xx5SrPTYF
         HMdZRWXQujEPFtB01Q8Cxq6EtAuzradmW4RxtNTi8IIs184q19aNcvQvbKRV/4cMaeJ1
         Hcy7e2EvHIumCnAN4dgGSUg7ytprG785qGprtdveTKxXfwlZx0n4oFAKCxKZhggaRboB
         bNLoz8XtvVb/N2ihghD9u4lNJIzt5A2cUAJbwKGtPH+tWFHDNT8frHF4JseWqEmtaozi
         RQHA==
X-Gm-Message-State: AOAM530du6LqKvhno/Cdz9HT+IQFO2TPBkQEWmg/7uznufK1OOmdLMnz
        tFnf1RcNku4+1XEvLgPIVFyETShdHw==
X-Google-Smtp-Source: ABdhPJxXG99qJ3lv1D83sXswxdrHOBD5m9nctikPYES7aSF5pSY7pHbh/+mHsU0IjjWUNbINMZrfQMqPRw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:d65:1a6a:e560:4abf])
 (user=elver job=sendgmr) by 2002:a1c:a401:: with SMTP id n1mr8834184wme.30.1622144692871;
 Thu, 27 May 2021 12:44:52 -0700 (PDT)
Date:   Thu, 27 May 2021 21:44:48 +0200
Message-Id: <20210527194448.3470080-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v3] kcov: add __no_sanitize_coverage to fix noinstr for all architectures
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, keescook@chromium.org,
        peterz@infradead.org, will@kernel.org, nivedita@alum.mit.edu,
        luc.vanoostenryck@gmail.com, masahiroy@kernel.org,
        samitolvanen@google.com, arnd@arndb.de,
        clang-built-linux@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now no compiler supported an attribute to disable coverage
instrumentation as used by KCOV.

To work around this limitation on x86, noinstr functions have their
coverage instrumentation turned into nops by objtool. However, this
solution doesn't scale automatically to other architectures, such as
arm64, which are migrating to use the generic entry code.

Clang [1] and GCC [2] have added support for the attribute recently.
[1] https://github.com/llvm/llvm-project/commit/280333021e9550d80f5c1152a34e33e81df1e178
[2] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=cec4d4a6782c9bd8d071839c50a239c49caca689
The changes will appear in Clang 13 and GCC 12.

Add __no_sanitize_coverage for both compilers, and add it to noinstr.

Note: In the Clang case, __has_feature(coverage_sanitizer) is only true
if the feature is enabled, and therefore we do not require an additional
defined(CONFIG_KCOV) (like in the GCC case where __has_attribute(..) is
always true) to avoid adding redundant attributes to functions if KCOV
is off. That being said, compilers that support the attribute will not
generate errors/warnings if the attribute is redundantly used; however,
where possible let's avoid it as it reduces preprocessed code size and
associated compile-time overheads.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
---
v3:
* Add comment explaining __has_feature() in Clang.
* Add Miguel's Reviewed-by.

v2:
* Implement __has_feature(coverage_sanitizer) in Clang
  (https://reviews.llvm.org/D103159) and use instead of version check.
* Add Peter's Ack.
---
 include/linux/compiler-clang.h | 17 +++++++++++++++++
 include/linux/compiler-gcc.h   |  6 ++++++
 include/linux/compiler_types.h |  2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index adbe76b203e2..49b0ac8b6fd3 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -13,6 +13,12 @@
 /* all clang versions usable with the kernel support KASAN ABI version 5 */
 #define KASAN_ABI_VERSION 5
 
+/*
+ * Note: Checking __has_feature(*_sanitizer) is only true if the feature is
+ * enabled. Therefore it is not required to additionally check defined(CONFIG_*)
+ * to avoid adding redundant attributes in other configurations.
+ */
+
 #if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
 /* Emulate GCC's __SANITIZE_ADDRESS__ flag */
 #define __SANITIZE_ADDRESS__
@@ -45,6 +51,17 @@
 #define __no_sanitize_undefined
 #endif
 
+/*
+ * Support for __has_feature(coverage_sanitizer) was added in Clang 13 together
+ * with no_sanitize("coverage"). Prior versions of Clang support coverage
+ * instrumentation, but cannot be queried for support by the preprocessor.
+ */
+#if __has_feature(coverage_sanitizer)
+#define __no_sanitize_coverage __attribute__((no_sanitize("coverage")))
+#else
+#define __no_sanitize_coverage
+#endif
+
 /*
  * Not all versions of clang implement the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 5d97ef738a57..cb9217fc60af 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -122,6 +122,12 @@
 #define __no_sanitize_undefined
 #endif
 
+#if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
+#define __no_sanitize_coverage __attribute__((no_sanitize_coverage))
+#else
+#define __no_sanitize_coverage
+#endif
+
 #if GCC_VERSION >= 50100
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d29bda7f6ebd..cc2bee7f0977 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -210,7 +210,7 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address
+	__no_kcsan __no_sanitize_address __no_sanitize_coverage
 
 #endif /* __KERNEL__ */
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

