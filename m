Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5835C2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbhDLJug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:50:36 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:33467 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237939AbhDLJho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:37:44 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 62ED51C4FAC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:37:24 +0100 (IST)
Received: (qmail 24080 invoked from network); 12 Apr 2021 09:37:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Apr 2021 09:37:24 -0000
Date:   Mon, 12 Apr 2021 10:37:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Rik van Riel <riel@surriel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Parth Shah <parth@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC/PATCH] powerpc/smp: Add SD_SHARE_PKG_RESOURCES flag to MC
 sched-domain
Message-ID: <20210412093722.GS3697@techsingularity.net>
References: <1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com>
 <20210412062436.GB2633526@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210412062436.GB2633526@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:54:36AM +0530, Srikar Dronamraju wrote:
> * Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2021-04-02 11:07:54]:
> 
> > 
> > To remedy this, this patch proposes that the LLC be moved to the MC
> > level which is a group of cores in one half of the chip.
> > 
> >       SMT (SMT4) --> MC (Hemisphere)[LLC] --> DIE
> > 
> 
> I think marking Hemisphere as a LLC in a P10 scenario is a good idea.
> 
> > While there is no cache being shared at this level, this is still the
> > level where some amount of cache-snooping takes place and it is
> > relatively faster to access the data from the caches of the cores
> > within this domain. With this change, we no longer see regressions on
> > P10 for applications which require single threaded performance.
> 
> Peter, Valentin, Vincent, Mel, etal
> 
> On architectures where we have multiple levels of cache access latencies
> within a DIE, (For example: one within the current LLC or SMT core and the
> other at MC or Hemisphere, and finally across hemispheres), do you have any
> suggestions on how we could handle the same in the core scheduler?
> 

Minimally I think it would be worth detecting when there are multiple
LLCs per node and detecting that in generic code as a static branch. In
select_idle_cpu, consider taking two passes -- first on the LLC domain
and if no idle CPU is found then taking a second pass if the search depth
allows within the node with the LLC CPUs masked out. While there would be
a latency hit because cache is not shared, it would still be a CPU local
to memory that is idle. That would potentially be beneficial on Zen*
as well without having to introduce new domains in the topology hierarchy.

-- 
Mel Gorman
SUSE Labs
