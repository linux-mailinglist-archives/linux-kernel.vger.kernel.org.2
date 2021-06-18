Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A844B3AD2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhFRTZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230433AbhFRTZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624044174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3ZW59nW/WyoTacwt3Dz2q15uu3UXU++wAjCRWyOYFw=;
        b=CpsDepTmbUtkZgQuRpkLlvjtiJxzSvj1BgAu5SGYQs4kRsXXMClb1JKME00kHZOwAtxtzF
        aQl8q+eLdttQu39ya2/lQQotmSdJhBWqh3TSyhmH8pHBxUy10NsGaYc8ZNUIyVLcdE4S54
        kBe12tSiRTJXrqBPIuQR5qPt0kbw9Vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-BrrcNyV5PeiR_UGZMXRblQ-1; Fri, 18 Jun 2021 15:22:52 -0400
X-MC-Unique: BrrcNyV5PeiR_UGZMXRblQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 848F0800C78;
        Fri, 18 Jun 2021 19:22:51 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39DAF17B4C;
        Fri, 18 Jun 2021 19:22:43 +0000 (UTC)
Date:   Fri, 18 Jun 2021 15:22:41 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
Message-ID: <YMzygXBOLT40qL+v@lorien.usersys.redhat.com>
References: <20210615111611.GH30378@techsingularity.net>
 <20210615204228.GB4272@worktop.programming.kicks-ass.net>
 <20210616090314.GJ30378@techsingularity.net>
 <YMtjvF0en9NjIspl@lorien.usersys.redhat.com>
 <20210617154006.GQ30378@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210617154006.GQ30378@techsingularity.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 04:40:06PM +0100 Mel Gorman wrote:
> On Thu, Jun 17, 2021 at 11:01:16AM -0400, Phil Auld wrote:
> > > Thanks, so far no serious objection :)
> > > 
> > > The latest results as I see them have been copied to
> > > https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/dashboard.html
> > > They will move from here if the patch is accepted to 5-assembly replacing
> > > 3-perf-test. This naming is part of my workflow for evaluating topic
> > > branches separetly and then putting them together for another round
> > > of testing.
> > > 
> > > NAS shows small differences but NAS would see limited impact from the
> > > patch. Specjbb shows small losses and some minor gains which is unfortunate
> > > but the workload tends to see small gains and losses all the time.
> > > redis is a mixed bag but has some wins. hackbench is the main benefit
> > > because it's wakeup intensive and tends to overload machines where deep
> > > searches hurt.
> > > 
> > > There are other results in there if you feel like digging around
> > > such as sched-core tested with no processes getting tagged with prctl
> > > https://beta.suse.com/private/mgorman/melt/v5.13-rc5/5-assembly/sched/sched-schedcore-v1r2/html/dashboard.html
> > >
> > 
> > Thanks for the links. It's cool to see what your results dashboard looks like.
> > It's really small, what are you plotting in those heat maps?
> > 
> > It's hard for me to publish the results that come from our testing (web based
> > on intranet) but we don't see any major differences with this patch.  There
> > are some gains here and there mostly balanced by some loses.  Overall it comes
> > out basically as a wash across our main performance test workload.
> > 
> 
> Ok, that's unfortunate. It's also somewhat surprising but then again, I
> don't know what tests were executed.

Yes, I know, sorry. I get these really nice reports but they're hard to
summarize in text :)

The testing consists of NAS (mostly C, some D), stress-ng, libmicro, linpack
and stream, specjvm2008, specjbb2005 and a few others across a range of (x86_64)
hardware. 

From libmicro there was these 2 which stand out

exit_100 	     52584      66975 [  -27.4%]
exit_100_nolibc      46831      57395 [  -22.6%]

Then some scattered gain and loss in the under +/-10% range.
That's on a 2-node Rome.  It's a bit worse on a 8-node Rome
but with libmicro it's a few nsecs here or there.


Here are some pieces from the summary page I pulled out and trimmed as an example:
kernel                            testcase              system           top % change
5.13.0_rc5.idle_aging    NASParallel-2_NUMA_nodes      gold-2s-b       NASParallel_ua_C_x: 4%
                                                                       NASParallel_sp_C_x: -4%
	
5.13.0_rc5.idle_aging    NASParallel-2_NUMA_nodes      amd-epyc2-rome  NASParallel_sp_C_x: 6%
					    			       NASParallel_sp_C_x: -10%
	
5.13.0_rc5.idle_aging    LinpackAndStream-2_NUMA_nod…  amd-epyc2-rome  Linpack_stream_default: 4%
							      	       Linpack_linpackd_default: -11%
	
5.13.0_rc5.idle_aging    LinpackAndStream-2_NUMA_nod…  gold-2s-b       Linpack_linpacks_default: 7%
                                                                       Linpack_linpackd_default: -2%

5.13.0_rc5.idle_aging    stress-ng-1_NUMA_nodes        gold-1s         STRESSngTest_getdent: 11%
							      	       STRESSngTest_madvise: -15%

5.13.0_rc5.idle_aging    Intel_Linpack-8_NUMA_nodes    gold-4s-b       IntelLinpack_default: 12%
							      	       IntelLinpack_single: -12%

The "gold"s are Intel based.

As I said, the perf team reported no real difference one way or the other.
From their perspective this patch is basically neutral.

> 
> > It'll be interesting to see if it effects a sensitive, proprietary perf test
> > suite from a European company with a 3 letter name :)
> > 
> 
> I don't think it's worth the effort if it's failing microbenchmarks at
> the moment.

Fair enough. I'm sensitive to this one because it can be a real pain to track down minor
trade-off differences. And I believe you have been there too...


Cheers,
Phil

> 
> -- 
> Mel Gorman
> SUSE Labs
> 

-- 

