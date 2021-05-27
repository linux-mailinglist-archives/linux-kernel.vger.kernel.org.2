Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751EC3933C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhE0Q2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbhE0Q2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:28:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6B7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:27:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so1053320ybo.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AGqIzmkDxtMVtRwwjXgh0j/7u4mFhsWkmDrrQlHpXTY=;
        b=f2w+5IQF5tdv8urRphu7TLjd4TFIB4uXJIzSKXdUxYhl8rPxLenbpLU6Qbs5+srec+
         JqfGQ4sMBHFhGa5m9ueuS0Tl8HOs5IF556TibIN8Ui/dkP3kqXAG3RNArVTZ3/rXoTte
         Lz18AJdvI+bPK5+fw2urau/N9xQYsNJLFaz3OxbzKT5d78NoPllOF7hKsKoixQQjnrXa
         3adqeOrM0NVRQqrVW+yIMlm+DQiXuyIDmngI1xScni7m7+vCzdpmyFqWtb0P/2bafLHY
         g6oC7yulS0q2LBPhcQ7KyxuQgvXp8XNGH7E5sCqmAwi7MwwM5JRExqz/3y1mgYE3i1nN
         7A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AGqIzmkDxtMVtRwwjXgh0j/7u4mFhsWkmDrrQlHpXTY=;
        b=CEu0bLlt22Sp+Cb+d777R78hWDnm8wH+39VD5+E4QXu1lKt411MEszQ6lKInQ39xgP
         zyanrlwLH/Nic3kH0KHKiRtBdUv20k6zUxY496zxMcBF6Xpdgr44MJ2JY1D4esmIC9EE
         hIRsEut34OtJJjsYX7QE1UrccZdM613A0h5QUpyPws0Ewp4w6HgC09MgnXreOVlpFes/
         ebVAcsE2eyiA4pQCMR94i9PsBvwJ/alNqHyzZmo8dpFeD0hmJXK1tg0rtu6fNbSr7KO4
         ts9tXFUPMv8TvlWYwhezbYdSCoPUMvotDvpAFstOuSPXRD4rRSeI4AjI3fgXLcGuX5PA
         DBCA==
X-Gm-Message-State: AOAM533vMVfzuuz2AuMexDPJP1kJq35HVZOwwJZleF1wPGgeQKl/Saj4
        Oj9YC1L61zhAfNmhCCExfmdGKbFXmQ==
X-Google-Smtp-Source: ABdhPJztD5xENNGd62rZTUUB+ZuNUG3OYAuQ1F3VuSEDEVzT+ymsoGVQ69pheTKGyuzxJxYEhW9YKpeFSw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:d65:1a6a:e560:4abf])
 (user=elver job=sendgmr) by 2002:a25:be41:: with SMTP id d1mr5987917ybm.352.1622132829802;
 Thu, 27 May 2021 09:27:09 -0700 (PDT)
Date:   Thu, 27 May 2021 18:26:55 +0200
Message-Id: <20210527162655.3246381-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2] kcov: add __no_sanitize_coverage to fix noinstr for all architectures
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, peterz@infradead.org,
        keescook@chromium.org, nivedita@alum.mit.edu, will@kernel.org,
        luc.vanoostenryck@gmail.com, masahiroy@kernel.org, bp@suse.de,
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
---
v2:
* Implement __has_feature(coverage_sanitizer) in Clang
  (https://reviews.llvm.org/D103159) and use instead of version check.
* Add Peter's Ack.
---
 include/linux/compiler-clang.h | 11 +++++++++++
 include/linux/compiler-gcc.h   |  6 ++++++
 include/linux/compiler_types.h |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index adbe76b203e2..e15eebfa8e5d 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -45,6 +45,17 @@
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
2.31.1.818.g46aad6cb9e-goog

