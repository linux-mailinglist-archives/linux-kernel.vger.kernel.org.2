Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5896D333B22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhCJLL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCJLLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:11:49 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD3DC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 03:11:49 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id j3so12628155qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 03:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBP2GEZI3062CK3RG/0Avaxq/S738d2MOV4Y7h3mfVw=;
        b=MDVZDolo3hMDGElR9gYwsHVcjFsmRO3t8AVDhLv5+hIxDO8gdYor8Ep39YwT3miWJa
         Jau5zPxuHj3XHaMwA0+3XSEme/FQ0K8rYJjJCMhIFwi1Plhy4gposjRwZqMsaE6XMC4G
         jm6zsSgNvU8HyUMtYkQQTISef+O/fSUTf+UEULQTn6+pSr6UxWWv1qzmmUF7TkM+burx
         r+SKcvnxBGxBRxJMK7E+paneAbGU01HDklevb14VHnYtaUO0YwJkc/IQ3PvF/rzwX5uW
         YpUBYCUR14qtkK/LTIVrP5bnOKqeyQRpLU6WOLJ0kVOFrrrpxLJlgYfiNx9i5BItVgj1
         MKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBP2GEZI3062CK3RG/0Avaxq/S738d2MOV4Y7h3mfVw=;
        b=JqjIX+NovuKCfpkyz6JYXQh/awdtkZBN+mS42blFFgsYRy8+icMLrqP1d6Uz1NRbVP
         z0GJJSLQYrNonuv5bFfnB6IKYSfoOI+BYIGNF68kcqFRJwcFmepBpFnHoeWxOVx95xcr
         dplhQ33qB0zgwcKP4vdYzyZPW2cmm2Ao6aUvRmuN86VUu0htpMvR/l+Snnf1BtGvJNvo
         S91toAvWxZJTU59bF4mYmJJsoQkBWAmdcjOXMXYnrN/45yRvQITZRuUv38BEKDL3wCDm
         ECuhG8KuyTMQMqrVqqT3exuhn8Mqy3kXCRi1HVznul3gsKwKeYrWcvxn2GVP3uwKqJME
         R6OQ==
X-Gm-Message-State: AOAM531z43UzPo3pe03Mwv5V06I8IVHVj1sBlO9/JJcTVFljRCxvEzQ5
        TdmVnEe4hMC0LPa+iAQBpl0JLUuc9HppU4EuzhnRWQ==
X-Google-Smtp-Source: ABdhPJw2Kp9xNh/BKGt/Ix1FbVQx25DR2PTHj700yxNyTh0TcRUPjwqG1g8leB9Y+f1j9coeVkWfKRkH6wIDOUeY548=
X-Received: by 2002:ac8:5c81:: with SMTP id r1mr2102466qta.209.1615374708081;
 Wed, 10 Mar 2021 03:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
 <20210209131719.1193428-1-odin@uged.al> <6112D83C-9A5F-4317-8AF1-DF49132135FB@linux.alibaba.com>
In-Reply-To: <6112D83C-9A5F-4317-8AF1-DF49132135FB@linux.alibaba.com>
From:   Odin Ugedal <odin@ugedal.com>
Date:   Wed, 10 Mar 2021 12:11:19 +0100
Message-ID: <CAFpoUr0jqE9T-PohSDNXuTacvK1=2F9-hbTGszcL0t28vbyehQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] sched/fair: Burstable CFS bandwidth controller
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     Odin Ugedal <odin@uged.al>, Benjamin Segall <bsegall@google.com>,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>, mgorman@suse.de,
        mingo@redhat.com, pauld@redhead.com, peterz@infradead.org,
        Paul Turner <pjt@google.com>, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> If there are cases where the "start bandwidth" matters, I think there is need to expose the
> "start bandwidth" explicitly too. However, I doubt the existence of such cases from my view
> and the two examples above.

Yeah, I don't think there will be any cases where users will be
"depending" on having burst available,
so I agree in that sense.

> In my thoughts, this patchset keeps cgroup usage within the quota in the longer term, and allows
> cgroup to respond to a burst of work with the help of a reasonable burst buffer. If quota is set correctly
> above average usage, and enough burst buffer is set to meet the needs of bursty work. In this
> case, it makes no difference whether this cgroup runs with 0 start bandwidth or all of it.
> Thus I used sysctl_sched_cfs_bw_burst_onset_percent to decided the start bandwidth
> to leave some convenience here. If this sysctl interface is confusing, I wonder whether it
> is a good idea not to expose this interface.
>
> For the first case mentioned above, if Kubernet users care the "start bandwidth" for process startup,
> maybe it is better to give all of it rather than a part?

Yeah, I am a bit afraid there will be some confusion, so not sure if
the sysctl is the best way to do it.

But I would like feedback from others to highlight the problem as
well, that would be helpful. I think a simple "API"
where you get 0 burst or full burst on "set" (the one we decide on)
would be best to avoid unnecessary complexity.

Start burst when starting up a new process in a new cgroup might be
helpful, so maybe that is a vote for
full burst? However, in long term that doesn't matter, so 0 burst on
start would work as well.

> For the second case with quota changes over time, I think it is important making sure each change works
> long enough to enforce average quota limit. Does it really matter to control "start burst" on each change?

No, I don't think so. Doing so would be another thing to set per
cgroup, and that would just clutter the api
more than necessary imo., since we cannot come up with any real use cases.

> It is an copy of runtime at period start, and used to calculate burst time during a period.
> Not quite remaining_runtime_prev_period.

Ahh, I see, I misunderstood the code. So in a essence it is
"runtime_at_period_start"?

> Yeah, there is the updating problem. It is okey not to expose cfs_b->runtime then.

Yeah, I think dropping it all together is the best solution.


> This comment does not mean any loss any unnecessary throttle for present cfsb.
> All this means is that all quota refilling that is not done during timer stop should be
> refilled on timer start, for the burstable cfsb.
>
> Maybe I shall change this comment in some way if it is misleading?

I think I formulated my question badly. The comment makes sense, I am
just trying to compare how "start_cfs_bandwidth"
works after your patch compared to how it works currently. As I
understand, without this patch "start_cfs_bandwidth" will
never refill runtime, while with your patch, it will refill even when
overrun=0 with burst disabled. Is that an intended change in
behavior, or am I not understanding the patch?


On another note, I have also been testing this patch, and I am not
able to reproduce your schbench results. Both with and without burst,
it gets the same result, and no nr_throttled stays at 0 (tested on a
32-core system). Can you try to rerun your tests with the mainline
to see if you still get the same results? (Also, I see you are running
with 30 threads. How many cores do your test setup have?). To actually
say that the result is real, all cores used should maybe be
exclusively reserved as well, to avoid issues where other processes
cause a
spike in latency.


Odin
