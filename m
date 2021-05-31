Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9043959FD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhEaMCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:02:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:51793 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhEaMB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:01:59 -0400
IronPort-SDR: L5HwMnADhLPS0or+/BEJ85gFe8+bg1RAFU46GVDUfQ4ERwayAa5nkXw67YS6QsvF0s28AH8auK
 Y/MXD4XquJqg==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="267226421"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="267226421"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 05:00:18 -0700
IronPort-SDR: sd6FdtwMraf70eTCVTU1yYqcag/9eY/X+xxAd5R8c4vJbWY25pYynp4SlC2Mb53cImsdcPAihy
 GkEfNIDDp30Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="482069253"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 31 May 2021 05:00:15 -0700
Date:   Mon, 31 May 2021 20:00:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and
 active CPUs
Message-ID: <20210531120015.GA89301@shbuild999.sh.intel.com>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
 <20210528085545.GJ30378@techsingularity.net>
 <893ce8ed-df14-612b-693f-48c9dac0eb19@intel.com>
 <20210528151834.GR30378@techsingularity.net>
 <c847e968-670a-ff6b-2f14-7fa4066955dd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c847e968-670a-ff6b-2f14-7fa4066955dd@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 09:17:41AM -0700, Dave Hansen wrote:
> On 5/28/21 8:18 AM, Mel Gorman wrote:
> >> BTW, to do some of this testing, Feng was doing a plain old kernel
> >> build.  On the one system where this got run, he noted a ~2% regression
> >> in build times.  Nothing major, but you might want to be on the lookout
> >> in case 0day or the other test harnesses find something similar once
> >> this series gets to them.
> >>
> > What type of system was it?
> > 
> > I noticed minor differences for some thread counts on kernel compilations
> > but for CascadeLake at least, it was mostly neutral. Below is an old test
> > result based on a previous revision.
> 
> It's a Cascade Lake as well.  But, I never trust hardware at a hardware
> company.  These could be preproduction CPUs or BIOS or both, or have
> some bonkers configuration knob flipped.
> 
> It's also got a bunch of PMEM plugged and onlined, including the
> _possibility_ of kernel data structures ended up on PMEM.  They *mostly*
> don't end up there, but it does happen on occasion.
> 
> Anyway, I'll see if we can do some more runs with your latest version.
> It looks like it's been picked up for -mm so 0day should be pounding on
> it soon enough.

Yes, usually 0day has more benchmark test covering -mm tree.

As for the kbuild test run for v2, after more runs, the previous 2%
longer kbuild time turns to 1% shorter time, seems to be in normal
deviation range.

Also I checked Mel's v3 branch which has the fix for cpuless node,
the pcp 'high' looks normal on PMEM node:

  pagesets
    cpu: 0
              count: 67
              high:  724
              batch: 63
  vm stats threshold: 125

Thanks,
Feng



