Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE735B91F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 05:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhDLDsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 23:48:04 -0400
Received: from foss.arm.com ([217.140.110.172]:34980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236541AbhDLDr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 23:47:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7EF331B;
        Sun, 11 Apr 2021 20:47:39 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.72.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F29143F694;
        Sun, 11 Apr 2021 20:47:37 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/page_alloc: Ensure that HUGETLB_PAGE_ORDER is less than MAX_ORDER
Date:   Mon, 12 Apr 2021 09:18:22 +0530
Message-Id: <1618199302-29335-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pageblock_order must always be less than MAX_ORDER, otherwise it might lead
to an warning during boot. A similar problem got fixed on arm64 platform
with the commit 79cc2ed5a716 ("arm64/mm: Drop THP conditionality from
FORCE_MAX_ZONEORDER"). Assert the above condition before HUGETLB_PAGE_ORDER
gets assigned as pageblock_order. This will help detect the problem earlier
on platforms where HUGETLB_PAGE_SIZE_VARIABLE is enabled.

Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Changed WARN_ON() to BUILD_BUG_ON() per David

Changes in V1:

https://patchwork.kernel.org/project/linux-mm/patch/1617947717-2424-1-git-send-email-anshuman.khandual@arm.com/

 mm/page_alloc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfc72873961d..19283bff4bec 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6875,10 +6875,17 @@ void __init set_pageblock_order(void)
 	if (pageblock_order)
 		return;
 
-	if (HPAGE_SHIFT > PAGE_SHIFT)
+	if (HPAGE_SHIFT > PAGE_SHIFT) {
+		/*
+		 * pageblock_order must always be less than
+		 * MAX_ORDER. So does HUGETLB_PAGE_ORDER if
+		 * that is being assigned here.
+		 */
+		BUILD_BUG_ON(HUGETLB_PAGE_ORDER >= MAX_ORDER);
 		order = HUGETLB_PAGE_ORDER;
-	else
+	} else {
 		order = MAX_ORDER - 1;
+	}
 
 	/*
 	 * Assume the largest contiguous order of interest is a huge page.
-- 
2.20.1

