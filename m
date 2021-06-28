Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A63B6583
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbhF1P37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:29:59 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:45525 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237031AbhF1PEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:04:48 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 40B3D1C354A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:02:21 +0100 (IST)
Received: (qmail 19484 invoked from network); 28 Jun 2021 15:02:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jun 2021 15:02:20 -0000
Date:   Mon, 28 Jun 2021 16:02:19 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] mm/page_alloc: Correct return value of populated elements if
 bulk array is populated
Message-ID: <20210628150219.GC3840@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones reported the following

	This made it into 5.13 final, and completely breaks NFSD for me
	(Serving tcp v3 mounts).  Existing mounts on clients hang, as do
	new mounts from new clients.  Rebooting the server back to rc7
	everything recovers.

The commit b3b64ebd3822 ("mm/page_alloc: do bulk array bounds check after
checking populated elements") returns the wrong value if the array is
already populated which is interpreted as an allocation failure. Dave
reported this fixes his problem and it also passed a test running dbench
over NFS.

Fixes: b3b64ebd3822 ("mm/page_alloc: do bulk array bounds check after checking populated elements")
Reported-and-tested-by: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Cc: <stable@vger.kernel.org> [5.13+]
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef2265f86b91..04220581579c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5058,7 +5058,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	/* Already populated array? */
 	if (unlikely(page_array && nr_pages - nr_populated == 0))
-		return 0;
+		return nr_populated;
 
 	/* Use the single page allocator for one page. */
 	if (nr_pages - nr_populated == 1)
