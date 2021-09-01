Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5B3FDDA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245028AbhIAOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:06:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51822 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244136AbhIAOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:06:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 801B52246F;
        Wed,  1 Sep 2021 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630505143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A5CQMxYr8Knsq3vFDrRQ8ixBT4QrOt3iGkhDaaK15bg=;
        b=b8OJW+ywPOul9Qh4Eymlc7uE3F2l3lui6G2CvNsm63X50+tvXuOAnQRE8mKJPEkSNI1xIu
        8FNCJj49fRnCBmnpiboHxw9PKpONP+vnzIEbWGF2s1l1Bj28Kk5NnH4UfP7t5XIh2RbTWb
        hkT5hsTcTpxH/sWO7hKaOYEmH5YuCuk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 28B7DA3B9C;
        Wed,  1 Sep 2021 14:05:43 +0000 (UTC)
Date:   Wed, 1 Sep 2021 16:05:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom: detect and kill task which has allocation
 forbidden by cpuset limit
Message-ID: <YS+ItADNn08hCLPY@dhcp22.suse.cz>
References: <1630399085-70431-1-git-send-email-feng.tang@intel.com>
 <YS5RTiVgydjszmjn@dhcp22.suse.cz>
 <52d80e9-cf27-9a59-94fd-d27a1e2dac6f@google.com>
 <20210901024402.GB46357@shbuild999.sh.intel.com>
 <20210901134200.GA50993@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901134200.GA50993@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-09-21 21:42:00, Feng Tang wrote:
[...]
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eeb3a9cb36bb..d1ae77be45a2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4271,10 +4271,18 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  		.gfp_mask = gfp_mask,
>  		.order = order,
>  	};
> -	struct page *page;
> +	struct page *page = NULL;
> +	struct zoneref *z;
>  
>  	*did_some_progress = 0;
>  
> +	if (cpusets_enabled() && (gfp_mask & __GFP_HARDWALL)) {
> +		z = first_zones_zonelist(ac->zonelist,
> +			gfp_zone(gfp_mask), &cpuset_current_mems_allowed);
> +		if (!z->zone)
> +			goto out;
> +	}
> +

This looks better than the previous attempt. It would be still better to
solve this at the page allocator layer. The slowpath is already doing
this for the nodemask. E.g.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eeb3a9cb36bb..a3193134540d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4929,6 +4929,17 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (!ac->preferred_zoneref->zone)
 		goto nopage;
 
+	/*
+	 * Check for insane configurations where the cpuset doesn't contain any suitable
+	 * zone to satisfy the request - e.g. kernel allocations from MOVABLE nodes only
+	 */
+	if (cpusets_enabled() && (gfp_mask & __GFP_HARDWALL)) {
+		struct zoneref *z = first_zones_zonelist(ac->zonelist, ac->highest_zoneidx,
+				&cpuset_current_mems_allowed);
+		if (!z->zone)
+			goto nopage;
+	}
+
 	if (alloc_flags & ALLOC_KSWAPD)
 		wake_all_kswapds(order, gfp_mask, ac);
 
if this is seen as an additional overhead for an insane configuration
then we can add insane_cpusets_enabled() which would be a static branch
enabled when somebody actually tries to configure movable only cpusets
or potentially other dubious usage.
-- 
Michal Hocko
SUSE Labs
