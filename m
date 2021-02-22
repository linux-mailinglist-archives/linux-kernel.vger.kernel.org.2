Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF78321329
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhBVJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:32:20 -0500
Received: from foss.arm.com ([217.140.110.172]:37130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhBVJbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:31:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78DC6D6E;
        Mon, 22 Feb 2021 01:30:32 -0800 (PST)
Received: from e124901.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E83463F73B;
        Mon, 22 Feb 2021 01:30:30 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:30:34 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com
Subject: Re: [PATCH] sched/pelt: Fix task util_est update filtering
Message-ID: <20210222093034.GB5716@e124901.cambridge.arm.com>
References: <20210216163921.572228-1-vincent.donnefort@arm.com>
 <16e1de11-d221-c572-aec7-4e9a638105a9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e1de11-d221-c572-aec7-4e9a638105a9@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:19:05AM +0100, Dietmar Eggemann wrote:
> On 16/02/2021 17:39, vincent.donnefort@arm.com wrote:
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > 
> > Being called for each dequeue, util_est reduces the number of its updates
> > by filtering out when the EWMA signal is different from the task util_avg
> > by less than 1%. It is a problem for a sudden util_avg ramp-up. Due to the
> > decay from a previous high util_avg, EWMA might now be close enough to
> > the new util_avg. No update would then happen while it would leave
> > ue.enqueued with an out-of-date value.
> 
> (1) enqueued[x-1] < ewma[x-1]
> 
> (2) diff(enqueued[x], ewma[x]) < 1024/100 && enqueued[x] < ewma[x] (*)
> 
> with ewma[x-1] == ewma[x]
> 
> (*) enqueued[x] must still be less than ewma[x] w/ default
> UTIL_EST_FASTUP. Otherwise we would already 'goto done' (write the new
> util_est) via the previous if condition.
> 
> > 
> > Taking into consideration the two util_est members, EWMA and enqueued for
> > the filtering, ensures, for both, an up-to-date value.
> > 
> > This is for now an issue only for the trace probe that might return the
> > stale value. Functional-wise, it isn't (yet) a problem, as the value is
> > always accessed through max(enqueued, ewma).
> 
> Yeah, I remember that the ue.enqueued plots looked weird in these
> sections with stale ue.enqueued values.
> 
> > This problem has been observed using LISA's UtilConvergence:test_means on
> > the sd845c board.
> 
> I ran the test a couple of times on my juno board and I never hit this
> path (util_est_within_margin(last_ewma_diff) &&
> !util_est_within_margin(last_enqueued_diff)) for a test task.
> 
> I can't see how this issue can be board specific? Does it happen
> reliably on sd845c or is it just that it happens very, very occasionally?

This is indeed not board specific. It just happened to be observed on that
one. And even then, it happens every once in a while.

> 
> I saw it a couple of times but always with a (non-test) tasks migrating
> from one CPU to another.
> 
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks!

> 
> [...]
