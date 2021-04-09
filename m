Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC193359508
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhDIFys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:54:48 -0400
Received: from foss.arm.com ([217.140.110.172]:41804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhDIFyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:54:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FFD9106F;
        Thu,  8 Apr 2021 22:54:33 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9BE0B3F694;
        Thu,  8 Apr 2021 22:54:31 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: Ensure that HUGETLB_PAGE_ORDER is less than MAX_ORDER
Date:   Fri,  9 Apr 2021 11:25:17 +0530
Message-Id: <1617947717-2424-1-git-send-email-anshuman.khandual@arm.com>
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/page_alloc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 604dcd69397b..81b7460e1228 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7068,10 +7068,17 @@ void __init set_pageblock_order(void)
 	if (pageblock_order)
 		return;
 
-	if (HPAGE_SHIFT > PAGE_SHIFT)
+	if (HPAGE_SHIFT > PAGE_SHIFT) {
+		/*
+		 * pageblock_order must always be less than
+		 * MAX_ORDER. So does HUGETLB_PAGE_ORDER if
+		 * that is being assigned here.
+		 */
+		WARN_ON(HUGETLB_PAGE_ORDER >= MAX_ORDER);
 		order = HUGETLB_PAGE_ORDER;
-	else
+	} else {
 		order = MAX_ORDER - 1;
+	}
 
 	/*
 	 * Assume the largest contiguous order of interest is a huge page.
-- 
2.20.1

