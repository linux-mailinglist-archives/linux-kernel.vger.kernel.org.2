Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555913CAEB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhGOVpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:45:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:6042 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhGOVpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:45:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="232463243"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="232463243"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 14:42:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="495648686"
Received: from snchan-mobl2.amr.corp.intel.com (HELO [10.209.125.33]) ([10.209.125.33])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 14:42:10 -0700
Subject: Re: [PATCH -V10 0/9] Migrate Pages in lieu of discard
To:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de,
        weixugc@google.com, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20210715055145.195411-1-ying.huang@intel.com>
 <20210715123836.ad76b0a2e29c0bbd3cd67767@linux-foundation.org>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <e571c5d8-4be3-c983-dcc2-aff5217aa055@intel.com>
Date:   Thu, 15 Jul 2021 14:42:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210715123836.ad76b0a2e29c0bbd3cd67767@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/21 12:38 PM, Andrew Morton wrote:
> On Thu, 15 Jul 2021 13:51:36 +0800 Huang Ying <ying.huang@intel.com> wrote:
>> We have tested the patchset with the postgresql and pgbench.  On a
>> 2-socket server machine with DRAM and PMEM, the kernel with the
>> patchset can improve the score of pgbench up to 22.1% compared with
>> that of the DRAM only + disk case.  This comes from the reduced disk
>> read throughput (which reduces up to 70.8%).
> 
> The [0/n] description talks a lot about PMEM, but the patches
> themselves are all about NUMA nodes.  I assume that what ties this
> together is that the PMEM tends to be organized as a NUMA node on its
> own, and that by enabling migrate-to-remote-node-during-reclaim, we get
> this PMEM behaviour as a desired side-effect?

Yes, an assumption of this whole thing is that there are uniform
performance capabilities within a NUMA node.  ACPI systems that
implement the HMAT table require that each proximity domain (PXM) have
these uniform capabilities.  This works out great since PXMs are so
closely translated to NUMA nodes.

> IOW, perhaps this [0/n] description could explain the linkage between
> PMEM and NUMA nodes more explicitly.

Sure, we can do that.

> Secondly...  at some point it just won't make sense to migrate pages to
> a remote node because that remote node isn't remote enough.  I mean, if
> accessing the remote node is 2% slower than the local node, it's best
> to just reclaim the page rather than going to the effort of migrating
> it around?

One thing to keep in mind is that these migrations are *cheap*.  Because
of the point where the migration is done near the end of the reclaim
process the page should be unmapped.  The expensive part like TLB
shootdowns don't need to happen.

But, yes, you're right.  There are going to be situations where it would
have been better to reclaim the page.

> And I assume the patchset doesn't (yet) attempt to make this judgement?

Correct.  The assumption is that, on average, having something in slower
memory is better than having it out of memory.

> Thirdly, the final patch which makes the feature off-by-default is a
> concern.  I expect this will cause the new feature to have much less
> testing (functional and performance).  We could make it default-on for
> now, then flip that to default-off after 5.14-rc5 (for example).  That
> will help, but is a bit lame.  Is it not possible for the kernel to
> look at the overall system layout and make an educated guess as to
> whether this system will benefit?

Unfortunately, no.  It's highly workload dependent.  I see it a lot like
autonuma or khugepaged/THP: there are going to be some big upsides, but
we're under no illusions that the wins will be universal.

I'd actually be quite happy to flip it to be default-on all the time.
But, I think I'll be a lot more confident about it once we have the
"promotion" side of the equation merged as well:

	https://lwn.net/Articles/835402/

> And I see this, from the [9/9] changelog:
> 
> : The benefits are truly workload-based and *not* hardware-based.  We do
> : not believe that there is a viable threshold where certain hardware
> : configurations should have this mechanism enabled while others do not.
> 
> so...  why not simply enable the thing for all systems and be done with
> it?  What sort of downsides are you anticipating?  We could of course
> include an emergency-off knob, but hoping that it won't need to be
> used.

The worst case scenario is that an important workload starts up, eats a
bunch of RAM and then goes idle, maybe during off-peak workload hours.
During the night, a bunch of batch jobs kick in and evict some of that
workload's data to PMEM.  The workload spools up again the next morning
and is hampered by the slower PMEM when there's lots of DRAM available.

This will be helped by the autonuma-based promotion once it's in place.

> Finally, having a feature which is good for some workloads, bad for
> others and which contains a system-wide enable knob is really quite
> sad.  It requires a lot of work from each and every operator in the
> world!  They must experimentally run their workloads both with and
> without, and determine which is best.  And they should rerun this
> testing periodically as userspace and the kernel evolve, to determine
> whether their earlier experimenting holds true.  And what happens if
> workload #1 wins and workload #2 loses?
> 
> And of course, many operators simply won't do all of this and they'll
> run slower, or will miss out of benefits.  What can we do to relieve
> our users of all of this?

I think this is a much bigger question than this patch set.  It's
basically the tale of /proc/sys/vm/* or /sys/kernel/mm.  Some workloads
win with transparent_hugepage/enabled=always, some lose.  Some win with
zone_reclaim_mode=7, some prefer zone_reclaim_mode=0.

The end game for auto-migration is to on by default, wherever these
hardware configurations show up.  Just like THP, I expect this to be
broadly useful.  But, given the breadth of our user base, I also expect
it to be nasty for a minority of users.  They'll need a way to turn it
off, and hopefully they'll also provide feedback so that, if possible,
we can improve the default behavior and bring them back into the fold.
