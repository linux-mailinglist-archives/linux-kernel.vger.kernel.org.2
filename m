Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06A63EADAB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbhHLXic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238019AbhHLXiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF3F8610A5;
        Thu, 12 Aug 2021 23:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811479;
        bh=SDwFDPOQmz/pmHMM+4prMbb/FBKaF/3A8kiP4jUiFjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=roa0nbg6P0b49j69EM6FvuJQOVTYh9WC3m/MSLBaWFNjUV+xkyM3Sep4d0y4LtEHo
         f5CaYtQWvkn4tZ3DHgCgkHKPXNkc+32AAjUCGiV39QnXL3t5bdYB/5wGizl+5rc2Cn
         9DaypbSSEqCr1e3eBWDofGqHqUwVLMVjgPNujXwg/B0jYRDyrnN8c1o9foaRw7+0hm
         iZ3uHbCyeDgFh1QMjdXKP5Go5wH/hXnkju2P+6OelxdXM3z/eOh5Zm/sf+xKs7eEv5
         +qBR8Iaju8svs91k0gm4lKV3K7Cls/dHPTqk+BHqo9h0NODF2NAm7K9k486yY4Ka9H
         /djBZrU5z5bnA==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 04/19] ARC: mm: Fixes to allow STRICT_MM_TYPECHECKS
Date:   Thu, 12 Aug 2021 16:37:38 -0700
Message-Id: <20210812233753.104217-5-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
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

