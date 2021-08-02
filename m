Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2A3DE202
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhHBVzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhHBVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:54:48 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B64C0617A2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:54:32 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t66so18180998qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KO+UtZYDZ93vRTmLSDKEJjOCFuS9p62EhZfFf9ovch8=;
        b=XKau4jwWMiCZa409w4MdI2PXmAxjIEEUEVgVNb4oqyKZvs4pzBFvMRyLou4UBwv+GQ
         TW+EJsuAd8LEq3UppSwoLKj2w/0TeuiJe4IGEABWnYRmbKKtlk+PE10R+S+6L1hDBKmv
         wmIiEFWWfvfUwhttS6zbIupZGyaYZbGyF6fOYqANIalWNad/7SCqTkmdzRxrAY+gL2Jy
         xTv09Un0W96gj6gvwoFBxqm0z+HDNJ88BsgZIOf27WfvUy40ipC/X3AoI0U2/OAuXPXk
         ZDgZy1N8l724D+q4JmH6H4itZ/vmMpWrskk2LUXOqmfm+DIkDhOpU+EHXoyaGbTObG0h
         2U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KO+UtZYDZ93vRTmLSDKEJjOCFuS9p62EhZfFf9ovch8=;
        b=QDA+WUnARsG4zrsxX/AYUbJgGgnYZBg9vR8aAicaqkxcHQJhkfeLZzn5ibMTUXQLDO
         fObExFWmW85UpsJGnztCLtHzSaZ9hQ6tdhpEBm6J2Azz/9QqoRzOAhEefPl7Oc0Hhw1E
         QDzjhIKZx4SIEbRk8AK83t2aW4MjbObYMGl/sQ3W0vneVaTAci34UGUUCWv/erqSsGru
         wa2VJvYGaJFv9lyj1eMxC7+5EWDqfkKjdOkxQ235FuuhMvIGMtDumfF+24eV21yOxx8K
         CCK73WHYeTBLfVjiItJCxEk2HDXefXcE+4jVki8fmfMSg7ZjJWqbL/PzoUWC2iyhD7gT
         z3mw==
X-Gm-Message-State: AOAM533VRaDOLOtowglIRxf1BL+7Q2732+X/D4H6HJWxkNXDmjozN8JH
        gUB59no2xRFqcahzmN2d9lBpHA==
X-Google-Smtp-Source: ABdhPJyLFm5KeldobIkuT9ocF0wPdPlFXom0qmn5x07S4Ban/u4jSm4NOTGd+dyu0FMWOe62wYnHYw==
X-Received: by 2002:a05:620a:1327:: with SMTP id p7mr17704056qkj.483.1627941271676;
        Mon, 02 Aug 2021 14:54:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v11sm5479216qtc.0.2021.08.02.14.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:54:31 -0700 (PDT)
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
Subject: [PATCH v16 15/15] arm64: trans_pgd: remove trans_pgd_map_page()
Date:   Mon,  2 Aug 2021 17:54:08 -0400
Message-Id: <20210802215408.804942-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
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
index a08cf313c858..b70588a42c29 100644
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

