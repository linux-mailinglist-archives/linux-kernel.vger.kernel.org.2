Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E373558A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbhDFP7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:59:39 -0400
Received: from foss.arm.com ([217.140.110.172]:45270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhDFP7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:59:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F71F1063;
        Tue,  6 Apr 2021 08:59:30 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 220913F792;
        Tue,  6 Apr 2021 08:59:29 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Subject: Re: [PATCH v4 3/3] sched/fair: Introduce a CPU capacity comparison helper
In-Reply-To: <b03ae299-0b0c-3090-4d16-edbf2bdd5edb@arm.com>
References: <20210401193006.3392788-1-valentin.schneider@arm.com> <20210401193006.3392788-4-valentin.schneider@arm.com> <b03ae299-0b0c-3090-4d16-edbf2bdd5edb@arm.com>
Date:   Tue, 06 Apr 2021 16:59:26 +0100
Message-ID: <87h7kjo141.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/21 17:37, Dietmar Eggemann wrote:
> On 01/04/2021 21:30, Valentin Schneider wrote:
>> While at it, replace group_smaller_{min, max}_cpu_capacity() with
>> comparisons of the source group's min/max capacity and the destination
>> CPU's capacity.
>
> IMHO, you haven't mentioned why you replace local sched group with dst
> CPU. I can see that only the capacity of the dst CPU makes really sense
> here. Might be worth mentioning in the patch header why. There is some
> of it in v3 6/7 but that's a different change.
>

Right, some of it got lost in the shuffling. This was a separate change in
v1 (4/8). I can reuse that changelog into:

"""
Also note that comparing capacity extrema of local and source sched_group's
doesn't make much sense when at the day of the day the imbalance will be
pulled by a known env->dst_cpu, whose capacity can be anywhere within the
local group's capacity extrema.

While at it, replace group_smaller_{min, max}_cpu_capacity() with
comparisons of the source group's min/max capacity and the destination
CPU's capacity.
"""

> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> [...]
