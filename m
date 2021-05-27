Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A673931D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbhE0PJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbhE0PHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:50 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295BAC061763
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:57 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 5so277502qvk.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KXQ+yohNMyyqRPEeNONrEzPBCefWBOBuVaWouKl2Q04=;
        b=Iq2Q5NY3yposm0EzkEbNN3/+GTxojDq2PR6h8IMwJ6xZAn+A1cRGovJwR2aPkV8hn7
         w+eFIRjxUsghtCzfIod0bzTDP+pcAgOSje5vB8U3q+aXKe+waXT2d6Ggk1uAUzfsA4gf
         +QgHKhRNtnebjuIuJILNouevRpewJ1PPo8mfAdzpLMPyW9f25kw4YpwOoRwxkKmbdVa8
         OfRtGvLr0zlSKmJy2Vzk7F0qHuaZXgJecrZvHqqRzNFweTj/J9gd2alfHSMSVk+7BIop
         627eTfXCJVf+/mfbfdy20rrkK0z6CFDL4pu/MrBdiV/h6BwYsj88TvOrAtjk36oXx7Dh
         13cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXQ+yohNMyyqRPEeNONrEzPBCefWBOBuVaWouKl2Q04=;
        b=lFkBg0U7TYKrZLrkJhKCTZKUutD2/+z1QmMDHEJbEsKcu6SozFV2f8FJym9aJRlv82
         Sed1uXwGqiJ2IXRr4HdzyIZb6sbT44kmcMXO/CbqqpHrCl8P8YFPLoFUPGPkvgOmtIEk
         8UNDAYGIo2/AT94vp1NknDrkyddw/sp5IiGhgzgNej/OPf7hpekVHL6nIZW6vzG54jKh
         0sTkYWzjfJIbWMtnWlVrf/KFhRkiTD7De5De3KcaAQZWHXJEwGUhN4BY9hQwo+Keq8Uu
         FSQRtcMxE6HcFs0lwRd6hpcKo2omiY7uyZBEf3Zmh3TOOrc/rwdDpu3vyOPLVlW27pDK
         XBrg==
X-Gm-Message-State: AOAM533CG2uYmFetumFcOs2yDV9VmEzpzHs9efX7xiO3mKI50n8zru2k
        gIwqhRO0SKZPTV+CBJq2apnIRw==
X-Google-Smtp-Source: ABdhPJzsC2TgTF9Gmqd9ulqOby16oaHRzRYnnCr7Rt0hFZaf2VvH052e/3SGjlSguYtwryEqV/XBTg==
X-Received: by 2002:a0c:9e24:: with SMTP id p36mr4019323qve.60.1622127956289;
        Thu, 27 May 2021 08:05:56 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:55 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: [PATCH 18/18] arm64/mm: remove useless trans_pgd_map_page()
Date:   Thu, 27 May 2021 11:05:26 -0400
Message-Id: <20210527150526.271941-19-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

The intend of trans_pgd_map_page() was to map contigous range of VA
memory to the memory that is getting relocated during kexec. However,
since we are now using linear map instead of contigous range this
function is not needed

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
[Changed commit message]
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  5 +--
 arch/arm64/mm/trans_pgd.c          | 57 ------------------------------
 2 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index e0760e52d36d..234353df2f13 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -15,7 +15,7 @@
 /*
  * trans_alloc_page
  *	- Allocator that should return exactly one zeroed page, if this
- *	  allocator fails, trans_pgd_create_copy() and trans_pgd_map_page()
+ *	  allocator fails, trans_pgd_create_copy() and trans_pgd_idmap_page()
  *	  return -ENOMEM error.
  *
  * trans_alloc_arg
@@ -30,9 +30,6 @@ struct trans_pgd_info {
 int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
 			  unsigned long start, unsigned long end);
 
-int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
-		       void *page, unsigned long dst_addr, pgprot_t pgprot);
-
 int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
 			 unsigned long *t0sz, void *page);
 
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 61549451ed3a..e24a749013c1 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -217,63 +217,6 @@ int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **dst_pgdp,
 	return rc;
 }
 
-/*
- * Add map entry to trans_pgd for a base-size page at PTE level.
- * info:	contains allocator and its argument
- * trans_pgd:	page table in which new map is added.
- * page:	page to be mapped.
- * dst_addr:	new VA address for the page
- * pgprot:	protection for the page.
- *
- * Returns 0 on success, and -ENOMEM on failure.
- */
-int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
-		       void *page, unsigned long dst_addr, pgprot_t pgprot)
-{
-	pgd_t *pgdp;
-	p4d_t *p4dp;
-	pud_t *pudp;
-	pmd_t *pmdp;
-	pte_t *ptep;
-
-	pgdp = pgd_offset_pgd(trans_pgd, dst_addr);
-	if (pgd_none(READ_ONCE(*pgdp))) {
-		p4dp = trans_alloc(info);
-		if (!pgdp)
-			return -ENOMEM;
-		pgd_populate(NULL, pgdp, p4dp);
-	}
-
-	p4dp = p4d_offset(pgdp, dst_addr);
-	if (p4d_none(READ_ONCE(*p4dp))) {
-		pudp = trans_alloc(info);
-		if (!pudp)
-			return -ENOMEM;
-		p4d_populate(NULL, p4dp, pudp);
-	}
-
-	pudp = pud_offset(p4dp, dst_addr);
-	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = trans_alloc(info);
-		if (!pmdp)
-			return -ENOMEM;
-		pud_populate(NULL, pudp, pmdp);
-	}
-
-	pmdp = pmd_offset(pudp, dst_addr);
-	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = trans_alloc(info);
-		if (!ptep)
-			return -ENOMEM;
-		pmd_populate_kernel(NULL, pmdp, ptep);
-	}
-
-	ptep = pte_offset_kernel(pmdp, dst_addr);
-	set_pte(ptep, pfn_pte(virt_to_pfn(page), pgprot));
-
-	return 0;
-}
-
 /*
  * The page we want to idmap may be outside the range covered by VA_BITS that
  * can be built using the kernel's p?d_populate() helpers. As a one off, for a
-- 
2.25.1

