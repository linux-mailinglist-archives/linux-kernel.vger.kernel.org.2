Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B2B44D375
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhKKIyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:50430 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232768AbhKKIya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="232819283"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="232819283"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 00:51:41 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="492465439"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 00:51:37 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <ziy@nvidia.com>, <osalvador@suse.de>, <shy828301@gmail.com>,
        <zhongjiang-ali@linux.alibaba.com>, <xlpang@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm: migrate: Allocate the node_demotion
 structure dynamically
References: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
        <e39502af91e12ba1a4bef3be4d05b11b2c7a7a9f.1636616548.git.baolin.wang@linux.alibaba.com>
Date:   Thu, 11 Nov 2021 16:51:35 +0800
In-Reply-To: <e39502af91e12ba1a4bef3be4d05b11b2c7a7a9f.1636616548.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Thu, 11 Nov 2021 15:48:35 +0800")
Message-ID: <87pmr7m5wo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> For the worst case (MAX_NUMNODES=1024), the node_demotion structure can
> consume 32k bytes, which appears too large, so we can change to allocate
> node_demotion dynamically at initialization time. Meanwhile allocating
> the target demotion nodes array dynamically to select a suitable size
> according to the MAX_NUMNODES.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 126e9e6..0145b38 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1152,10 +1152,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  #define DEFAULT_DEMOTION_TARGET_NODES 15
>  struct demotion_nodes {
>  	unsigned short nr;
> -	short nodes[DEFAULT_DEMOTION_TARGET_NODES];
> +	short nodes[];
>  };
>  
> -static struct demotion_nodes node_demotion[MAX_NUMNODES] __read_mostly;
> +static struct demotion_nodes *node_demotion[MAX_NUMNODES] __read_mostly;
> +static unsigned short target_nodes_max;

I think we can use something as below,

  #if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
  #define DEMOTION_TARGET_NODES   (MAX_NUMNODES - 1)
  #else
  #define DEMOTION_TARGET_NODES   DEFAULT_DEMOTION_TARGET_NODES
  #endif

  static struct demotion_nodes *node_demotion;

Then we can allocate nr_node_ids * sizeof(struct demotion_nodes) for node_demotion.

Best Regards,
Huang, Ying

[snip]
