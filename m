Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227C330B53B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhBBCZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:25:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBBCZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:25:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB04D64ECB;
        Tue,  2 Feb 2021 02:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612232701;
        bh=NTjUJbFdSth745Tu2pBJPfgH9+wOG7j4zxvy46kk270=;
        h=From:To:Cc:Subject:Date:From;
        b=oaHaPq6xfM71iwrpGLCQcUWclOXFO72r9YuCJ8CA2hrNwMeInijbsJMJqDv2gxEMz
         2TookcJENXyphcuzgymF2sxguNCHefba+6cnzRWxSU/GXNjdUx3mWjSjH7lESiFsgT
         V3AEk4CXf27hKJxbkKbZQh+NxFcQ2/N+pNuoBPATpXjD8hyPeFS3uaustRf/iaOiDi
         ZSWnVTMmgZ43N2PsD5eNu123pFsPEEAo+eFLbcF0JJBFB2/NQ6hTyUPRaNUwiVpCcG
         8pzLo2q/UWBMBxTKNSIYQ+iXjDwdA0T++Wp9TkJbui+rrmmQOcw4I4yaKu27s6zyDJ
         CQIVr3UmfCkYQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] arm64: Make CPU_BIG_ENDIAN depend on !LD_IS_LLD
Date:   Mon,  1 Feb 2021 19:24:42 -0700
Message-Id: <20210202022441.1451389-1-nathan@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 28187dc8ebd9 ("ARM: 9025/1: Kconfig: CPU_BIG_ENDIAN
depends on !LD_IS_LLD"), ld.lld does not support aarch64 big endian,
leading to the following build error when CONFIG_CPU_BIG_ENDIAN is
selected:

ld.lld: error: unknown emulation: aarch64linuxb

There are not currently plans to implement big endian support for
aarch64 in ld.lld but if it should be supported in the future, this
symbol can depend on the version that first supports it. In the
meantime, prevent this symbol from being selected to avoid these type
of build errors.

While we are here, the indentation of this symbol used spaces since its
introduction in commit a872013d6d03 ("arm64: kconfig: allow
CPU_BIG_ENDIAN to be selected"). Change it to tabs to be consistent with
kernel coding style.

Link: https://github.com/ClangBuiltLinux/linux/issues/380
Link: https://github.com/ClangBuiltLinux/linux/issues/1288
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f39568b28ec1..5ddf9fe7b4ee 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -952,8 +952,9 @@ choice
 	  that is selected here.
 
 config CPU_BIG_ENDIAN
-       bool "Build big-endian kernel"
-       help
+	bool "Build big-endian kernel"
+	depends on !LD_IS_LLD
+	help
 	  Say Y if you plan on running a kernel with a big-endian userspace.
 
 config CPU_LITTLE_ENDIAN

base-commit: 88bb507a74ea7d75fa49edd421eaa710a7d80598
-- 
2.30.0

