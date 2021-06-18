Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C13ACB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhFRMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:53:18 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:54825 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231536AbhFRMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:53:14 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id 2217EFA882
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:51:04 +0100 (IST)
Received: (qmail 32760 invoked from network); 18 Jun 2021 12:51:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jun 2021 12:51:03 -0000
Date:   Fri, 18 Jun 2021 13:51:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] mm/page_alloc: do bulk array bounds check after checking
 populated elements
Message-ID: <20210618125102.GU30378@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter reported the following

  The patch 0f87d9d30f21: "mm/page_alloc: add an array-based interface
  to the bulk page allocator" from Apr 29, 2021, leads to the following
  static checker warning:

        mm/page_alloc.c:5338 __alloc_pages_bulk()
        warn: potentially one past the end of array 'page_array[nr_populated]'

The problem can occur if an array is passed in that is fully populated. That
potentially ends up allocating a single page and storing it past the end of
the array. This patch returns 0 if the array is fully populated.

Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mel Gorman <mgorman@techsinguliarity.net>
---
 mm/page_alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7124bb00219d..ef2265f86b91 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5056,6 +5056,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
 		nr_populated++;
 
+	/* Already populated array? */
+	if (unlikely(page_array && nr_pages - nr_populated == 0))
+		return 0;
+
 	/* Use the single page allocator for one page. */
 	if (nr_pages - nr_populated == 1)
 		goto failed;
