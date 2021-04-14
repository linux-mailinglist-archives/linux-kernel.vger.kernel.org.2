Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECE835EF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhDNILW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:11:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:53416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349944AbhDNIJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:09:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CAD4AEC2;
        Wed, 14 Apr 2021 08:08:57 +0000 (UTC)
Date:   Wed, 14 Apr 2021 10:08:54 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Wei Xu <weixugc@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 02/10] mm/numa: automatically generate node migration
 order
Message-ID: <20210414080849.GA20886@linux>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183219.DC1928FA@viggo.jf.intel.com>
 <CAAPL-u8Jk-i-9-iSnU7_nb-k2ZMqdRk5c88d-M6Bi1rfv4kSLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAPL-u8Jk-i-9-iSnU7_nb-k2ZMqdRk5c88d-M6Bi1rfv4kSLQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 08:07:08PM -0700, Wei Xu wrote:
> On Thu, Apr 1, 2021 at 11:35 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> > + * When Node 0 fills up, its memory should be migrated to
> > + * Node 1.  When Node 1 fills up, it should be migrated to
> > + * Node 2.  The migration path start on the nodes with the
> > + * processors (since allocations default to this node) and
> > + * fast memory, progress through medium and end with the
> > + * slow memory:
> > + *
> > + *     0 -> 1 -> 2 -> stop
> > + *     3 -> 4 -> 5 -> stop
> > + *
> > + * This is represented in the node_demotion[] like this:
> > + *
> > + *     {  1, // Node 0 migrates to 1
> > + *        2, // Node 1 migrates to 2
> > + *       -1, // Node 2 does not migrate
> > + *        4, // Node 3 migrates to 4
> > + *        5, // Node 4 migrates to 5
> > + *       -1} // Node 5 does not migrate
> > + */
> 
> In this example, if we want to support multiple nodes as the demotion
> target of a source node, we can group these nodes into three tiers
> (classes):
> 
> fast class:
> 0 -> {1, 4}  // 1 is the preferred
> 3 -> {4, 1}  // 4 is the preferred
> 
> medium class:
> 1 -> {2, 5}  // 2 is the preferred
> 4 -> {5, 2}  // 5 is the preferred
> 
> slow class:
> 2 -> stop
> 5 -> stop

Hi Wei Xu,

I have some questions about it

Fast class/memory are pictured as those nodes with CPUs, while Slow class/memory
are PMEM, right?
Then, what stands for medium class/memory?

In Dave's example, list is created in a way that stays local to the socket,
and we go from the fast one to the slow one.
In yours, lists are created taking the fastest nodes from all sockets and
we work our way down, which means have cross-socket nodes in the list.
How much of a penalty is that?

And while I get your point, I am not sure if that is what we pretend here.
This patchset aims to place cold pages that are about to be reclaim in slower
nodes to give them a second chance, while your design seems more to have kind
of different memory clases and be able to place applications in one of those tiers
depending on its demands or sysadmin-demand.

Could you expand some more?

-- 
Oscar Salvador
SUSE L3
