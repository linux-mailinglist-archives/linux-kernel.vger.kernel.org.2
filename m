Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9593F5214
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhHWU3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:29:15 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:65301 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhHWU3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:29:13 -0400
IronPort-SDR: 9cRy6OFuvZ5FXzTmZ7VdxAG3mOTtRCYNKUCZJL1VPEjH7a62b6TiZxJyZGXh6x/HeCHCWrZHBp
 39pm1RvfCre3tGT/J0CVN4zi2DQDqrNPOrxW4COxa/Ec4lFhIHi7jD/rffd7J08pBpKBzPEnG5
 7zxhi9C36jHUo3x+JZhjOdP6LlzFH5z+cFIUudfcpBHkJysBvb3N7SB/mMSay3vONL0XCw4L4F
 QG2nolbT0Z7BhJRoIgGkh6yRtwVCY65TBfoMoEbJ1SycMBWZk0wSuaEEu2ClFDTbRPlSo+Bk47
 pz5kFb6pyx6Y80jgq3AGYXo6
X-IronPort-AV: E=Sophos;i="5.84,344,1620720000"; 
   d="scan'208";a="67519956"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 23 Aug 2021 12:28:31 -0800
IronPort-SDR: hrR8joVliJ/3UiwFWxKGvZJCCoSmSm0nOTK4WmW6uF67ZWb7BQYmvrHGsP5ZXuQt3hs4d3WrYu
 gi919jbFtmRT+gcoIcomRmKQMNvGVlrpD5rRCd+OcTf4jrp9DblskPDFy33aZLWOhWyV0ePNPY
 hcQZ/67JzhGJEwEVnjnDpGC8rsz9OWd3MCQwrghnydeYzkqoN1nudbMKDNtRJaXEY+nhRfZUb3
 08nR4bziQJBeUFjEsf9WGrciGwzMaMRezbbFoLssJmfTq1R4LOJeeV7lUphpW1nOlY42Tgd2s4
 D2I=
From:   "George G. Davis" <george_davis@mentor.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <george_davis@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <davis.george@siemens.com>
Subject: [RFC][PATCH] mm/page_isolation: tracing: trace all test_pages_isolated failures
Date:   Mon, 23 Aug 2021 16:28:23 -0400
Message-ID: <20210823202823.13765-1-george_davis@mentor.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "George G. Davis" <davis.george@siemens.com>

Some test_pages_isolated failure conditions don't include trace points.
For debugging issues caused by "pinned" pages, make sure to trace all
calls whether they succeed or fail. In this case, a failure case did not
result in a trace point. So add the missing failure case in
test_pages_isolated traces.

Signed-off-by: George G. Davis <davis.george@siemens.com>
---
 mm/page_isolation.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index bddf788f45bf..fff55bb830f9 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -287,6 +287,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long pfn, flags;
 	struct page *page;
 	struct zone *zone;
+	int ret;
 
 	/*
 	 * Note: pageblock_nr_pages != MAX_ORDER. Then, chunks of free pages
@@ -299,15 +300,21 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 			break;
 	}
 	page = __first_valid_page(start_pfn, end_pfn - start_pfn);
-	if ((pfn < end_pfn) || !page)
-		return -EBUSY;
+	if ((pfn < end_pfn) || !page) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* Check all pages are free or marked as ISOLATED */
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lock, flags);
 	pfn = __test_page_isolated_in_pageblock(start_pfn, end_pfn, isol_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
+	ret = pfn < end_pfn ? -EBUSY : 0;
+
+out:
 	trace_test_pages_isolated(start_pfn, end_pfn, pfn);
 
-	return pfn < end_pfn ? -EBUSY : 0;
+	return ret;
 }
-- 
2.17.1

