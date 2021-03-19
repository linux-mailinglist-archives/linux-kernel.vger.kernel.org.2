Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6332C3419E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCSK0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:26:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:56670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhCSK0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:26:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04944AE05;
        Fri, 19 Mar 2021 10:26:39 +0000 (UTC)
Date:   Fri, 19 Mar 2021 11:26:36 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
Message-ID: <20210319102628.GA6868@linux>
References: <20210317111251.17808-3-osalvador@suse.de>
 <YFIOTTC7wgXHQRpy@dhcp22.suse.cz>
 <20210317143827.GA20965@linux>
 <YFIZVvQllaZHDgzW@dhcp22.suse.cz>
 <843f68e7-6fe6-54e7-976b-af8647482ac1@suse.cz>
 <YFMprphu2jEf+OY7@dhcp22.suse.cz>
 <5b294e86-e6a4-71ea-6a7e-1a611c6ccccf@suse.cz>
 <YFM7VPo06EuzfN4b@dhcp22.suse.cz>
 <20210319095742.GA6409@linux>
 <5e7e6f51-489e-eac0-f817-d80015835b25@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7e6f51-489e-eac0-f817-d80015835b25@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 11:14:25AM +0100, Vlastimil Babka wrote:
> No I meant this:
> 
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -225,7 +225,13 @@ struct compact_control {
>         unsigned int nr_freepages;      /* Number of isolated free pages */
>         unsigned int nr_migratepages;   /* Number of pages to migrate */
>         unsigned long free_pfn;         /* isolate_freepages search base */
> -       unsigned long migrate_pfn;      /* isolate_migratepages search base */
> +       /*
> +        * Acts as an in/out parameter to page isolation for migration.
> +        * isolate_migratepages uses it as a search base.
> +        * isolate_migratepages_block will update the value to the next pfn
> +        * after the last isolated one.
> +        */
> +       unsigned long migrate_pfn;
>         unsigned long fast_start_pfn;   /* a pfn to start linear scan from */
>         struct zone *zone;
>         unsigned long total_migrate_scanned;

Meh, silly me.
Ok, I will do it that way.

I am also for expanding some of the comments as I see that some explanations are
rather laconic, but I do not think such work fits in this patchset.

Since I happen to be checking compaction code due to other reasons, I shall
come back to this matter once I am done with this patchset.

-- 
Oscar Salvador
SUSE L3
