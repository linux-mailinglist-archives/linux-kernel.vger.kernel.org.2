Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAF3413530
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhIUOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:19:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:27769 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233352AbhIUOTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:19:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210450840"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="210450840"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 07:06:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="549502391"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 07:06:05 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH v2 2/2] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
References: <20210921064553.293905-1-o451686892@gmail.com>
        <20210921064553.293905-3-o451686892@gmail.com>
        <87mto676fq.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <d57aaff2-b154-4462-1a7d-3d288ebabb6a@gmail.com>
Date:   Tue, 21 Sep 2021 22:06:03 +0800
In-Reply-To: <d57aaff2-b154-4462-1a7d-3d288ebabb6a@gmail.com> (Weizhao
        Ouyang's message of "Tue, 21 Sep 2021 15:31:27 +0800")
Message-ID: <87ee9i6n1w.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Weizhao Ouyang <o451686892@gmail.com> writes:

> On 2021/9/21 15:07, Huang, Ying wrote:
>> Weizhao Ouyang <o451686892@gmail.com> writes:
>>
>>> Sync up MR_DEMOTION to migrate_reason_names and add a synch prompt.
>>>
>>> Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
>>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>> ---
>>>  include/linux/migrate.h | 6 +++++-
>>>  mm/debug.c              | 1 +
>>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>> index 326250996b4e..c8077e936691 100644
>>> --- a/include/linux/migrate.h
>>> +++ b/include/linux/migrate.h
>>> @@ -19,6 +19,11 @@ struct migration_target_control;
>>>   */
>>>  #define MIGRATEPAGE_SUCCESS		0
>>>  
>>> +/*
>>> + * Keep sync with:
>>> + * - macro MIGRATE_REASON in include/trace/events/migrate.h
>>> + * - migrate_reason_names[MR_TYPES] in mm/debug.c
>>> + */
>>>  enum migrate_reason {
>>>  	MR_COMPACTION,
>>>  	MR_MEMORY_FAILURE,
>>> @@ -32,7 +37,6 @@ enum migrate_reason {
>>>  	MR_TYPES
>>>  };
>>>  
>>> -/* In mm/debug.c; also keep sync with include/trace/events/migrate.h */
>>>  extern const char *migrate_reason_names[MR_TYPES];
>>>  
>>>  #ifdef CONFIG_MIGRATION
>>> diff --git a/mm/debug.c b/mm/debug.c
>>> index e61037cded98..fae0f81ad831 100644
>>> --- a/mm/debug.c
>>> +++ b/mm/debug.c
>>> @@ -26,6 +26,7 @@ const char *migrate_reason_names[MR_TYPES] = {
>>>  	"numa_misplaced",
>>>  	"contig_range",
>>>  	"longterm_pin",
>>> +	"demotion",
>>>  };
>>>  
>>>  const struct trace_print_flags pageflag_names[] = {
>> Can we add BUILD_BUG_ON() somewhere to capture at least some
>> synchronization issue?
>
> Hi Huang, we discussed this in the v1 thread with you and John, seems you
> missed it. Now we just add a comment to do the synchronization, and we can
> figure out a more general way to use strings which in trace_events straight.

Got it!  And I think we can add the BUILD_BUG_ON() now and delete it
when we have a better solution to deal with that.  But if you can work
out a better solution quickly, that's fine to ignore this.

Best Regards,
Huang, Ying
