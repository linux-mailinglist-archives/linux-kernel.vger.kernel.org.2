Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83CC3D86E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 06:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhG1E4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 00:56:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:31326 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhG1E4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 00:56:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="192858190"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="192858190"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 21:56:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="506256005"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 21:56:06 -0700
Date:   Wed, 28 Jul 2021 13:14:21 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm/page_alloc]  44042b4498:
 WARNING:possible_recursive_locking_detected
Message-ID: <20210728051420.GA8616@xsang-OptiPlex-9020>
References: <20210727143136.GA27400@xsang-OptiPlex-9020>
 <20210727143538.GB3809@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727143538.GB3809@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Mel Gorman,

On Tue, Jul 27, 2021 at 03:35:38PM +0100, Mel Gorman wrote:
> On Tue, Jul 27, 2021 at 10:31:36PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 44042b4498728f4376e84bae1ac8016d146d850b ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> 
> Does this warning happen after 187ad460b841 ("mm/page_alloc: avoid page
> allocator recursion with pagesets.lock held")? I ask because I see the
> stack_depot_save in the warning.

from our tests, this warning cannot be reproduced upon 187ad460b841.
Thanks for information!

> 
> -- 
> Mel Gorman
> SUSE Labs
