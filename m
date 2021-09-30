Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8417C41DC56
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351950AbhI3Odh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351965AbhI3OdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:15 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79382C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:32 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r1so5797406qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XxlQwO+zvTPvOSLEI+q8JmpmwLvHiOqSq9H/D1w+4mk=;
        b=aOdtcLsSMWhdmH/KKMmZnRau19vAPajS02V43ANM6ifhO/tnr/ulMkrIJTQmX7vAlq
         YADiIG39r9Vb8SZLAASMRqAQkCynKyOg0JkQwWMSIFTPKBulzt9tXQmn3UQ4nHZ3Vec4
         voVkB4YK0EgaS0YEkK4o633fgSi4CFFC1DAx3UaBZ+BZVZx8Bh8Rv4FppGd+Ii7Uv5Ii
         gccTAgM1+8aZq5FXtWSip+4iu1L56aFhwQS1FUhvvzUT1IpJKlNrC0qCJuQm/EWJhkSX
         yeK0+vcszokE9LKwJMyqxq71n5JxLS0hdUyuJ15uNVFeMWMaLUwrC8M2NJ6UH9kOWleh
         WTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxlQwO+zvTPvOSLEI+q8JmpmwLvHiOqSq9H/D1w+4mk=;
        b=2hAmlHSt1nhcnpLTWOgqx9aMVHMb+aQ4+jJUd/Z8xtc93Pq2Oj8C1okkA2hK2+Axm+
         B4rbwFRroKOixA70Yy9XG0c/HOCKdmoPB3xYXm0SkL+ojZEem4Y90Y1p5Z+iIQNbKiLA
         eVsCOBPUvKyX0P5OGmTa1LnShMq9drsKJGBKm6iuMOnPByMt6yBoF/+qNEEhbLjY6sJh
         vHn7HmoOU5QVsMPpjcfT4L+MvzgUVZbs6mHexEJwxPghfD3xnCFYwVwIsJ6TsIyLKLtO
         B3AANt0ahBGJB0MYD9VQighOuZKxCI2HuNBEs7CVElwx+InKh+cPCR+rXL6zn9e0XjQD
         UkyA==
X-Gm-Message-State: AOAM530qk7qGpWbKhMKMi0zZLtxw1r2PmRm8xPukNDs3xRFtSe7GLuDG
        rDAM27GsKZ+4mgOnHTaDdxyrGg==
X-Google-Smtp-Source: ABdhPJzecZm5xCqX2NKvPHbAfDt/pCmj5N9m76pk7Eb3EnDGgwSGvIf0RbDVFg/Bu7rhjM9gly/kXw==
X-Received: by 2002:ac8:138b:: with SMTP id h11mr6860629qtj.163.1633012291650;
        Thu, 30 Sep 2021 07:31:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:30 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, kernelfans@gmail.com, akpm@linux-foundation.org
Subject: [PATCH v18 15/15] arm64: trans_pgd: remove trans_pgd_map_page()
Date:   Thu, 30 Sep 2021 14:31:13 +0000
Message-Id: <20210930143113.1502553-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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
2.33.0.800.g4c38ced690-goog

