Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD936836F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhDVPhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:37:00 -0400
Received: from foss.arm.com ([217.140.110.172]:52846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237511AbhDVPgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:36:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58E9513A1;
        Thu, 22 Apr 2021 08:36:15 -0700 (PDT)
Received: from e124901.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64653F73B;
        Thu, 22 Apr 2021 08:36:13 -0700 (PDT)
Date:   Thu, 22 Apr 2021 16:36:44 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <20210422153644.GA316798@e124901.cambridge.arm.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg7pfGKhzlMrXqC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHg7pfGKhzlMrXqC@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > As used in the hot-path, the efficient table is a lookup table, generated
> > dynamically when the perf domain is created. The complexity of searching
> > a performance state is hence changed from O(n) to O(1). This also
> > speeds-up em_cpu_energy() even if no inefficient OPPs have been found.
> 
> Interesting. Do you have measurements showing the benefits on wake-up
> duration? I remember doing so by hacking the wake-up path to force tasks
> into feec()/compute_energy() even when overutilized, and then running
> hackbench. Maybe something like that would work for you?
> 
> Just want to make sure we actually need all that complexity -- while
> it's good to reduce the asymptotic complexity, we're looking at a rather
> small problem (max 30 OPPs or so I expect?), so other effects may be
> dominating. Simply skipping inefficient OPPs could be implemented in a
> much simpler way I think.
> 
> Thanks,
> Quentin

On the Pixel4, I used rt-app to generate a task whom duty cycle is getting
higher for each phase. Then for each rt-app task placement, I measured how long
find_energy_efficient_cpu() took to run. I repeated the operation several
times to increase the count. Here's what I've got: 

┌────────┬─────────────┬───────┬────────────────┬───────────────┬───────────────┐
│ Phase  │ duty-cycle  │  CPU  │     w/o LUT    │    w/  LUT    │               │
│        │             │       ├────────┬───────┼───────┬───────┤      Diff     │
│        │             │       │ Mean   │ count │ Mean  │ count │               │
├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
│   0    │    12.5%    │ Little│ 10791  │ 3124  │ 10657 │ 3741  │  -1.2% -134ns │
├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
│   1    │    25%      │  Mid  │ 2924   │ 3097  │ 2894  │ 3740  │  -1%  -30ns   │
├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
│   2    │    37.5%    │  Mid  │ 2207   │ 3104  │ 2162  │ 3740  │  -2%  -45ns   │
├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
│   3    │    50%      │  Mid  │ 1897   │ 3119  │ 1864  │ 3717  │  -1.7% -33ns  │
├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
│        │             │  Mid  │ 1700   │  396  │ 1609  │ 1232  │  -5.4% -91ns  │
│   4    │    62.5%    ├───────┼────────┼───────┼───────┼───────┼───────────────┤
│        │             │  Big  │ 1187   │ 2729  │ 1129  │ 2518  │  -4.9% -58ns  │
├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
│   5    │    75%      │  Big  │  984   │ 3124  │  900  │ 3693  │  -8.5% -84ns  │
└────────┴─────────────┴───────┴────────┴───────┴───────┴───────┴───────────────┘

Notice:

  * The CPU column describes which CPU ran the find_energy_efficient()
    function.

  * I modified my patch so that no inefficient OPPs are reported. This is to
    have a fairer comparison between the original table walk and the lookup
    table.

  * I removed from the table results that didn't have enough count to be
    statistically significant.

-- 
Vincent.
