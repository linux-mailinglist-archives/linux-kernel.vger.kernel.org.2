Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00C236D9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbhD1OrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:47:01 -0400
Received: from foss.arm.com ([217.140.110.172]:44400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbhD1Oq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2766DED1;
        Wed, 28 Apr 2021 07:46:14 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E442F3F694;
        Wed, 28 Apr 2021 07:46:12 -0700 (PDT)
Date:   Wed, 28 Apr 2021 15:46:10 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <20210428144609.GB71893@e120877-lin.cambridge.arm.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg7pfGKhzlMrXqC@google.com>
 <20210422153644.GA316798@e124901.cambridge.arm.com>
 <YILydL1QDxvuiFde@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YILydL1QDxvuiFde@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > On the Pixel4, I used rt-app to generate a task whom duty cycle is getting
> > higher for each phase. Then for each rt-app task placement, I measured how long
> > find_energy_efficient_cpu() took to run. I repeated the operation several
> > times to increase the count. Here's what I've got: 
> > 
> > ┌────────┬─────────────┬───────┬────────────────┬───────────────┬───────────────┐
> > │ Phase  │ duty-cycle  │  CPU  │     w/o LUT    │    w/  LUT    │               │
> > │        │             │       ├────────┬───────┼───────┬───────┤      Diff     │
> > │        │             │       │ Mean   │ count │ Mean  │ count │               │
> > ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> > │   0    │    12.5%    │ Little│ 10791  │ 3124  │ 10657 │ 3741  │  -1.2% -134ns │
> > ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> > │   1    │    25%      │  Mid  │ 2924   │ 3097  │ 2894  │ 3740  │  -1%  -30ns   │
> > ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> > │   2    │    37.5%    │  Mid  │ 2207   │ 3104  │ 2162  │ 3740  │  -2%  -45ns   │
> > ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> > │   3    │    50%      │  Mid  │ 1897   │ 3119  │ 1864  │ 3717  │  -1.7% -33ns  │
> > ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> > │        │             │  Mid  │ 1700   │  396  │ 1609  │ 1232  │  -5.4% -91ns  │
> > │   4    │    62.5%    ├───────┼────────┼───────┼───────┼───────┼───────────────┤
> > │        │             │  Big  │ 1187   │ 2729  │ 1129  │ 2518  │  -4.9% -58ns  │
> > ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> > │   5    │    75%      │  Big  │  984   │ 3124  │  900  │ 3693  │  -8.5% -84ns  │
> > └────────┴─────────────┴───────┴────────┴───────┴───────┴───────┴───────────────┘
> 
> Thanks for that. Do you have the stddev handy?

I do, it shows that the distribution is quite wide. I also have a 95% confidence
interval, as follow:
                            w/o LUT               W/ LUT

	               Mean        std         Mean         std

Phase0:            10791+/-79      2262      10657+/-71     2240   [1]
Phase1:            2924 +/-19      529       2894 +/-16     513    [1]
Phase2:            2207 +/-19      535       2162 +/-17     515
Phase3:            1897 +/-18      504       1864 +/-17     515    [1]
Phase4:   Mid CPU  1700 +/-46      463       1609 +/-26     458
Phase4:   Big CPU  1187 +/-15      407       1129 +/-15     385
Phase5:            987  +/-14      395       900  +/-12     365 


[1] I included these results originally as the p-value for the test I used
showed we can reject confidently the null hypothesis that the 2 samples are
coming from the same distribution... However, the confidence intervals for
the mean overlaps. It is then complicated to conclude for those phases.

Interestingly it shows the distribution is slightly more narrow with the LUT. I
suppose due to the fact the LUT is less relying on caches than the original table
walk is.

> 
> > Notice:
> > 
> >   * The CPU column describes which CPU ran the find_energy_efficient()
> >     function.
> > 
> >   * I modified my patch so that no inefficient OPPs are reported. This is to
> >     have a fairer comparison between the original table walk and the lookup
> >     table.
> 
> You mean to avoid the impact of the frequency selection itself? Maybe
> pinning the frequencies in the cpufreq policy could do?

Yes, it could have worked too, maybe it would have even been better, as it
would have removed the running frequency variations.

> 
> > 
> >   * I removed from the table results that didn't have enough count to be
> >     statistically significant.
> 
> 
> Anyways, this looks like a small but consistent gain throughout, so it's a
> win for the LUT :)
> 
> Thanks,
> Quentin
