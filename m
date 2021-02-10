Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B513161C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBJJDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:03:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:54024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhBJI43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:56:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5AA7B152;
        Wed, 10 Feb 2021 08:55:40 +0000 (UTC)
Date:   Wed, 10 Feb 2021 09:55:34 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
Subject: Re: [RFC][PATCH 06/13] mm/migrate: update migration order during on
 hotplug events
Message-ID: <20210210085529.GA25285@linux>
References: <20210126003411.2AC51464@viggo.jf.intel.com>
 <20210126003423.8D2B5637@viggo.jf.intel.com>
 <20210202114157.GA12139@linux>
 <cb60195d-24cb-f800-399c-8da888ca6385@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb60195d-24cb-f800-399c-8da888ca6385@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 03:45:55PM -0800, Dave Hansen wrote:
> On 2/2/21 3:42 AM, Oscar Salvador wrote:
> >> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> >> +						 unsigned long action, void *arg)
> >> +{
> >> +	switch (action) {
> >> +	case MEM_GOING_OFFLINE:
> >> +		/*
> >> +		 * Make sure there are not transient states where
> >> +		 * an offline node is a migration target.  This
> >> +		 * will leave migration disabled until the offline
> >> +		 * completes and the MEM_OFFLINE case below runs.
> >> +		 */
> >> +		disable_all_migrate_targets();
> >> +		break;
> >> +	case MEM_OFFLINE:
> >> +	case MEM_ONLINE:
> >> +		/*
> >> +		 * Recalculate the target nodes once the node
> >> +		 * reaches its final state (online or offline).
> >> +		 */
> >> +		__set_migration_target_nodes();
> >> +		break;
> >> +	case MEM_CANCEL_OFFLINE:
> >> +		/*
> >> +		 * MEM_GOING_OFFLINE disabled all the migration
> >> +		 * targets.  Reenable them.
> >> +		 */
> >> +		__set_migration_target_nodes();
> >> +		break;
> >> +	case MEM_GOING_ONLINE:
> >> +	case MEM_CANCEL_ONLINE:
> >> +		break;
> >> +	}
> >> +
> >> +	return notifier_from_errno(0);
> >> +}
> > This looks good, and I kinda like it.
> > But in this case, all we care about is whether NUMA node does or does
> > not have memory, so we have to remove/added into the demotion list.
> > So, would make more sense to have a kinda helper in
> > node_states_{set,clear}_node that calls the respective functions
> > (disable_all_migrate_targets and __set_migration_target_nodes)?
> 
> Of, you're saying that we could do this in the hotplug code itself
> instead of from a notifier?  I agree, we *could*.  That would be more
> efficient.  But, I do like the idea of doing this from a notifier
> because it's a bit less brittle.
> 
> Do you feel strongly about this one?

Hi Dave,

No, I do not. I even had mixed feelings myself when suggesting this as well.
As you said, it would be more optimum, but it feels kinda wrong placing the
call directly in hotplug code.

So all in all, I think your approach is more neat and clean, and more than
enough for now.

I yet have to dive in the details, but I got one more question.
Can we have CONFIG_MEMORY_HOTPLUG && !CONFIG_HOTPLUG_CPU scenarios?
I wonder because I do not see a stub function in case CONFIG_HOTPLUG_CPU
is not enabled, so I guess we cannot.

I am asking this because migrate_on_reclaim_callback() is envolved
with CONFIG_MEMORY_HOTPLUG, but calls cpuhp_setup_state, and I was not
sure whether we would have some dependency here?

Thanks


-- 
Oscar Salvador
SUSE L3
