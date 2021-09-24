Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B1D416B68
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 08:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbhIXGIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 02:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244116AbhIXGIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 02:08:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7BAA60E97;
        Fri, 24 Sep 2021 06:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632463628;
        bh=mQgvLQUAYCNHQCu/wDtgBmgvIR6v7hDr+zZvd42AeyI=;
        h=From:To:Cc:Subject:Date:From;
        b=VwPIvCYDQzg2X+FPSGH2Qkn7V+T4MkGSt1iOoICTXBcUknFb/Notx+YfEviEOOXYJ
         7OubZtXUQ+FsIf53rbf/5E2IwsGKpvHeUd6PBfGmxoSGxkkM3MgLO7RZS2QmW/MAme
         bzmeS6aaHzzjFIj11TZIctWR1dpwV7rtHIGIn0UyMKfnT3Aqq8EzdmQYtFuipv2LdK
         bypG0nzPvzUggTmXylZDxDalXZ5zwZwR9ZobBx15Jyx0n1prAD/YuzW8uqwdaCYhN/
         MxsB0UzMWpUlNi59931npKPNDsbA06ZPtXKPrZcqQGNjwk5jKdBHwCO+g1VPNyfzY3
         y4y9OR9h44IgA==
From:   guoren@kernel.org
To:     guoren@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] mm: debug_vm_pgtable: Don't use __P000 directly
Date:   Fri, 24 Sep 2021 14:06:54 +0800
Message-Id: <20210924060654.1137902-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The __Pxxx/__Sxxx macros are only for protection_map[] init. All
usage of them in linux should come from protection_map array.

Because a lot of architectures would re-initilize protection_map[]
array, eg: x86-mem_encrypt, m68k-motorola, mips, arm, sparc.

Using __P000 is not rigorous.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

---

Changes since V2:
 - s/init protection_map[]/protection_map[] init/
 - s/Becasue/Because/
 - Remove unclear part
 - Replace __P000 and __S000 with protection_map[0] and
   protection_map[8]
---
 mm/debug_vm_pgtable.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1403639302e4..228e3954b90c 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1104,13 +1104,14 @@ static int __init init_args(struct pgtable_debug_args *args)
 	/*
 	 * Initialize the debugging data.
 	 *
-	 * __P000 (or even __S000) will help create page table entries with
-	 * PROT_NONE permission as required for pxx_protnone_tests().
+	 * protection_map[0] (or even protection_map[8]) will help create
+	 * page table entries with PROT_NONE permission as required for
+	 * pxx_protnone_tests().
 	 */
 	memset(args, 0, sizeof(*args));
 	args->vaddr              = get_random_vaddr();
 	args->page_prot          = vm_get_page_prot(VMFLAGS);
-	args->page_prot_none     = __P000;
+	args->page_prot_none     = protection_map[0];
 	args->is_contiguous_page = false;
 	args->pud_pfn            = ULONG_MAX;
 	args->pmd_pfn            = ULONG_MAX;
-- 
2.25.1

