Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB543AAECC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFQIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFQIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:32:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AEDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:30:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r5so9101814lfr.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDa88QrbH3+rs0XZg8Su0jRogy5CTceMjbXgiQc0o4s=;
        b=D+7+5PiYIhMLfCVkSlVSC6OoOT70wWKAJoEhCbiNDQSRWfX8WfNq0i9poT5F5/nI+N
         SkY2iUdQa+GG6Nm9Bn0UJGsjmzFoV9zU2jyFyZsWjfGY27jwS5FGDfrtS2xOxe8aHqFJ
         4Bjvybb/zoqZBmiNqc89Vv9VEjBYJBSLRoaM2Bza7j9pFAmA9+lUN+Zd9vX5qtDRsWgQ
         i8HkUAlVjh+B4UGDGOdv7kLpv35EQdNElg8Yz7g0Wd8666tuvNEjUvJEdHl9RXq65wsk
         1mv9JEw4/Br+knnLZ6d/57KH0XQpqJqBvizuNmWylipLA0h6qepWZjS0uaxvM4KN4zfT
         X//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDa88QrbH3+rs0XZg8Su0jRogy5CTceMjbXgiQc0o4s=;
        b=n2qgqwKe0frm/vrFDYYcsZc2/wdCY8eKIjCAwpWjv39iJ+y9RcS3udBgCxV0o6dwsb
         MHzKL98zkC3NO7/2r0tcVFF2RPC2846GAa0TJvsC21ZNq9J9ak07nO8AIBodUyNjmxzB
         u/RN3rZh7cefaiJOZHacTVZfw06Xacixv6KRdcYj0sXoiiT/biWnNqnwuZNUdcPYRLYo
         smG74DgUPswWurTpdUMakdVAg8GIeejI+fuHbq7IfV1HQ3+88gsBZpeBNMJag/ODeSA0
         fEiKkfp+0mADqd5tT1C9yz8pICaBrTHK8v93bPKLHk4Phh7JSA1aAkLfbcmIIcBPvv/b
         mEZA==
X-Gm-Message-State: AOAM532iGYwPqxFQVPwCz3uw6rxOw3lQOCl3s01IO1WnVj/GVn+S3G+X
        qlzLx6j7JjyvjSE/3OEXAuQIysSbB2saUx8USSkREHH7cFs=
X-Google-Smtp-Source: ABdhPJxQHchlMVooUL00LUYdR59k92XRLeaInlWorIW1mX5BGT5t0Yr4II+2fVTsfkGc9OBcxglFjlF84jJL9oZ/oBI=
X-Received: by 2002:a05:6512:3b84:: with SMTP id g4mr3203408lfv.277.1623918620363;
 Thu, 17 Jun 2021 01:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210615111611.GH30378@techsingularity.net> <20210615204228.GB4272@worktop.programming.kicks-ass.net>
 <CAKfTPtAZ_Aq_S-O2qh5LPyxExkBq3G0kxh51fT7sSC_z8He4+w@mail.gmail.com> <20210617074401.GL30378@techsingularity.net>
In-Reply-To: <20210617074401.GL30378@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 17 Jun 2021 10:30:09 +0200
Message-ID: <CAKfTPtC8d37ZrXfDF2jkgg=tDPb1qAvFQQGXHhTf9LLR59hd8Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 at 09:44, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jun 16, 2021 at 05:52:25PM +0200, Vincent Guittot wrote:
> > On Tue, 15 Jun 2021 at 22:43, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jun 15, 2021 at 12:16:11PM +0100, Mel Gorman wrote:
> > > > From: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > >
> > > > This is a partial forward-port of Peter Ziljstra's work first posted
> > > > at https://lore.kernel.org/lkml/20180530142236.667774973@infradead.org/.
> > >
> > > It's patches 2 and 3 together, right?
> > >
> > > > His Signed-off has been removed because it is modified but will be restored
> > > > if he says it's still ok.
> > >
> > > I suppose the SoB will auto-magically re-appear if I apply it :-)
> > >
> > > > The patch potentially matters when a socket was multiple LLCs as the
> > > > maximum search depth is lower. However, some of the test results were
> > > > suspiciously good (e.g. specjbb2005 gaining 50% on a Zen1 machine) and
> > > > other results were not dramatically different to other mcahines.
> > > >
> > > > Given the nature of the patch, Peter's full series is not being forward
> > > > ported as each part should stand on its own. Preferably they would be
> > > > merged at different times to reduce the risk of false bisections.
> > >
> > > I'm tempted to give it a go.. anyone object?
> >
> > Just finished running some tests on my large arm64 system.
> > Tbench tests are a mixed between small gain and loss
> >
>
> Same for tbench on three x86 machines I reran tests for
>
> https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/network-tbench/bing2/index.html#tbench4
> Small gains and losses, gains at higher client counts where search depth
>         should be reduced
>
> https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/network-tbench/hardy2/index.html#tbench4
> Mostly gains, one counter-example at 4 clients
>
> https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/network-tbench/marvin2/index.html#tbench4
> Worst by far, 1 client took a major hit for unknown reasons, otherwise
>         mix of gains and losses. I'm not confident that the 1 client
>         results are meaningful because for this machine, there should
>         have been idle cores so the code the patch adjusts should not
>         even be executed.
>
> > hackbench shows significant changes in both direction
> > hackbench -g $group
> >
> > group  tip/sched/core      + this patch
> > 1      13.358(+/- 1.82%)   12.850(+/- 2.21%) +4%
> > 4      4.286(+/- 2.77%)    4.114(+/- 2.25%)  +4%
> > 16     3.175(+/- 0.55%)    3.559(+/- 0.43%)  -12%
> > 32     2.912(+/- 0.79%)    3.165(+/- 0.95%)  -8%
> > 64     2.859(+/- 1.12%)    2.937(+/- 0.91%)  -3%
> > 128    3.092(+/- 4.75%)    3.003(+/-5.18%)   +3%
> > 256    3.233(+/- 3.03%)    2.973(+/- 0.80%)  +8%
>
> Think this is processes and sockets. Of the hackbench results I had,
> this one performed the worst
>
> https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/scheduler-unbound/bing2/index.html#hackbench-process-sockets
> Small gains and losses
>
> https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/scheduler-unbound/hardy2/index.html#hackbench-process-sockets
> Small gains and losses
>
> https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/scheduler-unbound/marvin2/index.html#hackbench-process-sockets
> Small gains and losses
>
> One of the better results for hackbench was processes and pipes
> https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/scheduler-unbound/bing2/index.html#hackbench-process-pipes
> 1-12% gains
>
> For your arm machine, how many logical CPUs are online, what is the level
> of SMT if any and is the machine NUMA?

It's a SMT4 x 28 cores x 2 NUMA nodes = 224 CPUs

>
> Fundamentally though, as the changelog notes "due to the nature of the
> patch, this is a regression magnet". There are going to be examples
> where a deep search is better even if a machine is fully busy or
> overloaded and examples where cutting off the search is better. I think
> it's better to have an idle estimate that gets updated if CPUs are fully
> busy even if it's not a universal win.

Although I agree that using a stall average idle time value of local
is not good, I'm not sure this proposal is better. The main problem is
that we use the avg_idle of the local CPU to estimate how many times
we should loop and try to find another idle CPU. But there is no
direct relation between both. Typically, a short average idle time on
the local CPU doesn't mean that there are less idle CPUs and that's
why we have a mix a gain and loss

>
> --
> Mel Gorman
> SUSE Labs
