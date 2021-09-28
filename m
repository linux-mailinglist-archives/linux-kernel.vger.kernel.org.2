Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1136F41A48F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 03:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhI1BXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 21:23:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:46983 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238420AbhI1BXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 21:23:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="310145645"
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="310145645"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 18:22:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="553706932"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 18:21:58 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH -V2] mm/migrate: fix CPUHP state to update node demotion
 order
References: <20210927081100.475075-1-ying.huang@intel.com>
        <20210927174722.6ca9bc6a63bb50da7754bdaf@linux-foundation.org>
Date:   Tue, 28 Sep 2021 09:21:56 +0800
In-Reply-To: <20210927174722.6ca9bc6a63bb50da7754bdaf@linux-foundation.org>
        (Andrew Morton's message of "Mon, 27 Sep 2021 17:47:22 -0700")
Message-ID: <871r59v6iz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 27 Sep 2021 16:11:00 +0800 Huang Ying <ying.huang@intel.com> wrote:
>
>> The node demotion order needs to be updated during CPU hotplug.
>> Because whether a NUMA node has CPU may influence the demotion order.
>> The update function should be called during CPU online/offline after
>> the node_states[N_CPU] has been updated.  That is done in
>> CPUHP_AP_ONLINE_DYN during CPU online and in CPUHP_MM_VMSTAT_DEAD
>> during CPU offline.  But in commit 884a6e5d1f93 ("mm/migrate: update
>> node demotion order on hotplug events"), the function to update node
>> demotion order is called in CPUHP_AP_ONLINE_DYN during CPU
>> online/offline.  This doesn't satisfy the order requirement.
>
> What are the user-visible runtime effects of this error?

For example, there are 4 CPUs (P0, P1, P2, P3) in 2 sockets (P0, P1 in
S0 and P2, P3 in S1), the demotion order is

- S0 -> NUMA_NO_NODE
- S1 -> NUMA_NO_NODE

After P2 and P3 is offlined, because S1 has no CPU now, the demotion
order should have been changed to

- S0 -> S1
- S1 -> NO_NODE

but it isn't changed, because the order updating callback for CPU
hotplug doesn't see the new nodemask.  Now, if P1 is offlined, the
demotion order is changed to the expected order as above.

I will update the patch description after adding the above description.

Best Regards,
Huang, Ying

>>  So in
>> this patch, we added CPUHP_AP_MM_DEMOTION_ONLINE and
>> CPUHP_MM_DEMOTION_DEAD to be called after CPUHP_AP_ONLINE_DYN and
>> CPUHP_MM_VMSTAT_DEAD during CPU online and offline, and register the
>> update function on them.
>> 
>> Fixes: 884a6e5d1f93 ("mm/migrate: update node demotion order on hotplug events")
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Greg Thelen <gthelen@google.com>
>> Cc: Keith Busch <kbusch@kernel.org>
>> 
