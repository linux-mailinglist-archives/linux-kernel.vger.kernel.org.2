Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1DD360B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhDOOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:12:39 -0400
Received: from foss.arm.com ([217.140.110.172]:47200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232774AbhDOOMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:12:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7586106F;
        Thu, 15 Apr 2021 07:12:14 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FA103F694;
        Thu, 15 Apr 2021 07:12:13 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:12:08 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <20210415141207.GA391924@e120877-lin.cambridge.arm.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg7pfGKhzlMrXqC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHg7pfGKhzlMrXqC@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 01:12:05PM +0000, Quentin Perret wrote:
> Hi Vincent,
> 
> On Thursday 08 Apr 2021 at 18:10:29 (+0100), Vincent Donnefort wrote:
> > Some SoCs, such as the sd855 have OPPs within the same performance domain,
> > whose cost is higher than others with a higher frequency. Even though
> > those OPPs are interesting from a cooling perspective, it makes no sense
> > to use them when the device can run at full capacity. Those OPPs handicap
> > the performance domain, when choosing the most energy-efficient CPU and
> > are wasting energy. They are inefficient.
> > 
> > Hence, add support for such OPPs to the Energy Model, which creates for
> > each OPP a performance state. The Energy Model can now be read using the
> > regular table, which contains all performance states available, or using
> > an efficient table, where inefficient performance states (and by
> > extension, inefficient OPPs) have been removed.
> > 
> > Currently, the efficient table is used in two paths. Schedutil, and
> > find_energy_efficient_cpu(). We have to modify both paths in the same
> > patch so they stay synchronized. The thermal framework still relies on
> > the original table and hence, DevFreq devices won't create the efficient
> > table.
> > 
> > As used in the hot-path, the efficient table is a lookup table, generated
> > dynamically when the perf domain is created. The complexity of searching
> > a performance state is hence changed from O(n) to O(1). This also
> > speeds-up em_cpu_energy() even if no inefficient OPPs have been found.
> 
> Interesting. Do you have measurements showing the benefits on wake-up
> duration? I remember doing so by hacking the wake-up path to force tasks
> into feec()/compute_energy() even when overutilized, and then running
> hackbench. Maybe something like that would work for you?

I'll give a try and see if I get improved numbers.

> 
> Just want to make sure we actually need all that complexity -- while
> it's good to reduce the asymptotic complexity, we're looking at a rather
> small problem (max 30 OPPs or so I expect?), so other effects may be
> dominating. Simply skipping inefficient OPPs could be implemented in a
> much simpler way I think.

I could indeed just skip the perf state if marked as ineffective. But the idea
was to avoid bringing another for loop in this hot-path.

Also, not covered by this patch but probably we could get rid of the EM
complexity limit as the table resolution is way faster with this change.

> 
> Thanks,
> Quentin
