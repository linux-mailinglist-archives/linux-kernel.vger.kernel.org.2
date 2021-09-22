Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C200414AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhIVNoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:44:22 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:47051 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232688AbhIVNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:44:19 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 94C471C48F4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:42:48 +0100 (IST)
Received: (qmail 12818 invoked from network); 22 Sep 2021 13:42:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Sep 2021 13:42:48 -0000
Date:   Wed, 22 Sep 2021 14:42:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [sched/fair]  56498cfb04:  netperf.Throughput_tps -5.4%
 regression
Message-ID: <20210922134247.GY3959@techsingularity.net>
References: <20210912153447.GG25450@xsang-OptiPlex-9020>
 <20210922124400.GQ4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210922124400.GQ4323@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 02:44:00PM +0200, Peter Zijlstra wrote:
> On Sun, Sep 12, 2021 at 11:34:47PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed a -5.4% regression of netperf.Throughput_tps due to commit:
> > 
> > 
> > commit: 56498cfb045d7147cdcba33795d19429afcd1d00 ("sched/fair: Avoid a second scan of target in select_idle_cpu")
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> Mel, was this in line with your own benchmarks?

UDP-RR was not run but I could add it for future reference as a
socket-based-ping-pong test. However, it would not be equivalent to lkp
as I only run one client/server.

For UDP_STREAM with single client the significant differences reported
were;

machine1:	+1.07% to +1.54% depending on packet size
machine2:	-1.4%  to +0.9%
machine3:	+1.5%  to -2.46%
machine4:	+1.16% to +1.64%
machine5:	-1.59% to +1.23%
machine6:	-2.10% to +1.83%

So it was a mix of small gains and some regressions with more gains than
losses. As netperf is running localhost, it can be a bit unreliable and
other workloads showed more gains than losses. On machine 2, total system
CPU usage went from 1195.21 seconds to 1197.52 seconds but activities like
context switches and interrupt deliveries were broadly similar. There
were differences in the total number of slab pages used but roughly
similar trends to probably reflect the system starting state more than
anything else.

On balance, I concluded that rescanning target is wasteful and that while
there might be slight variances, they would be difficult to consistent
reproduce. The largest concern is that skipping target means that one
additional new rq is potentially examined. That would incur a small
penalty if it was a wasteful search.

For the LKP test, the nr_threads are 50% so I expect with two sockets,
the machine is fully loaded and would be vulnerable to load-balancing
artifacts as client and server threads move around. Hence, I ended up
thinking that this result was likely a false positive.

-- 
Mel Gorman
SUSE Labs
