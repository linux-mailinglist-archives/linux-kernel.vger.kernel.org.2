Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A8A32BCCB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359509AbhCCOsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:48:53 -0500
Received: from foss.arm.com ([217.140.110.172]:44942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1843017AbhCCKX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B47AED6E;
        Wed,  3 Mar 2021 02:06:40 -0800 (PST)
Received: from e124901.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A3FD3F73B;
        Wed,  3 Mar 2021 02:06:39 -0800 (PST)
Date:   Wed, 3 Mar 2021 10:06:40 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/pelt: Fix task util_est update filtering
Message-ID: <20210303100640.GA12437@e124901.cambridge.arm.com>
References: <20210225165820.1377125-1-vincent.donnefort@arm.com>
 <YDi0Ip11fpOubQqz@hirez.programming.kicks-ass.net>
 <b1471e3a-e8c5-3ab4-5db4-0084612ade55@arm.com>
 <YD0ik65KwwU5R4Rv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD0ik65KwwU5R4Rv@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 06:21:23PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 01, 2021 at 05:34:09PM +0100, Dietmar Eggemann wrote:
> > On 26/02/2021 09:41, Peter Zijlstra wrote:
> > > On Thu, Feb 25, 2021 at 04:58:20PM +0000, Vincent Donnefort wrote:
> > >> +#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
> > >> +
> > >>  /*
> > >> - * Check if a (signed) value is within a specified (unsigned) margin,
> > >> + * Check if a (signed) value is within the (unsigned) util_est margin,
> > >>   * based on the observation that:
> > >>   *
> > >>   *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
> > >>   *
> > >> - * NOTE: this only works when value + maring < INT_MAX.
> > >> + * NOTE: this only works when value + UTIL_EST_MARGIN < INT_MAX.
> > >>   */
> > >> -static inline bool within_margin(int value, int margin)
> > >> +static inline bool util_est_within_margin(int value)
> > >>  {
> > >> -	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
> > >> +	return ((unsigned int)(value + UTIL_EST_MARGIN - 1) <
> > >> +		(2 * UTIL_EST_MARGIN - 1));
> > >>  }
> > > 
> > >> -	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
> > >> +	if (util_est_within_margin(last_ewma_diff)) {
> > > 
> > > What was the purpose of this change? What was a generic helper is now
> > > super specific.
> > 
> > I guess because it was only ever used in util_est for last_ewma_diff.
> > 
> > It's now used for last_ewma_diff and last_enqueued_diff, still only for
> > util_est though and both times with the same margin
> > (SCHED_CAPACITY_SCALE / 100)).
> > 
> > Vincent D. should be back on Wed from hols.
> 
> Fair enough; I've un-done it but kept the rest of the patch.

Indeed I was off for couple of days. Apologies for the delay and thanks for
applying the patch.

-- 
Vincent
