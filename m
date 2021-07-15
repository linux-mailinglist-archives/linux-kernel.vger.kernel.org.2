Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2873CAD35
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhGOTza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238289AbhGOTle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:41:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80A7C61158;
        Thu, 15 Jul 2021 19:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626377917;
        bh=pafQ2xdM6xyHMF72qROoYxgfMfnroXBBXafJkAAWtTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=imxymS/UDQcQfssY6UVkYZbIRr623vzQIa3AVAn/a7wHQAIhNNeDBmSgoemXrNQLW
         HUnK46CKhoU3diouwO4wph1P7LJpZ4o51vExhppQHGFWMxtdnK74JlPfd5XSgd3SV9
         DUbQq1HI05ReJTnURBwhvfgzNedBGXdR8IMjE5ds=
Date:   Thu, 15 Jul 2021 12:38:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de,
        weixugc@google.com, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH -V10 0/9] Migrate Pages in lieu of discard
Message-Id: <20210715123836.ad76b0a2e29c0bbd3cd67767@linux-foundation.org>
In-Reply-To: <20210715055145.195411-1-ying.huang@intel.com>
References: <20210715055145.195411-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 13:51:36 +0800 Huang Ying <ying.huang@intel.com> wrote:

> The full series is also available here:
> 
> 	https://github.com/hying-caritas/linux/tree/automigrate-20210715
> 
> The changes since the last post are as follows,
> 
>  * Reduce code duplication via move common demotion condition code
>    into can_demote_anon_pages() per Wei's comments.
> 
> --
> 
> We're starting to see systems with more and more kinds of memory such
> as Intel's implementation of persistent memory.
> 
> Let's say you have a system with some DRAM and some persistent memory.
> Today, once DRAM fills up, reclaim will start and some of the DRAM
> contents will be thrown out.  Allocations will, at some point, start
> falling over to the slower persistent memory.
> 
> That has two nasty properties.  First, the newer allocations can end
> up in the slower persistent memory.  Second, reclaimed data in DRAM
> are just discarded even if there are gobs of space in persistent
> memory that could be used.
> 
> This set implements a solution to these problems.  At the end of the
> reclaim process in shrink_page_list() just before the last page
> refcount is dropped, the page is migrated to persistent memory instead
> of being dropped.
> 
> While I've talked about a DRAM/PMEM pairing, this approach would
> function in any environment where memory tiers exist.
> 
> This is not perfect.  It "strands" pages in slower memory and never
> brings them back to fast DRAM.  Huang Ying has follow-on work which
> repurposes autonuma to promote hot pages back to DRAM.
> 
> This is also all based on an upstream mechanism that allows
> persistent memory to be onlined and used as if it were volatile:
> 
> 	http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com
> 
> We have tested the patchset with the postgresql and pgbench.  On a
> 2-socket server machine with DRAM and PMEM, the kernel with the
> patchset can improve the score of pgbench up to 22.1% compared with
> that of the DRAM only + disk case.  This comes from the reduced disk
> read throughput (which reduces up to 70.8%).

The [0/n] description talks a lot about PMEM, but the patches
themselves are all about NUMA nodes.  I assume that what ties this
together is that the PMEM tends to be organized as a NUMA node on its
own, and that by enabling migrate-to-remote-node-during-reclaim, we get
this PMEM behaviour as a desired side-effect?

IOW, perhaps this [0/n] description could explain the linkage between
PMEM and NUMA nodes more explicitly.


Secondly...  at some point it just won't make sense to migrate pages to
a remote node because that remote node isn't remote enough.  I mean, if
accessing the remote node is 2% slower than the local node, it's best
to just reclaim the page rather than going to the effort of migrating
it around?  And I assume the patchset doesn't (yet) attempt to make this
judgement?


Thirdly, the final patch which makes the feature off-by-default is a
concern.  I expect this will cause the new feature to have much less
testing (functional and performance).  We could make it default-on for
now, then flip that to default-off after 5.14-rc5 (for example).  That
will help, but is a bit lame.  Is it not possible for the kernel to
look at the overall system layout and make an educated guess as to
whether this system will benefit?

And I see this, from the [9/9] changelog:

: The benefits are truly workload-based and *not* hardware-based.  We do
: not believe that there is a viable threshold where certain hardware
: configurations should have this mechanism enabled while others do not.

so...  why not simply enable the thing for all systems and be done with
it?  What sort of downsides are you anticipating?  We could of course
include an emergency-off knob, but hoping that it won't need to be
used.

Finally, having a feature which is good for some workloads, bad for
others and which contains a system-wide enable knob is really quite
sad.  It requires a lot of work from each and every operator in the
world!  They must experimentally run their workloads both with and
without, and determine which is best.  And they should rerun this
testing periodically as userspace and the kernel evolve, to determine
whether their earlier experimenting holds true.  And what happens if
workload #1 wins and workload #2 loses?

And of course, many operators simply won't do all of this and they'll
run slower, or will miss out of benefits.  What can we do to relieve
our users of all of this?

