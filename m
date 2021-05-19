Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897C5388AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbhESJpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:45:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:19435 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239386AbhESJpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:45:13 -0400
IronPort-SDR: lBtbmSZqlSYsqkPL7ZfiakfsK/pbV+PJUN24unC+dOMTX/psYbf46FnazeAxLfhTCDku/P4MMI
 1RDrPrmxOaeg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="286466212"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="286466212"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 02:43:53 -0700
IronPort-SDR: ON3io25K4TSdRLdfXgZrCBD/Uy301n85yYSyiIxaNM8HryivBq7xALR0vp7DQ5Igxr7TfdPzbL
 ijE2ECeiwj1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="461174404"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2021 02:43:50 -0700
Subject: Re: [PATCH v2 6/8] sched/idle: Move busy_cpu accounting to idle
 callback
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
References: <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
 <47d29f1d-cea6-492a-5125-85db6bce0fa7@linux.intel.com>
 <20210513073112.GV2633526@linux.vnet.ibm.com>
 <5823f298-6fae-5a73-3ab8-f708d90a7e52@linux.intel.com>
 <20210517104058.GW2633526@linux.vnet.ibm.com>
 <9d493353-7a27-16aa-3e99-c6a07e69de25@linux.intel.com>
 <20210517125727.GX2633526@linux.vnet.ibm.com>
 <27ab234c-b36b-bf7f-52f4-92c1804f8245@linux.intel.com>
 <20210518040024.GY2633526@linux.vnet.ibm.com>
 <ce4eba7e-dc2e-1c67-d04d-579f04c2040b@linux.intel.com>
 <20210518071843.GZ2633526@linux.vnet.ibm.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <32b98350-35e4-7475-2d19-9101f50ecc63@linux.intel.com>
Date:   Wed, 19 May 2021 17:43:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518071843.GZ2633526@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 3:18 PM, Srikar Dronamraju wrote:

>>>> This is v3. It looks like hackbench gets better. And netperf still has
>>>> some notable changes under 2 x overcommit cases.
>>>>
>>>
>>> Thanks Aubrey for the results. netperf (2X) case does seem to regress.
>>> I was actually expecting the results to get better with overcommit.
>>> Can you confirm if this was just v3 or with v3 + set_next_idle_core
>>> disabled?
>>
>> Do you mean set_idle_cores(not set_next_idle_core) actually? Gautham's patch
>> changed "this" to "target" in set_idle_cores, and I removed it to apply
>> v3-2-8-sched-fair-Maintain-the-identity-of-idle-core.patch for tip/sched/core
>> commit-id 915a2bc3c6b7.
> 
> Thats correct,
> 
> In the 3rd patch, I had introduced set_next_idle_core
> which is suppose to set idle_cores in the LLC.
> What I suspected was is this one is causing issues in your 48 CPU LLC.
> 
> I am expecting set_next_idle_core to be spending much time in your scenario.
> I was planning for something like the below on top of my patch.
> With this we dont look for an idle-core if we already know that we dont find one.
> But in the mean while I had asked if you could have dropped the call to
> set_next_idle_core.
> 

+	if (atomic_read(&sd->shared->nr_busy_cpus) * 2 >=  per_cpu(sd_llc_size, target))
+		goto out;

Does this has side effect if waker and wakee are coalesced on a portion of cores?
Also, is 2 a SMT2 assumption?

I did a quick testing on this, it looks like the regression of netperf 2x cases are 
improved indeed, but hackbench two mid-load cases get worse.

process-sockets 	group-2 	 1.00 (  5.32)	-18.40 (  7.32)
threads-sockets 	group-2 	 1.00 (  5.44)	-20.44 (  4.60)

Thanks,
-Aubrey
