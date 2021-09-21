Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4042E412F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhIUHJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:09:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:34180 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhIUHI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:08:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210377428"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="210377428"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 00:07:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="556822401"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 00:07:23 -0700
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
Date:   Tue, 21 Sep 2021 15:07:21 +0800
In-Reply-To: <20210921064553.293905-3-o451686892@gmail.com> (Weizhao Ouyang's
        message of "Tue, 21 Sep 2021 14:45:53 +0800")
Message-ID: <87mto676fq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Weizhao Ouyang <o451686892@gmail.com> writes:

> Sync up MR_DEMOTION to migrate_reason_names and add a synch prompt.
>
> Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  include/linux/migrate.h | 6 +++++-
>  mm/debug.c              | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 326250996b4e..c8077e936691 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -19,6 +19,11 @@ struct migration_target_control;
>   */
>  #define MIGRATEPAGE_SUCCESS		0
>  
> +/*
> + * Keep sync with:
> + * - macro MIGRATE_REASON in include/trace/events/migrate.h
> + * - migrate_reason_names[MR_TYPES] in mm/debug.c
> + */
>  enum migrate_reason {
>  	MR_COMPACTION,
>  	MR_MEMORY_FAILURE,
> @@ -32,7 +37,6 @@ enum migrate_reason {
>  	MR_TYPES
>  };
>  
> -/* In mm/debug.c; also keep sync with include/trace/events/migrate.h */
>  extern const char *migrate_reason_names[MR_TYPES];
>  
>  #ifdef CONFIG_MIGRATION
> diff --git a/mm/debug.c b/mm/debug.c
> index e61037cded98..fae0f81ad831 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -26,6 +26,7 @@ const char *migrate_reason_names[MR_TYPES] = {
>  	"numa_misplaced",
>  	"contig_range",
>  	"longterm_pin",
> +	"demotion",
>  };
>  
>  const struct trace_print_flags pageflag_names[] = {

Can we add BUILD_BUG_ON() somewhere to capture at least some
synchronization issue?

Best Regards,
Huang, Ying
