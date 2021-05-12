Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569B637B8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhELJCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhELJCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:02:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FEDF61403;
        Wed, 12 May 2021 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620810093;
        bh=zG9OP4EUNrKHbg0lDClVXB7imXazcWV3M6RxRM30/B0=;
        h=From:To:Cc:Subject:Date:From;
        b=Td7SRIdSsGHyhuayIkYNwak11j2m/4FOJ85kSV/oyueaB18U9WQrRhAEEGxV9gBO7
         qze70HHr0sSi0HjBceE4O0YHfI2bJz0pGlrObkk0eQujgBMmAcunIl7f6Lis0o0lMN
         FZ2zQXOUpWFUQCjng+DssUZAqLrfmEwPS8tdO3ThV1UM5xj3D/Nrjd6IuWHpySMc83
         eWYybrFXaModi8Uy6esqUk5mGujB26AZBvRaz1Ia8h6XQkQKyTHntJwgw4LKbpyfeJ
         +FaEjmR14mfJPPkMMd1WUFuMhMyg1L2uhH9tlGJxbIa0nMLodTZhUdpLm57lisqlle
         Ea+Dt6uVv9qVQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ARM: mark prepare_page_table as __init
Date:   Wed, 12 May 2021 11:00:42 +0200
Message-Id: <20210512090047.2069033-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In some configurations when building with gcc-11, prepare_page_table
does not get inline, which causes a build time warning for a section
mismatch:

WARNING: modpost: vmlinux.o(.text.unlikely+0xce8): Section mismatch in reference from the function prepare_page_table() to the (unknown reference) .init.data:(unknown)
The function prepare_page_table() references
the (unknown reference) __initdata (unknown).
This is often because prepare_page_table lacks a __initdata
annotation or the annotation of (unknown) is wrong.

Mark the function as __init to avoid the warning regardless of the
inlining, and remove the 'inline' keyword. The compiler is
free to ignore the 'inline' here and it doesn't result in better
object code or more readable source.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: remove 'inline', as suggested by Russell and Ard
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 051f4f82414b..40a1fa5ec93b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1246,7 +1246,7 @@ void __init adjust_lowmem_bounds(void)
 	memblock_set_current_limit(memblock_limit);
 }
 
-static inline void prepare_page_table(void)
+static __init void prepare_page_table(void)
 {
 	unsigned long addr;
 	phys_addr_t end;
-- 
2.29.2

