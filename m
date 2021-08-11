Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1543B3E8757
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhHKAnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235981AbhHKAnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C1C06101D;
        Wed, 11 Aug 2021 00:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642598;
        bh=SDwFDPOQmz/pmHMM+4prMbb/FBKaF/3A8kiP4jUiFjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkJz7h7+oRGr3Xu1DUppMJk0wp3gXJP97aJv06qXq1C4tMizWAXPfFe5GyVCcMKmT
         +vPP/Ls42lfy8cgY4VR+nEGmA3S59MGj1hVyPixzMORUsnw2WxfPJqoCRGZuTx0mdD
         RdowomDxp3/FtdZbae2lZGnJAvVQb3RJrx1SPcmtMcvRC8+cMDbj6UVbitRzs6Ti9w
         x4iWLmXJXWjEHmuPA59CjG8jRhMnzUCdq/fdTSXgaZLh4dDN5MmG4PsFU4Zb58WdRF
         9LkrTwbllbHu4pkenQgBHaTko3uU7oTXGT4YJqugupg64C+RCKItUwjwomN0F5mOG3
         bd2XlgnvbUzaQ==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 05/18] ARC: mm: Fixes to allow STRICT_MM_TYPECHECKS
Date:   Tue, 10 Aug 2021 17:42:45 -0700
Message-Id: <20210811004258.138075-6-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811004258.138075-1-vgupta@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/mm/tlb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 6079dfd129b9..15cbc285b0de 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -71,7 +71,7 @@ static void tlb_entry_erase(unsigned int vaddr_n_asid)
 	}
 }
 
-static void tlb_entry_insert(unsigned int pd0, pte_t pd1)
+static void tlb_entry_insert(unsigned int pd0, phys_addr_t pd1)
 {
 	unsigned int idx;
 
@@ -109,13 +109,16 @@ static void tlb_entry_erase(unsigned int vaddr_n_asid)
 	write_aux_reg(ARC_REG_TLBCOMMAND, TLBDeleteEntry);
 }
 
-static void tlb_entry_insert(unsigned int pd0, pte_t pd1)
+static void tlb_entry_insert(unsigned int pd0, phys_addr_t pd1)
 {
 	write_aux_reg(ARC_REG_TLBPD0, pd0);
-	write_aux_reg(ARC_REG_TLBPD1, pd1);
 
-	if (is_pae40_enabled())
+	if (!is_pae40_enabled()) {
+		write_aux_reg(ARC_REG_TLBPD1, pd1);
+	} else {
+		write_aux_reg(ARC_REG_TLBPD1, pd1 & 0xFFFFFFFF);
 		write_aux_reg(ARC_REG_TLBPD1HI, (u64)pd1 >> 32);
+	}
 
 	write_aux_reg(ARC_REG_TLBCOMMAND, TLBInsertEntry);
 }
@@ -391,7 +394,7 @@ void create_tlb(struct vm_area_struct *vma, unsigned long vaddr, pte_t *ptep)
 	unsigned long flags;
 	unsigned int asid_or_sasid, rwx;
 	unsigned long pd0;
-	pte_t pd1;
+	phys_addr_t pd1;
 
 	/*
 	 * create_tlb() assumes that current->mm == vma->mm, since
-- 
2.25.1

