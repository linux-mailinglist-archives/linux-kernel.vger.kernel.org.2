Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D334376025
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhEGGPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:15:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:51286 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhEGGP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:15:29 -0400
IronPort-SDR: J2bhH6EhmhAlqySpxjIKXlGu+NhUh74X1gB9zAOBCTcJvn2yzgnNRCtYaw5/GW+tfoWuBexXb2
 T4RJc7+sg36g==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="196640857"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="196640857"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 23:14:29 -0700
IronPort-SDR: UBtL/btF+damZ06lGSeBGO6WKVyRXVKQtOjBI2dEJcsxulyeLT4w+LkwdVSXayCfqdgqmHwS6V
 ++p9ZtrKDSUw==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="389914662"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 23:14:26 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com,
        rientjes@google.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de, weixugc@google.com
Subject: Re: [PATCH 00/10] [v7][RESEND] Migrate Pages in lieu of discard
References: <20210401183216.443C4443@viggo.jf.intel.com>
        <YHmEm/yHpaqO6khp@dhcp22.suse.cz>
        <9cd0dcde-f257-1b94-17d0-f2e24a3ce979@intel.com>
        <YHmm11fxEnxXAxas@dhcp22.suse.cz>
Date:   Fri, 07 May 2021 14:14:24 +0800
In-Reply-To: <YHmm11fxEnxXAxas@dhcp22.suse.cz> (Michal Hocko's message of
        "Fri, 16 Apr 2021 17:02:23 +0200")
Message-ID: <87y2crnk8v.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michal,

Michal Hocko <mhocko@suse.com> writes:

[...]

>> 
>> > Btw. do you have any numbers from running this with some real work
>> > workload?
>> 
>> Yes, quite a bit.  Do you have a specific scenario in mind?  Folks seem
>> to come at this in two different ways:
>> 
>> Some want to know how much DRAM they can replace by buying some PMEM.
>> They tend to care about how much adding the (cheaper) PMEM slows them
>> down versus (expensive) DRAM.  They're making a cost-benefit call
>> 
>> Others want to repurpose some PMEM they already have.  They want to know
>> how much using PMEM in this way will speed them up.  They will basically
>> take any speedup they can get.
>> 
>> I ask because as a kernel developer with PMEM in my systems, I find the
>> "I'll take what I can get" case more personally appealing.  But, the
>> business folks are much more keen on the "DRAM replacement" use.  Do you
>> have any thoughts on what you would like to see?
>
> I was thinking about typical large in memory processing (e.g. in memory
> databases) where the hot part of the working set is only a portion and
> spilling over to a slower memory can be still benefitial because IO +
> data preprocessing on cold data is much slower.

We have tested the patchset with the postgresql and pgbench.  On a
machine with DRAM and PMEM, the kernel with the patchset can improve the
score of pgbench up to 22.1% compared with that of the DRAM only + disk
case.  This comes from the reduced disk read throughput (which reduces
up to 70.8%).

Best Regards,
Huang, Ying
