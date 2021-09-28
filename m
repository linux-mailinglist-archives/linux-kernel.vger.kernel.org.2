Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6441B331
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbhI1PoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241800AbhI1PoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:44:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A32C86124A;
        Tue, 28 Sep 2021 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843744;
        bh=fK3Q2oqvtUgvjlTJS3xSTsoPj9+qRtVxTymOeapiW40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAfG2hEXhEA9bHqiR8mCQ+AdpcssV0EapvyKnwizMS/yg67TZQwYBIVIr9S0TGJ5M
         JWP78C8oAEse8icvSQcOMwfqGqobHL1Gx5xjOwxlBE4NwgsXCwrdd7JI3pQ0J6lPN9
         WTP54DQMmApJFLHt1k1/GPQmECcfR8htc9JCM5VomuuMn1fG/Fe09aM+SwJJ0XeAuf
         40CR1iUeXdN6oxSZy4fODXilJvdCpMgC3qghEu2HeqfYCIQ0JEiVebzUE0SNsMxoc8
         6c8xesWI/jgNBAHykYlmwbi3W/4O+e25+hngIxAwWUJ2xJ/9keCdAKxGB7vGHa49YQ
         We/nhK6dn5PpA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 12/14] ARM: add CONFIG_PHYS_OFFSET default values
Date:   Tue, 28 Sep 2021 17:41:41 +0200
Message-Id: <20210928154143.2106903-13-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928154143.2106903-1-arnd@kernel.org>
References: <20210928154143.2106903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

For platforms that are not yet converted to ARCH_MULTIPLATFORM,
we can disable CONFIG_ARM_PATCH_PHYS_VIRT, which in turn requires
setting a correct address here.

As we actualy know what all the values are supposed to be based
on the old mach/memory.h header file contents (from git history),
we can just add them here.

This also solves a problem in Kconfig where 'make randconfig'
fails to continue if no number is selected for a 'hex' option.
Users can still override the number at configuration time, e.g.
when the memory visible to the kernel starts at a nonstandard
address on some machine, but it should no longer be required
now.

I originally posted this back in 2016, but the problem still
persists. The patch has gotten much simpler though, as almost
all platforms rely on ARM_PATCH_PHYS_VIRT now.

Acked-by: Nicolas Pitre <nico@linaro.org>
Link: https://lore.kernel.org/linux-arm-kernel/1455804123-2526139-5-git-send-email-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 12a0bd4b315d..0d4f3e2d50ad 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -264,10 +264,12 @@ config PHYS_OFFSET
 	hex "Physical address of main memory" if MMU
 	depends on !ARM_PATCH_PHYS_VIRT
 	default DRAM_BASE if !MMU
-	default 0x00000000 if ARCH_FOOTBRIDGE
+	default 0x00000000 if ARCH_FOOTBRIDGE || ARCH_IXP4XX
 	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
-	default 0x20000000 if ARCH_S5PV210
-	default 0xc0000000 if ARCH_SA1100
+	default 0x30000000 if ARCH_S3C24XX
+	default 0xa0000000 if ARCH_IOP32X || ARCH_PXA
+	default 0xc0000000 if ARCH_EP93XX || ARCH_SA1100
+	default 0
 	help
 	  Please provide the physical address corresponding to the
 	  location of main memory in your system.
-- 
2.29.2

