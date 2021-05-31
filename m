Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4A3956F8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhEaIbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:31:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:11115 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhEaIbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:31:06 -0400
IronPort-SDR: tj+Fm39yMCfh1XnQOAKdRbS0xr5KP7QBAKf8Ag7sINyTH8zeOD/fqynnCM+A3M/FsBvB4R9J18
 xUjbEFe+f1IQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="203354743"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="203354743"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 01:29:26 -0700
IronPort-SDR: J3u/Qqen6sxUPjq8sd43cC547nnxbLlmxikRCPESXSwM1P9yqZP/hWDk59rn+k8uRwZ+AMnF8N
 btzp3cVx9oBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="446528877"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 31 May 2021 01:29:21 -0700
Date:   Mon, 31 May 2021 16:29:22 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v1 4/4] mm/mempolicy: kill MPOL_F_LOCAL bit
Message-ID: <20210531082922.GD56979@shbuild999.sh.intel.com>
References: <1622005302-23027-5-git-send-email-feng.tang@intel.com>
 <YK9WOKBRsaFESPfR@dhcp22.suse.cz>
 <20210527121041.GA7743@shbuild999.sh.intel.com>
 <YK+P8GDH2kn4FDsA@dhcp22.suse.cz>
 <20210527133436.GD7743@shbuild999.sh.intel.com>
 <YK+8IAphFzbCweHI@dhcp22.suse.cz>
 <20210528043954.GA32292@shbuild999.sh.intel.com>
 <YLSJiV0tLPvCTnjG@dhcp22.suse.cz>
 <20210531073252.GC56979@shbuild999.sh.intel.com>
 <YLSc2zzr1g+CTiAY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLSc2zzr1g+CTiAY@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 10:22:51AM +0200, Michal Hocko wrote:
> On Mon 31-05-21 15:32:52, Feng Tang wrote:
> > On Mon, May 31, 2021 at 09:00:25AM +0200, Michal Hocko wrote:
> [...]
> > > I can see you have posted a newer version which I haven't seen yet but
> > > this is really better to get resolved before building up more on top.
> > > And let me be explicit. I do believe that rebinding preferred policy is
> > > just bogus and it should be dropped altogether on the ground that a 
> > > preference is a mere hint from userspace where to start the allocation. 
> > 
> > Yes, the current mpol_rebind_preferred()'s logic is confusing. Let me
> > try to understand it correctly, are you suggesting to do nothing for
> > 'prefer's rebinding regarding MPOL_F_STATIC_NODES and MPOL_F_RELATIVE_NODES,
> > while just setting 'pol->w.cpuset_mems_allowed' to the new nodemask?
> 
> yes this is exactly what I've had in mind.
 
Thanks for confirming. Will spin another version.

- Feng

> -- 
> Michal Hocko
> SUSE Labs
