Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962CF4556DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbhKRIWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbhKRIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:22:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83662C0432E3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:18:28 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z6so3390469plk.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=cZ+YA8uAzApfXRQQGU6EpEsIwHWl1lHGZYEmkQkBhzo=;
        b=cDwrnb4aNFg6kGJfRpci4saVKp9WwBYstRoJ9IEugLZKi87EST/F7M1qXnu7J2ok/4
         ZcrVJavz89knFtMW0q/I4Fk6vYCG9Y5kmMwipfF0e5NpxET602HWoABwrloMbTdg7Opy
         UlFcec2RzTyjQ/9rX+gfUcmqB8YoOB6vRgp611AfO6sd8EAF9sz9g4rqp2W69L9B9D2A
         GcnSzz/K2KlRtTFwNwcftOaNZgGjBt1W053Wyxp/aOZIziVWbi63/44H5E+OWjH3lS0y
         E7Q1LrlP6EY6ijozc68K8jDU6RdoWCpiPYo2Y4+WbH0eBkd+5WhYQdXViOT9tKuNBBDV
         40AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=cZ+YA8uAzApfXRQQGU6EpEsIwHWl1lHGZYEmkQkBhzo=;
        b=61ijVEJzvG3VMzphuDwedWZraFL1c/o8JAhbjaogxPEzzRKb2tvx2ecB3R1k3bBDfa
         +KdvmhGi9ghoVxOeLNmFssYUQb9Y1Sx42lRxb7lSWDokThvVkUDtZyETrhWUx+bJtYi/
         HADVqlvDjIlBiUMScHFHVE+aFXsZY2t9+y1MB7d2TeyJEnEDKc8t4xVigMd5rE6w2pYp
         p1Ipesn+urSEGAi2yKgNSXXuEPD0djL4OqBEV5oSEDdxq3butUkiwY763Snkyrs/Bp2Z
         dJuL9foHAadWK3a8MmbIe2n0mEBTb72hyMJYERF3hrSTPHiAsuEn++zRLoXSLvxkpA53
         ejsw==
X-Gm-Message-State: AOAM531Q4YoSXpB32UwDMChr7/iqhnIELl/SydICv7i90StB4nGT/JJe
        GDR8JkWRY6/9yW+iJT+T5aU=
X-Google-Smtp-Source: ABdhPJwCx6Y69smeN1eEBx4ltoy2FmVuGGdC0A2LA+y9NC70l7kpBNN/WdakR5rIOQdrMIwNqGEViQ==
X-Received: by 2002:a17:902:d490:b0:141:fd0f:5316 with SMTP id c16-20020a170902d49000b00141fd0f5316mr63602417plg.14.1637223508108;
        Thu, 18 Nov 2021 00:18:28 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v1sm2000265pfg.169.2021.11.18.00.18.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 00:18:27 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] arch: arm64: try to use PTE_CONT when change page attr
Date:   Thu, 18 Nov 2021 16:18:03 +0800
Message-Id: <1637223483-2867-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

kernel will use the min granularity when rodata_full enabled which
make TLB pressure high. Furthermore, there is no PTE_CONT applied.
Try to improve these a little by apply PTE_CONT when change page's
attr.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 arch/arm64/mm/pageattr.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index a3bacd7..0b6a354 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -61,8 +61,13 @@ static int change_memory_common(unsigned long addr, int numpages,
 	unsigned long start = addr;
 	unsigned long size = PAGE_SIZE * numpages;
 	unsigned long end = start + size;
+	unsigned long cont_pte_start = 0;
+	unsigned long cont_pte_end = 0;
+	unsigned long cont_pmd_start = 0;
+	unsigned long cont_pmd_end = 0;
+	pgprot_t orig_set_mask = set_mask;
 	struct vm_struct *area;
-	int i;
+	int i = 0;
 
 	if (!PAGE_ALIGNED(addr)) {
 		start &= PAGE_MASK;
@@ -98,9 +103,58 @@ static int change_memory_common(unsigned long addr, int numpages,
 	 */
 	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
 			    pgprot_val(clear_mask) == PTE_RDONLY)) {
-		for (i = 0; i < area->nr_pages; i++) {
-			__change_memory_common((u64)page_address(area->pages[i]),
-					       PAGE_SIZE, set_mask, clear_mask);
+		cont_pmd_start = (start + ~CONT_PMD_MASK + 1) & CONT_PMD_MASK;
+		cont_pmd_end = cont_pmd_start + ~CONT_PMD_MASK + 1;
+		cont_pte_start = (start + ~CONT_PTE_MASK + 1) & CONT_PTE_MASK;
+		cont_pte_end = cont_pte_start + ~CONT_PTE_MASK + 1;
+
+		if (addr <= cont_pmd_start && end > cont_pmd_end) {
+			do {
+				__change_memory_common((u64)page_address(area->pages[i]),
+						PAGE_SIZE, set_mask, clear_mask);
+				i++;
+				addr++;
+			} while(addr < cont_pmd_start);
+			do {
+				set_mask = __pgprot(pgprot_val(set_mask) | PTE_CONT);
+				__change_memory_common((u64)page_address(area->pages[i]),
+						PAGE_SIZE, set_mask, clear_mask);
+				i++;
+				addr++;
+			} while(addr < cont_pmd_end);
+			set_mask = orig_set_mask;
+			do {
+				__change_memory_common((u64)page_address(area->pages[i]),
+						PAGE_SIZE, set_mask, clear_mask);
+				i++;
+				addr++;
+			} while(addr <= end);
+		} else if (addr <= cont_pte_start && end > cont_pte_end) {
+			do {
+				__change_memory_common((u64)page_address(area->pages[i]),
+						PAGE_SIZE, set_mask, clear_mask);
+				i++;
+				addr++;
+			} while(addr < cont_pte_start);
+			do {
+				set_mask = __pgprot(pgprot_val(set_mask) | PTE_CONT);
+				__change_memory_common((u64)page_address(area->pages[i]),
+						PAGE_SIZE, set_mask, clear_mask);
+				i++;
+				addr++;
+			} while(addr < cont_pte_end);
+			set_mask = orig_set_mask;
+			do {
+				__change_memory_common((u64)page_address(area->pages[i]),
+						PAGE_SIZE, set_mask, clear_mask);
+				i++;
+				addr++;
+			} while(addr <= end);
+		} else {
+			for (i = 0; i < area->nr_pages; i++) {
+				__change_memory_common((u64)page_address(area->pages[i]),
+						PAGE_SIZE, set_mask, clear_mask);
+			}
 		}
 	}
 
-- 
1.9.1

