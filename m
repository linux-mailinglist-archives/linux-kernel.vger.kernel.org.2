Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD3F32654E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBZQNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhBZQM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:12:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7822664EBA;
        Fri, 26 Feb 2021 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614355936;
        bh=C3YYYvLVQ2aWy1CSZtnNQUvgD7cCZHBGlr/W3FNNMxs=;
        h=From:To:Cc:Subject:Date:From;
        b=DP9nkO3oybnEAnHFCqYU6CdF/AbL2T+K3usNFtsn/N9/Yn70o/rliMJOb8/WaWYBA
         d57EoBBjnNAhow4GofagZQCF1EjMWeh2qtYWxT7Q2/aOxtXITbSMYBB3lw4CWilLYg
         Zexl3Qov2U8PKzyAAXLUD/zU1Bkty2FB87MLC4ViEz8Ff/mRR7+Pe6ZmhkIzEwTcNd
         SqEsb2UDI2IDem/YpMq+qDnEMYGzGJllqU1MqPodlUlmY/Sqw6vZybTE6YpgStqCWX
         zj09D3CS2CWUt9S2GaQg4mUKko6HBLUIkmvjstoN4N6dRN1g6k1IEc53f669FkOFBz
         oIlZmTXT7qF5Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: [PATCH] [v2] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
Date:   Fri, 26 Feb 2021 17:11:12 +0100
Message-Id: <20210226161151.2629097-1-arnd@kernel.org>
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

Note: it might also be worth revisiting which architectures set
CONFIG_ARCH_USE_BUILTIN_BSWAP for one compiler or the other, today
this is set on six architectures (arm32, csky, mips, powerpc, s390,
x86), while another ten architectures define custom helpers (alpha,
arc, ia64, m68k, mips, nios2, parisc, sh, sparc, xtensa), and the rest
(arm64, h8300, hexagon, microblaze, nds32, openrisc, riscv) just get
the unoptimized version and rely on the compiler to detect it.

A long time ago, the compiler builtins were architecture specific, but
nowadays, all compilers that are able to build the kernel have correct
implementations of them, though some may not be as optimized as
the inline asm versions.

The patch that dropped the optimization landed in v4.19, so as discussed
it would be fairly safe to backport this revert to stable kernels to
the 4.19/5.4/5.10 stable kernels, but there is a remaining risk for
regressions, and it has no known side-effects besides compile speed.

Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/lkml/20210225164513.3667778-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
 - drop exception for sparse
 - expand changelog text
---
 include/linux/compiler-clang.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 6478bff6fcc2..917f7f88cef0 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -33,6 +33,12 @@
 #define __no_sanitize_thread
 #endif
 
+#if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
+#define __HAVE_BUILTIN_BSWAP32__
+#define __HAVE_BUILTIN_BSWAP64__
+#define __HAVE_BUILTIN_BSWAP16__
+#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP */
+
 #if __has_feature(undefined_behavior_sanitizer)
 /* GCC does not have __SANITIZE_UNDEFINED__ */
 #define __no_sanitize_undefined \
-- 
2.29.2

