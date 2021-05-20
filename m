Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9824F38A017
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhETIty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:49:54 -0400
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:42033 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231180AbhETItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:49:53 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id 6706ABAC2D
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:48:31 +0100 (IST)
Received: (qmail 3202 invoked from network); 20 May 2021 08:48:31 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:48:31 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 01/14] mm/vmscan: Remove kerneldoc-like comment from isolate_lru_pages
Date:   Thu, 20 May 2021 09:47:56 +0100
Message-Id: <20210520084809.8576-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for vmscan.c

    mm/vmscan.c:1814: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

It is not a kerneldoc comment and isolate_lru_pages() is a static
function. While the detailed comment is nice, it does not need to be
exposed via kernel-doc.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5199b9696bab..73682ba1f93c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1810,7 +1810,7 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
 
 }
 
-/**
+/*
  * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
  *
  * lruvec->lru_lock is heavily contended.  Some of the functions that
-- 
2.26.2

