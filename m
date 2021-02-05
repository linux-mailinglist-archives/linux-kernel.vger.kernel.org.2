Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA863106E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBEIjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:39:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:42298 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhBEIim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:38:42 -0500
IronPort-SDR: 0I89RSkXMuO2IQZuWKFVjoFEo8DCszN1H8RhqfMaLpGm4lEBOI1jKUh+hgG9immz+l9p4hw+9u
 BPuOhZ5i/X7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181468415"
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="181468415"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 00:37:53 -0800
IronPort-SDR: YIpVA6ccVP+JERWauwmb0OIUviUU85ydS6ors+VWFKQaD5gxMfX0vBxkoy3gTgJsctlRlKsyWC
 do7xq+rZatqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="373323390"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Feb 2021 00:37:49 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC -V5 1/6] NUMA balancing: optimize page placement for
 memory tiering system
References: <20210204101056.89336-1-ying.huang@intel.com>
        <20210205075312.2515-1-hdanton@sina.com>
Date:   Fri, 05 Feb 2021 16:37:48 +0800
In-Reply-To: <20210205075312.2515-1-hdanton@sina.com> (Hillf Danton's message
        of "Fri, 5 Feb 2021 15:53:12 +0800")
Message-ID: <87pn1ekizn.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> writes:

> On Thu,  4 Feb 2021 18:10:51 +0800 Huang Ying wrote:
>> With the advent of various new memory types, some machines will have
>> multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
>> memory subsystem of these machines can be called memory tiering
>> system, because the performance of the different types of memory are
>> usually different.
>> 
>> In such system, because of the memory accessing pattern changing etc,
>> some pages in the slow memory may become hot globally.  So in this
>> patch, the NUMA balancing mechanism is enhanced to optimize the page
>> placement among the different memory types according to hot/cold
>> dynamically.
>> 
>> In a typical memory tiering system, there are CPUs, fast memory and
>> slow memory in each physical NUMA node.  The CPUs and the fast memory
>> will be put in one logical node (called fast memory node), while the
>> slow memory will be put in another (faked) logical node (called slow
>> memory node).  That is, the fast memory is regarded as local while the
>> slow memory is regarded as remote.  So it's possible for the recently
>> accessed pages in the slow memory node to be promoted to the fast
>> memory node via the existing NUMA balancing mechanism.
>> 
>> The original NUMA balancing mechanism will stop to migrate pages if the free
>> memory of the target node will become below the high watermark.  This
>> is a reasonable policy if there's only one memory type.  But this
>> makes the original NUMA balancing mechanism almost not work to optimize page
>> placement among different memory types.  Details are as follows.
>> 
>> It's the common cases that the working-set size of the workload is
>> larger than the size of the fast memory nodes.  Otherwise, it's
>> unnecessary to use the slow memory at all.  So in the common cases,
>> there are almost always no enough free pages in the fast memory nodes,
>> so that the globally hot pages in the slow memory node cannot be
>
> In assumption like
>
> 1/ the workload's working set size is 1.5x larger than one DRAM node,
> 2/ PMEM is 10x (or 5x) larger than DRAM,
>
> what difference is it going to make if the spinning hard disk swap
> can be replaced with PMEM? With PMEM swap, the page demotion is swapout
> and we will pay nothing for page promotion.

Per my understanding, this is the difference between PMEM as swap and
accessing PMEM directly + promotion.

PMEM as swap:

- PMEM will not be accessed directly, that is, any DRAM miss will
  trigger swapping in.  That is, 1 cache line access will be inflated as
  4KB accessing (4096 / 64 = 64).  And page direct reclaiming may be
  triggered, so the accessing latency is almost unbounded.

- The good part is that if the PMEM page is very hot, we will put the
  page in DRAM at the first accessing.

promotion + accessing PMEM directly:

- PMEM may be accessed directly.  The latency of PMEM is longer than
  that of DRAM, but much smaller than that of swapping in.  And we avoid
  to trigger direct reclaiming for page promotion.

- The bad part is that the very hot PMEM page may be accessed directly
  for a while before being promoted to DRAM.  It takes some time to
  identify whether a page is hot or not.

So in another words, swap can guarantee the very hot pages to be
accessed in DRAM always, but promotion + accessing PMEM directly
solution can avoid to move very cold pages to DRAM so that the page
thrashing can be avoided.

If the pages we put in PMEM will almost never been accessed, then PMEM
as swap may be the suitable solution too.  But if it's not, promotion +
accessing PMEM directly works generally better.

Best Regards,
Huang, Ying

[snip]
