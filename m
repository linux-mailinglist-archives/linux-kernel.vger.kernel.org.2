Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9A3AAFBF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhFQJd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhFQJdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:33:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6C7C061768
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:30:56 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t17so4480640pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lssK+06OrqYXMI/RYJk+NygLCQ6hQhXYMHdalKVel+U=;
        b=ApqW+b4wR3tXMa534EPaBXG3/a/Hp08qg47DiHJtK0mgfEzFsiG1Ao4n68XSbDDzxZ
         9xXHIEqvn94lOxSRnTRB/+vsb0DyGcdYekj3LvN+7sN7No/pDmeLXun8PSncAf7BVTvs
         3fWwD8exglZRS+hl5MRe5QjV1DWRuF2+sp7mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lssK+06OrqYXMI/RYJk+NygLCQ6hQhXYMHdalKVel+U=;
        b=eB+M3mQ2DqECzfJc2SW5T6fMRsLwm3ZpaRNqLjd8v7AME7PQ7nVioCCDJaN9QgmuE1
         w1eQ2w2U1X2SR16yTqH2dVaz77JfPEF5fyqrW4miwhvoadnIVoPWfLkEvujf8W9ys252
         Z5ZvDqIjUxMcyfiIMjV0XGhXGU4WijBymk7HNcgBywg8cMGyjfrKSdbaYOGowug0C46F
         mIku3gM21AXHkIIZtF5eGN3teZF7Skv52RA0dqK3R+tNs1JSBcPgOv0FSAb3Ur2QV87o
         /T+e0C9pIE8UBvUzI48FZ1vw0B7VUhlQ8riU8Y+gt2xTzyRYh7rtEwG0ujCsPkylS0n/
         B4mQ==
X-Gm-Message-State: AOAM531z0p8IdaQkKQ9MFgqohEGEmLYSyM/+eNXya94tDO2XCe69wzeR
        TqT3CU9JJtVUMjGJtiIIhIP2LdB7SzVvmw==
X-Google-Smtp-Source: ABdhPJz6OUBNln7eU/91Mj+ScyWERfC5hrYLY7B9BZavgiJtBCoiFIgMEfAytW77+pj2ssxxHF0OIA==
X-Received: by 2002:a63:db01:: with SMTP id e1mr4204540pgg.38.1623922255699;
        Thu, 17 Jun 2021 02:30:55 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id o14sm4847028pgk.82.2021.06.17.02.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:30:55 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v15 4/4] kasan: use MAX_PTRS_PER_* for early shadow tables
Date:   Thu, 17 Jun 2021 19:30:32 +1000
Message-Id: <20210617093032.103097-5-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617093032.103097-1-dja@axtens.net>
References: <20210617093032.103097-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc has a variable number of PTRS_PER_*, set at runtime based
on the MMU that the kernel is booted under.

This means the PTRS_PER_* are no longer constants, and therefore
breaks the build. Switch to using MAX_PTRS_PER_*, which are constant.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Suggested-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/kasan.h | 6 +++---
 mm/kasan/init.c       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 768d7d342757..5310e217bd74 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -41,9 +41,9 @@ struct kunit_kasan_expectation {
 #endif
 
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
-extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS];
-extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
-extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
+extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS];
+extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
+extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
 extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 
 int kasan_populate_early_shadow(const void *shadow_start,
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 348f31d15a97..cc64ed6858c6 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -41,7 +41,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
-pud_t kasan_early_shadow_pud[PTRS_PER_PUD] __page_aligned_bss;
+pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
 static inline bool kasan_pud_table(p4d_t p4d)
 {
 	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
@@ -53,7 +53,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD] __page_aligned_bss;
+pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
 static inline bool kasan_pmd_table(pud_t pud)
 {
 	return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
@@ -64,7 +64,7 @@ static inline bool kasan_pmd_table(pud_t pud)
 	return false;
 }
 #endif
-pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS]
+pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS]
 	__page_aligned_bss;
 
 static inline bool kasan_pte_table(pmd_t pmd)
-- 
2.30.2

