Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA083A94A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhFPIFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhFPIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:05:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E189FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:03:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x16so1516577pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1YLXpeuYLLATMRsuPzyJcK3SDVQ5TMCmimmfEEEFlM=;
        b=rVBqDrHDojw1oOxvtGWdyVPwGWo2mMUr5IgajW4/qA4lE1M4G4tEBk3XJzv0y7ko3e
         Fz6GvlzHMtBiLEQVONvxx5QdpBJP3sdvzKkZ6WuE/e56rSuPyGDhIk/gXRXRLPqVm02U
         VDeEj9eDuhM941UL2SJm4SP6rH2lgPfnF9k0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1YLXpeuYLLATMRsuPzyJcK3SDVQ5TMCmimmfEEEFlM=;
        b=psLXvMLC+QMqe8Z/dC0EW+dQm/mFB2+9/ULvq9XHLOYsQKQpryW1lC6JJZa1nQdEbb
         U/36t28OddwixgJMKR2nKOqsfzLQ8SoHWEnTS6FdDCmPYgFNR9O9jabp5Bl9q6Bmrt90
         g8opFkB5vJmcz6XxkVYuEsM4pwUZDLQovKVH75RVBWYtp+XUKpXnqzYvx+WQM9xxskTQ
         m16tny7xsiN0/r6fu5Ms1ay0ehzLUgmjBcvI3rqkPljiMaIldVzxWT9OrD5cOEow/Nxa
         3bViwH4aZWyDYiK0+QbGCfc2LiZDBLUr+rw+EzUlfBjQsW2hhIQ24PP3js0MEyonLkmT
         xF8A==
X-Gm-Message-State: AOAM533fwTN8OXbJohK7pRxBtk4C8Y9Gs9EMc1O4+yxztwWDiB47A44D
        oSeXicOu0gLJGxx3TOPXj1Oe5dvtWynpMg==
X-Google-Smtp-Source: ABdhPJxoCRhpWmzvnliIbHWAX/WGlzPbnJ/iqyfsGmCCe8L+UNRUKHGC27ecG9iS94G7m1ZOmRlU9A==
X-Received: by 2002:a62:e307:0:b029:2f8:d49:7b65 with SMTP id g7-20020a62e3070000b02902f80d497b65mr8326880pfh.48.1623830582233;
        Wed, 16 Jun 2021 01:03:02 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id g17sm1466688pgh.61.2021.06.16.01.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 01:03:01 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v13 3/3] kasan: define and use MAX_PTRS_PER_* for early shadow tables
Date:   Wed, 16 Jun 2021 18:02:44 +1000
Message-Id: <20210616080244.51236-4-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616080244.51236-1-dja@axtens.net>
References: <20210616080244.51236-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc has a variable number of PTRS_PER_*, set at runtime based
on the MMU that the kernel is booted under.

This means the PTRS_PER_* are no longer constants, and therefore
breaks the build.

Define default MAX_PTRS_PER_*s in the same style as MAX_PTRS_PER_P4D.
As KASAN is the only user at the moment, just define them in the kasan
header, and have them default to PTRS_PER_* unless overridden in arch
code.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Suggested-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/kasan.h | 18 +++++++++++++++---
 mm/kasan/init.c       |  6 +++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 768d7d342757..fd65f477ac92 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -40,10 +40,22 @@ struct kunit_kasan_expectation {
 #define PTE_HWTABLE_PTRS 0
 #endif
 
+#ifndef MAX_PTRS_PER_PTE
+#define MAX_PTRS_PER_PTE PTRS_PER_PTE
+#endif
+
+#ifndef MAX_PTRS_PER_PMD
+#define MAX_PTRS_PER_PMD PTRS_PER_PMD
+#endif
+
+#ifndef MAX_PTRS_PER_PUD
+#define MAX_PTRS_PER_PUD PTRS_PER_PUD
+#endif
+
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

