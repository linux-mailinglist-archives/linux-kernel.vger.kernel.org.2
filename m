Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D84312976
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 04:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBHDi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 22:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHDiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 22:38:54 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94AC06178A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 19:38:14 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u11so7058230plg.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 19:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4C5iLZlVvdkZC9NTP4RSEn9cQKbnXPASByXOW3WHX6w=;
        b=eVRAB6HjcS3MEfypq3MRp+KECOKyhAXle9CP+q63DdAPT3/trm41iQMYVXBR32f6qR
         wXb3uq2y8l7ke7t/yq+9csLm4NpAQfXTUaUH7tDnlnIxu4DCItSLHJNnGqJUqdZQ29WQ
         M+jttZaAq/MP2DtY1GzrWXotPb7rUUttgELwDsY8YBNNCLVByqLvFxhnPPvbqyRYMN6f
         7xUXAXz2B1lRHp9MaWZwRGhhTQd8/yFEJ62BGlARwNgFd3K+j2tlrPpq6JKrxgQkn0cl
         Oq7n23eiIA9jl6yP1g0ewMMF+OiQpFTMp8rhYi4kcmY3nFp9Otpy5RSVb70SGmETCbEI
         YjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4C5iLZlVvdkZC9NTP4RSEn9cQKbnXPASByXOW3WHX6w=;
        b=kTwhyE5kG54AE1eEtOMoYvF1q51885bryFBgFDMpsRdF5u/B6EWZj0kKZHOHlPoZI4
         pFCIOxlY7i6B9PR/JdrILhFMUuWDjgtn/jtVb679woWUOvEpng867qojt1fh6DKxEy5m
         OUk3hj4Qrr+gbmk3qk9XU9nhQ/VuJmJ9vFnfEw0+GGp0zujzePDEvMdcNnXqG3OBDS1j
         22PUXVHYz6RJyEejkPw91RnXuzEtIFLcnbP2LFyfwfdtyuzfe7rDqNdIRhXyYLR4pBVJ
         XYe2FvCqhzkoUaY5crMX7JSlZhS/I4KDsk7spbisoOzcTLdjeNJvfdeFs86aMVIUvsWz
         uAgw==
X-Gm-Message-State: AOAM5332kbS9Mpkcu+yW0pNKL9jmpHrPGxt9qWpDFKX5t6EWIJbgml/2
        wLvAh0/uiLtB+TvUqORlywXrDIO6I7i/eldaZsI=
X-Google-Smtp-Source: ABdhPJzyNkSK5CkI0uUrktjXdhZGDZDMe3jbRWs7L+GVqg03fPrNRtqrEewEqJzVl/mPHrnNil6NAg==
X-Received: by 2002:a17:90b:17c7:: with SMTP id me7mr14879930pjb.205.1612755494058;
        Sun, 07 Feb 2021 19:38:14 -0800 (PST)
Received: from localhost.localdomain ([2600:3c01::f03c:91ff:fe03:4f59])
        by smtp.gmail.com with ESMTPSA id j73sm3481178pfd.170.2021.02.07.19.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 19:38:13 -0800 (PST)
From:   hev <r@hev.cc>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangrui <wangrui@loongson.cn>, hev <r@hev.cc>
Subject: [RFC PATCH v1] MIPS: tlbex: Avoid access invalid address when pmd is modifying
Date:   Mon,  8 Feb 2021 11:37:43 +0800
Message-Id: <20210208033743.1105739-1-r@hev.cc>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangrui <wangrui@loongson.cn>

When modifying pmd through THP, invalid address access may occurs in the tlb
handler. Because the tlb handler loads value of pmd twice, one is used for huge
page testing and the other is used to load pte. So these two values may be
different:

   CPU 0: (app)                     CPU 1: (khugepaged)
1:                                  scan hit: set pmd to invalid_pmd_table
                                    (pmd_clear)
2: tlb invalid: handle_tlbl,
   load pmd for huge page testing,
   is not a huge page
3:                                  collapsed: set pmd to huge page
4: handle_tlbl: load pmd again for
   load pte(as base address), the
   value of pmd is not an address,
   access invalid address!

This patch avoids the inconsistency of two memory loads by reusing the result
of one load.

