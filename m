Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5107E41B32A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbhI1Pn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241747AbhI1Pnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:43:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF3796124B;
        Tue, 28 Sep 2021 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843731;
        bh=ZBngGf1dNCnDo4MEWi+qXj5S4gy442NSnDPEpj1qxIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvEvIEbKxhG1/nqcMJ2acjMJg+VTozcsnAQpEzJIRIye7Z3mjWSRbUej+JcyUFFbi
         sOw7qa4lQnYLWrNeZuMup7kd8GTc2WKFo+NyM3cBKA4qz0c0mG3Ra8sGDhzPU67SyJ
         eBcOsFPcXwha1NrbirPjSEmo2lUUYgWIZh2hu0nWmEeLFjKw3XVnlNws4yzkyTqmy2
         CBrj/tEofya0JEY6YvYFjDwROrP+i58o/lNFWA7TloLj1ovnIDsJLMW2Lo3JOBajCi
         AJI2ojLvJxO7e9CVdiZd40PZbRyKTIxS2KRHEJPiPuBKPM3AfXb8bcVEVoH7zRSSKl
         0wOowTnG5DbJA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH 06/14] ARM: disallow CONFIG_THUMB with ARMv4
Date:   Tue, 28 Sep 2021 17:41:35 +0200
Message-Id: <20210928154143.2106903-7-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928154143.2106903-1-arnd@kernel.org>
References: <20210928154143.2106903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

We can currently build a multi-cpu enabled kernel that allows both ARMv4
and ARMv5 CPUs, and also supports THUMB mode in user space.

However, returning to user space in this configuration with the usr_ret
macro requires the use of the 'bx' instruction, which is refused by
the assembler:

arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:937: Error: selected processor does not support `bx lr' in ARM mode
arch/arm/kernel/entry-armv.S:960: Error: selected processor does not support `bx lr' in ARM mode
arch/arm/kernel/entry-armv.S:1003: Error: selected processor does not support `bx lr' in ARM mode
<instantiation>:2:2: note: instruction requires: armv4t
 bx lr

While it would be possible to handle this correctly in principle, doing so
seems to not be worth it, if we can simply avoid the problem by enforcing
that a kernel supporting both ARMv4 and a later CPU architecture cannot
run THUMB binaries.

This turned up while build-testing with clang; for some reason,
gcc never triggered the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 82aa990c4180..58afba346729 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -675,7 +675,7 @@ config ARM_PV_FIXUP
 
 config ARM_THUMB
 	bool "Support Thumb user binaries" if !CPU_THUMBONLY && EXPERT
-	depends on CPU_THUMB_CAPABLE
+	depends on CPU_THUMB_CAPABLE && !CPU_32v4
 	default y
 	help
 	  Say Y if you want to include kernel support for running user space
-- 
2.29.2

