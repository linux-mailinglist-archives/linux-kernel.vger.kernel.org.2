Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5DB3AD5F1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 01:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhFRXdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhFRXdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:33:00 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC61FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:30:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id e18-20020ad441920000b029025ddd75f418so7153227qvp.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K5IKvJejgNpA3AFkHBDCXpqjsqKJvtxs1XINxFL+/80=;
        b=Xv1vHb+6WsCa/m6Vu4jkUgfv1Vfd65hhIYj1E3ovZR0PeSnobLEZ8/fkUe0eW4cw9K
         yDZ7kCLjXQ7qoo6HDD6UtUX371UzqR+Ln4OgvkHTaIzVLvh8NPmG67ec4obfZhhR9D1r
         wG/Zpu1orD+4NmfnjCqPZjGf9nOuo0lVIUYkhbYV6FPjdHnZmHKd3veFeTf14H4CGmlv
         v/PwyJLYCw7Xq/GwW4fgY8vwlddErA6HThDqWuFyK9CR8Y83dz1jVNtwk+2vNcDVJV1U
         pQu2txUobp7XJW2tyungb03WIolNt1xZvhhD5A+rWy5p/xWtqYE38+HOv9Xf/4asOGv3
         KIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K5IKvJejgNpA3AFkHBDCXpqjsqKJvtxs1XINxFL+/80=;
        b=fz1PTCaOlnF1Lg7dYyaHXkqvXA+jzd5OI1LcW0Mssj1rgV7Gr7NiXJ6iYxdkbegZfO
         KRvJAq5TpIAH0I6VSyLBBKTE+OE+L9prgcL6t3of1ngMMPD1WPpQIwQg84IQfq2nuKB+
         x6SuHPhIQgrIqYCP9Pz6vu239RU9iAVv8fFaeuODZaWQgnyzSY93X4AYS7PcOcOL6TlR
         TFcAGCX41a4CspGH6JjBL7+LnCu+gQwH78XUKVf0I4oSvfT/8J3bEfKyYuYEA7gGY73p
         fYZvbcqeAPWEx9eBS3YjwB85SCcM6pPEVhvueTY82BeTkeTQSXSPLWTGsMH2ApYIG1Tm
         pHtA==
X-Gm-Message-State: AOAM531z4urRnXC760KAKHsDwoTdxmY8PzdTSJBAmRFpkfnd1zCaJyVg
        ygIElYcmJD20FebO/f2SEDgpJve6msYmbY3bwLM=
X-Google-Smtp-Source: ABdhPJzv3iuu4rmC8ir3YJzvMzMIGBJAAJJhBB51vid/gVjQPP1e/24XhYkWkAPDbTnLwPxLy7jP+XAcFn4lE+v0wXI=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:7c41:e84c:8fcb:6664])
 (user=ndesaulniers job=sendgmr) by 2002:a25:d257:: with SMTP id
 j84mr16278281ybg.404.1624059048916; Fri, 18 Jun 2021 16:30:48 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:30:23 -0700
In-Reply-To: <20210618233023.1360185-1-ndesaulniers@google.com>
Message-Id: <20210618233023.1360185-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210618233023.1360185-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 2/2] Kconfig: CC_HAS_NO_PROFILE_FN_ATTR, depend on for GCOV
 and PGO
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

We don't want compiler instrumentation to touch noinstr functions, which
are annotated with the no_profile function attribute. Add a Kconfig test
for this and make PGO and GCOV depend on it.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Link: https://lore.kernel.org/lkml/YMTn9yjuemKFLbws@hirez.programming.kicks-ass.net/
Link: https://lore.kernel.org/lkml/YMcssV%2Fn5IBGv4f0@hirez.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 init/Kconfig        | 3 +++
 kernel/gcov/Kconfig | 1 +
 kernel/pgo/Kconfig  | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 1ea12c64e4c9..540f862b40c6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -83,6 +83,9 @@ config TOOLS_SUPPORT_RELR
 config CC_HAS_ASM_INLINE
 	def_bool $(success,echo 'void foo(void) { asm inline (""); }' | $(CC) -x c - -c -o /dev/null)
 
+config CC_HAS_NO_PROFILE_FN_ATTR
+	def_bool $(success,echo '__attribute__((no_profile)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
+
 config CONSTRUCTORS
 	bool
 
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 58f87a3092f3..19facd4289cd 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -5,6 +5,7 @@ config GCOV_KERNEL
 	bool "Enable gcov-based kernel profiling"
 	depends on DEBUG_FS
 	depends on !CC_IS_CLANG || CLANG_VERSION >= 110000
+	depends on !X86 || (X86 && CC_HAS_NO_PROFILE_FN_ATTR)
 	select CONSTRUCTORS
 	default n
 	help
diff --git a/kernel/pgo/Kconfig b/kernel/pgo/Kconfig
index d2053df1111c..26f75ac4c6c1 100644
--- a/kernel/pgo/Kconfig
+++ b/kernel/pgo/Kconfig
@@ -8,7 +8,8 @@ config PGO_CLANG
 	bool "Enable clang's PGO-based kernel profiling"
 	depends on DEBUG_FS
 	depends on ARCH_SUPPORTS_PGO_CLANG
-	depends on CC_IS_CLANG && CLANG_VERSION >= 120000
+	depends on CC_IS_CLANG
+	depends on CC_HAS_NO_PROFILE_FN_ATTR
 	help
 	  This option enables clang's PGO (Profile Guided Optimization) based
 	  code profiling to better optimize the kernel.
-- 
2.32.0.288.g62a8d224e6-goog

