Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06848413579
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhIUOiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:38:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:29759 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233059AbhIUOiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:38:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210458105"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="210458105"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 07:36:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="549516740"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 07:36:24 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>,
        <mhocko@suse.com>, <weixugc@google.com>, <osalvador@suse.de>,
        <rientjes@google.com>, <dan.j.williams@intel.com>,
        <david@redhat.com>, <gthelen@google.com>,
        <yang.shi@linux.alibaba.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/migrate: optimize hotplug-time demotion order
 updates
References: <20210917223504.C140445A@davehans-spike.ostc.intel.com>
        <20210917223505.F817CB6B@davehans-spike.ostc.intel.com>
        <87k0jeog7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2d7e4078-f9c0-7511-0bab-de5dab25b45d@intel.com>
Date:   Tue, 21 Sep 2021 22:36:22 +0800
In-Reply-To: <2d7e4078-f9c0-7511-0bab-de5dab25b45d@intel.com> (Dave Hansen's
        message of "Mon, 20 Sep 2021 14:37:28 -0700")
Message-ID: <87a6k66lnd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 9/17/21 5:55 PM, Huang, Ying wrote:
>>> @@ -3147,6 +3177,16 @@ static void __set_migration_target_nodes
>>>  	int node;
>>>  
>>>  	/*
>>> +	 * The "migration path" array is heavily optimized
>>> +	 * for reads.  This is the write side which incurs a
>>> +	 * very heavy synchronize_rcu().  Avoid this overhead
>>> +	 * when nothing of consequence has changed since the
>>> +	 * last write.
>>> +	 */
>>> +	if (!node_demotion_topo_changed())
>>> +		return;
>>> +
>>> +	/*
>>>  	 * Avoid any oddities like cycles that could occur
>>>  	 * from changes in the topology.  This will leave
>>>  	 * a momentary gap when migration is disabled.
>> Now synchronize_rcu() is called in disable_all_migrate_targets(), which
>> is called for MEM_GOING_OFFLINE.  Can we remove the synchronize_rcu()
>> from disable_all_migrate_targets() and call it in
>> __set_migration_target_nodes() before we update the node_demotion[]?
>
> I see what you are saying.  This patch just targeted
> __set_migration_target_nodes() which is called in for
> MEM_ONLINE/OFFLINE.  But, it missed MEM_GOING_OFFLINE's call to
> disable_all_migrate_targets().
>
> I think I found something better than what I had in this patch, or the
> tweak you suggested: The 'memory_notify->status_change_nid' field is
> passed to all memory hotplug notifiers and tells us whether the node is
> going online/offline.  Instead of trying to track the changes, I think
> we can simply rely on it to tell us when a node is going online/offline.
>
> This removes the need for the demotion code to track *any* state.  I've
> attached a totally untested patch to do this.

Yes.  This sounds good.  I will try to test this patch on my side.

From another point of view, we still need to update demotion order upon
CPU hotplug too, because whether a node has CPU may be changed there.
And we need a solution for that too.

Best Regards,
Huang, Ying
