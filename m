Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE82F33694E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhCKAy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhCKAys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:54:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BB6D64FBA;
        Thu, 11 Mar 2021 00:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615424087;
        bh=xcryLZ0Gb5mYAc5JfRylLi7w7iJuxtG63AI/SwJzEbg=;
        h=From:To:Cc:Subject:Date:From;
        b=qOa3LL3/If4YhmTZfWnjKjVL/SAQJTmwrb9UHJqsUsuXJbGv6StV29YBU5xNdwuIN
         VYYl4Zc3NUbck+33xFf7bARR9duUh3t+bL/Svi8RY9h48ti9Q+RnZqR6xK0jQuKMSy
         pZnzGYZelkKvy3sykn9Y5HV+hvjkllaHCAiiYhFT1v1Tw43Is99pBlR4U6xr90QiVD
         U622du50w1r3QMuzCvsWLH0loSuYfSBCafhecNuluSF8svLmJ1NuJRcGVwxmOSifQ+
         uzO4S8GKmGEwdvNak6TQsY3v3hhV5aaKqlXzOFjukp4UdU+z3ZClQsGLeJ8srRB39w
         BNOWaLgL3/prw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] ARM: Make UNWINDER_ARM depend on ld.bfd or ld.lld 11.0.0+
Date:   Wed, 10 Mar 2021 17:54:18 -0700
Message-Id: <20210311005418.2207250-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When linking aspeed_g5_defconfig with ld.lld 10.0.1, the following error
occurs:

ld.lld: error: .tmp_vmlinux.kallsyms1:(.ARM.exidx+0x34D98): relocation
R_ARM_PREL31 out of range: 2135538592 is not in [-1073741824,
1073741823]

This was resolved in ld.lld 11.0.0 but the minimum supported version of
ld.lld for the kernel is 10.0.1. Prevent CONFIG_UNWINDER_ARM from being
selected in this case so that the problematic sections cannot be
created.

Link: https://github.com/ClangBuiltLinux/linux/issues/732
Link: https://github.com/llvm/llvm-project/commit/48aebfc908ba7b9372aaa478a9c200789491096e
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9e0b5e7f12af..64c1f8a46ab5 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -66,6 +66,8 @@ config UNWINDER_FRAME_POINTER
 config UNWINDER_ARM
 	bool "ARM EABI stack unwinder"
 	depends on AEABI && !FUNCTION_GRAPH_TRACER
+	# https://github.com/ClangBuiltLinux/linux/issues/732
+	depends on !LD_IS_LLD || LLD_VERSION >= 110000
 	select ARM_UNWIND
 	help
 	  This option enables stack unwinding support in the kernel

base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
-- 
2.31.0.rc1

