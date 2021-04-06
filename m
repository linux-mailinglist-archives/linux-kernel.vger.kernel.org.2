Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F263355821
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbhDFPhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:37:36 -0400
Received: from foss.arm.com ([217.140.110.172]:44912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232762AbhDFPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:37:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B00E1FB;
        Tue,  6 Apr 2021 08:37:23 -0700 (PDT)
Received: from [192.168.1.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D22C3F792;
        Tue,  6 Apr 2021 08:37:20 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] sched/fair: Introduce a CPU capacity comparison
 helper
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210401193006.3392788-1-valentin.schneider@arm.com>
 <20210401193006.3392788-4-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b03ae299-0b0c-3090-4d16-edbf2bdd5edb@arm.com>
Date:   Tue, 6 Apr 2021 17:37:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210401193006.3392788-4-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2021 21:30, Valentin Schneider wrote:
> During load-balance, groups classified as group_misfit_task are filtered
> out if they do not pass
> 
>   group_smaller_max_cpu_capacity(<candidate group>, <local group>);
> 
> which itself employs fits_capacity() to compare the sgc->max_capacity of
> both groups.
> 
> Due to the underlying margin, fits_capacity(X, 1024) will return false for
> any X > 819. Tough luck, the capacity_orig's on e.g. the Pixel 4 are
> {261, 871, 1024}. If a CPU-bound task ends up on one of those "medium"
> CPUs, misfit migration will never intentionally upmigrate it to a CPU of
> higher capacity due to the aforementioned margin.
> 
> One may argue the 20% margin of fits_capacity() is excessive in the advent
> of counter-enhanced load tracking (APERF/MPERF, AMUs), but one point here
> is that fits_capacity() is meant to compare a utilization value to a
> capacity value, whereas here it is being used to compare two capacity
> values. As CPU capacity and task utilization have different dynamics, a
> sensible approach here would be to add a new helper dedicated to comparing
> CPU capacities.
> 
> While at it, replace group_smaller_{min, max}_cpu_capacity() with
> comparisons of the source group's min/max capacity and the destination
> CPU's capacity.

IMHO, you haven't mentioned why you replace local sched group with dst
CPU. I can see that only the capacity of the dst CPU makes really sense
here. Might be worth mentioning in the patch header why. There is some
of it in v3 6/7 but that's a different change.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]
