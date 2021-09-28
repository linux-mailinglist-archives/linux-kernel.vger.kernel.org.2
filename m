Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9FB41B330
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbhI1PoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241761AbhI1PoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:44:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 832A361213;
        Tue, 28 Sep 2021 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843742;
        bh=CO94xDsc1VtfSRAfyKqtO5ONWPyRd2vlujyNsapS8kQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnijjKG41jlJwa3o/h94QbMzuYt/xrzfbVW7/HD2VIesnu/lRCqsG/OgYMX80y9IQ
         hH4/BVEka83RqpyFz6r9slWxrqp0I3VvuGyIfOzKH+fuK+ZZLaGcLE0IV3JpAeha0I
         ASE1LfkaUDQIdm7PjdJ2tgJ1FN2nzkzQqWPFLmgdf3vqv/sDRyxMT+eEamyKzMpgZl
         knvAexWpCIo2DM5H84nxqeLWz98tsxUbukm0J9R/56hS96DmM8o6p1axJ1iQR2d3pv
         4ZhohkxknS4pwtQEQv2Z/b7ozo2B1IY2gzN3qDsatFd9OH+5HmlrBdMR50JYNVmN7i
         Kr8V4dFSt98kw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH 11/14] ARM: kasan: work around LPAE build warning
Date:   Tue, 28 Sep 2021 17:41:40 +0200
Message-Id: <20210928154143.2106903-12-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928154143.2106903-1-arnd@kernel.org>
References: <20210928154143.2106903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

pgd_page_vaddr() returns an 'unsigned long' address, causing a warning
with the memcpy() call in kasan_init():

arch/arm/mm/kasan_init.c: In function 'kasan_init':
include/asm-generic/pgtable-nop4d.h:44:50: error: passing argument 2 of '__memcpy' makes pointer from integer without a cast [-Werror=int-conversion]
   44 | #define pgd_page_vaddr(pgd)                     ((unsigned long)(p4d_pgtable((p4d_t){ pgd })))
      |                                                 ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                  |
      |                                                  long unsigned int
arch/arm/include/asm/string.h:58:45: note: in definition of macro 'memcpy'
   58 | #define memcpy(dst, src, len) __memcpy(dst, src, len)
      |                                             ^~~
arch/arm/mm/kasan_init.c:229:16: note: in expansion of macro 'pgd_page_vaddr'
  229 |                pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_START)),
      |                ^~~~~~~~~~~~~~
arch/arm/include/asm/string.h:21:47: note: expected 'const void *' but argument is of type 'long unsigned int'
   21 | extern void *__memcpy(void *dest, const void *src, __kernel_size_t n);
      |                                   ~~~~~~~~~~~~^~~

Avoid this by adding an explicit typecast.

Fixes: 5615f69bc209 ("ARM: 9016/2: Initialize the mapping of KASan shadow memory")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/all/CACRpkdb3DMvof3-xdtss0Pc6KM36pJA-iy=WhvtNVnsDpeJ24Q@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 9c348042a724..4b1619584b23 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -226,7 +226,7 @@ void __init kasan_init(void)
 	BUILD_BUG_ON(pgd_index(KASAN_SHADOW_START) !=
 		     pgd_index(KASAN_SHADOW_END));
 	memcpy(tmp_pmd_table,
-	       pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_START)),
+	       (void*)pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_START)),
 	       sizeof(tmp_pmd_table));
 	set_pgd(&tmp_pgd_table[pgd_index(KASAN_SHADOW_START)],
 		__pgd(__pa(tmp_pmd_table) | PMD_TYPE_TABLE | L_PGD_SWAPPER));
-- 
2.29.2

