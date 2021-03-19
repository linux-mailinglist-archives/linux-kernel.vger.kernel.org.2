Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C163419AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCSKOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:14:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:38372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhCSKO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:14:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22F38AC17;
        Fri, 19 Mar 2021 10:14:26 +0000 (UTC)
Subject: Re: [PATCH v5 2/5] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
To:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-3-osalvador@suse.de> <YFIOTTC7wgXHQRpy@dhcp22.suse.cz>
 <20210317143827.GA20965@linux> <YFIZVvQllaZHDgzW@dhcp22.suse.cz>
 <843f68e7-6fe6-54e7-976b-af8647482ac1@suse.cz>
 <YFMprphu2jEf+OY7@dhcp22.suse.cz>
 <5b294e86-e6a4-71ea-6a7e-1a611c6ccccf@suse.cz>
 <YFM7VPo06EuzfN4b@dhcp22.suse.cz> <20210319095742.GA6409@linux>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5e7e6f51-489e-eac0-f817-d80015835b25@suse.cz>
Date:   Fri, 19 Mar 2021 11:14:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319095742.GA6409@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 10:57 AM, Oscar Salvador wrote:
> On Thu, Mar 18, 2021 at 12:36:52PM +0100, Michal Hocko wrote:
>> Yeah, makes sense. I am not a fan of the above form of documentation.
>> Btw. maybe renaming the field would be even better, both from the
>> intention and review all existing users. I would go with pfn_iter or
>> something that wouldn't make it sound like migration specific.
> 
> Just to be sure we are on the same page, you meant something like the following
> (wrt. comments):
> 
>  /*
>   * compact_control is used to track pages being migrated and the free pages
>   * they are being migrated to during memory compaction. The free_pfn starts
>   * at the end of a zone and migrate_pfn begins at the start. Movable pages
>   * are moved to the end of a zone during a compaction run and the run
>   * completes when free_pfn <= migrate_pfn
>   *
>   * freepages:           List of free pages to migrate to
>   * migratepages:        List of pages that need to be migrated
>   * nr_freepages:        Number of isolated free pages
>   ...
>   */
>   struct compact_control {
>           struct list_head freepages;
>           ...

No I meant this:

--- a/mm/internal.h
+++ b/mm/internal.h
@@ -225,7 +225,13 @@ struct compact_control {
        unsigned int nr_freepages;      /* Number of isolated free pages */
        unsigned int nr_migratepages;   /* Number of pages to migrate */
        unsigned long free_pfn;         /* isolate_freepages search base */
-       unsigned long migrate_pfn;      /* isolate_migratepages search base */
+       /*
+        * Acts as an in/out parameter to page isolation for migration.
+        * isolate_migratepages uses it as a search base.
+        * isolate_migratepages_block will update the value to the next pfn
+        * after the last isolated one.
+        */
+       unsigned long migrate_pfn;
        unsigned long fast_start_pfn;   /* a pfn to start linear scan from */
        struct zone *zone;
        unsigned long total_migrate_scanned;


> With the preface that I am not really familiar with compaction code:
> 
> About renaming the variable to something else, I wouldn't do it.
> I see migrate_pfn being used in contexts where migration gets mentioned,
> e.g: 

I also don't like the renaming much. "Migration" is important as this is about
pages to be migrated, and there's "free_pfn" field tracking scan for free pages as
migration target. So the name can't be as generic as "pfn_iter".

>  /*
>   * Briefly search the free lists for a migration source that already has
>   * some free pages to reduce the number of pages that need migration
>   * before a pageblock is free.
>   */
>  fast_find_migrateblock(struct compact_control *cc)
>  {
>   ...
>   unsigned long pfn = cc->migrate_pfn;
>  }
> 
> isolate_migratepages()
>  /* Record where migration scanner will be restarted. */
> 
> 
> So, I would either stick with it, or add a new 'iter_pfn'/'next_pfn_scan'
> field if we feel the need to.
> 
> 

