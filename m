Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC64E3C1C67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 02:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhGIAMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 20:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhGIAME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 20:12:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6EC461464;
        Fri,  9 Jul 2021 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625789362;
        bh=ZmxKtJP5ExpVCWmzEkIOSTsoTZNxKk6teetJ374jSgY=;
        h=From:To:Cc:Subject:Date:From;
        b=e1xMz/ZO3lHnpTQnO6nQJCUTW11mg3PbgO7ZotO48RfHjaTdM/LPLeG1p92nsfZ2l
         jFqfO+uamAwpJKdeXk45ogWoKB7slYnNyLyTYZnJ6nOmVCNqIepkVXICOqagk0l89P
         HuiEZ/382goU13Ujy5eCPcrnuBDvh3tpemVdHq8Tptgm6n/F+1ZjQCjWTWy2Jq1V8I
         9OwgOrDApCNL01hXi/mUDDvfmb2RNCJGwDEqR3/N/FZUUOVL+h9A5S1PCXEWk2l5oZ
         t14/hzyNytWa0xuMFDDFdarw5aENtrGrxKUVsubMyWX/A/zhAL3RmxCFrD8pk9I5Ie
         JdtgRkx40fkaw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] arm64: Restrict ARM64_BTI_KERNEL to clang 12.0.0 and newer
Date:   Thu,  8 Jul 2021 17:06:27 -0700
Message-Id: <20210709000627.3183718-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 97fed779f2a6 ("arm64: bti: Provide Kconfig for kernel mode BTI")
disabled CONFIG_ARM64_BTI_KERNEL when CONFIG_GCOV_KERNEL was enabled and
compilign with clang because of warnings that occur because LLVM was not
emitting PAC/BTI instructions for compiler generated functions.

This was an adequate fix to avoid the warnings with allmodconfig until
commit 51c2ee6d121c ("Kconfig: Introduce ARCH_WANTS_NO_INSTR and
CC_HAS_NO_PROFILE_FN_ATTR"), which prevented CONFIG_GCOV_KERNEL from
being selected with clang 12.0.0 and older because it does not support
the no_profile_instrument_function attribute. As a result,
CONFIG_ARM64_BTI_KERNEL gets enabled and there are more warnings of this
nature.

Rather than play whack-a-mole with the config options, just update this
condition to require clang 12.0.0, which should have all of the issues
ironed out.

Link: https://github.com/ClangBuiltLinux/linux/issues/1428
Link: https://github.com/ClangBuiltLinux/continuous-integration2/runs/3010034706?check_suite_focus=true
Link: https://github.com/ClangBuiltLinux/continuous-integration2/runs/3010035725?check_suite_focus=true
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e07e7de9ac49..c2127595980f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1605,7 +1605,8 @@ config ARM64_BTI_KERNEL
 	depends on CC_HAS_BRANCH_PROT_PAC_RET_BTI
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94697
 	depends on !CC_IS_GCC || GCC_VERSION >= 100100
-	depends on !(CC_IS_CLANG && GCOV_KERNEL)
+	# https://reviews.llvm.org/D85649
+	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
 	help
 	  Build the kernel with Branch Target Identification annotations

base-commit: f55966571d5eb2876a11e48e798b4592fa1ffbb7
-- 
2.32.0.93.g670b81a890

