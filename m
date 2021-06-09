Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F28C3A0898
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhFIAr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:47:56 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:38611 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbhFIArr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:47:47 -0400
Received: by mail-qt1-f181.google.com with SMTP id l7so16761644qtk.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GjSDlwdpWFRYVlnzm94wTdyVwlXZM6Svb6WtI86k1kg=;
        b=ZuuVM+oG7LEN8BGkaNklXAgBWK1R83XggxUaKuqIhawxrVr4hkcQbeGaRstDd0MhxZ
         2y8rk1EO5extgzrNLXpnzxFc67giCQF2xjOgbwQTWSnVPm+j9YjSZJ/GLxXfqRPxsgRe
         1LBBED3bhIDcYR53xtZBI+0Cx3RQE/za9PCCrkva6V0qwlF1d+kmT0iuEhX/bitmVS19
         h0wh1vmTJ92P1Pdf5Lb51FdfztXyzfhtFKAcd7CO0KdxsDFA/yl/ug3nPS2bVJ/AG9GG
         8rhd4otd8vwBPylUMO+VsdTRspg1bncZtbWNoZhZHQfvLPHMDXQgXmLx/wKAvsjUahOe
         xO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjSDlwdpWFRYVlnzm94wTdyVwlXZM6Svb6WtI86k1kg=;
        b=j+XE54vF9g1UqgVxW3zcfEIQI9IO+WQcBYZdzmRijhmi8mY2pZkZEcZnrZCstQ1X4D
         k/5jG1EhNhMTw2j8GHNuy43zNJlHnqe0sG3x8BcMYfDjiGpn0SCqgVK3gOkKHj/949Oc
         fgxJD1yqFiGXDt2ipL1XNVL7DCbcxqil8Rl+TucaPenqJsquQUeTXnVcBOhOhymB7/73
         IFN04p+5xZMwJRpXEsyGg6F5swX0sE61d9BqUPYNYGxioj51DRDq0bM+FloZTUL/AP20
         USjZMLQ4jWcs4p5JsyI6i/xWaDLbN7DB1FXMGKcWePQB9UJaEp7EW5zmRrrbCQFl5l/S
         Cr5w==
X-Gm-Message-State: AOAM530rqTnsCjSiPwdVkk+Lyj2/DApjyv3xBSDZ/LfQpm+0qqfNE3fd
        hvmWiuTpaBKWDpHghuTVzDt5Tw==
X-Google-Smtp-Source: ABdhPJzqtRWOkclgaHjthbeRbJ9Nm1ps+o1K7YT9wm8f0oWLxYvA3vqVz21USCX+0GNStAMjm0lKdw==
X-Received: by 2002:ac8:5550:: with SMTP id o16mr11967741qtr.387.1623199482673;
        Tue, 08 Jun 2021 17:44:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n194sm12869011qka.66.2021.06.08.17.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:44:42 -0700 (PDT)
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
Subject: [PATCH v15 15/15] arm64: trans_pgd: remove trans_pgd_map_page()
Date:   Tue,  8 Jun 2021 20:44:19 -0400
Message-Id: <20210609004419.936873-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
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
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  5 +--
 arch/arm64/mm/trans_pgd.c          | 57 ------------------------------
 2 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 411323bda7a4..c373d43c07ec 100644
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
index d4f0a6492d8f..7ae27a948145 100644
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

