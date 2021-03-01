Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3713281F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbhCAPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:12:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236962AbhCAPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614611394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sii7nAfrV7srStWfit5QssGqQJ5z5OEblPF7nTrmNeM=;
        b=TX+ZSUrgupzCs+dUOIxxKV7zfmeYVeA4M1/9UY7d40EryPp/Otsx5PfgnOLvAvhYdUkmuV
        hQM1qNLrMUOlRx3a6in+Id31F+1qYJGy2QK0OeZe1ed1ytUCPTGy4LnTk2fGbQCf9/f6fB
        dlH6FQ55WOsIG5IBQZT7ITH1LZyUX3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-qe_9k3zCNJK5Ejpi3ohs0g-1; Mon, 01 Mar 2021 10:09:52 -0500
X-MC-Unique: qe_9k3zCNJK5Ejpi3ohs0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 025E91005501;
        Mon,  1 Mar 2021 15:09:51 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E08355C3E5;
        Mon,  1 Mar 2021 15:09:45 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v1] mm/page_alloc: drop pr_info_ratelimited() in alloc_contig_range()
Date:   Mon,  1 Mar 2021 16:09:45 +0100
Message-Id: <20210301150945.77012-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The information that some PFNs are busy is:
a) not helpful for ordinary users: we don't even know *who* called
   alloc_contig_range(). This is certainly not worth a pr_info.*().
b) not really helpful for debugging: we don't have any details *why*
   these PFNs are busy, and that is what we usually care about.
c) not complete: there are other cases where we fail alloc_contig_range()
   using different paths that are not getting recorded.

For example, we reach this path once we succeeded in isolating pageblocks,
but failed to migrate some pages - which can happen easily on
ZONE_NORMAL (i.e., has_unmovable_pages() is racy) but also on ZONE_MOVABLE
i.e., we would have to retry longer to migrate).

For example via virtio-mem when unplugging memory, we can create quite
some noise (especially with ZONE_NORMAL) that is not of interest to
users - it's expected that some allocations may fail as memory is busy.

Let's just drop that pr_info_ratelimit() and rather implement a dynamic
debugging mechanism in the future that can give us a better reason why
alloc_contig_range() failed on specific pages.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 519a60d5b6f7..efb924fb13e8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8647,8 +8647,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 
 	/* Make sure the range is really isolated. */
 	if (test_pages_isolated(outer_start, end, 0)) {
-		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
-			__func__, outer_start, end);
 		ret = -EBUSY;
 		goto done;
 	}
-- 
2.29.2

