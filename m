Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8796345C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCWKt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:49:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:40418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhCWKtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:49:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45367AD6D;
        Tue, 23 Mar 2021 10:49:06 +0000 (UTC)
Date:   Tue, 23 Mar 2021 11:49:03 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
Message-ID: <20210323104858.GA7776@linux>
References: <20210319132004.4341-1-osalvador@suse.de>
 <20210319132004.4341-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319132004.4341-3-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 02:20:01PM +0100, Oscar Salvador wrote:
> Currently, isolate_migratepages_{range,block} and their callers use
> a pfn == 0 vs pfn != 0 scheme to let the caller know whether there was
> any error during isolation.
> This does not work as soon as we need to start reporting different error
> codes and make sure we pass them down the chain, so they are properly
> interpreted by functions like e.g: alloc_contig_range.
> 
> Let us rework isolate_migratepages_{range,block} so we can report error
> codes.
> Since isolate_migratepages_block will stop returning the next pfn to be
> scanned, we reuse the cc->migrate_pfn field to keep track of that.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Hi Andrew,

I realized a missed place wrt. error handling.
could you squash this on top?

diff --git a/mm/compaction.c b/mm/compaction.c
index cd090a675321..9b989fc3168d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -809,6 +809,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	bool skip_on_failure = false;
 	unsigned long next_skip_pfn = 0;
 	bool skip_updated = false;
+	int ret = 0;
 
 	cc->migrate_pfn = low_pfn;
 
@@ -877,8 +878,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 			if (fatal_signal_pending(current)) {
 				cc->contended = true;
+				ret = -EINTR;
 
-				low_pfn = 0;
 				goto fatal_pending;
 			}
 
@@ -1134,7 +1135,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 	cc->migrate_pfn = low_pfn;
 
-	return 0;
+	return ret;
 }


Thanks a lot

-- 
Oscar Salvador
SUSE L3
