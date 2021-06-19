Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB7C3AD6BC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 04:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhFSCgX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Jun 2021 22:36:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:45715 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhFSCgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 22:36:22 -0400
IronPort-SDR: csbA2nxzH/V4xZym/sqAMDnFnkLk3s+YmAUdLYq1d5l+FpiUzTnjpYitQm8fbnc/zdUv5BbaY4
 liWydgvhJfhA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193777281"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193777281"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 19:34:02 -0700
IronPort-SDR: o/iJRsDyUnI+QHJwsUmdMtmLyRnRD2HvDnYA9WtJ29HiUcQyeOSQAkg37ZNe7JTOw7Ak4z4l24
 XduJHWH4vqww==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="555747358"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 19:34:00 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: Re: [PATCH -V8 07/10] mm/vmscan: add helper for querying ability to
 age anonymous pages
References: <20210618061537.434999-1-ying.huang@intel.com>
        <20210618061537.434999-8-ying.huang@intel.com>
        <9E787EAE-BED4-4902-B34D-F08FD8F21D76@nvidia.com>
Date:   Sat, 19 Jun 2021 10:33:58 +0800
In-Reply-To: <9E787EAE-BED4-4902-B34D-F08FD8F21D76@nvidia.com> (Zi Yan's
        message of "Fri, 18 Jun 2021 11:45:50 -0400")
Message-ID: <878s36poq1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 18 Jun 2021, at 2:15, Huang Ying wrote:
>
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>
>> Anonymous pages are kept on their own LRU(s).  These lists could
>> theoretically always be scanned and maintained.  But, without swap,
>> there is currently nothing the kernel can *do* with the results of a
>> scanned, sorted LRU for anonymous pages.
>>
>> A check for '!total_swap_pages' currently serves as a valid check as
>> to whether anonymous LRUs should be maintained.  However, another
>> method will be added shortly: page demotion.
>>
>> Abstract out the 'total_swap_pages' checks into a helper, give it a
>> logically significant name, and check for the possibility of page
>> demotion.
>>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> Reviewed-by: Greg Thelen <gthelen@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: osalvador <osalvador@suse.de>
>> ---
>>  mm/vmscan.c | 28 +++++++++++++++++++++++++---
>>  1 file changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 7d5c7216a4b7..8654cec65522 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2706,6 +2706,26 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>>  	}
>>  }
>>
>> +/*
>> + * Anonymous LRU management is a waste if there is
>> + * ultimately no way to reclaim the memory.
>> + */
>> +bool anon_should_be_aged(struct lruvec *lruvec)
>> +{
>> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>> +
>> +	/* Aging the anon LRU is valuable if swap is present: */
>> +	if (total_swap_pages > 0)
>> +		return true;
>> +
>> +	/* Also valuable if anon pages can be demoted: */
>> +	if (next_demotion_node(pgdat->node_id) >= 0)
>
> != NUMA_NO_NODE might be better, even though we know NUMA_NO_NODE
> is currently set to -1.

Sure.  Will change this in the next version.

Best Regards,
Huang, Ying

>> +		return true;
>> +
>> +	/* No way to reclaim anon pages.  Should not age anon LRUs: */
>> +	return false;
>> +}
>> +
>>  static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>>  {
>>  	unsigned long nr[NR_LRU_LISTS];
>> @@ -2815,7 +2835,8 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>>  	 * Even if we did not try to evict anon pages at all, we want to
>>  	 * rebalance the anon lru active/inactive ratio.
>>  	 */
>> -	if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
>> +	if (anon_should_be_aged(lruvec) &&
>> +	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
>>  		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
>>  				   sc, LRU_ACTIVE_ANON);
>>  }
>> @@ -3644,10 +3665,11 @@ static void age_active_anon(struct pglist_data *pgdat,
>>  	struct mem_cgroup *memcg;
>>  	struct lruvec *lruvec;
>>
>> -	if (!total_swap_pages)
>> +	lruvec = mem_cgroup_lruvec(NULL, pgdat);
>> +
>> +	if (!anon_should_be_aged(lruvec))
>>  		return;
>>
>> -	lruvec = mem_cgroup_lruvec(NULL, pgdat);
>>  	if (!inactive_is_low(lruvec, LRU_INACTIVE_ANON))
>>  		return;
>>
>> -- 
>> 2.30.2
>
>
> —
> Best Regards,
> Yan, Zi
