Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098623B2594
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhFXDne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhFXDnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:43:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F600C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:41:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w71so4028351pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ctu6eGIgdooF8iPxRHw2B5UaQhrklgx8o8kc13VGL+0=;
        b=FooYSsrf/byfUjHr9v8Z5dcDSMVq+aOy9Zw2Y6OY+wiqjx/RpBD79cPIN4lJXSGXs3
         4+vPSeNPFJMweHYJew6Xa77gKY1t6pM6NkcMtoX1pvl3TEEEFl8TL9aVfMp/WVgF0LL3
         BRf01yjVSdrvlKtMN7gA78LXgbINNraud8dis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ctu6eGIgdooF8iPxRHw2B5UaQhrklgx8o8kc13VGL+0=;
        b=B0J2B5UbiQT5NBHr/PWSv0BiS8ij4CXK+A7JvdS/R5HsW2f/aSvGWg2fvebSzZUqgr
         QaKqReH5WaUKas6cPSBwqolxd1DgXwwi8hZfKzHOibtLTm9wvYIT1sl0Iv3e8d1nlIbi
         kK3QVivdS0dT2Jjxx1jPr+PkNqD5Eg/xHq5Gbms/z4uSefRloPgbDFG+IsIpu4vP5JqG
         V6/mf9bgPjx4TLifHjAuk3ly5f+kJzCLxzYqSxPPGUyJl6IWR0vewCJeFecOJPFqX9o0
         YN0KzO/k3H+MoYZLr5atg0C2D3eOWAaBzzhqsSaRFtYLWak1Fwe1zOUfvIYXWrHaD1Zc
         DVcg==
X-Gm-Message-State: AOAM533Da6LliBVrXod+otW6wNC57z+8J5yIYyOG+4IOkjhqBWfDqGO+
        Rc9nVgxgHvInks88mmEO+7aR9R1QfWCRig==
X-Google-Smtp-Source: ABdhPJzyemWeDjYSvtIVYwsIq1X0bowWLkR1TGinCknV//VarDM6vRNV9QrEYKNeX2yQiXYPgJ/wAQ==
X-Received: by 2002:a62:1657:0:b029:301:af69:5ae3 with SMTP id 84-20020a6216570000b0290301af695ae3mr2929381pfw.57.1624506073704;
        Wed, 23 Jun 2021 20:41:13 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id n69sm1160501pfd.132.2021.06.23.20.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 20:41:13 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v16 4/4] kasan: use MAX_PTRS_PER_* for early shadow tables
Date:   Thu, 24 Jun 2021 13:40:50 +1000
Message-Id: <20210624034050.511391-5-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210624034050.511391-1-dja@axtens.net>
References: <20210624034050.511391-1-dja@axtens.net>
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
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
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

