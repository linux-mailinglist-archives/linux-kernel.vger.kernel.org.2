Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD83FB60D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhH3Mau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:30:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhH3Mat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:30:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6535E2211C;
        Mon, 30 Aug 2021 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630326595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xjKBIsHOE5hh7wFrPPgbILIwuIlQvq83/c8Ge7u+M1g=;
        b=MLU26fgUXLVXYSle96eODFIeaGgnydiRKSFt5va/pGYci4bu82vZqfsMkB5Fc7q3cB59ys
        Ip/plnfMeNAE7y8yWWs1aUGVWcQlI8CzqFDj6/jgYrVRU148h4ajmXgCgW6Gdqt35Hhp4i
        DmKQunLO8jJeLypuIwlDHUFtLojN8/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630326595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xjKBIsHOE5hh7wFrPPgbILIwuIlQvq83/c8Ge7u+M1g=;
        b=xpXAVyk+cFaSlBGZLIrSzp0cAcXHqm3zdlvds+5MYlDum3Dj/P9nrHqbvy7JZ+LUZLlmOn
        0fL9vf8ZPnXXFyCQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E06FCA3BB3;
        Mon, 30 Aug 2021 12:29:54 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:29:52 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, kamezawa.hiroyu@jp.fujitsu.com,
        lee.schermerhorn@hp.com, Krupa.Ramakrishnan@amd.com,
        Sadagopan.Srinivasan@amd.com
Subject: Re: [FIX PATCH 2/2] mm/page_alloc: Use accumulated load when
 building node fallback list
Message-ID: <20210830122952.GC4060@suse.de>
References: <20210830121603.1081-1-bharata@amd.com>
 <20210830121603.1081-3-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210830121603.1081-3-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 05:46:03PM +0530, Bharata B Rao wrote:
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

Minor not, The Fixes should be all one line even if it goes over the
line length limit.

Otherwise, I can confirm that 2-socket Intel machines with SNC enabled
suffer a similar problem -- the fallback lists for equal-distance nodes
ends up overloading one node. Aside from the problems you mention, the
overloaded node could trigger premature reclaim and inconsistent
behaviour depending on where the task executes so

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
