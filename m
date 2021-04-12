Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A51F35C367
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbhDLKIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:08:45 -0400
Received: from foss.arm.com ([217.140.110.172]:45288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240222AbhDLKGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:06:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC6A51FB;
        Mon, 12 Apr 2021 03:06:26 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E18933F694;
        Mon, 12 Apr 2021 03:06:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Parth Shah <parth@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC/PATCH] powerpc/smp: Add SD_SHARE_PKG_RESOURCES flag to MC sched-domain
In-Reply-To: <20210412093722.GS3697@techsingularity.net>
References: <1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com> <20210412062436.GB2633526@linux.vnet.ibm.com> <20210412093722.GS3697@techsingularity.net>
Date:   Mon, 12 Apr 2021 11:06:19 +0100
Message-ID: <871rbfom04.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/21 10:37, Mel Gorman wrote:
> On Mon, Apr 12, 2021 at 11:54:36AM +0530, Srikar Dronamraju wrote:
>> * Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2021-04-02 11:07:54]:
>>
>> >
>> > To remedy this, this patch proposes that the LLC be moved to the MC
>> > level which is a group of cores in one half of the chip.
>> >
>> >       SMT (SMT4) --> MC (Hemisphere)[LLC] --> DIE
>> >
>>
>> I think marking Hemisphere as a LLC in a P10 scenario is a good idea.
>>
>> > While there is no cache being shared at this level, this is still the
>> > level where some amount of cache-snooping takes place and it is
>> > relatively faster to access the data from the caches of the cores
>> > within this domain. With this change, we no longer see regressions on
>> > P10 for applications which require single threaded performance.
>>
>> Peter, Valentin, Vincent, Mel, etal
>>
>> On architectures where we have multiple levels of cache access latencies
>> within a DIE, (For example: one within the current LLC or SMT core and the
>> other at MC or Hemisphere, and finally across hemispheres), do you have any
>> suggestions on how we could handle the same in the core scheduler?
>>
>
> Minimally I think it would be worth detecting when there are multiple
> LLCs per node and detecting that in generic code as a static branch. In
> select_idle_cpu, consider taking two passes -- first on the LLC domain
> and if no idle CPU is found then taking a second pass if the search depth
> allows within the node with the LLC CPUs masked out.

I think that's actually a decent approach. Tying SD_SHARE_PKG_RESOURCES to
something other than pure cache topology in a generic manner is tough (as
it relies on murky, ill-defined hardware fabric properties).

Last I tried thinking about that, I stopped at having a core-to-core
latency matrix, building domains off of that, and having some knob
specifying the highest distance value below which we'd set
SD_SHARE_PKG_RESOURCES. There's a few things I 'hate' about that; for one
it makes cpus_share_cache() somewhat questionable.

> While there would be
> a latency hit because cache is not shared, it would still be a CPU local
> to memory that is idle. That would potentially be beneficial on Zen*
> as well without having to introduce new domains in the topology hierarchy.
>
> --
> Mel Gorman
> SUSE Labs
