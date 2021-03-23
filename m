Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7634681C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhCWSvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:51:43 -0400
Received: from foss.arm.com ([217.140.110.172]:50624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhCWSvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:51:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3636E1042;
        Tue, 23 Mar 2021 11:51:31 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA2513F718;
        Tue, 23 Mar 2021 11:51:29 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH v3 6/7] sched/fair: Filter out locally-unsolvable misfit imbalances
In-Reply-To: <CAKfTPtDiNKpVWM4Tw2z+z6g+G1nf5SK5wbdsdnyAhAK5=q+OBg@mail.gmail.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com> <20210311120527.167870-7-valentin.schneider@arm.com> <CAKfTPtAZmOp+c4LR0jKSP=cSUOnu0O_ubGUMnpEKh-cPc89qZw@mail.gmail.com> <87v99srztf.mognet@arm.com> <CAKfTPtDiNKpVWM4Tw2z+z6g+G1nf5SK5wbdsdnyAhAK5=q+OBg@mail.gmail.com>
Date:   Tue, 23 Mar 2021 18:51:27 +0000
Message-ID: <87pmzpya8g.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/21 16:19, Vincent Guittot wrote:
> On Mon, 15 Mar 2021 at 20:18, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> As stated the current behaviour is to classify groups as group_misfit_task
>> regardless of the dst_cpu's capacity. When we see a group_misfit_task
>> candidate group misfit task with higher per-CPU capacity than the local
>> group, we don't pick it as busiest.
>>
>> I initially thought not marking those as group_misfit_task was the right
>> thing to do, as they could then be classified as group_fully_busy or
>> group_has_spare. Consider:
>>
>>   DIE [          ]
>>   MC  [    ][    ]
>>        0  1  2  3
>>        L  L  B  B
>>
>>   arch_scale_capacity(L) < arch_scale_capacity(B)
>>
>>   CPUs 0-1 are idle / lightly loaded
>>   CPU2 has a misfit task and a few very small tasks
>>   CPU3 has a few very small tasks
>>
>> When CPU0 is running load_balance() at DIE level, right now we'll classify
>> the [2-3] group as group_misfit_task and not pick it as busiest because the
>> local group has a lower CPU capacity.
>>
>> If we didn't do that, we could leave the misfit task alone and pull some
>> small task(s) from CPU2 or CPU3, which would be a good thing to
>
> Are you sure? the last check in update_sd_pick_busiest() should
> already filter this. So it should be enough to let it be classify
> correctly
>
> A group should be classified as group_misfit_task when there is a task
> to migrate in priority compared to some other groups. In your case,
> you tag it as group_misfit_task but in order to do the opposite, i.e.
> make sure to not select it. As mentioned above, this will be filter in
> the last check in update_sd_pick_busiest()
>

This hinges on sgc->min_capacity, which might be influenced by a CPU in the
candidate group being severely pressured by IRQ / thermal / RT / DL
pressure. That said, you have a point in that this check and the one in
find_busiest_queue() catches most scenarios I can think of.

Let me ponder about this some more, and if throw it at the test
infrastructure monster if I go down that route.
