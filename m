Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7581D30D96B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhBCMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhBCMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:00:48 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5632EC061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:00:07 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o63so17188219pgo.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yeRRS+YoQcAmvPlaj8okeosVtMgEWoUxf3CV/ngv8E=;
        b=NU7X5sikSrpePvQWWlAOjtah9E4+4ONvCH12/t/ANyREsmFC1U6slYAHQ0zmeSFXtS
         y5kYCxRVl3oLIBHZNpGopaRd9vFwDTIvfCNi6ytdk87MQmRVEeuvILkrk4umt/zvnzIT
         Ax/WvhUpYH0eEv9Xg5VK6Jjjn+pw057DRyRVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yeRRS+YoQcAmvPlaj8okeosVtMgEWoUxf3CV/ngv8E=;
        b=XSp2HGLPHcQuiY4vNriwrLEQLk54OpYNkoKWwgof4KeiBq5xPtnQXCy1ZbE33VI6cQ
         GJKFfu1f/7k7BM+UT5z2ToRbW0jLmvFFrwMIDBYsZ3xMCiMHrxij5dm5e8Kw7DL/5nSJ
         Nn4xl3Qv+7Avl3hALbAT7UTqdFR+ZJJ18h0UJgqIibXKb7X5oQFZ7DdOmNLazqrDscU4
         ZNhkd1gAAAs4hx5adWCP+vr4pR3xqCspz3KevwgRCFnvYzIYgVtnep0W4UM09tlb8fLJ
         baDH0xt6Qu4Ic/lK1x+L5l7YpV6ZdGUj5nJvmvAbVe9XrD5Y/L4Wjp2O8Te+vj2ixDMu
         oRmw==
X-Gm-Message-State: AOAM5326vhLxXYYxs9Lb0p51mk2QLRqXtI9U9D6ldxF6ewloU1axnsVo
        jms5VfXqWLALAI4h2y9UQWgf3KadI3xBbw==
X-Google-Smtp-Source: ABdhPJzzK5YvOyMfvgQ+AuWV/qojdK9qpJUT9pEzaRWUltgKk0EicgeZzjiaUG5uB5i/jb8YlXG4ZA==
X-Received: by 2002:a65:648c:: with SMTP id e12mr3246745pgv.123.1612353606752;
        Wed, 03 Feb 2021 04:00:06 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-1c59-4eca-f876-fd51.static.ipv6.internode.on.net. [2001:44b8:1113:6700:1c59:4eca:f876:fd51])
        by smtp.gmail.com with ESMTPSA id 32sm2747368pgq.80.2021.02.03.04.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:00:06 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v10 3/6] kasan: define and use MAX_PTRS_PER_* for early shadow tables
Date:   Wed,  3 Feb 2021 22:59:43 +1100
Message-Id: <20210203115946.663273-4-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210203115946.663273-1-dja@axtens.net>
References: <20210203115946.663273-1-dja@axtens.net>
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
index d314c0fa5804..84bea59d01b3 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -43,10 +43,22 @@ static inline bool kasan_arch_is_ready(void)	{ return true; }
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
index c4605ac9837b..b4d822dff1fb 100644
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

