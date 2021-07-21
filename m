Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA583D1220
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbhGUOgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238083AbhGUOgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:36:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 245B061246;
        Wed, 21 Jul 2021 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626880644;
        bh=/uBtyK2U7BD8Q45Q0cNkKmotxwn41fmtF4LDSn7thOw=;
        h=From:To:Cc:Subject:Date:From;
        b=Nkd0f/MdfW+V4naOY7BF+n2vt8NvlY8HbOXbeoPnnGiOxARh026DwRAFhettuAwq4
         8Ldot67fdGtVCkqngyHShRw+H4h6XAVYthtiuQPHtb/yQTE4P4iUCgWrfyv/sUvsTn
         mKW66Lmb5EvLKiwTrGBT2QNvitLVcbRPH6WLWjMjd82L0EMy56R25LOfJwV8wJ26uj
         LUoVoeWAnt+VPuFgaHOOil2J9YesjRn5NckMCFipm++/oWtm6zlsv/u5K2+8zvCQ3K
         hKItmXCAyz8VcAd/jjrUJ1vRu5M0ia/ZQhrNxV3CTWhiHG3xvU6C2j8tz7HNk9fYXy
         fsbtiEdp8xCnw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: kasan: work around LPAE build warning
Date:   Wed, 21 Jul 2021 17:16:59 +0200
Message-Id: <20210721151706.2439073-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
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

