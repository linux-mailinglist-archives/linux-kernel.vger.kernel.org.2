Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406F443B1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 14:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhJZMJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 08:09:45 -0400
Received: from ns.lineo.co.jp ([203.141.200.203]:41754 "EHLO mail.lineo.co.jp"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231937AbhJZMJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:09:44 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Oct 2021 08:09:44 EDT
Received: from naokihayama-desktop (vpn1.lineo.co.jp [203.141.200.204])
        by mail.lineo.co.jp (Postfix) with ESMTPSA id ACBA08021611C;
        Tue, 26 Oct 2021 21:00:37 +0900 (JST)
Received: by naokihayama-desktop (Postfix, from userid 1000)
        id 991D15000253; Tue, 26 Oct 2021 21:00:37 +0900 (JST)
From:   Naoki Hayama <naoki.hayama@lineo.co.jp>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Naoki Hayama <naoki.hayama@lineo.co.jp>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Fix superpage handling in kernel_page_present()
Date:   Tue, 26 Oct 2021 20:59:47 +0900
Message-Id: <20211026115947.11899-1-naoki.hayama@lineo.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checks by p*d_leaf() functions.
Though we don't have to use pgd_leaf() and p4d_leaf() as
of now, I include them in this patch for the future
compatibility.

I tested this patch on HiFive Unmatched.

Signed-off-by: Naoki Hayama <naoki.hayama@lineo.co.jp>
---
 arch/riscv/mm/pageattr.c | 44 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 5e49e4b4a4cc..125eea4d13c7 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -208,28 +208,40 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 bool kernel_page_present(struct page *page)
 {
 	unsigned long addr = (unsigned long)page_address(page);
-	pgd_t *pgd;
-	pud_t *pud;
-	p4d_t *p4d;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset_k(addr);
-	if (!pgd_present(*pgd))
+	pgd_t *pgdp, pgd;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep;
+
+	pgdp = pgd_offset_k(addr);
+	pgd = READ_ONCE(*pgdp);
+	if (!pgd_present(pgd))
 		return false;
+	if (pgd_leaf(pgd))
+		return true;
 
-	p4d = p4d_offset(pgd, addr);
-	if (!p4d_present(*p4d))
+	p4dp = p4d_offset(pgdp, addr);
+	p4d = READ_ONCE(*p4dp);
+	if (!p4d_present(p4d))
 		return false;
+	if (p4d_leaf(p4d))
+		return true;
 
-	pud = pud_offset(p4d, addr);
-	if (!pud_present(*pud))
+	pudp = pud_offset(p4dp, addr);
+	pud = READ_ONCE(*pudp);
+	if (!pud_present(pud))
 		return false;
+	if (pud_leaf(pud))
+		return true;
 
-	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
+	pmdp = pmd_offset(pudp, addr);
+	pmd = READ_ONCE(*pmdp);
+	if (!pmd_present(pmd))
 		return false;
+	if (pmd_leaf(pmd))
+		return true;
 
-	pte = pte_offset_kernel(pmd, addr);
-	return pte_present(*pte);
+	ptep = pte_offset_kernel(pmdp, addr);
+	return pte_present(READ_ONCE(*ptep));
 }
-- 
2.17.1

