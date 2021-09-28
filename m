Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E402D41B32F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbhI1PoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241740AbhI1Pn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:43:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DD9961206;
        Tue, 28 Sep 2021 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843740;
        bh=6j5W3PeNhaqrb1ag47WKtjEaOZNAEDFZKRywAiERVWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JcpQRLmIY7uju3UPPtngKNiNR+OwKrbSdXhuV/mwt/GdB8lePBrEv+T9RS+/oe8WU
         IdVQMCxmuWhb1QowpZJzHLVKIsNtvnb3rR0pTJEotJ7CHv79XJAKkk9dcTm4uKAp9o
         cbgHXTmB+UgL1nXExUGz3sRMfvs0fTCNpC5dGdVgAz3VKdUTV3vuP28B88AV7qSfwE
         UaqVthh4Su5blhV+Hs09PHIIk4TJTz1Dvn0eiMcr4w4LOe/YSxwCloqsaV2r02N1uK
         WPC9xKpvlFc/LD/2UdO7NtbmJy4pecL8yQd1OnDE+NzleGZg93FEylePMnOTsXLBUQ
         ujW2c5sEGoNeA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH 10/14] ARM: only warn about XIP address when not compile testing
Date:   Tue, 28 Sep 2021 17:41:39 +0200
Message-Id: <20210928154143.2106903-11-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928154143.2106903-1-arnd@kernel.org>
References: <20210928154143.2106903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In randconfig builds, we sometimes come across this warning:

arm-linux-gnueabi-ld: XIP start address may cause MPU programming issues

While this is helpful for actual systems to figure out why it
fails, the warning does not provide any benefit for build testing,
so guard it in a check for CONFIG_COMPILE_TEST, which is usually
set on randconfig builds.

Fixes: 216218308cfb ("ARM: 8713/1: NOMMU: Support MPU in XIP configuration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index bf16fadb6a00..76678732c60d 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -178,7 +178,7 @@ ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
 ASSERT((_end - __bss_start) >= 12288, ".bss too small for CONFIG_XIP_DEFLATED_DATA")
 #endif
 
-#ifdef CONFIG_ARM_MPU
+#if defined(CONFIG_ARM_MPU) && !defined(CONFIG_COMPILE_TEST)
 /*
  * Due to PMSAv7 restriction on base address and size we have to
  * enforce minimal alignment restrictions. It was seen that weaker
-- 
2.29.2

