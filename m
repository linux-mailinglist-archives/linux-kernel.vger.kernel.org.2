Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44893A0AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhFIELO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:11:14 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33743 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFIELN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:11:13 -0400
Received: by mail-ot1-f53.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so8919392otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QmK8FBhttGUph4KR+UOsWqjeoyXcMjszBFQUOkXXU7c=;
        b=VcnMtrzlBE+CY5kEaMTWz55SvEBEWCwvrikYxeBoFoxZErVCk3TtL6h4J1h59LMz0V
         JxeEdVA1ksuzwAK+iAk47JDOZx4YTCcDk8JdBOAv1OnQoonbr2kwMMJkI7tqqaZ0HtAD
         EoYvnIkY+oC5Pliif6xm5c6BUyv919tY4ctZiE0bHgx6LtTvRDoS6GoLmnMYegZRmJdd
         8n1xn99no8iBELP0GxuZV4OAyDWURL5m+kzMRZgQ0J1DtAWGUa9zrXthMKmClikBJGiI
         pKqfQCP/56PEp2oca7jKizlV7SONU1T2DUmxS1+yTVM3o+MqdJC/pC4yozqUb/rNbhEV
         9BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=QmK8FBhttGUph4KR+UOsWqjeoyXcMjszBFQUOkXXU7c=;
        b=R38KCs7OON6x3GRRqCVsaITTtFTZdsqV37vOWI28M6AtssN3jr9ZZDjPgnd410lqzm
         CQM68B0YTFZMMABXNwB+KoqFoFHV1SkLnkRJpA5dZn6NnNpurkxXj6pn8HlxtIaZD/nj
         i7y662fhEdqGDrjV81roiXX5U1kEGaC4dcv/g0Hz+HtEVfz+HgXTX/TK0DllO/zAImem
         U5we2ndLhm27r+GqZ6znLCX1YT2xJV0RicIc22rT39Ft7SQi7nK8us1OVNehxf/WE/Ff
         MQdOyj9q7t+caPu2DV3D2ApwHxA7PKMXSU2Uqv/4yM1jAlyvUSRvoqY11arcdYxWCdH5
         4O3g==
X-Gm-Message-State: AOAM5307Ex34mTwrPzmDutSToRUMp41ODqsDO0/0eqN0KVi9lt859jFY
        JRAFop+L+2YIUvy990U5ZaeC7Q==
X-Google-Smtp-Source: ABdhPJzHa+Ru6vQBkltZYZhJjYyaVUL60oRVZQeRKT3d8Ottzz1rXugi84dq+noUyrtFItweMCApXQ==
X-Received: by 2002:a9d:2cf:: with SMTP id 73mr11534662otl.204.1623211692702;
        Tue, 08 Jun 2021 21:08:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x13sm3481856ote.70.2021.06.08.21.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:08:12 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:08:09 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] mm/thp: make is_huge_zero_pmd() safe and quicker
In-Reply-To: <af88612-1473-2eaa-903-8d1a448b26@google.com>
Message-ID: <21ea9ca-a1f5-8b90-5e88-95fb1c49bbfa@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most callers of is_huge_zero_pmd() supply a pmd already verified present;
but a few (notably zap_huge_pmd()) do not - it might be a pmd migration
entry, in which the pfn is encoded differently from a present pmd: which
might pass the is_huge_zero_pmd() test (though not on x86, since L1TF
forced us to protect against that); or perhaps even crash in pmd_page()
applied to a swap-like entry.

Make it safe by adding pmd_present() check into is_huge_zero_pmd() itself;
and make it quicker by saving huge_zero_pfn, so that is_huge_zero_pmd()
will not need to do that pmd_page() lookup each time.

__split_huge_pmd_locked() checked pmd_trans_huge() before: that worked,
but is unnecessary now that is_huge_zero_pmd() checks present.

Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
Patch added (replacing part of first) since the v1 series was posted.

 include/linux/huge_mm.h | 8 +++++++-
 mm/huge_memory.c        | 5 ++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9626fda5efce..2a8ebe6c222e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -286,6 +286,7 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
 
 extern struct page *huge_zero_page;
+extern unsigned long huge_zero_pfn;
 
 static inline bool is_huge_zero_page(struct page *page)
 {
@@ -294,7 +295,7 @@ static inline bool is_huge_zero_page(struct page *page)
 
 static inline bool is_huge_zero_pmd(pmd_t pmd)
 {
-	return is_huge_zero_page(pmd_page(pmd));
+	return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
 }
 
 static inline bool is_huge_zero_pud(pud_t pud)
@@ -440,6 +441,11 @@ static inline bool is_huge_zero_page(struct page *page)
 	return false;
 }
 
+static inline bool is_huge_zero_pmd(pmd_t pmd)
+{
+	return false;
+}
+
 static inline bool is_huge_zero_pud(pud_t pud)
 {
 	return false;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 42cfefc6e66e..5885c5f5836f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -62,6 +62,7 @@ static struct shrinker deferred_split_shrinker;
 
 static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
+unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
 bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
@@ -98,6 +99,7 @@ static bool get_huge_zero_page(void)
 		__free_pages(zero_page, compound_order(zero_page));
 		goto retry;
 	}
+	WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
 
 	/* We take additional reference here. It will be put back by shrinker */
 	atomic_set(&huge_zero_refcount, 2);
@@ -147,6 +149,7 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
 		struct page *zero_page = xchg(&huge_zero_page, NULL);
 		BUG_ON(zero_page == NULL);
+		WRITE_ONCE(huge_zero_pfn, ~0UL);
 		__free_pages(zero_page, compound_order(zero_page));
 		return HPAGE_PMD_NR;
 	}
@@ -2071,7 +2074,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		return;
 	}
 
-	if (pmd_trans_huge(*pmd) && is_huge_zero_pmd(*pmd)) {
+	if (is_huge_zero_pmd(*pmd)) {
 		/*
 		 * FIXME: Do we want to invalidate secondary mmu by calling
 		 * mmu_notifier_invalidate_range() see comments below inside
-- 
2.26.2

