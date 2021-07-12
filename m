Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E063C65B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhGLVyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 17:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhGLVyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 17:54:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E1F860232;
        Mon, 12 Jul 2021 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626126677;
        bh=5vqH/9WMlx5qlNWbJyIbS33BMltJ59roYjI/NA3A8zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nabIYQH1RzcFAg09o1rTJxVWITUxILIHB5/Luu5fGL4rmO7LU2ZLz+GihxhLh/k//
         W9sHG23QF5gW6mjfP68OpjQUxu5resqOGeEpCuEmyZPmZwONDMkDXCTgf2rXDuD31Z
         Yqi+EJqqoHsyoEqJs4JLYcty8ZnXe9Mfe0I2gsELyqy9B89Qsr3HVJxfAfCSd/XaNs
         p29kCtsmU0zDiFMjdSGNcyR5bY1TnQsZyyTNPEVB60ond0PvmWdGtfowQsOyrKluLy
         VZOLzI+oKzNuaQf+/QX6sGU/9KbdtYY5BoMcgcl07Dg6BhbL3bhDPiklTxRxdbYSER
         hqd59j6HnPFjg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2] arm64: Restrict ARM64_BTI_KERNEL to clang 12.0.0 and newer
Date:   Mon, 12 Jul 2021 14:46:37 -0700
Message-Id: <20210712214636.3134425-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
In-Reply-To: <20210709000627.3183718-1-nathan@kernel.org>
References: <20210709000627.3183718-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 97fed779f2a6 ("arm64: bti: Provide Kconfig for kernel mode BTI")
disabled CONFIG_ARM64_BTI_KERNEL when CONFIG_GCOV_KERNEL was enabled and
compiling with clang because of warnings that were seen with
allmodconfig because LLVM was not emitting PAC/BTI instructions for
compiler generated functions:

warning: some functions compiled with BTI and some compiled without BTI
warning: not setting BTI in feature flags

This depedency was fine for avoiding the warnings with allmodconfig
until commit 51c2ee6d121c ("Kconfig: Introduce ARCH_WANTS_NO_INSTR and
CC_HAS_NO_PROFILE_FN_ATTR"), which prevents CONFIG_GCOV_KERNEL from
being enabled with clang 12.0.0 or older because those versions do not
support the no_profile_instrument_function attribute.

As a result, CONFIG_ARM64_BTI_KERNEL gets enabled with allmodconfig and
there are more warnings like the ones above due to CONFIG_KASAN, which
suffers from the same problem as CONFIG_GCOV_KERNEL. This was most
likely not noticed at the time because allmodconfig +
CONFIG_GCOV_KERNEL=n was not tested. defconfig + CONFIG_KASAN=y is
enough to reproduce the same warnings as above.

The root cause of the warnings was resolved in LLVM during the 12.0.0
release so rather than play whack-a-mole with the dependencies, just
update CONFIG_ARM64_BTI_KERNEL to require clang 12.0.0, which will have
all of the issues ironed out.

Link: https://github.com/ClangBuiltLinux/linux/issues/1428
Link: https://github.com/ClangBuiltLinux/continuous-integration2/runs/3010034706?check_suite_focus=true
Link: https://github.com/ClangBuiltLinux/continuous-integration2/runs/3010035725?check_suite_focus=true
Link: https://github.com/llvm/llvm-project/commit/a88c722e687e6780dcd6a58718350dc76fcc4cc9
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2:

* Fix typo ("compilign" to "compiling") per Will.

* Clarify that these warnings are reproducible back at the time of
  97fed779f2a6 with allmodconfig + CONFIG_GCOV_KERNEL=n but that
  configuration was most likely not tested.

* Clarify that the warnings come from CONFIG_KASAN, which suffers from
  the same issue at CONFIG_GCOV_KERNEL because there are compiler
  generated functions.

* Clarify that the root cause of the warnings is resolved in 12.0.0 and
  link to the GitHub commit rather than the Phabricator instance, in
  case LLVM moves to GitHub reviews in the future.

Hopefully this is adequate explanation for what is going on, thanks to
Will and Nick for providing input on the commit message.

 arch/arm64/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e07e7de9ac49..b5b13a932561 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1605,7 +1605,8 @@ config ARM64_BTI_KERNEL
 	depends on CC_HAS_BRANCH_PROT_PAC_RET_BTI
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94697
 	depends on !CC_IS_GCC || GCC_VERSION >= 100100
-	depends on !(CC_IS_CLANG && GCOV_KERNEL)
+	# https://github.com/llvm/llvm-project/commit/a88c722e687e6780dcd6a58718350dc76fcc4cc9
+	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
 	help
 	  Build the kernel with Branch Target Identification annotations

base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.32.0.93.g670b81a890

