Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFA13A747D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFOC7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFOC7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:59:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A0CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:57:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id n12so10238703pgs.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a1pNfOTnuu9q0yP3UcKWGmSF0bOy6BujGvnQzOBamsE=;
        b=YYXooO3Cnx/8RRR45+QVR/V3WcE3xeUcgsrSiFZ8Bce/7llMZ/Adqd2T0IUdvAugcd
         RY+YQ19gupEvIYKx525suaotmjelBf+zbDnEqFa02qOVcK3JeIm1KTWd08naiN3zgzao
         rCgISrOnSh+C1pCvsjM5c7/EWMqh4CojaCtPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a1pNfOTnuu9q0yP3UcKWGmSF0bOy6BujGvnQzOBamsE=;
        b=idTsURjEykNpcRqzdXYIx1kauTSFxI3C0/9gE3tNzcn9c6bzgzuqhaDvWPK7QMjtBp
         CIVYvBtXfWrik6HP18z3Ehg0DWo+z4yhIb/VPzZ1o/t+f15NwlSpMCbpmrczoVJ46ARi
         eQ6SeJpfYpMPHVtFclO4intgtyB5Lr9aSpvWVveFIgi1g7rERExuyO/4LIpd/0OZd4r8
         RGphC+XOw9xAA1zCbiI9ba+FHxOykcn/633TjY2578MOoIvI0T33VDK2BZFpTErsLHxR
         cLV36p6f8o+Bg9uFnvavLlvbUb6rgcpmJcua8HsvjGnfe2ZePWA+GrthG5sgQryOigaT
         Wx7w==
X-Gm-Message-State: AOAM532XMxNeNTPr940d/DqrtM5WUwNZrm96DoR9eKv0XUpMi9ANJULi
        u/PGXWXFfBhn+jSTTHgkLzf/twIJT0zvxA==
X-Google-Smtp-Source: ABdhPJzk937KNv1xqdfNNH68yFFGRboFxRzpAnQokFApWsBfy+ttacdd4uZ+sRluc5jsOiD/+Z34tw==
X-Received: by 2002:a05:6a00:82:b029:2e9:c6db:e16d with SMTP id c2-20020a056a000082b02902e9c6dbe16dmr1937093pfj.78.1623721643469;
        Mon, 14 Jun 2021 18:47:23 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id n6sm5768289pgt.7.2021.06.14.18.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 18:47:23 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     elver@google.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v12 3/6] kasan: define and use MAX_PTRS_PER_* for early shadow tables
Date:   Tue, 15 Jun 2021 11:47:02 +1000
Message-Id: <20210615014705.2234866-4-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210615014705.2234866-1-dja@axtens.net>
References: <20210615014705.2234866-1-dja@axtens.net>
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
2.27.0

