Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5438941B325
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbhI1Pnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241711AbhI1Pnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:43:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 227646124B;
        Tue, 28 Sep 2021 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843720;
        bh=PBKDwsYSta8SiZylGzSgzt3FGPPrz1SUUHK/m3YlIcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlJxI+WirTf95k6HHPje/lbDdWzUmbhRWMY24e1RsE4qs9PbqBw4wfhITGQDEBYTa
         EPVsDaJdx3VmsH4eCqJf714Dg8y/W4r6HgDdmrfFeTG9JURTAYbneoNAkSGtg0g8aU
         TDiAVxUG7nJ1HjJj/E+cKJbmb2TOKhRsFYR/sn6DXJzf54WpBQ65sd3AzNX9NV95mq
         LInC7GjAao9B1j6d7v3U7kqRf3jyzh41Nrt2QSpN0yyH8X+BypuVQcz1zgKhHi8YyH
         63YfQEZSz/djmJKw1HUtsPdwXqf2UM6/YQh62F5Z6QapSlnoh5LRFUP5IwoEiTSj/I
         Hy7bamlGPKwYw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH 01/14] ARM: RiscPC needs older gcc version
Date:   Tue, 28 Sep 2021 17:41:30 +0200
Message-Id: <20210928154143.2106903-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928154143.2106903-1-arnd@kernel.org>
References: <20210928154143.2106903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Attempting to build mach-rpc with gcc-9 or higher, or with any version
of clang results in a build failure, like:

arm-linux-gnueabi-gcc-11.1.0: error: unrecognized -march target: armv3m
arm-linux-gnueabi-gcc-11.1.0: note: valid arguments are: armv4 armv4t armv5t armv5te armv5tej armv6 armv6j armv6k armv6z armv6kz armv6zk armv6t2 armv6-m armv6s-m armv7 armv7-a armv7ve armv7-r armv7-m armv7e-m armv8-a armv8.1-a armv8.2-a armv8.3-a armv8.4-a armv8.5-a armv8.6-a armv8-m.base armv8-m.main armv8-r armv8.1-m.main iwmmxt iwmmxt2; did you mean 'armv4'?

Handle this in Kconfig so we don't run into this with randconfig
builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc196421b2ce..12a0bd4b315d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -431,7 +431,7 @@ config ARCH_PXA
 
 config ARCH_RPC
 	bool "RiscPC"
-	depends on MMU
+	depends on !CC_IS_CLANG || GCC_VERSION < 90100
 	select ARCH_ACORN
 	select ARCH_MAY_HAVE_PC_FDC
 	select ARCH_SPARSEMEM_ENABLE
-- 
2.29.2

