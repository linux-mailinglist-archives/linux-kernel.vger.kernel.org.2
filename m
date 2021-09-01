Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD64B3FDD61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbhIANnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:43:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:48731 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244221AbhIANnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:43:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="218805028"
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="218805028"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 06:42:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="498900664"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2021 06:42:00 -0700
Date:   Wed, 1 Sep 2021 21:42:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom: detect and kill task which has allocation
 forbidden by cpuset limit
Message-ID: <20210901134200.GA50993@shbuild999.sh.intel.com>
References: <1630399085-70431-1-git-send-email-feng.tang@intel.com>
 <YS5RTiVgydjszmjn@dhcp22.suse.cz>
 <52d80e9-cf27-9a59-94fd-d27a1e2dac6f@google.com>
 <20210901024402.GB46357@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901024402.GB46357@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 10:44:02AM +0800, Tang, Feng wrote:
[SNIP]
> > So I'd agree in this case that it would be better to simply fail the 
> > allocation.
> 
> I agree with yours and Michal's comments, putting it in the OOM code
> is a little late and wastes cpu cycles.
> 
> > Feng, would you move this check to __alloc_pages_may_oom() like the other 
> > special cases and simply fail rather than call into the oom killer?
> 
> Will explore more in this direction, thanks!
 
I tried below patch, which can solve the blindly killing issue, that
the docker processes will see page allocation errors, and eventually 
quit running.

Thanks,
Feng

---
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eeb3a9cb36bb..d1ae77be45a2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4271,10 +4271,18 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 		.gfp_mask = gfp_mask,
 		.order = order,
 	};
-	struct page *page;
+	struct page *page = NULL;
+	struct zoneref *z;
 
 	*did_some_progress = 0;
 
+	if (cpusets_enabled() && (gfp_mask & __GFP_HARDWALL)) {
+		z = first_zones_zonelist(ac->zonelist,
+			gfp_zone(gfp_mask), &cpuset_current_mems_allowed);
+		if (!z->zone)
+			goto out;
+	}
+
 	/*
 	 * Acquire the oom lock.  If that fails, somebody else is
 	 * making progress for us.
