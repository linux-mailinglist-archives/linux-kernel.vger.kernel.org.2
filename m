Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CEB44D57E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhKKLFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232997AbhKKLFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:05:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D285361994;
        Thu, 11 Nov 2021 11:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636628579;
        bh=io70YJK4yAFGUOIUrCZJ3liy25qxmLC6azAgejVa/ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9ApuoLFEXqE0veS2bv8DIkiT1u+YiDiuUnf4yE5txjwl++NRGwIZOtT51/S327lq
         4fEq7fEdlNrR5cUXBD93tT3/md0iJWkYyt0FQq5brHDJGv/IY6sDQqxD06W2EEgT3m
         PyGu//sQQNDrrNfexz6SEskRbLmNFU3h+hRQPHcbMUw7j9xL6DRi8EqxWbGPgcDlRz
         +z4+etMaINXitGOrnzpAv5esQbDuACvyEfDCIw8Doz77FW7m54HClICmLxcbVVtf6S
         T9L2F2ke8CoXNTgojQRXps1+Pzk5c6IqcWVJznWM0Z6Qgxr4Y54TCoKKkuKn3u5QHn
         P+cLYggqXOHvg==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] x86/mm: init_64: make set_pte_vaddr_p4d static
Date:   Thu, 11 Nov 2021 13:02:40 +0200
Message-Id: <20211111110241.25968-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211111110241.25968-1-rppt@kernel.org>
References: <20211111110241.25968-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The function set_pte_vaddr_p4d() is never called outside the file
arch/x86/mm/init_64.c.

Make it static.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/include/asm/pgtable_64.h | 1 -
 arch/x86/mm/init_64.c             | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 56d0399a0cd1..9f4b6d48ce2b 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -59,7 +59,6 @@ static inline bool mm_p4d_folded(struct mm_struct *mm)
 	return !pgtable_l5_enabled();
 }
 
-void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte);
 void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_pte);
 
 static inline void native_set_pte(pte_t *ptep, pte_t pte)
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 9a24532d2b85..e46d2f18d895 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -302,7 +302,8 @@ static void __set_pte_vaddr(pud_t *pud, unsigned long vaddr, pte_t new_pte)
 	flush_tlb_one_kernel(vaddr);
 }
 
-void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte)
+static void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr,
+			      pte_t new_pte)
 {
 	p4d_t *p4d = p4d_page + p4d_index(vaddr);
 	pud_t *pud = fill_pud(p4d, vaddr);
-- 
2.28.0

