Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C189B390839
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhEYSAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhEYSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:00:40 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46764C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:59:09 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id x2-20020a0cda020000b02901edb4c412fdso31209807qvj.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O+kNZR25+vDl6MdOvHlxMTavYKFo24nOs+bV5Xh/gL4=;
        b=TNKdPm5Lc8m5Yr+Q0Kghvn98kwQPuxloIzdloAJ9QEagHnLD2iGfLjzxZeonKnpoG/
         TUEp4jFciIHVj73vOLyYeZoDZmoNKjDQ34szJG+z0PDWewTcqraYOscZjJ9vCNh2urKJ
         GQGdOiSsAs62JvqYeoRdBW0JZeHKEmp7ozjO1FTp2wp9b/HqWj9AllUMGsPFPIo20l+u
         CKM9/ChrQraKYuNNtEY+gcEyPreHROGOrlSbisWygQYDS0L94zXMUKXq23QG3Etok5v+
         HyOhNdIwhLJvCYREDN7uOqNTmokffw6ZZUo1rYPu/m9eW0nEyCozmLi8DoRf4epIdAs4
         o1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O+kNZR25+vDl6MdOvHlxMTavYKFo24nOs+bV5Xh/gL4=;
        b=D55ok01/lQPS8Ch1Xjk1+739H17Xbas/sd3zrQYx+49dgSo9C32WugGxfuPaZHVYAD
         y5ewLJL+NsCZ9vjk34daV7EmaA300y5JoiV+L7Qlymh0UwtrCAWID2Mtfo/9VANAdcQa
         9HtA8304LvSLjEp7ppk8KzwhIWWjSgkNKMmQu9Jg7zt3dBvT2ZiHFytDZjrfLqHjhOSM
         bEtvnz06FvzLz21Wx23141Bd7hCWzgiw5CABcg/qqRIZvw96vxnJZBAFyQYryhnOJOC3
         ZDQ7m74jVCAFaGOF0CqjGY99nkkr0lwYPDPqvsWbUd0ZLkeFNjwtQGjfQwBP+UaA6zFL
         ue8A==
X-Gm-Message-State: AOAM5339gZMnvBVUxh0Pw96KOopky+KUaPL+glwwnLC1XGY64mRr5px3
        oDjeeWBLdOT1SWRu+iXknGLkxv2zSA==
X-Google-Smtp-Source: ABdhPJwn51Cp1/KhsmJlAmgL+vnA+kzdgTifCI9Q6t2awhhsv12FHBqJfTrDx3HxZhAn9pYlZmb/hO+IFQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:b328:d556:de65:97a2])
 (user=elver job=sendgmr) by 2002:ad4:4e67:: with SMTP id ec7mr38673270qvb.58.1621965548449;
 Tue, 25 May 2021 10:59:08 -0700 (PDT)
Date:   Tue, 25 May 2021 19:58:19 +0200
Message-Id: <20210525175819.699786-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH] kcov: add __no_sanitize_coverage to fix noinstr for all architectures
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, keescook@chromium.org,
        akpm@linux-foundation.org, will@kernel.org, ardb@kernel.org,
        luc.vanoostenryck@gmail.com, nivedita@alum.mit.edu,
        masahiroy@kernel.org, peterz@infradead.org,
        samitolvanen@google.com, arnd@arndb.de,
        clang-built-linux@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>
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

Add __no_sanitize_coverage for both compilers, and add it to noinstr.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler-clang.h | 6 ++++++
 include/linux/compiler-gcc.h   | 6 ++++++
 include/linux/compiler_types.h | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index adbe76b203e2..370565f4cfde 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -45,6 +45,12 @@
 #define __no_sanitize_undefined
 #endif
 
+#if defined(CONFIG_KCOV) && CONFIG_CLANG_VERSION >= 130000
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

