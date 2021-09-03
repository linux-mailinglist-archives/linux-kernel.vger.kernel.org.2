Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9C3FF997
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 06:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhICEbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 00:31:46 -0400
Received: from foss.arm.com ([217.140.110.172]:34952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232624AbhICEbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:31:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F230D6E;
        Thu,  2 Sep 2021 21:30:39 -0700 (PDT)
Received: from [10.163.72.65] (unknown [10.163.72.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E205E3F5A1;
        Thu,  2 Sep 2021 21:30:35 -0700 (PDT)
Subject: Re: [FIX PATCH 1/2] mm/page_alloc: Print node fallback order
To:     Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, kamezawa.hiroyu@jp.fujitsu.com,
        lee.schermerhorn@hp.com, mgorman@suse.de,
        Krupa.Ramakrishnan@amd.com, Sadagopan.Srinivasan@amd.com
References: <20210830121603.1081-1-bharata@amd.com>
 <20210830121603.1081-2-bharata@amd.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9c29181a-b188-ea61-9d86-0d8d0ca4ee04@arm.com>
Date:   Fri, 3 Sep 2021 10:01:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210830121603.1081-2-bharata@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/21 5:46 PM, Bharata B Rao wrote:
> Print information message about the allocation fallback order
> for each NUMA node during boot.
> 
> No functional changes here. This makes it easier to illustrate
> the problem in the node fallback list generation, which the
> next patch fixes.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>  mm/page_alloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eeb3a9cb36bb..22f7ad6ec11c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6277,6 +6277,10 @@ static void build_zonelists(pg_data_t *pgdat)
>  
>  	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
>  	build_thisnode_zonelists(pgdat);
> +	pr_info("Fallback order for Node %d: ", local_node);
> +	for (node = 0; node < nr_nodes; node++)
> +		pr_cont("%d ", node_order[node]);
> +	pr_cont("\n");
>  }
>  
>  #ifdef CONFIG_HAVE_MEMORYLESS_NODES
> 

Node allocation preference sequence for a given accessing node is an
important information on large systems. This information during boot
and (hotplug --> online sequence) will help the user.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
