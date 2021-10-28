Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE0643E19C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhJ1NJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:09:39 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:52441 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhJ1NJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:09:37 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Hg5SF3GNPz9sSx;
        Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tvGwtnYp-lih; Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Hg5SF2TNVz9sSg;
        Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 419078B787;
        Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eqfnO5qTU4i5; Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.217])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1353C8B763;
        Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19SCxHHx195803
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 14:59:17 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19SCxFn5195802;
        Thu, 28 Oct 2021 14:59:15 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc: Don't provide __kernel_map_pages() without ARCH_SUPPORTS_DEBUG_PAGEALLOC
Date:   Thu, 28 Oct 2021 14:59:15 +0200
Message-Id: <971b69739ff4746252e711a9845210465c023a9e.1635425947.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1635425954; l=1115; s=20211009; h=from:subject:message-id; bh=LxlwKSgR4iWA1DQx6k6WwBk3KZkX6hJQqb0HjweCiQg=; b=QFpxsaYfvyxKVMiy03gV7TAuhARS2grI6N6AL6sMRvnBlfWWD5yDEpCh4M+QgTXfhuhYFmhli2GY EG/egSvOAmreQ8Me0DTPHFr3LZqLYD7MLCsEX+PXLKdhmCafXxWs
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ARCH_SUPPORTS_DEBUG_PAGEALLOC is not selected, the user can
still select CONFIG_DEBUG_PAGEALLOC in which case __kernel_map_pages()
is provided by mm/page_poison.c

So only define __kernel_map_pages() when both
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC and CONFIG_DEBUG_PAGEALLOC
are defined.

Fixes: 68b44f94d637 ("powerpc/booke: Disable STRICT_KERNEL_RWX, DEBUG_PAGEALLOC and KFENCE")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/pgtable_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index dcf5ecca19d9..fde1ed445ca4 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -173,7 +173,7 @@ void mark_rodata_ro(void)
 }
 #endif
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
+#if defined(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) && defined(CONFIG_DEBUG_PAGEALLOC)
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	unsigned long addr = (unsigned long)page_address(page);
-- 
2.31.1

