Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE63C6BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhGMIDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234503AbhGMIDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:03:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B410E6120A;
        Tue, 13 Jul 2021 08:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626163246;
        bh=wO4nJtb/0wmA00Vei0+gmgdy2aWHz0Ba7T19Y+vP1x8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRsc61qxHMAb+kt6H/RN8zE95GSoRZyVLOgD6w+LR3twa5veB913+sEn8WAZbqMxI
         hbZ6PngcwX6uB4K7gBtnCmDpVwqZhPffRagPxGQrANgpY1NPh0EqRicEC+KQQI7szH
         lKF4aLAH0MUVZ881P9r+o4mmXEjUmAKePNHr1l7xu9yXsMuFrChorqQErn2uXErRnK
         xeIxnj4USn/RVRGlQQhQVNAF7FtJim3zdOTontWzNCT8JfmaswipC9R87Ims1EGeZm
         iFxUy9NKpBZJAZluUUu7Mp0bBoH5skAZIKccZk4qiEFGeWITY9OfXz+UAXjx8IhwV9
         FTvfI3kMGVI6g==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] mm: memory_hotplug: cleanup after removal of pfn_valid_within()
Date:   Tue, 13 Jul 2021 11:00:35 +0300
Message-Id: <20210713080035.7464-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210713080035.7464-1-rppt@kernel.org>
References: <20210713080035.7464-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

When test_pages_in_a_zone() used pfn_valid_within() is has some logic
surrounding pfn_valid_within() checks.

Since pfn_valid_within() is gone, this logic can be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memory_hotplug.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1085bd03ecba..ca09045bb587 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1298,7 +1298,7 @@ struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 	unsigned long pfn, sec_end_pfn;
 	struct zone *zone = NULL;
 	struct page *page;
-	int i;
+
 	for (pfn = start_pfn, sec_end_pfn = SECTION_ALIGN_UP(start_pfn + 1);
 	     pfn < end_pfn;
 	     pfn = sec_end_pfn, sec_end_pfn += PAGES_PER_SECTION) {
@@ -1307,13 +1307,10 @@ struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 			continue;
 		for (; pfn < sec_end_pfn && pfn < end_pfn;
 		     pfn += MAX_ORDER_NR_PAGES) {
-			i = 0;
-			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
-				continue;
 			/* Check if we got outside of the zone */
-			if (zone && !zone_spans_pfn(zone, pfn + i))
+			if (zone && !zone_spans_pfn(zone, pfn))
 				return NULL;
-			page = pfn_to_page(pfn + i);
+			page = pfn_to_page(pfn);
 			if (zone && page_zone(page) != zone)
 				return NULL;
 			zone = page_zone(page);
-- 
2.28.0