Signed-off-by: hev <r@hev.cc>
Signed-off-by: wangrui <wangrui@loongson.cn>
---
 arch/mips/mm/tlbex.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a7521b8f7658..66ca219b4457 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -720,14 +720,14 @@ static void build_huge_tlb_write_entry(u32 **p, struct uasm_label **l,
  * Check if Huge PTE is present, if so then jump to LABEL.
  */
 static void
-build_is_huge_pte(u32 **p, struct uasm_reloc **r, unsigned int tmp,
-		  unsigned int pmd, int lid)
+build_is_huge_pte(u32 **p, struct uasm_reloc **r, unsigned int out,
+		  unsigned int tmp, unsigned int pmd, int lid)
 {
-	UASM_i_LW(p, tmp, 0, pmd);
+	UASM_i_LW(p, out, 0, pmd);
 	if (use_bbit_insns()) {
-		uasm_il_bbit1(p, r, tmp, ilog2(_PAGE_HUGE), lid);
+		uasm_il_bbit1(p, r, out, ilog2(_PAGE_HUGE), lid);
 	} else {
-		uasm_i_andi(p, tmp, tmp, _PAGE_HUGE);
+		uasm_i_andi(p, tmp, out, _PAGE_HUGE);
 		uasm_il_bnez(p, r, tmp, lid);
 	}
 }
@@ -1103,7 +1103,6 @@ EXPORT_SYMBOL_GPL(build_update_entries);
 struct mips_huge_tlb_info {
 	int huge_pte;
 	int restore_scratch;
-	bool need_reload_pte;
 };
 
 static struct mips_huge_tlb_info
@@ -1118,7 +1117,6 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 
 	rv.huge_pte = scratch;
 	rv.restore_scratch = 0;
-	rv.need_reload_pte = false;
 
 	if (check_for_high_segbits) {
 		UASM_i_MFC0(p, tmp, C0_BADVADDR);
@@ -1323,7 +1321,6 @@ static void build_r4000_tlb_refill_handler(void)
 	} else {
 		htlb_info.huge_pte = K0;
 		htlb_info.restore_scratch = 0;
-		htlb_info.need_reload_pte = true;
 		vmalloc_mode = refill_noscratch;
 		/*
 		 * create the plain linear handler
@@ -1349,19 +1346,19 @@ static void build_r4000_tlb_refill_handler(void)
 #endif
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
-		build_is_huge_pte(&p, &r, K0, K1, label_tlb_huge_update);
+		build_is_huge_pte(&p, &r, K0, K1, K1, label_tlb_huge_update);
 #endif
 
-		build_get_ptep(&p, K0, K1);
-		build_update_entries(&p, K0, K1);
+		GET_CONTEXT(&p, K1); /* get context reg */
+		build_adjust_context(&p, K1);
+		UASM_i_ADDU(&p, K0, K0, K1); /* add in offset */
+		build_update_entries(&p, K1, K0);
 		build_tlb_write_entry(&p, &l, &r, tlb_random);
 		uasm_l_leave(&l, p);
 		uasm_i_eret(&p); /* return from trap */
 	}
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	uasm_l_tlb_huge_update(&l, p);
-	if (htlb_info.need_reload_pte)
-		UASM_i_LW(&p, htlb_info.huge_pte, 0, K1);
 	build_huge_update_entries(&p, htlb_info.huge_pte, K1);
 	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
 				   htlb_info.restore_scratch);
@@ -2065,14 +2062,13 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
 	 * see if we need to jump to huge tlb processing.
 	 */
-	build_is_huge_pte(p, r, wr.r1, wr.r2, label_tlb_huge_update);
+	build_is_huge_pte(p, r, wr.r3, wr.r1, wr.r2, label_tlb_huge_update);
 #endif
 
 	UASM_i_MFC0(p, wr.r1, C0_BADVADDR);
-	UASM_i_LW(p, wr.r2, 0, wr.r2);
 	UASM_i_SRL(p, wr.r1, wr.r1, PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2);
 	uasm_i_andi(p, wr.r1, wr.r1, (PTRS_PER_PTE - 1) << PTE_T_LOG2);
-	UASM_i_ADDU(p, wr.r2, wr.r2, wr.r1);
+	UASM_i_ADDU(p, wr.r2, wr.r3, wr.r1);
 
 #ifdef CONFIG_SMP
 	uasm_l_smp_pgtable_change(l, *p);
-- 
2.30.0

