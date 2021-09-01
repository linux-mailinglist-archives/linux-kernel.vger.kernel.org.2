Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1913FD177
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbhIACpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:45:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:6423 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231613AbhIACpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:45:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="198843984"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="198843984"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 19:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="531611425"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Aug 2021 19:44:03 -0700
Date:   Wed, 1 Sep 2021 10:44:02 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/oom: detect and kill task which has allocation
 forbidden by cpuset limit
Message-ID: <20210901024402.GB46357@shbuild999.sh.intel.com>
References: <1630399085-70431-1-git-send-email-feng.tang@intel.com>
 <YS5RTiVgydjszmjn@dhcp22.suse.cz>
 <52d80e9-cf27-9a59-94fd-d27a1e2dac6f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d80e9-cf27-9a59-94fd-d27a1e2dac6f@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David and Michal,

On Tue, Aug 31, 2021 at 06:06:17PM -0700, David Rientjes wrote:
> On Tue, 31 Aug 2021, Michal Hocko wrote:
> 
> > I do not like this solution TBH. We know that that it is impossible to
> > satisfy the allocation at the page allocator level so dealing with it at
> > the OOM killer level is just a bad layering and a lot of wasted cycles
> > to reach that point. Why cannot we simply fail the allocation if cpusets
> > filtering leads to an empty zone intersection?
> 
> Cpusets will guarantee our effective nodemask will include at least one 
> node in N_MEMORY (cpuset_mems_allowed()) so we'll always have at least one 
> zone in our zonelist.
> 
> Issue in this case appears to be that the zone will never satisfy 
> non-movable allocations.  I think this would be very similar to a GFP_DMA 
> allocation when bound to a node without lowmem, in which case we get a 
> page allocation failure.  We don't kill current like this patch.
 
Thanks for sharing the case, the DMA case is quite simliar. And in our usage,
the allocating task is finally killed after many OS routine/GUI tasks get
killed.

> So I'd agree in this case that it would be better to simply fail the 
> allocation.

I agree with yours and Michal's comments, putting it in the OOM code
is a little late and wastes cpu cycles.

> Feng, would you move this check to __alloc_pages_may_oom() like the other 
> special cases and simply fail rather than call into the oom killer?

Will explore more in this direction, thanks!

- Feng
