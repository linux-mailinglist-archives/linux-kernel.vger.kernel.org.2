Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A683FF94B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 06:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhICEUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 00:20:13 -0400
Received: from foss.arm.com ([217.140.110.172]:34808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhICEUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:20:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2576ED6E;
        Thu,  2 Sep 2021 21:19:12 -0700 (PDT)
Received: from [10.163.72.65] (unknown [10.163.72.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D9943F5A1;
        Thu,  2 Sep 2021 21:19:08 -0700 (PDT)
Subject: Re: [FIX PATCH 2/2] mm/page_alloc: Use accumulated load when building
 node fallback list
To:     Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, kamezawa.hiroyu@jp.fujitsu.com,
        lee.schermerhorn@hp.com, mgorman@suse.de,
        Krupa.Ramakrishnan@amd.com, Sadagopan.Srinivasan@amd.com
References: <20210830121603.1081-1-bharata@amd.com>
 <20210830121603.1081-3-bharata@amd.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c9d5d8f2-13de-b919-cfcf-ca7cd2940af9@arm.com>
Date:   Fri, 3 Sep 2021 09:50:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210830121603.1081-3-bharata@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/21 5:46 PM, Bharata B Rao wrote:
> From: Krupa Ramakrishnan <krupa.ramakrishnan@amd.com>
> 
> In build_zonelists(), when the fallback list is built for the nodes,
> the node load gets reinitialized during each iteration. This results
> in nodes with same distances occupying the same slot in different
> node fallback lists rather than appearing in the intended round-
> robin manner. This results in one node getting picked for allocation
> more compared to other nodes with the same distance.
> 
> As an example, consider a 4 node system with the following distance
> matrix.
> 
> Node 0  1  2  3
> ----------------
> 0    10 12 32 32
> 1    12 10 32 32
> 2    32 32 10 12
> 3    32 32 12 10
> 
> For this case, the node fallback list gets built like this:
> 
> Node	Fallback list
> ---------------------
> 0	0 1 2 3
> 1	1 0 3 2
> 2	2 3 0 1
> 3	3 2 0 1 <-- Unexpected fallback order
> 
> In the fallback list for nodes 2 and 3, the nodes 0 and 1
> appear in the same order which results in more allocations
> getting satisfied from node 0 compared to node 1.
> 
> The effect of this on remote memory bandwidth as seen by stream
> benchmark is shown below:
> 
> Case 1: Bandwidth from cores on nodes 2 & 3 to memory on nodes 0 & 1
> 	(numactl -m 0,1 ./stream_lowOverhead ... --cores <from 2, 3>)
> Case 2: Bandwidth from cores on nodes 0 & 1 to memory on nodes 2 & 3
> 	(numactl -m 2,3 ./stream_lowOverhead ... --cores <from 0, 1>)
> 
> ----------------------------------------
> 		BANDWIDTH (MB/s)
>     TEST	Case 1		Case 2
> ----------------------------------------
>     COPY	57479.6		110791.8
>    SCALE	55372.9		105685.9
>      ADD	50460.6		96734.2
>   TRIADD	50397.6		97119.1
> ----------------------------------------
> 
> The bandwidth drop in Case 1 occurs because most of the allocations
> get satisfied by node 0 as it appears first in the fallback order
> for both nodes 2 and 3.
> 
> This can be fixed by accumulating the node load in build_zonelists()
> rather than reinitializing it during each iteration. With this the
> nodes with the same distance rightly get assigned in the round robin
> manner. In fact this was how it was originally until the
> commit f0c0b2b808f2 ("change zonelist order: zonelist order selection
> logic") dropped the load accumulation and resorted to initializing
> the load during each iteration. While zonelist ordering was removed by
> commit c9bff3eebc09 ("mm, page_alloc: rip out ZONELIST_ORDER_ZONE"),
> the change to the node load accumulation in build_zonelists() remained.
> So essentially this patch reverts back to the accumulated node load
> logic.
> 
> After this fix, the fallback order gets built like this:
> 
> Node Fallback list
> ------------------
> 0    0 1 2 3
> 1    1 0 3 2
> 2    2 3 0 1
> 3    3 2 1 0 <-- Note the change here
> 
> The bandwidth in Case 1 improves and matches Case 2 as shown below.
> 
> ----------------------------------------
> 		BANDWIDTH (MB/s)
>     TEST	Case 1		Case 2
> ----------------------------------------
>     COPY	110438.9	110107.2
>    SCALE	105930.5	105817.5
>      ADD	97005.1		96159.8
>   TRIADD	97441.5		96757.1
> ----------------------------------------
> 
> The correctness of the fallback list generation has been verified
> for the above node configuration where the node 3 starts as
> memory-less node and comes up online only during memory hotplug.
> 
> [bharata@amd.com: Added changelog, review, test validation]
> 
> Fixes: f0c0b2b808f2 ("change zonelist order: zonelist order selection
> logic")
> Signed-off-by: Krupa Ramakrishnan <krupa.ramakrishnan@amd.com>
> Co-developed-by: Sadagopan Srinivasan <Sadagopan.Srinivasan@amd.com>
> Signed-off-by: Sadagopan Srinivasan <Sadagopan.Srinivasan@amd.com>
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 22f7ad6ec11c..47f4d160971e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6268,7 +6268,7 @@ static void build_zonelists(pg_data_t *pgdat)
>  		 */
>  		if (node_distance(local_node, node) !=
>  		    node_distance(local_node, prev_node))
> -			node_load[node] = load;
> +			node_load[node] += load;
>  
>  		node_order[nr_nodes++] = node;
>  		prev_node = node;
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
