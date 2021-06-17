Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6743AAC96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFQGmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFQGm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:42:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BFCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:40:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g6so4217793pfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRdt/wFzvgUcAph19a7+La8R0pqDnXPYkPybGzP3TFs=;
        b=LW8mQ1aUFkj03n/RiqJV2xkT3exIY4LtDgccB7rozmA2OQfAiuVQxboDoQGry9XmzT
         Rw6MVtymYZEzC5bYdmJ+4EYgpjgqjhkzeSU5agu/yHfWJlU7hk6D7ZBbs+2zPDD71A5N
         pfCmsHWyxSHDaUWlivIYJVqE4KttoIxL2Gvx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRdt/wFzvgUcAph19a7+La8R0pqDnXPYkPybGzP3TFs=;
        b=Hi1akfrSUyeWOpwP50LQCxpYMlKfy0HWRC5OuCaBlh8j9MTEXiuKlhgD7zdWejJrcs
         jhvRCxsrbt7WjQrsxC1q98rNT63TBwK1Dwx254EvSfQiBNLOjv0EcLYZJg417xPhgwFg
         baozW9FgT9rl3Gx3IETXB4VYeMc20wqyvdmcKuUPUqhgDAbPDZIcMkCzP4a8r4wTWyb4
         Lh59oWDe+q562JmsiDzwY9bl+x1sO5MnNPYz96vCKi7QYeSktYLh389zPTFHgZjcBxGE
         JBgIcWQJLJ2Eq+mvML1r1Q/F0I65eUIjg7rW9FII16U4oJTRoJ9NEwby/4YLN91qmKfv
         9Ajg==
X-Gm-Message-State: AOAM533GoscVO4mJ5/aHYjMnCprCmhYJwLCgOTRvt7KMsqILHUKFA6Eq
        3UbulakGxnMtg8oriuIw+AjnTkwnKfChmA==
X-Google-Smtp-Source: ABdhPJxZ8JWJ4Mjr5ash2IXA6R5rV4gGGXHwovDZyw0LOK/tt3IT1XtCKUzvjMkiK2XZ7DVnqYtOEA==
X-Received: by 2002:a63:64a:: with SMTP id 71mr3578146pgg.360.1623912021307;
        Wed, 16 Jun 2021 23:40:21 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id o34sm717337pgm.6.2021.06.16.23.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 23:40:21 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v14 4/4] kasan: use MAX_PTRS_PER_* for early shadow tables
Date:   Thu, 17 Jun 2021 16:39:56 +1000
Message-Id: <20210617063956.94061-5-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617063956.94061-1-dja@axtens.net>
References: <20210617063956.94061-1-dja@axtens.net>
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

