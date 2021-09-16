Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D27740EDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbhIPXPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241642AbhIPXPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:15:12 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84C4C0613E4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:50 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id w8so5341926qvt.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y1Uk63vpkrh4HSEXHQNbtcSjOksblIyIRxi91WKbEAM=;
        b=ZX6T1oIM4R3goFT9v/2cf0FQGFBs9qoQ1Dv0TkKRDmuJXkp0fJ4WJqes6t87z1iuLS
         2dvwca0W8lx+DFNgimo62pYY1v2NlFLAvt6vo2HthGJRqDkA1Ogsd1ivXC/NEzdln8KQ
         kC/vjnO88YyNTPWT214IP97mzvlq7sozyzRAtDw78VAOk43svmZFJuicv3ozQSnczCBf
         Uy+BK2ojCcJhc8bdfYtDAvjzrxlx/H7zJkRdVeS8tHN5S5i3ZVsCxPzLB+zVPcxwCzuZ
         ygQjb4HPG6I7UqyVUggGHNtedtZTV6stzxnmQ6pDF1ArDvMDsiNABNm17COwOLbtS/gz
         pAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1Uk63vpkrh4HSEXHQNbtcSjOksblIyIRxi91WKbEAM=;
        b=BQrj6fvQDao34R92THarmSNbVIQqGYLIpcXhRMoNmsAijCYB24w0lcdZh3etDneNys
         5UFaZuhWvC0oyBE1872eyLuzehauZiAIA7bzgXtC+Wa/xkTmabxq7Lgo/9vIFhzO1Gvg
         f8UlaVfcSbtSLCzJyYdf2EFrFsC/a5bHVnJ4/YuaO9+lbJK1wDghyKCtWSemqCTdSr1X
         II5pH6YeO9ChelF/zyw0PR+rWfG8DdqoeLX0UuZbzFdnmqSAT5BG5rgRqGOA71OfOpHv
         iLBDHnyVZsZ2n8YFOnNTU5TchM9OteGrHSeS2CYGE3KDHCXURLTwdgydCUvxgJyu920C
         d3DQ==
X-Gm-Message-State: AOAM530ewj6n5gUnUTGUrNbyP2SyoH6RWzvZbPxm7w+6jHfMaYBkv0BK
        JWSK2tKIv6YDEYO48xTcnwKxZ9yCaowBVg==
X-Google-Smtp-Source: ABdhPJzANQuYEdGyFPzM2h5cBvhaMadksnrGaWSms5XeNGsc2+WLwnbrziOAQEnBWBa9YCXfDzrokQ==
X-Received: by 2002:ad4:54b2:: with SMTP id r18mr8169426qvy.6.1631834029839;
        Thu, 16 Sep 2021 16:13:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id az6sm3312891qkb.70.2021.09.16.16.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:13:49 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
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
Subject: [PATCH v17 15/15] arm64: trans_pgd: remove trans_pgd_map_page()
Date:   Thu, 16 Sep 2021 19:13:25 -0400
Message-Id: <20210916231325.125533-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intend of trans_pgd_map_page() was to map contiguous range of VA
memory to the memory that is getting relocated during kexec. However,
since we are now using linear map instead of contiguous range this
function is not needed

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  5 +--
 arch/arm64/mm/trans_pgd.c          | 57 ------------------------------
 2 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 7b04d32b102c..033d400a4ea4 100644
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
index 26bd8f2d95af..d7da8ca40d2e 100644
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

