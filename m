Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1268630B026
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhBATN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:13:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:55575 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhBATN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:13:57 -0500
IronPort-SDR: 1gFlcogLgve0XtU50NMXiijk3Dymkg7z8zkwBabQR2VSIa7dKvgIPecQOMAPjpVJ5xowqrdJZF
 KLFjg0QCpR7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242255840"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242255840"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 11:13:15 -0800
IronPort-SDR: A5y68mMuyVxRL2prrrHw/rpJF3wj+J36WCTrZgqUkI/zlUj2f9uRYtuRsftxd/XeKQTkIyevap
 cQOZabHnuXyg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="370070836"
Received: from ccmincem-mobl1.amr.corp.intel.com (HELO [10.212.145.244]) ([10.212.145.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 11:13:14 -0800
Subject: Re: [RFC][PATCH 05/13] mm/numa: automatically generate node migration
 order
To:     Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
References: <20210126003411.2AC51464@viggo.jf.intel.com>
 <20210126003421.45897BF4@viggo.jf.intel.com>
 <CAHbLzkoB98YY0amBWTGcDPStcy1c35CC8D5MPMbVxzRKqVA0Cg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <317d4c23-76a7-b653-87a4-bab642fa1717@intel.com>
Date:   Mon, 1 Feb 2021 11:13:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkoB98YY0amBWTGcDPStcy1c35CC8D5MPMbVxzRKqVA0Cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/21 12:46 PM, Yang Shi wrote:
...
>>  int next_demotion_node(int node)
>>  {
>> -       return node_demotion[node];
>> +       /*
>> +        * node_demotion[] is updated without excluding
>> +        * this function from running.  READ_ONCE() avoids
>> +        * reading multiple, inconsistent 'node' values
>> +        * during an update.
>> +        */
> 
> Don't we need a smp_rmb() here? The single write barrier might be not
> enough in migration target set. Typically a write barrier should be
> used in pairs with a read barrier.

I don't think we need one, practically.

Since there is no locking against node_demotion[] updates, although a
smp_rmb() would ensure that this read is up-to-date, it could change
freely after the smp_rmb().

In other words, smp_rmb() would shrink the window where a "stale" read
could occur but would not eliminate it.

>> +       return READ_ONCE(node_demotion[node]);
> 
> Why not consolidate the patch #4 in this patch? The patch #4 just add
> the definition of node_demotion and the function, then the function is
> changed in this patch, and the function is not used by anyone between
> the adding and changing.

I really wanted to highlight that the locking scheme and the READ_ONCE()
(or lack thereof) was specifically due to how node_demotion[] was being
updated.

The READ_ONCE() is not, for instance, inherent to the data structure.

...
>> +/*
>> + * When memory fills up on a node, memory contents can be
>> + * automatically migrated to another node instead of
>> + * discarded at reclaim.
>> + *
>> + * Establish a "migration path" which will start at nodes
>> + * with CPUs and will follow the priorities used to build the
>> + * page allocator zonelists.
>> + *
>> + * The difference here is that cycles must be avoided.  If
>> + * node0 migrates to node1, then neither node1, nor anything
>> + * node1 migrates to can migrate to node0.
>> + *
>> + * This function can run simultaneously with readers of
>> + * node_demotion[].  However, it can not run simultaneously
>> + * with itself.  Exclusion is provided by memory hotplug events
>> + * being single-threaded.
> 
> Maybe an example diagram for the physical topology and how the
> migration target is generated in the comment seems helpful to
> understand the code.

Sure.  Were you thinking of a code comment, or enhanced changelog?

Let's say there's a system with two sockets each with the same three
classes of memory: fast, medium and slow.  Each memory class is placed
in its own NUMA node and the CPUs are attached to the fast memory.  That
leaves 6 NUMA nodes (0-5):

	Socket A: 0, 1, 2
	Socket B: 3, 4, 5

The migration path for this configuration path would start on the nodes
with the processors and fast memory, progress through medium and end
with the slow memory:

	0 -> 1 -> 2 -> stop
	3 -> 4 -> 5 -> stop

This is represented in the node_demotion[] like this:

	{  1, // Node 0 migrates to 1
	   2, // Node 1 migrates to 2
	  -1, // Node 2 does not migrate
	   4, // Node 3 migrates to 1
	   5, // Node 4 migrates to 2
	  -1} // Node 5 does not migrate

Is that what you were thinking of?

...
>> +again:
>> +       this_pass = next_pass;
>> +       next_pass = NODE_MASK_NONE;
>> +       /*
>> +        * To avoid cycles in the migration "graph", ensure
>> +        * that migration sources are not future targets by
>> +        * setting them in 'used_targets'.  Do this only
>> +        * once per pass so that multiple source nodes can
>> +        * share a target node.
>> +        *
>> +        * 'used_targets' will become unavailable in future
>> +        * passes.  This limits some opportunities for
>> +        * multiple source nodes to share a desintation.
> 
> s/desination/destination

Fixed, thanks.

>> +        */
>> +       nodes_or(used_targets, used_targets, this_pass);
>> +       for_each_node_mask(node, this_pass) {
>> +               int target_node = establish_migrate_target(node, &used_targets);
>> +
>> +               if (target_node == NUMA_NO_NODE)
>> +                       continue;
>> +
>> +               /* Visit targets from this pass in the next pass: */
>> +               node_set(target_node, next_pass);
>> +       }
>> +       /* Is another pass necessary? */
>> +       if (!nodes_empty(next_pass))
>> +               goto again;
>> +}
>> +
>> +void set_migration_target_nodes(void)
> 
> It seems this function is not called outside migrate.c, so it should be static.

Fixed, thanks.
