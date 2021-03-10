Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31923335D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 07:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhCJG13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 01:27:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:52573 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231140AbhCJG1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:27:08 -0500
IronPort-SDR: 4J+5Y+KUUZxozCfGjvwCZScOZ6NspvKsyIn+QyqJSpLMVFF674Lrt26epRzQ8vyHa3I2NtYbMS
 3bAnarY89WOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188437974"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="188437974"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 22:27:08 -0800
IronPort-SDR: ouIk1BF3tljdFg26L8+Q8KzPvjVS59e7xljVT76S14nRcxKoMzZcOqk2MUUWhcQ9iLV6dXnZhs
 5B33vpfXXavA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="438199033"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2021 22:27:04 -0800
Date:   Wed, 10 Mar 2021 14:27:04 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi leen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 01/14] mm/mempolicy: Add comment for missing LOCAL
Message-ID: <20210310062704.GA63076@shbuild999.sh.intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
 <1614766858-90344-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614766858-90344-2-git-send-email-feng.tang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 06:20:45PM +0800, Feng Tang wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> MPOL_LOCAL is a bit weird because it is simply a different name for an
> existing behavior (preferred policy with no node mask). It has been this
> way since it was added here:
> commit 479e2802d09f ("mm: mempolicy: Make MPOL_LOCAL a real policy")
> 
> It is so similar to MPOL_PREFERRED in fact that when the policy is
> created in mpol_new, the mode is set as PREFERRED, and an internal state
> representing LOCAL doesn't exist.
> 
> To prevent future explorers from scratching their head as to why
> MPOL_LOCAL isn't defined in the mpol_ops table, add a small comment
> explaining the situations.
> 
> v2:
> Change comment to refer to mpol_new (Michal)
> 
> Link: https://lore.kernel.org/r/20200630212517.308045-2-ben.widawsky@intel.com
> #Acked-by: Michal Hocko <mhocko@suse.com>

This shouldn't be masked:

Acked-by: Michal Hocko <mhocko@suse.com>

I did the mask when sending for internal review, and forgot to restore
it, sorry for the noise.

Thanks,
Feng

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/mempolicy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 2c3a865..5730fc1 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -427,6 +427,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>  		.create = mpol_new_bind,
>  		.rebind = mpol_rebind_nodemask,
>  	},
> +	/* [MPOL_LOCAL] - see mpol_new() */
>  };
>  
>  static int migrate_page_add(struct page *page, struct list_head *pagelist,
> -- 
> 2.7.4
