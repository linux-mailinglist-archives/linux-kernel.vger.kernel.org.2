Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1932A305841
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhA0KXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:23:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235688AbhA0KT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611742710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xjqz0z3B10MBMjRhyTzjYxNKEzPg2nutGw+BuiLIitY=;
        b=OCEdIOXAAPSCnYv9GFWV3cbykt664ihtGgntZ26ipblwaxnoeCVPzxfC9j6YuHWHDIGLem
        i0fAFTh9vU5FloPM+R8Wy03gnebii4yReNcs/Nj+Wjkmnh0vaI/J/ppRkuud5HHX0teTrN
        zmngPQh7KrJfX+m/IQP+t/qpM2N0l8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-nzpZ7BHTOPa1PH98o-_REw-1; Wed, 27 Jan 2021 05:18:25 -0500
X-MC-Unique: nzpZ7BHTOPa1PH98o-_REw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4601D801AB8;
        Wed, 27 Jan 2021 10:18:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 445086EF55;
        Wed, 27 Jan 2021 10:18:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 2/2] mm/page_alloc: count CMA pages per zone and print them in /proc/zoneinfo
Date:   Wed, 27 Jan 2021 11:18:13 +0100
Message-Id: <20210127101813.6370-3-david@redhat.com>
In-Reply-To: <20210127101813.6370-1-david@redhat.com>
References: <20210127101813.6370-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's count the number of CMA pages per zone and print them in
/proc/zoneinfo.

Having access to the total number of CMA pages per zone is helpful for
debugging purposes to know where exactly the CMA pages ended up, and to
figure out how many pages of a zone might behave differently (e.g., like
ZONE_MOVABLE) - even after some of these pages might already have been
allocated.

For now, we are only able to get the global nr+free cma pages from
/proc/meminfo and the free cma pages per zone from /proc/zoneinfo.

Note: Track/print that information even without CONFIG_CMA, similar to
"nr_free_cma" in /proc/zoneinfo. This is different to /proc/meminfo -
maybe we want to make that consistent in the future (however, changing
/proc/zoneinfo output might uglify the code a bit).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h | 4 ++++
 mm/page_alloc.c        | 1 +
 mm/vmstat.c            | 6 ++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ae588b2f87ef..3bc18c9976fd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -503,6 +503,9 @@ struct zone {
 	 * bootmem allocator):
 	 *	managed_pages = present_pages - reserved_pages;
 	 *
+	 * cma pages is present pages that are assigned for CMA use
+	 * (MIGRATE_CMA).
+	 *
 	 * So present_pages may be used by memory hotplug or memory power
 	 * management logic to figure out unmanaged pages by checking
 	 * (present_pages - managed_pages). And managed_pages should be used
@@ -527,6 +530,7 @@ struct zone {
 	atomic_long_t		managed_pages;
 	unsigned long		spanned_pages;
 	unsigned long		present_pages;
+	unsigned long		cma_pages;
 
 	const char		*name;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b031a5ae0bd5..9a82375bbcb2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2168,6 +2168,7 @@ void __init init_cma_reserved_pageblock(struct page *page)
 	}
 
 	adjust_managed_page_count(page, pageblock_nr_pages);
+	page_zone(page)->cma_pages += pageblock_nr_pages;
 }
 #endif
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 7758486097f9..97fc32a53320 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1642,14 +1642,16 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   "\n        high     %lu"
 		   "\n        spanned  %lu"
 		   "\n        present  %lu"
-		   "\n        managed  %lu",
+		   "\n        managed  %lu"
+		   "\n        cma      %lu",
 		   zone_page_state(zone, NR_FREE_PAGES),
 		   min_wmark_pages(zone),
 		   low_wmark_pages(zone),
 		   high_wmark_pages(zone),
 		   zone->spanned_pages,
 		   zone->present_pages,
-		   zone_managed_pages(zone));
+		   zone_managed_pages(zone),
+		   zone->cma_pages);
 
 	seq_printf(m,
 		   "\n        protection: (%ld",
-- 
2.29.2

