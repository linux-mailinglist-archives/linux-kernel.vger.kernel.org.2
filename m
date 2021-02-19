Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2499931F73F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhBSKUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:20:05 -0500
Received: from foss.arm.com ([217.140.110.172]:32838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhBSKUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:20:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5F79D6E;
        Fri, 19 Feb 2021 02:19:16 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C73F3F694;
        Fri, 19 Feb 2021 02:19:15 -0800 (PST)
Subject: Re: [PATCH] sched/pelt: Fix task util_est update filtering
To:     vincent.donnefort@arm.com, peterz@infradead.org,
        tglx@linutronix.de, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com
References: <20210216163921.572228-1-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <16e1de11-d221-c572-aec7-4e9a638105a9@arm.com>
Date:   Fri, 19 Feb 2021 11:19:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210216163921.572228-1-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 17:39, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> Being called for each dequeue, util_est reduces the number of its updates
> by filtering out when the EWMA signal is different from the task util_avg
> by less than 1%. It is a problem for a sudden util_avg ramp-up. Due to the
> decay from a previous high util_avg, EWMA might now be close enough to
> the new util_avg. No update would then happen while it would leave
> ue.enqueued with an out-of-date value.

(1) enqueued[x-1] < ewma[x-1]

(2) diff(enqueued[x], ewma[x]) < 1024/100 && enqueued[x] < ewma[x] (*)

with ewma[x-1] == ewma[x]

(*) enqueued[x] must still be less than ewma[x] w/ default
UTIL_EST_FASTUP. Otherwise we would already 'goto done' (write the new
util_est) via the previous if condition.

> 
> Taking into consideration the two util_est members, EWMA and enqueued for
> the filtering, ensures, for both, an up-to-date value.
> 
> This is for now an issue only for the trace probe that might return the
> stale value. Functional-wise, it isn't (yet) a problem, as the value is
> always accessed through max(enqueued, ewma).

Yeah, I remember that the ue.enqueued plots looked weird in these
sections with stale ue.enqueued values.

> This problem has been observed using LISA's UtilConvergence:test_means on
> the sd845c board.

I ran the test a couple of times on my juno board and I never hit this
path (util_est_within_margin(last_ewma_diff) &&
!util_est_within_margin(last_enqueued_diff)) for a test task.

I can't see how this issue can be board specific? Does it happen
reliably on sd845c or is it just that it happens very, very occasionally?

I saw it a couple of times but always with a (non-test) tasks migrating
from one CPU to another.

> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]
