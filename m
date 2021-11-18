Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE000455E64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhKROnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhKROnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:43:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837C8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:40:19 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u3so27086394lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7zz8gOW0spq6SwCj6xdmPi8mKkUZqJzBx7pOfLsS8go=;
        b=eROHSRErai982dsiFR0/iwBghuSftaP5Z4UIvzXIpWbMe0M1az9iiNKVPzEUkbMPPh
         7zgTeIcjWjXBxpWq3G5lr3J467F577/bvKDTiC+kgKmmUPAe8TvwrhJ4rNGCUTdGhAYQ
         aUPyEjwZF+qSH32RX7/XVhfOd7T3X22bSlTFhAqRBVQmxUu1/aUom6JDB2w57X3XjSlJ
         hLJohLPubNFkk/w/kIR1/Hd2JtUKnADUPypYnzTEaSJdcBEFYEt8/Z4w6pM7r87ABele
         5DTeTmA0nNVOC+cf2Ly/sddpKQvhIFX/8jOUZ+hzHqWOOlRJYY9PDWQxHqS126o86Tiw
         IpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zz8gOW0spq6SwCj6xdmPi8mKkUZqJzBx7pOfLsS8go=;
        b=HDTNFh+Gz3WBECMp0JefZM5prhLGUerYcuSHEa8gXLoFew1W9rVnhqkCNasGmWsHHO
         Jek06TT7hj9ssxRFeKmDpd7F6NCc7YqWtWsmrYtzuzg1SSTEcc85Sr+MgyxQXQplCqcw
         HvEvS6+25d+dN+FjLRVIm4IPCbeRRBOjvkwCUkL+d+MlcWWfzaserD5XKJPClGGlABm7
         d9SZFL1gVDbWjmgJcP+FMzMRaUnt5WiqPvdXmAEjtVhnuC+mFxGSLA5rT56pkuBEJyG9
         A4Hi7LvTc6XvCbqpkJecRQLtAEm6RBq2UAzMiWd9LEuKw5K9Wp+pmcWo+iAInNVv3mpe
         bvdA==
X-Gm-Message-State: AOAM531z3TEp/oAdFL/0a6TjbIMY3DyKob3wVY5u4/AC06j7FODmYqSs
        96IiSRtuY7fedMIulIyFuqLKR7GBzvx0uOE/9AbqXQ==
X-Google-Smtp-Source: ABdhPJxq1h2mVE4eCU1xEh6Wt0Dh/zczIcfSsWZBvAddXlhEICnyaBDTBDZZGCBR6UFUC57bNpqOKxCot0QVWS8dikE=
X-Received: by 2002:a05:6512:2292:: with SMTP id f18mr24308379lfu.18.1637246417714;
 Thu, 18 Nov 2021 06:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20211112095857.7016-1-vincent.guittot@linaro.org> <41d0d7cbd3e292eb89b12d27d9beb576be3531bf.camel@linux.intel.com>
In-Reply-To: <41d0d7cbd3e292eb89b12d27d9beb576be3531bf.camel@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 18 Nov 2021 15:40:06 +0100
Message-ID: <CAKfTPtBhf5Wt_tAPhg-vvFMsk-xrPW2KvSqZ7aoGDnf9OE1b-g@mail.gmail.com>
Subject: Re: [PATCH 0/2] avoid spurious blocked load update
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 at 00:48, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Fri, 2021-11-12 at 10:58 +0100, Vincent Guittot wrote:
> > This patchset is a follow up of :
> > https://lore.kernel.org/lkml/20211019123537.17146-1-vincent.guittot@linaro.org/
> >
> > It ensures that newly idle load balance will not kick the update of
> > blocked load if it skips the load balance because avg_idle is too
> > short.
> > It also makes sure that rq->next_balance doesn't go in the past when
> > updated.
> >
> > Tim Chen (1):
> >   sched: sched: Fix rq->next_balance time updated to earlier than
> >     current time
> >
> > Vincent Guittot (1):
> >   sched/fair: skip newidle update stats
> >
> >  kernel/sched/fair.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
>
> Vincent,
>
> Got some data back from the benchmark team.
> To my surprise, the skip_new_idle_update_stats patch
> actually makes things a little worse.
>
>                                         Relative Performance
>                                         (higher better)
> 5.15 rc4 vanilla (cgroup disabled)      100%
> 5.15 rc4 vanilla (cgroup enabled)       96%
> patch v2                                96%
> patch v3                                96%
> patch v3
>         +skip_new_idle_update_stats     93.7%
> patch v3
>         +skip_new_idle_update_stats
>         +Fix rq->next_balance_time      93.7%
>

Yeah, that looks surprising.
patch skip_new_idle_update_stats only ensures that the cpu will not
run an update of the blocked average of idle cpus before entering idle
but outside newidle_balance if it thinks that a task is about to wake
up soon.
The end result is that we run less often
_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE); before
entering idle.

> The cpu utilization actually is the similar compared with
> having just the v3 patch. In both cases they are
> 81% user
> 12% kernel
> 2%  idle
> 5%  waiting for IO
>
>
> Profile on key functions
> in load balancing shows a little more cpu utilization,
> which is unexpected as we are cutting short
> the newidle_balance.
>
> patch v3
>      0.56%          [k] __update_load_avg_cfs_rq
>      0.51%          [k] update_load_avg
>      0.39%          [k] update_blocked_averages
>      0.36%          [k] __update_load_avg_se
>      0.05%          [k] newidle_balance
>
> patch v3 + skip_new_idle_update_stats
>      0.58%          [k] __update_load_avg_cfs_rq
>      0.53%          [k] update_load_avg
>      0.40%          [k] update_blocked_averages
>      0.37%          [k] __update_load_avg_se
>      0.06%          [k] newidle_balance
>
> Context switch frequency is lower by 4% with the skip_new_idle_update_stats
> patch.
>
> Thanks.
>
> Tim
>
