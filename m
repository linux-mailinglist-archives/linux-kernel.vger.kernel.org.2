Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC239402555
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbhIGIpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:45:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37400 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbhIGIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:45:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2BACB21FE4;
        Tue,  7 Sep 2021 08:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631004276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLbWJgt7Pq7iTo2+u+wRsltkx42moH/GKLU6EPym12c=;
        b=fb8TAUdnRMI1pKMM76wf/il79XFi0Xe4TReUmU6/lhZUL3XOJc62vvSBdlMVUv9YqHGlKm
        veoFeOD4ahD2cCGJRlkIqS0cRLa/UWqJsPQNi4VfQP43kHbcnp0xPo7hTXoEha1qFpV3H1
        bxfKDDTXbJyIg0mAxgPGQLyk7Oh4nGw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EFDD5A3B81;
        Tue,  7 Sep 2021 08:44:35 +0000 (UTC)
Date:   Tue, 7 Sep 2021 10:44:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and
 bail out early
Message-ID: <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
References: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-09-21 16:25:50, Feng Tang wrote:
> There was report that starting an Ubuntu in docker while using cpuset
> to bind it to movlabe nodes (a node only has movable zone, like a node

s@movlabe@movable@

> for hotplug or a Persistent Memory  node in normal usage) will fail
> due to memory allocation failure, and then OOM is involved and many
> other innocent processes got killed. It can be reproduced with command:
> $docker run -it --rm  --cpuset-mems 4 ubuntu:latest bash -c
> "grep Mems_allowed /proc/self/status" (node 4 is a movable node)
> 
> The reason is, in the case, the target cpuset nodes only have movable
> zone, while the creation of an OS in docker sometimes needs to allocate
> memory in non-movable zones (dma/dma32/normal) like GFP_HIGHUSER, and
> the cpuset limit forbids the allocation, then out-of-memory killing is
> involved even when normal nodes and movable nodes both have many free
> memory.

It would be great to add a oom report here as an example.

> The failure is reasonable, but still there is one problem, that when
> the usage fails as it's an mission impossible due to the cpuset limit,
> the allocation should just not trigger reclaim/compaction, and more
> importantly, not get any innocent process oom-killed.

I would reformulate to something like:
"
The OOM killer cannot help to resolve the situation as there is no
usable memory for the request in the cpuset scope. The only reasonable
measure to take is to fail the allocation right away and have the caller
to deal with it.
"
 
> So add detection for cases like this in the slowpath of allocation,
> and bail out early returning NULL for the allocation.
> 
> We've run some cases of malloc/mmap/page_fault/lru-shm/swap from
> will-it-scale and vm-scalability, and didn't see obvious performance
> change (all inside +/- 1%), test boxes are 2 socket Cascade Lake and
> Icelake servers.
> 
> [thanks to Micho Hocko and David Rientjes for suggesting not handle
>  it inside OOM code]

While this is a good fix from the functionality POV I believe you can go
a step further. Please add a detection to the cpuset code and complain
to the kernel log if somebody tries to configure movable only cpuset.
Once you have that in place you can easily create a static branch for
cpuset_insane_setup() and have zero overhead for all reasonable
configuration. There shouldn't be any reason to pay a single cpu cycle
to check for something that almost nobody does.

What do you think?
-- 
Michal Hocko
SUSE Labs
