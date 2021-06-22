Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D159B3AFA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 03:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFVBQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 21:16:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:45447 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhFVBQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 21:16:49 -0400
IronPort-SDR: qJrArOUnr0pwX+X4l0O40LNlb5BXRJ4YPG5AHwU65dVT+y/ECPI3bAWEL1Ln9+IoOf1g9XpgA2
 0oQdTwWbU7IQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="228514968"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="228514968"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 18:14:34 -0700
IronPort-SDR: S4SXaIKNke6jbeLRI8Zz8HPKRwgjG7yyFA3hcpwT0N3cYT6i/aP4uSL22ZcCDzJEUFRfjglT42
 19EetnP6bLkA==
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="454080998"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 18:14:31 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: Re: [PATCH -V8 02/10] mm/numa: automatically generate node
 migration order
References: <20210618061537.434999-1-ying.huang@intel.com>
        <20210618061537.434999-3-ying.huang@intel.com>
        <79397FE3-4B08-4DE5-8468-C5CAE36A3E39@nvidia.com>
        <87v96anu6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2AA3D792-7F14-4297-8EDD-3B5A7B31AECA@nvidia.com>
Date:   Tue, 22 Jun 2021 09:14:29 +0800
In-Reply-To: <2AA3D792-7F14-4297-8EDD-3B5A7B31AECA@nvidia.com> (Zi Yan's
        message of "Mon, 21 Jun 2021 10:50:14 -0400")
Message-ID: <87sg1an1je.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 19 Jun 2021, at 4:18, Huang, Ying wrote:
>
>> Zi Yan <ziy@nvidia.com> writes:
>>
>>> On 18 Jun 2021, at 2:15, Huang Ying wrote:

[snip]

>>>> +/*
>>>> + * When memory fills up on a node, memory contents can be
>>>> + * automatically migrated to another node instead of
>>>> + * discarded at reclaim.
>>>> + *
>>>> + * Establish a "migration path" which will start at nodes
>>>> + * with CPUs and will follow the priorities used to build the
>>>> + * page allocator zonelists.
>>>> + *
>>>> + * The difference here is that cycles must be avoided.  If
>>>> + * node0 migrates to node1, then neither node1, nor anything
>>>> + * node1 migrates to can migrate to node0.
>>>> + *
>>>> + * This function can run simultaneously with readers of
>>>> + * node_demotion[].  However, it can not run simultaneously
>>>> + * with itself.  Exclusion is provided by memory hotplug events
>>>> + * being single-threaded.
>>>> + */
>>>> +static void __set_migration_target_nodes(void)
>>>> +{
>>>> +	nodemask_t next_pass	= NODE_MASK_NONE;
>>>> +	nodemask_t this_pass	= NODE_MASK_NONE;
>>>> +	nodemask_t used_targets = NODE_MASK_NONE;
>>>> +	int node;
>>>> +
>>>> +	/*
>>>> +	 * Avoid any oddities like cycles that could occur
>>>> +	 * from changes in the topology.  This will leave
>>>> +	 * a momentary gap when migration is disabled.
>>>> +	 */
>>>> +	disable_all_migrate_targets();
>>>> +
>>>> +	/*
>>>> +	 * Ensure that the "disable" is visible across the system.
>>>> +	 * Readers will see either a combination of before+disable
>>>> +	 * state or disable+after.  They will never see before and
>>>> +	 * after state together.
>>>> +	 *
>>>> +	 * The before+after state together might have cycles and
>>>> +	 * could cause readers to do things like loop until this
>>>> +	 * function finishes.  This ensures they can only see a
>>>> +	 * single "bad" read and would, for instance, only loop
>>>> +	 * once.
>>>> +	 */
>>>> +	smp_wmb();
>>>> +
>>>> +	/*
>>>> +	 * Allocations go close to CPUs, first.  Assume that
>>>> +	 * the migration path starts at the nodes with CPUs.
>>>> +	 */
>>>> +	next_pass = node_states[N_CPU];
>>>
>>> Is there a plan of allowing user to change where the migration
>>> path starts? Or maybe one step further providing an interface
>>> to allow user to specify the demotion path. Something like
>>> /sys/devices/system/node/node*/node_demotion.
>>
>> I don't think that's necessary at least for now.  Do you know any real
>> world use case for this?
>
> In our P9+volta system, GPU memory is exposed as a NUMA node.
> For the GPU workloads with data size greater than GPU memory size,
> it will be very helpful to allow pages in GPU memory to be migrated/demoted
> to CPU memory. With your current assumption, GPU memory -> CPU memory
> demotion seems not possible, right? This should also apply to any
> system with a device memory exposed as a NUMA node and workloads running
> on the device and using CPU memory as a lower tier memory than the device
> memory.

Thanks a lot for your use case!  It appears that the demotion path
specified by users is one possible way to satisfy your requirement.  And
I think it's possible to enable that on top of this patchset.  But we
still have no specific plan to work on that at least for now.

Best Regards,
Huang, Ying
