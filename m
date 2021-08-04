Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E453DFF63
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhHDK0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:26:31 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:60327 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235383AbhHDK03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:26:29 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 0E70ACAD34
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:26:16 +0100 (IST)
Received: (qmail 16267 invoked from network); 4 Aug 2021 10:26:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Aug 2021 10:26:15 -0000
Date:   Wed, 4 Aug 2021 11:26:13 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        yangyicong <yangyicong@huawei.com>
Subject: Re: [PATCH 8/9] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20210804102613.GC6464@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
 <20210726102247.21437-9-mgorman@techsingularity.net>
 <9dde989df06b483790cc24dc7670a919@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <9dde989df06b483790cc24dc7670a919@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:41:13AM +0000, Song Bao Hua (Barry Song) wrote:
> Hi Mel, Aubrey,
> A similar thing Yicong and me has discussed is having a mask or a count for
> idle cores. And then we can only scan idle cores in this mask in
> select_idle_cpu().
> 

Either approach would require a lot of updates.

> A obvious problem is that has_idle_cores is a bool, it can seriously lag
> from the real status. I mean, after system enters the status without idle
> cores, has_idle_cores could be still true.
> 

True.

> Right now, we are setting has_idle_cores to true while cpu enters idle
> and its smt sibling is also idle. But we are setting has_idle_cores to
> false only after we scan all cores in a llc.
> 
> So we have thought for a while to provide an idle core mask. But never
> really made a workable patch.
> 
> Mel's patch7/9 limits the number of cores which will be scanned in
> select_idle_cpu(), it might somehow alleviate the problem we redundantly
> scan all cores while we actually have no idle core even has_idle_cores
> is true.
> 

I prototyped a patch that tracked the location of a known idle core and
use it as a starting hint for a search. It's cleared if the core is
selected for use. Unfortunately, it was not a universal win so was
dropped for the moment but either way, improving the accurate of
has_idle_cores without being too expensive would be niuce.

> However, if we can get idle core mask, it could be also good to
> select_idle_core()? Maybe after that, we don't have to enforce
> proportional scan limits while scanning for an idle core?
> 

To remove the limits entirely, it would have to be very accurate and
it's hard to see how that can be done without having a heavily updated
shared cache line.

-- 
Mel Gorman
SUSE Labs
