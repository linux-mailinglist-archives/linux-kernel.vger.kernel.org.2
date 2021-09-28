Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1541B327
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhI1Pnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241730AbhI1Pno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:43:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51D8B61262;
        Tue, 28 Sep 2021 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843725;
        bh=rrsS5AFXKM3ytp6XhzCbbxVjilQ1UQwXqY9Io+ZYNdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJuBy/q/WJQB014QxBCA9uTGswQUARzuNSoMTQG/u99ldLPqd45P0HmXTa33CjXdr
         I6vM5elhjvNPWqt25H0Qho3MIjNbUz5Z00KBzcNhFFyOAlmDL+cOA5YLi+5SPk1Z/v
         95z2Y/dVs+/EBNq11//rqv6mZOLO+v5sfYMmS5Sa2CBGisYVyshF2DGpF4FH26Q6qF
         yT+jJQOD6985t2jW6sQ+cwxhWLePIihxaghxQm51f1+auWwlJT8rKPYEiIbvMHCnXx
         napmWkXl4p8AivKfMvXq3Uj5Zf+rj9VWCduFoiUnWMvlxyzxDLdaVtmRQX3+GkXMdo
         lyCoZLyHfZ7zg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH 03/14] ARM: remove duplicate memcpy() definition
Date:   Tue, 28 Sep 2021 17:41:32 +0200
Message-Id: <20210928154143.2106903-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928154143.2106903-1-arnd@kernel.org>
References: <20210928154143.2106903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Both the decompressor code and the kasan logic try to override
the memcpy() and memmove()  definitions, which leading to a clash
in a KASAN-enabled kernel with XZ decompression:

arch/arm/boot/compressed/decompress.c:50:9: error: 'memmove' macro redefined [-Werror,-Wmacro-redefined]
 #define memmove memmove
        ^
arch/arm/include/asm/string.h:59:9: note: previous definition is here
 #define memmove(dst, src, len) __memmove(dst, src, len)
        ^
arch/arm/boot/compressed/decompress.c:51:9: error: 'memcpy' macro redefined [-Werror,-Wmacro-redefined]
 #define memcpy memcpy
        ^
arch/arm/include/asm/string.h:58:9: note: previous definition is here
 #define memcpy(dst, src, len) __memcpy(dst, src, len)
        ^

Here we want the set of functions from the decompressor, so undefine
the other macros before the override.

Fixes: d6d51a96c7d6 ("ARM: 9014/2: Replace string mem* functions for KASan")
Fixes: a7f464f3db93 ("ARM: 7001/2: Wire up support for the XZ decompressor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/compressed/decompress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index aa075d8372ea..5b387c60accd 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -47,7 +47,9 @@ extern char * strchrnul(const char *, int);
 #endif
 
 #ifdef CONFIG_KERNEL_XZ
+#undef memmove
 #define memmove memmove
+#undef memcpy
 #define memcpy memcpy
 #include "../../../../lib/decompress_unxz.c"
 #endif
-- 
2.29.2

