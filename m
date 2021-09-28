Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCAA41B32C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbhI1Pn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241761AbhI1Pnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:43:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4B4061206;
        Tue, 28 Sep 2021 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843733;
        bh=YUTkeqO15Fma8yWD34z1Lh7SHxgvyx1Y5p/CZcT9xhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgQ0sRJdNp3fuetg6bKoMk21ysseY9OodqNAVvrxVtT4YvKwyDQ/p4XURIpEPS9Hh
         AL3PMlSNzbChQSXiG1Aw5p/5y/xxdRSK7Xv3TXi6wHAXlzvUe2nTzr9tKM2EkQzXxI
         N2kOlOZM1Ua3IPmx6EvGijVfUZB9OycIWURi/HlA7JI+fWJJ6OWpU69wywJhrIOgFa
         +Wg1EVnKLReT1qnbM2lHAQt07X0D8623UumIgdaLSZqOZTJarUkfw9iZ/2nIpWMRmu
         ZPIVqcq6B2UtI5+frU+0IICl6NZFVRNQv2Tckg+tWHpgkKxd3Oc4PBoCcYkgtdrApq
         aREcHDV9GQ7ug==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Kees Cook <keescook@chromium.org>
Subject: [PATCH 07/14] ARM: fix link warning with XIP + frame-pointer
Date:   Tue, 28 Sep 2021 17:41:36 +0200
Message-Id: <20210928154143.2106903-8-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928154143.2106903-1-arnd@kernel.org>
References: <20210928154143.2106903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When frame pointers are used instead of the ARM unwinder,
and the kernel is built using clang with an external assembler
and CONFIG_XIP_KERNEL, every file produces two warnings
like:

arm-linux-gnueabi-ld: warning: orphan section `.ARM.extab' from `net/mac802154/util.o' being placed in section `.ARM.extab'
arm-linux-gnueabi-ld: warning: orphan section `.ARM.exidx' from `net/mac802154/util.o' being placed in section `.ARM.exidx'

The same fix was already merged for the normal (non-XIP)
linker script, with a longer description.

Fixes: c39866f268f8 ("arm/build: Always handle .ARM.exidx and .ARM.extab sections")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 50136828f5b5..e0c00986487f 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -40,6 +40,10 @@ SECTIONS
 		ARM_DISCARD
 		*(.alt.smp.init)
 		*(.pv_table)
+#ifndef CONFIG_ARM_UNWIND
+		*(.ARM.exidx) *(.ARM.exidx.*)
+		*(.ARM.extab) *(.ARM.extab.*)
+#endif
 	}
 
 	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
-- 
2.29.2

