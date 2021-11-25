Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2CD45D26B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 02:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbhKYB2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 20:28:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:63888 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238769AbhKYB0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 20:26:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="296223090"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="296223090"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 17:23:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="510091926"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 17:23:33 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hasan Al Maruf <hasan3050@gmail.com>
Cc:     dave.hansen@linux.intel.com, yang.shi@linux.alibaba.com,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Transparent Page Placement for Tiered-Memory
References: <cover.1637778851.git.hasanalmaruf@fb.com>
Date:   Thu, 25 Nov 2021 09:23:31 +0800
In-Reply-To: <cover.1637778851.git.hasanalmaruf@fb.com> (Hasan Al Maruf's
        message of "Wed, 24 Nov 2021 13:58:25 -0500")
Message-ID: <874k812fl8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hasan Al Maruf <hasan3050@gmail.com> writes:

> [resend in proper format]
>
> With the advent of new memory types and technologies, we can see different
> types of memory together, e.g. DRAM, PMEM, CXL-enabled memory, etc. In
> recent future, we can see CXL-Memory be available in the physical address-
> space as a CPU-less NUMA node along with the native DDR memory channels.
> As different types of memory have different level of performance impact,
> how we manage pages across the NUMA nodes should be a matter of concern.
>
> Dave Hansen's patchset on "Migrate Pages in lieu of discard" demotes
> toptier pages to a slow tier node during the reclamation process.
>
>     		https://lwn.net/Articles/860215/
>
> However, that patchset does not include the features to promote pages on
> slow tier memory node to the toptier one. As a result, pages demoted or
> newly allocated on the slow tier node, experiences NUMA latency and hurt
> application performance. In this patch set, we augment existing AutoNUMA
> mechanism to promote pages from slow tier nodes to toptier nodes.
>
> We decouple reclamation and allocation logics for the toptier node so that
> reclamation gets triggered at a higher watermark and demotes colder pages
> to the slow-tier memory. As a result, toptier nodes can maintain some free
> space to accept both new allocation and promotion from slowtier nodes.
> During promotion, we add hysteresis to page and only promote pages that
> are less likely to be demoted within a short period of time. This reduces
> the chance for a page being ping-ponged across the NUMA nodes due to
> frequent demotion and promotion within a short period of time.
>
> We tested this patchset on systems with CXL-enabled DRAM and PMEM tiers.
> We find this patchset can bring hotter pages to the toptier node while
> moving the colder pages to the slow-tier nodes for a good range of Meta
> production workloads with live traffic. As a result, toptier nodes serve
> more hot pages and the application performance improves.
>
> Case Study of a Meta cache application with two NUMA nodes
> ==========================================================
> Toptier node: DRAM directly attached to the CPU
> Slowtier node: DRAM attached through CXL
>
> Toptier vs Slowtier memory capacity ratio is 1:4
>
> With default page placement policy, file caches fills up the toptier node
> and anons get trapped in the slowtier node. Only 14% of the total anons
> reside in toptier node. Remote NUMA read bandwidth is 80%. Throughput
> regression is 18% compared to all memory being served from toptier node.
>
> This patchset brings 80% of the anons to the toptier node. Anons on the
> slowtier memory is mostly cold anons. As the toptier node can not host all
> the hot memory, some hot files still remain on the slowtier node. Even
> though, remote NUMA read bandwidth reduces from 80% to 40%. With this
> patchset, throughput regression is only 5% compared to the baseline of
> toptier node serving the whole working set.

Hi, Hasan,

I found that quite some code in your patchset is exactly same as that in
my patchset as follows,

https://lore.kernel.org/lkml/20211116013522.140575-1-ying.huang@intel.com/

and patches in the following repo we used to publish some patchset that
hasn't been sent to community for review,

https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/log/?h=tiering-0.72

I am glad that more people have interest and worked on optimizing page
placement for tiering memory system.  How about we merge instead of
duplicate our effort?

Because I tried to make the patches above as simple as possible (at
least first 3), can you comment the most basic patches there to help
them to be improved.  And then we can build our more complex/advanced
patches on top of that?

Best Regards,
Huang, Ying
