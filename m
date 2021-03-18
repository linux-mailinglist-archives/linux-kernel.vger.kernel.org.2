Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA9D340312
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCRKWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:22:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:59900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhCRKWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:22:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616062970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6drPy5++cy/jLxICKU45ttYyTRuG0/pKPjS/Nwj8Jvs=;
        b=JBzkA7hwJx0aIzuewbyoR+uidBiIKel4JFalCj7FtGVMQiJNn2NyZ5WRLyWVzVsdGFt8k3
        IYnzEkIKJ/DPPJsGSeYexjcngPm8GCqAMUF5++UamGBqOlXXVvrC8MNUKWeIBPrjPHgkr5
        l+1LUq+d1oONfo250qlHJ0HbBPj5B48=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C43DDAC1E;
        Thu, 18 Mar 2021 10:22:50 +0000 (UTC)
Date:   Thu, 18 Mar 2021 11:22:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
Message-ID: <YFMprphu2jEf+OY7@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-3-osalvador@suse.de>
 <YFIOTTC7wgXHQRpy@dhcp22.suse.cz>
 <20210317143827.GA20965@linux>
 <YFIZVvQllaZHDgzW@dhcp22.suse.cz>
 <843f68e7-6fe6-54e7-976b-af8647482ac1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843f68e7-6fe6-54e7-976b-af8647482ac1@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-03-21 10:50:38, Vlastimil Babka wrote:
> On 3/17/21 3:59 PM, Michal Hocko wrote:
> > On Wed 17-03-21 15:38:35, Oscar Salvador wrote:
> >> On Wed, Mar 17, 2021 at 03:12:29PM +0100, Michal Hocko wrote:
> >> > > Since isolate_migratepages_block will stop returning the next pfn to be
> >> > > scanned, we reuse the cc->migrate_pfn field to keep track of that.
> >> > 
> >> > This looks hakish and I cannot really tell that users of cc->migrate_pfn
> >> > work as intended.
> 
> We did check those in detail. Of course it's possible to overlook something...
> 
> The alloc_contig_range user never cared about cc->migrate_pfn. compaction
> (isolate_migratepages() -> isolate_migratepages_block()) did, and
> isolate_migratepages_block() returned the pfn only to be assigned to
> cc->migrate_pfn in isolate_migratepages(). I think it's now better that
> isolate_migratepages_block() sets it.
> 
> >> When discussing this with Vlastimil, I came up with the idea of adding a new
> >> field in compact_control struct, e.g: next_pfn_scan to keep track of the next
> >> pfn to be scanned.
> >> 
> >> But Vlastimil made me realize that since cc->migrate_pfn points to that aleady,
> >> so we do not need any extra field.
> 
> Yes, the first patch had at asome point:
> 
> 	/* Record where migration scanner will be restarted. */
> 	cc->migrate_pfn = cc->the_new_field;
> 
> Which was a clear sign that the new field is unnecessary.
> 
> > This deserves a big fat comment.
> 
> Comment where, saying what? :)

E.g. something like the following
diff --git a/mm/internal.h b/mm/internal.h
index 1432feec62df..6c5a9066adf0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -225,7 +225,13 @@ struct compact_control {
 	unsigned int nr_freepages;	/* Number of isolated free pages */
 	unsigned int nr_migratepages;	/* Number of pages to migrate */
 	unsigned long free_pfn;		/* isolate_freepages search base */
-	unsigned long migrate_pfn;	/* isolate_migratepages search base */
+	unsigned long migrate_pfn;	/* Acts as an in/out parameter to page
+					 * isolation.
+					 * isolate_migratepages uses it as a search base.
+					 * isolate_migratepages_block will update the
+					 * value the next pfn after the last isolated
+					 * one.
+					 */
 	unsigned long fast_start_pfn;	/* a pfn to start linear scan from */
 	struct zone *zone;
 	unsigned long total_migrate_scanned;

Btw isolate_migratepages_block still has this comment which needs
updating
"The cc->migrate_pfn field is neither read nor updated."
-- 
Michal Hocko
SUSE Labs
