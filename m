Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EA43A24B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhFJGtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:49:42 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]:46844 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:49:40 -0400
Received: by mail-qv1-f41.google.com with SMTP id w9so14152042qvi.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2OT9ZOT1k9Jrl0NBTEVPMljz+ghdujF4gPDHMzwzXkI=;
        b=fItDKAwEWa27P6UoPqgsJmxWxx+88uY7YcweWA0CjJkHQ/a0qq3VMLFQGCheHOetC3
         thbHJ+GkAgYvV9MvOGSd1SedriGSLoRyUGD7SHaGqOJaIRvBfO6VzJLBx101C7QOIdqe
         7d/xyw4cAq1x1sC14413xqHk+aX9nGDcmYOH6HsbEY3Sq0M8O6KTTCRTfTwfZUc0oO74
         9qz1oWxVUORVI69H72mEyT4hMad64PunjlNNCmPyWhv6XK2woi+jrJlx4x0eMuLLOvL4
         gNsTLQ7nISZaJNkvP4IIVj25ZkvW+15nQxnmN9XZOX9TYBCNpUuD3it60s6CWLrEjfHl
         19ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2OT9ZOT1k9Jrl0NBTEVPMljz+ghdujF4gPDHMzwzXkI=;
        b=KZAkNtSpE0WgTV+q312JEKTUWl9006u6BmKjSRu45rRATmBvfOhm00qKsJjSp6AQ39
         p6/EA5NCd2dcL4PKVG/CQvXFXmhW3FEZ6/fRtz/JRshkk7e28LfRwCMXXMsOhleCIxz5
         YoV1WSRqL0mMLtimlW83Ym9em8XF/7suVvYu5O0XUs4G+haxxk7PT6pPkMqrwyqBbAfv
         Et4zfQegyjNxAeU/0VnOAUau7EyVBU8BwKZi5HT3Un/QknHAD6aTmPvTx3N/H46D2cm9
         JYCbBbYRJmBuMYgzxaPloaM9IdIfyQjrOBezs26TBE2dQaWsRIkYfJF5U+mqXhwcFweV
         zQgg==
X-Gm-Message-State: AOAM531I+zd52p7gR7xJYgoEyZGIPeBpqzRf6NOiZJi1RF2QfE4ty9HA
        i51l2mRdbBoExxJdpVnppPxncg==
X-Google-Smtp-Source: ABdhPJzebxEMV8nIRPyxc3ps1IgHzw1v6T3H/U3jGmnUmUAEsDFERk8zIQP7dpPhp/qi25qO4XO93A==
X-Received: by 2002:a0c:d610:: with SMTP id c16mr3670609qvj.13.1623307593003;
        Wed, 09 Jun 2021 23:46:33 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x8sm1675789qkb.54.2021.06.09.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:46:32 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:46:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] mm: page_vma_mapped_walk(): add a level of
 indentation
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <efde211-f3e2-fe54-977-ef481419e7f3@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_vma_mapped_walk() cleanup: add a level of indentation to much of
the body, making no functional change in this commit, but reducing the
later diff when this is all converted to a loop.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 109 +++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 53 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 0fe6e558d336..0840079ef7d2 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -173,65 +173,68 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	if (pvmw->pte)
 		goto next_pte;
 restart:
-	pgd = pgd_offset(mm, pvmw->address);
-	if (!pgd_present(*pgd))
-		return false;
-	p4d = p4d_offset(pgd, pvmw->address);
-	if (!p4d_present(*p4d))
-		return false;
-	pud = pud_offset(p4d, pvmw->address);
-	if (!pud_present(*pud))
-		return false;
-
-	pvmw->pmd = pmd_offset(pud, pvmw->address);
-	/*
-	 * Make sure the pmd value isn't cached in a register by the
-	 * compiler and used as a stale value after we've observed a
-	 * subsequent update.
-	 */
-	pmde = pmd_read_atomic(pvmw->pmd);
-	barrier();
-
-	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
-		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-		pmde = *pvmw->pmd;
-		if (likely(pmd_trans_huge(pmde))) {
-			if (pvmw->flags & PVMW_MIGRATION)
-				return not_found(pvmw);
-			if (pmd_page(pmde) != page)
-				return not_found(pvmw);
-			return true;
-		}
-		if (!pmd_present(pmde)) {
-			swp_entry_t entry;
+	{
+		pgd = pgd_offset(mm, pvmw->address);
+		if (!pgd_present(*pgd))
+			return false;
+		p4d = p4d_offset(pgd, pvmw->address);
+		if (!p4d_present(*p4d))
+			return false;
+		pud = pud_offset(p4d, pvmw->address);
+		if (!pud_present(*pud))
+			return false;
 
-			if (!thp_migration_supported() ||
-			    !(pvmw->flags & PVMW_MIGRATION))
-				return not_found(pvmw);
-			entry = pmd_to_swp_entry(pmde);
-			if (!is_migration_entry(entry) ||
-			    migration_entry_to_page(entry) != page)
-				return not_found(pvmw);
-			return true;
-		}
-		/* THP pmd was split under us: handle on pte level */
-		spin_unlock(pvmw->ptl);
-		pvmw->ptl = NULL;
-	} else if (!pmd_present(pmde)) {
+		pvmw->pmd = pmd_offset(pud, pvmw->address);
 		/*
-		 * If PVMW_SYNC, take and drop THP pmd lock so that we
-		 * cannot return prematurely, while zap_huge_pmd() has
-		 * cleared *pmd but not decremented compound_mapcount().
+		 * Make sure the pmd value isn't cached in a register by the
+		 * compiler and used as a stale value after we've observed a
+		 * subsequent update.
 		 */
-		if ((pvmw->flags & PVMW_SYNC) && PageTransCompound(page)) {
-			spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
+		pmde = pmd_read_atomic(pvmw->pmd);
+		barrier();
+
+		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
+			pmde = *pvmw->pmd;
+			if (likely(pmd_trans_huge(pmde))) {
+				if (pvmw->flags & PVMW_MIGRATION)
+					return not_found(pvmw);
+				if (pmd_page(pmde) != page)
+					return not_found(pvmw);
+				return true;
+			}
+			if (!pmd_present(pmde)) {
+				swp_entry_t entry;
 
-			spin_unlock(ptl);
+				if (!thp_migration_supported() ||
+				    !(pvmw->flags & PVMW_MIGRATION))
+					return not_found(pvmw);
+				entry = pmd_to_swp_entry(pmde);
+				if (!is_migration_entry(entry) ||
+				    migration_entry_to_page(entry) != page)
+					return not_found(pvmw);
+				return true;
+			}
+			/* THP pmd was split under us: handle on pte level */
+			spin_unlock(pvmw->ptl);
+			pvmw->ptl = NULL;
+		} else if (!pmd_present(pmde)) {
+			/*
+			 * If PVMW_SYNC, take and drop THP pmd lock so that we
+			 * cannot return prematurely, while zap_huge_pmd() has
+			 * cleared *pmd but not decremented compound_mapcount().
+			 */
+			if ((pvmw->flags & PVMW_SYNC) &&
+			    PageTransCompound(page)) {
+				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
+
+				spin_unlock(ptl);
+			}
+			return false;
 		}
-		return false;
+		if (!map_pte(pvmw))
+			goto next_pte;
 	}
-	if (!map_pte(pvmw))
-		goto next_pte;
 	while (1) {
 		unsigned long end;
 
-- 
2.26.2

