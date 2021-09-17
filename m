Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2849240F2DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbhIQHFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:05:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:55360 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhIQHFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:05:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202895715"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="202895715"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 00:03:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="546223904"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 00:03:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
References: <20210917061432.323777-1-o451686892@gmail.com>
Date:   Fri, 17 Sep 2021 15:03:48 +0800
In-Reply-To: <20210917061432.323777-1-o451686892@gmail.com> (Weizhao Ouyang's
        message of "Fri, 17 Sep 2021 14:14:32 +0800")
Message-ID: <871r5nptt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Weizhao Ouyang <o451686892@gmail.com> writes:

> After related migrate page updates, sync up latest migrate_reason to
> migrate_reason_names, page_owner use it to parse the page migrate
> reason.
>
> Fixes: d1e153fea2a8 ("mm/gup: migrate pinned pages out of movable zone")
> Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>  mm/debug.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/debug.c b/mm/debug.c
> index e73fe0a8ec3d..733770b0ed0c 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -25,6 +25,8 @@ const char *migrate_reason_names[MR_TYPES] = {
>  	"mempolicy_mbind",
>  	"numa_misplaced",
>  	"cma",
> +	"longterm_pin",
> +	"demotion",
>  };
>  
>  const struct trace_print_flags pageflag_names[] = {

Good catch!  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

It may be better to use BUILD_BUG_ON() to capture similar issue earlier?

Best Regards,
Huang, Ying
