Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC795363D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbhDSHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:55:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhDSHyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:54:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54138AECD;
        Mon, 19 Apr 2021 07:54:25 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v10 1/7] mm,page_alloc: Bail out earlier on -ENOMEM in alloc_contig_migrate_range
Date:   Mon, 19 Apr 2021 09:54:07 +0200
Message-Id: <20210419075413.1064-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210419075413.1064-1-osalvador@suse.de>
References: <20210419075413.1064-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, __alloc_contig_migrate_range can generate -EINTR, -ENOMEM or -EBUSY,
and report them down the chain.
The problem is that when migrate_pages() reports -ENOMEM, we keep going till we
exhaust all the try-attempts (5 at the moment) instead of bailing out.

migrate_pages() bails out right away on -ENOMEM because it is considered a fatal
error. Do the same here instead of keep going and retrying.
Note that this is not fixing a real issue, just a cosmetic change. Although we
can save some cycles by backing off ealier

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/page_alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1c67c99603a3..689454692de1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8697,7 +8697,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 			}
 			tries = 0;
 		} else if (++tries == 5) {
-			ret = ret < 0 ? ret : -EBUSY;
+			ret = -EBUSY;
 			break;
 		}
 
@@ -8707,6 +8707,13 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
+
+		/*
+		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
+		 * to retry again over this error, so do the same here.
+		 */
+		if (ret == -ENOMEM)
+			break;
 	}
 
 	lru_cache_enable();
-- 
2.16.3

