Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28D43418FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhCSJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:58:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:49404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhCSJ5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:57:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ACF38AE05;
        Fri, 19 Mar 2021 09:57:49 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:57:47 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
Message-ID: <20210319095742.GA6409@linux>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-3-osalvador@suse.de>
 <YFIOTTC7wgXHQRpy@dhcp22.suse.cz>
 <20210317143827.GA20965@linux>
 <YFIZVvQllaZHDgzW@dhcp22.suse.cz>
 <843f68e7-6fe6-54e7-976b-af8647482ac1@suse.cz>
 <YFMprphu2jEf+OY7@dhcp22.suse.cz>
 <5b294e86-e6a4-71ea-6a7e-1a611c6ccccf@suse.cz>
 <YFM7VPo06EuzfN4b@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFM7VPo06EuzfN4b@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:36:52PM +0100, Michal Hocko wrote:
> Yeah, makes sense. I am not a fan of the above form of documentation.
> Btw. maybe renaming the field would be even better, both from the
> intention and review all existing users. I would go with pfn_iter or
> something that wouldn't make it sound like migration specific.

Just to be sure we are on the same page, you meant something like the following
(wrt. comments):

 /*
  * compact_control is used to track pages being migrated and the free pages
  * they are being migrated to during memory compaction. The free_pfn starts
  * at the end of a zone and migrate_pfn begins at the start. Movable pages
  * are moved to the end of a zone during a compaction run and the run
  * completes when free_pfn <= migrate_pfn
  *
  * freepages:           List of free pages to migrate to
  * migratepages:        List of pages that need to be migrated
  * nr_freepages:        Number of isolated free pages
  ...
  */
  struct compact_control {
          struct list_head freepages;
          ...

With the preface that I am not really familiar with compaction code:

About renaming the variable to something else, I wouldn't do it.
I see migrate_pfn being used in contexts where migration gets mentioned,
e.g: 

 /*
  * Briefly search the free lists for a migration source that already has
  * some free pages to reduce the number of pages that need migration
  * before a pageblock is free.
  */
 fast_find_migrateblock(struct compact_control *cc)
 {
  ...
  unsigned long pfn = cc->migrate_pfn;
 }

isolate_migratepages()
 /* Record where migration scanner will be restarted. */


So, I would either stick with it, or add a new 'iter_pfn'/'next_pfn_scan'
field if we feel the need to.


-- 
Oscar Salvador
SUSE L3
