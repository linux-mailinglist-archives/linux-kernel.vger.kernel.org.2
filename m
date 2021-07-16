Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1C3CB125
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 05:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhGPDfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 23:35:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:33669 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233612AbhGPDfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 23:35:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="210479838"
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="210479838"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 20:32:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="495779552"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 20:32:10 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de,
        weixugc@google.com, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH -V10 0/9] Migrate Pages in lieu of discard
References: <20210715055145.195411-1-ying.huang@intel.com>
        <20210715123836.ad76b0a2e29c0bbd3cd67767@linux-foundation.org>
Date:   Fri, 16 Jul 2021 11:32:09 +0800
In-Reply-To: <20210715123836.ad76b0a2e29c0bbd3cd67767@linux-foundation.org>
        (Andrew Morton's message of "Thu, 15 Jul 2021 12:38:36 -0700")
Message-ID: <87k0lrndc6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 15 Jul 2021 13:51:36 +0800 Huang Ying <ying.huang@intel.com> wrote:
>
> The [0/n] description talks a lot about PMEM, but the patches
> themselves are all about NUMA nodes.  I assume that what ties this
> together is that the PMEM tends to be organized as a NUMA node on its
> own, and that by enabling migrate-to-remote-node-during-reclaim, we get
> this PMEM behaviour as a desired side-effect?
>
> IOW, perhaps this [0/n] description could explain the linkage between
> PMEM and NUMA nodes more explicitly.

Hi, Andrew,

I have added some words in the [0/9] description to link PMEM and NUMA
nodes.  The updated description is as below.  Can you take a look at it?

Best Regards,
Huang, Ying

--------------------------8<-----------------------------------

We're starting to see systems with more and more kinds of memory such
as Intel's implementation of persistent memory.

Let's say you have a system with some DRAM and some persistent memory.
Today, once DRAM fills up, reclaim will start and some of the DRAM
contents will be thrown out.  Allocations will, at some point, start
falling over to the slower persistent memory.

That has two nasty properties.  First, the newer allocations can end
up in the slower persistent memory.  Second, reclaimed data in DRAM
are just discarded even if there are gobs of space in persistent
memory that could be used.

This patchset implements a solution to these problems.  At the end of
the reclaim process in shrink_page_list() just before the last page
refcount is dropped, the page is migrated to persistent memory instead
of being dropped.

While I've talked about a DRAM/PMEM pairing, this approach would
function in any environment where memory tiers exist.

This is not perfect.  It "strands" pages in slower memory and never
brings them back to fast DRAM.  Huang Ying has follow-on work which
repurposes autonuma to promote hot pages back to DRAM.

This is also all based on an upstream mechanism that allows
persistent memory to be onlined and used as if it were volatile:

	http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com

With that, the DRAM and PMEM in each socket will be represented as 2
separate NUMA nodes, with the CPUs sit in the DRAM node.  So the
general inter-NUMA demotion mechanism introduced in the patchset can
migrate the cold DRAM pages to the PMEM node.

We have tested the patchset with the postgresql and pgbench.  On a
2-socket server machine with DRAM and PMEM, the kernel with the
patchset can improve the score of pgbench up to 22.1% compared with
that of the DRAM only + disk case.  This comes from the reduced disk
read throughput (which reduces up to 70.8%).

== Open Issues ==

 * Memory policies and cpusets that, for instance, restrict allocations
   to DRAM can be demoted to PMEM whenever they opt in to this
   new mechanism.  A cgroup-level API to opt-in or opt-out of
   these migrations will likely be required as a follow-on.
 * Could be more aggressive about where anon LRU scanning occurs
   since it no longer necessarily involves I/O.  get_scan_count()
   for instance says: "If we have no swap space, do not bother
   scanning anon pages"
