Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA73334133
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhCJPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:09:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:34310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhCJPJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:09:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC43EAE55;
        Wed, 10 Mar 2021 15:09:00 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 1/4] mm,page_alloc: Bail out earlier on -ENOMEM in alloc_contig_migrate_range
Date:   Wed, 10 Mar 2021 16:08:50 +0100
Message-Id: <20210310150853.13541-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210310150853.13541-1-osalvador@suse.de>
References: <20210310150853.13541-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, __alloc_contig_migrate_range can generate -EINTR, -ENOMEM or -EBUSY,
and report them down the chain.
The problem is that when migrate_pages() reports -ENOMEM, we keep going till we
exhaust all the try-attempts (5 at the moment) instead of bailing out.

migrate_pages bails out right away on -ENOMEM because it is considered a fatal
error. Do the same here instead of keep going and retrying.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..94467f1b85ff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8484,7 +8484,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 			}
 			tries = 0;
 		} else if (++tries == 5) {
-			ret = ret < 0 ? ret : -EBUSY;
+			ret = -EBUSY;
 			break;
 		}
 
@@ -8494,6 +8494,12 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
+		/*
+		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
+		 * to retry again over this error, so do the same here.
+		 */
+		if (ret == -ENOMEM)
+			break;
 	}
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
-- 
2.16.3

