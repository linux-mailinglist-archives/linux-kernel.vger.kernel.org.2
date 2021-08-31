Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705F13FC556
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 12:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbhHaJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:58:20 -0400
Received: from foss.arm.com ([217.140.110.172]:52748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239629AbhHaJ6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:58:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A577A1FB;
        Tue, 31 Aug 2021 02:57:14 -0700 (PDT)
Received: from [10.163.72.217] (unknown [10.163.72.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E0943F5A1;
        Tue, 31 Aug 2021 02:57:11 -0700 (PDT)
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
Message-ID: <13dab5ac-03a3-e9b3-ff12-f819f7711569@arm.com>
Date:   Tue, 31 Aug 2021 15:28:11 +0530
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

I am wondering what causes this performance drop here ? Would not the memory
access latency be similar between {2, 3} --->  { 0 } and {2, 3} --->  { 1 },
given both these nodes {0, 1} have same distance from {2, 3} i.e 32 from the
above distance matrix. Even if the preferred node order changes from { 0 } to
{ 1 } for the accessing node { 3 }, it should not change the latency as such.

Is the performance drop here, is caused by excessive allocation on node { 0 }
resulting from page allocation latency instead.
