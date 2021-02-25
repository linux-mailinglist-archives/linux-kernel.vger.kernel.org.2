Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAB3253FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhBYQuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhBYQqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:46:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 349F664F03;
        Thu, 25 Feb 2021 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614271520;
        bh=XRJIv+0+/8Nj1u+obSmK1DS17lE9bT/ZjCm47/50Gf4=;
        h=From:To:Cc:Subject:Date:From;
        b=sXQX2Mh/K0e9XUVXMZacifSOWdh+X26EAtCs5pqQYww2CpZazIzMnHaikMbGyl9u4
         OaJwaS37R7sXUlbz7TTw9rHxbImpA+tIKnv6V+vKsMy62/w7PbEELARSWIre0fFZLB
         hnpc5AcMqqu5ew18esInd7Ye6rTCao4P/jntiejgkdi87k6MomwEnVDZPmdThx9GDM
         TcjFyL2/v6DJCJhddIL6NU8kmZT2b/sRKLtxrk/UT5nVf83Q5o52nZxi+QES9ED7db
         zTPTxh55X41OaxiWfTEsj480yM0yNFNNDQYLFsMycrShq7ywy3TkY6rVr6tfmmMyfk
         z/bFB8YbsZnWQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
Date:   Thu, 25 Feb 2021 17:45:09 +0100
Message-Id: <20210225164513.3667778-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Separating compiler-clang.h from compiler-gcc.h inadventently dropped the
definitions of the three HAVE_BUILTIN_BSWAP macros, which requires falling
back to the open-coded version and hoping that the compiler detects it.

Since all versions of clang support the __builtin_bswap interfaces,
add back the flags and have the headers pick these up automatically.

This results in a 4% improvement of compilation speed for arm defconfig.

Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compiler-clang.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 6478bff6fcc2..bbfa9ff6a2ec 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -33,6 +33,16 @@
 #define __no_sanitize_thread
 #endif
 
+/*
+ * sparse (__CHECKER__) pretends to be gcc, but can't do constant
+ * folding in __builtin_bswap*() (yet), so don't set these for it.
+ */
+#if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP) && !defined(__CHECKER__)
+#define __HAVE_BUILTIN_BSWAP32__
+#define __HAVE_BUILTIN_BSWAP64__
+#define __HAVE_BUILTIN_BSWAP16__
+#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP && !__CHECKER__ */
+
 #if __has_feature(undefined_behavior_sanitizer)
 /* GCC does not have __SANITIZE_UNDEFINED__ */
 #define __no_sanitize_undefined \
-- 
2.29.2

