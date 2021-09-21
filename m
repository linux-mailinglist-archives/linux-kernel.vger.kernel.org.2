Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4238412EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhIUGnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:43:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:40808 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhIUGnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:43:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="223327904"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="223327904"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 23:41:35 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="511729870"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 23:41:31 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] mm/migrate: fix CPUHP state to update node demotion order
References: <20210918025849.88901-1-ying.huang@intel.com>
        <87lf3r7mqr.ffs@tglx>
Date:   Tue, 21 Sep 2021 14:41:29 +0800
In-Reply-To: <87lf3r7mqr.ffs@tglx> (Thomas Gleixner's message of "Mon, 20 Sep
        2021 09:02:52 +0200")
Message-ID: <877dfactwm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Sat, Sep 18 2021 at 10:58, Huang Ying wrote:
>> @@ -72,6 +72,7 @@ enum cpuhp_state {
>>  	CPUHP_SLUB_DEAD,
>>  	CPUHP_DEBUG_OBJ_DEAD,
>>  	CPUHP_MM_WRITEBACK_DEAD,
>> +	CPUHP_MM_DEMOTION_OFFLINE,
>
> Please keep the _DEAD convention in that section. The plugged CPU is
> already gone.

Sure.  Will do that.

>>  	CPUHP_MM_VMSTAT_DEAD,
>>  	CPUHP_SOFTIRQ_DEAD,
>>  	CPUHP_NET_MVNETA_DEAD,
>> @@ -240,6 +241,7 @@ enum cpuhp_state {
>>  	CPUHP_AP_BASE_CACHEINFO_ONLINE,
>>  	CPUHP_AP_ONLINE_DYN,
>>  	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
>> +	CPUHP_AP_MM_DEMOTION_ONLINE,
>
> Are there any ordering requirements of these states vs. other CPU
> hotplug states?
>
> If not, then please use the dynamically allocated states.
>
> If so, then please add a comment:
>
> +	/* Must be before CPUHP_XXX and after CPUHP_YYY */
> +	CPUHP_MM_DEMOTION_OFFLINE,

The callbacks need to be called after node_states[N_CPU] has been
updated during CPU online/offline.  While node_states[N_CPU] is updated
in CPUHP_AP_ONLINE_DYN and CPUHP_MM_VMSTAT_DEAD.  So the new state must
be before CPUHP_MM_VMSTAT_DEAD for offline and after CPUHP_AP_ONLINE_DYN
for online.  I will update the patch and add the comments.

Best Regards,
Huang, Ying
