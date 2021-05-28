Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5506D394255
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhE1MOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:14:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33152 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbhE1MNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:13:45 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE8DA218B3;
        Fri, 28 May 2021 12:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622203929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vri3iLgnuhvZlNDsWXgWeFnIHTDjEjZ+Fvja7rOAqd8=;
        b=0E5X5iS2BZy6FaWcZxfwQgKnCD45BvZP6XN2h4g0IsJZXsqF2iY6srPWwVL7JmhPorL+x0
        RcCTk1v7dXc7RpD1NQPOpQOfaaD4U5espBE5Co6WWpWZvLBumuxMpZ1QrZynlIOUa6J/SR
        42MKh+tsbi/PWSmYIugADPeRqVpzpzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622203929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vri3iLgnuhvZlNDsWXgWeFnIHTDjEjZ+Fvja7rOAqd8=;
        b=mJwRHXkpMbm3U06RZTGrRETPMoScqMqf2bx9sGLAIY/Q9toomS2UBLiBPAqmQX4Mnm0hMH
        q59gCIEE6gGY5zAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C30F111A98;
        Fri, 28 May 2021 12:12:09 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id mNbELhnesGCBHwAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Fri, 28 May 2021 12:12:09 +0000
To:     Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, "Tang, Feng" <feng.tang@intel.com>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
 <20210528085545.GJ30378@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and active
 CPUs
Message-ID: <416f39e7-704a-86d0-8261-dc27366336ab@suse.cz>
Date:   Fri, 28 May 2021 14:12:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528085545.GJ30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/21 10:55 AM, Mel Gorman wrote:
> On Thu, May 27, 2021 at 12:36:21PM -0700, Dave Hansen wrote:
>> Hi Mel,
>> 
>> Feng Tang tossed these on a "Cascade Lake" system with 96 threads and
>> ~512G of persistent memory and 128G of DRAM.  The PMEM is in "volatile
>> use" mode and being managed via the buddy just like the normal RAM.
>> 
>> The PMEM zones are big ones:
>> 
>>         present  65011712 = 248 G
>>         high       134595 = 525 M
>> 
>> The PMEM nodes, of course, don't have any CPUs in them.
>> 
>> With your series, the pcp->high value per-cpu is 69584 pages or about
>> 270MB per CPU.  Scaled up by the 96 CPU threads, that's ~26GB of
>> worst-case memory in the pcps per zone, or roughly 10% of the size of
>> the zone.
>> 
>> I did see quite a few pcp->counts above 60,000, so it's definitely
>> possible in practice to see the pcps filled up.  This was not observed
>> to cause any actual problems in practice.  But, it's still a bit worrisome.
>> 
> 
> Ok, it does have the potential to trigger early reclaim as pages are
> stored on remote PCP lists. The problem would be transient because
> vmstat would drain those pages over time but still, how about this patch
> on top of the series?
> 
> --8<--
> mm/page_alloc: Split pcp->high across all online CPUs for cpuless nodes
> 
> Dave Hansen reported the following about Feng Tang's tests on a machine
> with persistent memory onlined as a DRAM-like device.
> 
>   Feng Tang tossed these on a "Cascade Lake" system with 96 threads and
>   ~512G of persistent memory and 128G of DRAM.  The PMEM is in "volatile
>   use" mode and being managed via the buddy just like the normal RAM.
> 
>   The PMEM zones are big ones:
> 
>         present  65011712 = 248 G
>         high       134595 = 525 M
> 
>   The PMEM nodes, of course, don't have any CPUs in them.
> 
>   With your series, the pcp->high value per-cpu is 69584 pages or about
>   270MB per CPU.  Scaled up by the 96 CPU threads, that's ~26GB of
>   worst-case memory in the pcps per zone, or roughly 10% of the size of
>   the zone.
> 
> This should not cause a problem as such although it could trigger reclaim
> due to pages being stored on per-cpu lists for CPUs remote to a node. It
> is not possible to treat cpuless nodes exactly the same as normal nodes
> but the worst-case scenario can be mitigated by splitting pcp->high across
> all online CPUs for cpuless memory nodes.
> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Maybe we should even consider distinguishing high limits for local-to-cpu zones
vs remote, for example for the local-to-cpu zones we would divide by the number
of local cpus, for remote-to-cpu zones we would divide by all cpus.

Because we can expect cpus to allocate mostly from local zones, so leaving more
pages on percpu for those zones can be beneficial.

But as the motivation here was to reduce lock contention on freeing, that's less
clear. We probably can't expect the cpu to be freeing mostly local pages (in
case of e.g. a large process exiting), because no mechanism works towards that,
or does it? In case of cpu freeing to remote zone, the lower high limit could hurt.

So that would have to be evaluated if that works in practice. Out of scope here,
just an idea to discuss.
