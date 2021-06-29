Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74693B6DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 06:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhF2FAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 01:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhF2FAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 01:00:21 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 21:57:54 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id c8so22445106ybq.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 21:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQl18TLUkr2nRKyC1vSxbS/UF4p2F5gHfYaFUi3T+n0=;
        b=oa+RMAZJc9GfX0EhzdE4o3cLkjNhncy1FDkP9Jufvd9x5CqaKqV++FNnako5tDhYdi
         0/2Nlyquzq/xT+qvJsGAfkxwz9hFCa07GV7PsqePF3w4qwgMYLzPfPjjZSVhd2HKJOE+
         fAvHdbRoBLUVCtvGicKOyoEYhHYFHPfGYu2cchyM4sInBGBjZByB8DtKuvr1sjAxqz6Q
         WCJnmmvjCZb4zg8I8Eh/+f6/AwxO3VBAtD7ERiV9SR4edRPgQ4dN/FFfBFHVsWBSKo4j
         vTJ8I1ziM67ADXMJc+fOCzB+UYttQL4K90NFjD2VhfVjksbxLM8PotwVxrN567r+o31b
         Lasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQl18TLUkr2nRKyC1vSxbS/UF4p2F5gHfYaFUi3T+n0=;
        b=gbMqC1ngEF7vojUKmJ+9lQm4dEDkhAzio17vRWMUXZIVWuPjcZzOX1hpHAWvoSdXLM
         6b7FARSiITySCaJkcFBfF7W97A2MlcqgkQhSDqjxL+oEc2dm/WWeyoiS3VQVRCt3UZpC
         YtgiXIK9Yz41RHvs7RXkJ+2pJtZcXn+3Osl/Gfo7pizbLfk0x8Twd6o3hmxkzP4lhmvz
         3IsfvrBd1PAAt1IRbBCDqu+PyIib1EZ+aDIG+wREqYFbgHhpM7n2AIwRM/ZQUPt5ieke
         LJhKe4ZGJVkhLKTrhglSyN5U4zmb6rOEFnU+Z+lPxsRsyn3vFaEjCb9tPc6CNPSVcd+N
         Chjg==
X-Gm-Message-State: AOAM533GFdBR0nISP2oS9Nu1GE2BzIqumLHxzXzft22ntt8hRdCbO5Lp
        8/QuU3fFRhvtDSZ635upxZUe/dc/Ye9QFM1DHBhraA==
X-Google-Smtp-Source: ABdhPJz/VwtV/M6UVVx0zhZJBKuBd80vzBt37+/nIC7cK2jztcvIpxJ0grp0Ws9MxGsZQN0V/ryHpL49vA2HBqE9Tzk=
X-Received: by 2002:a5b:7c4:: with SMTP id t4mr25331717ybq.368.1624942673533;
 Mon, 28 Jun 2021 21:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210608231132.32012-1-joshdon@google.com> <YMobzbLecaFYuLtq@slm.duckdns.org>
 <CABk29NtcRUwskBjrvLKkEKQ0hpNPSrdzrGAGZy+bHSfnznOUSg@mail.gmail.com> <YNb6CL6Q9CJnbB2R@mtj.duckdns.org>
In-Reply-To: <YNb6CL6Q9CJnbB2R@mtj.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 28 Jun 2021 21:57:42 -0700
Message-ID: <CABk29NtqZH8nJ1NGuBVisGDBJxAK0948vRau7RhYA4O_bvJ-ww@mail.gmail.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 2:57 AM Tejun Heo <tj@kernel.org> wrote:
[snip]
>
> Would you care to share some concrete use cases?
>
> Thank you.
>
> --
> tejun

Sure thing, there are two use cases we've found compelling:

1. On a machine, different users are given their own top-level cgroup
(configured with an appropriate number of shares). Each user is free
to spawn any threads and create any additional cgroups within their
top-level group.
Some users would like to run high priority, latency-sensitive work
(for example, responding to an RPC) as well as some batch tasks (ie.
background work such as data manipulation, transcoding, etc.) within
their cgroup. The batch tasks should interfere minimally with the high
priority work. However, it is still desired that this batch work be
considered the same as the high priority work vs the jobs of some
other user on the machine.

To achieve this, the user sets up two sub-cgroups, one of which is
marked as idle. The idle cgroup will always be preempted on wakeup of
a task in the other sub-cgroup (but not a wakeup of another user's
task). This is not possible with the per-task SCHED_IDLE setting.
Cgroup shares/weight alone is also not as strong as SCHED_IDLE.

2. We can create a top-level idle cgroup in which we place users who
want to run some best-effort work (ie. some long running
computations). Since it is the top-level cgroup that is marked idle,
any other task on the machine will always preempt something running
within the top-level idle cgroup. We can also easily maintain the
relative weights between different users within the idle group.

This top-level idle group allows for soaking otherwise unused cycles,
and offers cheap machine quota for users who have latency-tolerant
jobs.
