Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD73AB7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhFQPmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:42:20 -0400
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:32882 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233372AbhFQPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:42:16 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id 22F873E00C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 16:40:08 +0100 (IST)
Received: (qmail 7930 invoked from network); 17 Jun 2021 15:40:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jun 2021 15:40:07 -0000
Date:   Thu, 17 Jun 2021 16:40:06 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
Message-ID: <20210617154006.GQ30378@techsingularity.net>
References: <20210615111611.GH30378@techsingularity.net>
 <20210615204228.GB4272@worktop.programming.kicks-ass.net>
 <20210616090314.GJ30378@techsingularity.net>
 <YMtjvF0en9NjIspl@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YMtjvF0en9NjIspl@lorien.usersys.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:01:16AM -0400, Phil Auld wrote:
> > Thanks, so far no serious objection :)
> > 
> > The latest results as I see them have been copied to
> > https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/dashboard.html
> > They will move from here if the patch is accepted to 5-assembly replacing
> > 3-perf-test. This naming is part of my workflow for evaluating topic
> > branches separetly and then putting them together for another round
> > of testing.
> > 
> > NAS shows small differences but NAS would see limited impact from the
> > patch. Specjbb shows small losses and some minor gains which is unfortunate
> > but the workload tends to see small gains and losses all the time.
> > redis is a mixed bag but has some wins. hackbench is the main benefit
> > because it's wakeup intensive and tends to overload machines where deep
> > searches hurt.
> > 
> > There are other results in there if you feel like digging around
> > such as sched-core tested with no processes getting tagged with prctl
> > https://beta.suse.com/private/mgorman/melt/v5.13-rc5/5-assembly/sched/sched-schedcore-v1r2/html/dashboard.html
> >
> 
> Thanks for the links. It's cool to see what your results dashboard looks like.
> It's really small, what are you plotting in those heat maps?
> 
> It's hard for me to publish the results that come from our testing (web based
> on intranet) but we don't see any major differences with this patch.  There
> are some gains here and there mostly balanced by some loses.  Overall it comes
> out basically as a wash across our main performance test workload.
> 

Ok, that's unfortunate. It's also somewhat surprising but then again, I
don't know what tests were executed.

> It'll be interesting to see if it effects a sensitive, proprietary perf test
> suite from a European company with a 3 letter name :)
> 

I don't think it's worth the effort if it's failing microbenchmarks at
the moment.

-- 
Mel Gorman
SUSE Labs
