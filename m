Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA39E36F2DD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 01:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhD2X1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 19:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhD2X1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:27:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 051FA60FEF;
        Thu, 29 Apr 2021 23:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619738795;
        bh=iJnXiao/XqJdR6XikaxL4phVBTlASI0UZ03/8UYRsLk=;
        h=From:To:Cc:Subject:Date:From;
        b=d44QNcLPGSM+kCDPp7yHT0u0uEyKxuNDm6h+5Q0BBaT6bPeNviE2dtANZpanzIC14
         wAo1jZmN2LXikYcaYtbZMQj4Lc3qFQzjBKE60f7sGscInv7osU9CSVjhehY9iiRwC7
         8RKhKyVlEPE9X47hXq/pJEUZ11tNwLga1z2kfUZMuysXWJ36dvj3FKYDzj8jpV0SZR
         kJWdFY3tk/k0GlEsqJ9g/tmgfHjPrFPh4mxeybyumwkfCm/PYQLPtpA+FocNBPmfNO
         s/IzHq542B4lUk5Rzyz0oWcaw3y/bvJEp/Zc517evQTDtqFPWX8I0FaHpPC6jZ1AtJ
         u5KsLa7SEwKfA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] x86: Enable clang LTO for 32-bit as well
Date:   Thu, 29 Apr 2021 16:26:12 -0700
Message-Id: <20210429232611.3966964-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.1.362.g311531c9de
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b33fff07e3e3 ("x86, build: allow LTO to be selected") enabled
support for LTO for x86_64 but 32-bit works fine as well.

I tested the following config combinations:

* i386_defconfig + CONFIG_LTO_CLANG_FULL=y

* i386_defconfig + CONFIG_LTO_CLANG_THIN=y

* ARCH=i386 allmodconfig + CONFIG_LTO_CLANG_THIN=y

with LLVM 11.1.0, 12.0.0, and 13.0.0 from git without any build
failures. The defconfigs boot in QEMU with no new warnings.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0fc82237414d..d8a919d9535e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -97,8 +97,8 @@ config X86
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
-	select ARCH_SUPPORTS_LTO_CLANG		if X86_64
-	select ARCH_SUPPORTS_LTO_CLANG_THIN	if X86_64
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS

base-commit: d8201efe75e13146ebde433745c7920e15593baf
-- 
2.31.1.362.g311531c9de

