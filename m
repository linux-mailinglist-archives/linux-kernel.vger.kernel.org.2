Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E4B41B32E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbhI1PoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:44:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241758AbhI1Pn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:43:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58BBC611BD;
        Tue, 28 Sep 2021 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843738;
        bh=20HrPlguOHn0M8K+69hCaAI8qSZhXcrez8gQx1tVSes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htL2BmgtLyCDQTTZaByWG4uMFHLESfUkX1tZvQz5DcFypt6AqFvXoU8mCbpJKVMID
         xaTHblViyswWVy9ObHuDXohCW45EbfIs+5Ex9fv7J4vi/clNJV8GuEX+Iscs3+Vr3l
         z+OalgA8Wzvf9O/4LD8mFfv60Y1rzrFJOWYNNU34r2MtLbYgA3UqkNCg62f42OzbrR
         6jNHkPniTkogd6+HW5sz+dGQ3n/J70iZbDUyXBa8SdovsaUwhRNe7q8Hd4qHaGjh04
         muUcS97Vh2ULralF87vZdj/IwqWgUmyfhyb/PwX2hO0UgoY10YsIat6c4s/9eKSbp6
         aNyPB1FogGhmQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH 09/14] ARM: allow compile-testing without machine record
Date:   Tue, 28 Sep 2021 17:41:38 +0200
Message-Id: <20210928154143.2106903-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928154143.2106903-1-arnd@kernel.org>
References: <20210928154143.2106903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A lot of randconfig builds end up not selecting any machine type at
all. This is generally fine for the purpose of compile testing, but
of course it means that the kernel is not usable on actual hardware,
and it causes a warning about this fact.

As most of the build bots now force-enable CONFIG_COMPILE_TEST for
randconfig builds, use that as a guard to control whether we warn
on this type of broken configuration.

We could do the same for the missing-cpu-type warning, but those
configurations fail to build much earlier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 2 ++
 arch/arm/kernel/vmlinux.lds.S     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index e0c00986487f..bf16fadb6a00 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -166,7 +166,9 @@ SECTIONS
  * binutils is too old (for other reasons as well)
  */
 ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
+#ifndef CONFIG_COMPILE_TEST
 ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
+#endif
 
 #ifdef CONFIG_XIP_DEFLATED_DATA
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 20c4f6d20c7a..f02d617e3359 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -174,6 +174,8 @@ __start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
  * binutils is too old (for other reasons as well)
  */
 ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
+#ifndef CONFIG_COMPILE_TEST
 ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
+#endif
 
 #endif /* CONFIG_XIP_KERNEL */
-- 
2.29.2

