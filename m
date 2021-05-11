Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFA37A2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhEKJFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhEKJFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:05:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1D9D6161F;
        Tue, 11 May 2021 09:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620723842;
        bh=pbA8eDUPg6Mq4QyVblPhji3gPa2YxilPRFhuNV14x0E=;
        h=From:To:Cc:Subject:Date:From;
        b=R/Vyn2WATe9G1aKnC5ZzQD5Fw6EVirjYxfLNyYpwUFH2O9A03wX/n9M5ayIDI0OdH
         tKRjQWdF1i8N/9g8Zq5cN05UEJIUvYvvqOjqVuMGHjNNzHwEMeNMwlmPdzgvzeAtDk
         cd6kYiRFa9R4jtk/aT6y2i7YDgS9RUCWLCAaiwQdmgTGejzafht5q8Xo/nCElmAeyM
         2krDREWFRsEM2B2LVwhqLi0Id26Z5Acgp4Jsvro/k3uBnd+DrizbJ9aNqX9q4q9twV
         UCX2oYtAnckT+CHEGirkrLwGgglgUFpZglLaxo5TvTIKupes7cU7n/gqi+ZqbAQwrp
         ZKWxXw5UGfTAA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong Liu <carver4lio@163.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mark prepare_page_table as __init
Date:   Tue, 11 May 2021 11:03:13 +0200
Message-Id: <20210511090318.478586-1-arnd@kernel.org>
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
inlining.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 051f4f82414b..5220b8147f40 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1246,7 +1246,7 @@ void __init adjust_lowmem_bounds(void)
 	memblock_set_current_limit(memblock_limit);
 }
 
-static inline void prepare_page_table(void)
+static inline __init void prepare_page_table(void)
 {
 	unsigned long addr;
 	phys_addr_t end;
-- 
2.29.2

