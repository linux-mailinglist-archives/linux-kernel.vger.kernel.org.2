Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF741B329
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbhI1Pny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241645AbhI1Pns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:43:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F3786124A;
        Tue, 28 Sep 2021 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843729;
        bh=CBSGNM1iI7xF61HbwvXZEXTVfHCXl92PwnqkdtpkV1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQp2Rc+gxrZWKUTIrH3JjAUcWeGw2yzUfkG+ML3ZsrcHhyepXKHUoBIyHe+tCWfjg
         PoFaLNBt4/esG+rK//VyRcFicAcaXx+Drl+WJ41c4yaJ2GPXhV757N23A/JW7rdnjC
         W5zgU+CGM+lZhxzn2Gq4wNZm+QKt5RrHC2vnPcqJaRmbWx0lrYCTZ0TM/gTgxd6rZk
         Ek5Dy1Ijyq0M0jd5nx0bT1pQI1s0FlGdXc/+o0hybiXKAirpQQgTipH/Bms3arCckk
         rbtlbVMXOBIQhudI4dshES6QJ5yeFXxnBYZ0S4936PrhGVQrVvNUAQt0k3FJN/wdlZ
         G8viTvkjBCcRw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 05/14] ARM: ARMv7-M uses BE-8, not BE-32
Date:   Tue, 28 Sep 2021 17:41:34 +0200
Message-Id: <20210928154143.2106903-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928154143.2106903-1-arnd@kernel.org>
References: <20210928154143.2106903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When configuring the kernel for big-endian, we set either BE-8 or BE-32
based on the CPU architecture level. Until linux-4.4, we did not have
any ARMv7-M platform allowing big-endian builds, but now i.MX/Vybrid
is in that category, adn we get a build error because of this:

arch/arm/kernel/module-plts.c: In function 'get_module_plt':
arch/arm/kernel/module-plts.c:60:46: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]

This comes down to picking the wrong default, ARMv7-M uses BE8
like ARMv7-A does. Changing the default gets the kernel to compile
and presumably works.

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
https://lore.kernel.org/all/1455804123-2526139-2-git-send-email-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 8355c3895894..82aa990c4180 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -750,7 +750,7 @@ config CPU_BIG_ENDIAN
 config CPU_ENDIAN_BE8
 	bool
 	depends on CPU_BIG_ENDIAN
-	default CPU_V6 || CPU_V6K || CPU_V7
+	default CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M
 	help
 	  Support for the BE-8 (big-endian) mode on ARMv6 and ARMv7 processors.
 
-- 
2.29.2

