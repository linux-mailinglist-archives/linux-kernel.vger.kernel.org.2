Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA72416B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 08:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbhIXGKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 02:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244141AbhIXGKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 02:10:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5361461107;
        Fri, 24 Sep 2021 06:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632463707;
        bh=mQgvLQUAYCNHQCu/wDtgBmgvIR6v7hDr+zZvd42AeyI=;
        h=From:To:Cc:Subject:Date:From;
        b=sPsLftsOyfYlVXG1Nz2OoqGSycAdSp+OeSkEkxj+voN4Qvl3qs2r7Fhj5pAzfwHUm
         9S/eNb9J/wtfxBrmRAvKtoLdPjwr3hDoTgER9QgFn9JvRIL4zD4yvW5m+scA+HhVLO
         5flfjqk3Fqf+/qzU1w1Qo+i3HoVyLd0jpfwIrGnnGgtpQ88mcRugiaxruUL+Dhk0Pe
         ktAlSe+2ktcKJAdmJq/F+1Q3Bk3GrDpB+nryhw8zu6o+p3/BT/Vj5XMKlCS+lfPips
         P1egHCelX29D1hHMRPdPb1aJLHUzucYcIferUrqghisAV4kpJCn1Zs4LPCueD7iLOL
         z0uoFZW0HIo7w==
From:   guoren@kernel.org
To:     guoren@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2] mm: debug_vm_pgtable: Don't use __P000 directly
Date:   Fri, 24 Sep 2021 14:08:21 +0800
Message-Id: <20210924060821.1138281-1-guoren@kernel.org>
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

