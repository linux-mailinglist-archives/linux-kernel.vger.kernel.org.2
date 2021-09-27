Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6B4418F29
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 08:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhI0Gqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 02:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232955AbhI0Gqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 02:46:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FF8A60F4A;
        Mon, 27 Sep 2021 06:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632725094;
        bh=Ld1vVAFmYNZcXK+8yISPfBNEddduEPZhsJnF3sCzD4M=;
        h=From:To:Cc:Subject:Date:From;
        b=uYdz6qI0fThLYpXL1ZqwyNfVvPKflst0ywOhiGaSm0mmlpLVnoPs5qKju6I3K8xGr
         X9NsUfcdaAYkeUtU7lSWhkIzfGTsernqempr36+vCSjLtzjX1aKjPOhkxh1Bamq6CL
         Yg6LqRnGFYFsPVqB/T/wferp5/CM69xbi0TPDFhqcCXoVVHxyFUicL2u0lAdOrq5uw
         Tr0q0PenJY75JwU2ENW4wniSNnpr3eYY6vq4hsCTz94vFPbDnFBwcdg5ma94b/o7FV
         c7r86gJ/obfrDTY77Up3fXstg7wh4yzqE6H+CCPVuylRQWq/YwAO/HVXG0MbL91egZ
         nO1Jf3q7d55tA==
From:   guoren@kernel.org
To:     guoren@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3] mm: debug_vm_pgtable: Don't use __P000 directly
Date:   Mon, 27 Sep 2021 14:43:40 +0800
Message-Id: <20210927064340.2411397-1-guoren@kernel.org>
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
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Christoph Hellwig <hch@lst.de>

---
Changes since V3:
 - Add Reviewed-by: Anshuman Khandual
 - Add Cc: Christoph Hellwig

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

