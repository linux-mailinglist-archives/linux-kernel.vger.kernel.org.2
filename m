Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E460331452A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhBIA7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhBIA7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:59:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E556464E82;
        Tue,  9 Feb 2021 00:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612832322;
        bh=WTzVfyDECWyda2V3zd0/237OY1tpljp4GOvC63bQyIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrAK/jQGItiwbV2qgsJ/REd2PxX8xY0hxWCzpJ3g0zw3C1P3nAfuoc3weeFg+S562
         c/Tx5gj0cke5MV99TYssKctfV4Yx9uo4aGiLToBUr3qdM7cVEj2NnHTCvwzGkMh0lm
         LKUBTqqbELpeKa3KZisgPSxCJhSIJkqmjOisV1+RrIqntXGGj2+VbHyqE+jT7o4evI
         vesnTcCAlTdyadlWcrGug31us/UhtHq9CYXbYdp0CO+wzpSD1nRteVZdKmi+Ehcoyo
         emavb04ynMAQAAmN9+GabfUnnpYhTeCjvHUbI2nYQUHcXkN/WafFyEzAIXFV4uL+AY
         i88GixNIhfw/A==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] arm64: Make CPU_BIG_ENDIAN depend on ld.bfd or ld.lld 13.0.0+
Date:   Mon,  8 Feb 2021 17:57:20 -0700
Message-Id: <20210209005719.803608-1-nathan@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210202022441.1451389-1-nathan@kernel.org>
References: <20210202022441.1451389-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 28187dc8ebd9 ("ARM: 9025/1: Kconfig: CPU_BIG_ENDIAN
depends on !LD_IS_LLD"), ld.lld prior to 13.0.0 does not properly
support aarch64 big endian, leading to the following build error when
CONFIG_CPU_BIG_ENDIAN is selected:

ld.lld: error: unknown emulation: aarch64linuxb

This has been resolved in LLVM 13. To avoid errors like this, only allow
CONFIG_CPU_BIG_ENDIAN to be selected if using ld.bfd or ld.lld 13.0.0
and newer.

While we are here, the indentation of this symbol used spaces since its
introduction in commit a872013d6d03 ("arm64: kconfig: allow
CPU_BIG_ENDIAN to be selected"). Change it to tabs to be consistent with
kernel coding style.

Link: https://github.com/ClangBuiltLinux/linux/issues/380
Link: https://github.com/ClangBuiltLinux/linux/issues/1288
Link: https://github.com/llvm/llvm-project/commit/7605a9a009b5fa3bdac07e3131c8d82f6d08feb7
Link: https://github.com/llvm/llvm-project/commit/eea34aae2e74e9b6fbdd5b95f479bc7f397bf387
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2:

* Conditionally disable CONFIG_CPU_BIG_ENDIAN for older versions of
  ld.lld now that proper support has been added to ld.lld 13+ (thanks to
  the quick work of Fangrui Song).

 arch/arm64/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f39568b28ec1..912da4e2ab59 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -952,8 +952,9 @@ choice
 	  that is selected here.
 
 config CPU_BIG_ENDIAN
-       bool "Build big-endian kernel"
-       help
+	bool "Build big-endian kernel"
+	depends on !LD_IS_LLD || LLD_VERSION >= 130000
+	help
 	  Say Y if you plan on running a kernel with a big-endian userspace.
 
 config CPU_LITTLE_ENDIAN

base-commit: 92bf22614b21a2706f4993b278017e437f7785b3
-- 
2.30.1

