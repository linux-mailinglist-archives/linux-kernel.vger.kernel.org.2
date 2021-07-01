Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F773B9970
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 01:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhGAXgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 19:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbhGAXgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 19:36:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86950C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 16:33:51 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d12so7421114pfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=E9l07IxNSgJt9CE4ED2nK8dEUQ3zKcbJc06F5p86Rl0=;
        b=WXM//DJ7dgD9d1YB/uTZEMX3MY/V5Eu+twkQEQL781kragkKcNi2bOA6j93goQnqYp
         jFHqB26a3oOOWHT2vLzGWq22EX+cNBvt2qdyvq9Xza53ZHAYzXcJxga4oQPtxyt2cUWa
         iKiRm4CCaWru4XLN2F1kB/cpEq4vmDgJdTMf/lP9yTXEMOGvK7ftLa8Lg33yYrHLPuT/
         o8XWR5hHYuMjnjuQQA8YV07yXY0y3v6TaFubMUIuHBJ6vKgRQCnevRivEHFIZLs4zja7
         CMrdG5Wc4IUK6fDdLzGShdGLDlmN/cYj78987h6riqIMIkxlV2lc/tyNroW0Q8wUYK8R
         nWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=E9l07IxNSgJt9CE4ED2nK8dEUQ3zKcbJc06F5p86Rl0=;
        b=ezAS7VIid0TPM+DgMvNNxcpod7wjDyPMgwab7Z9OYM3yLjCZ4JQB++J6t+5wSG75+W
         mhHqcmCTx/RR1ilNEK6zC8lwE/jHSxmvnjjNi+sov/qXDbaZLGq4WkTThGHbjVn/xYRr
         EGFZxrKD4F/KyG94o6CDWZ31Mi0QoOwsMXDBNjmMyuAsJjvrPCivjE1I3d7rHf6k7lXW
         LBUstR50ueFnqSs+LoK6Nd6gzToj+e2DdTv/IgicRKPBAjO4V+2tP5wY/we6w+Qwb9jN
         OKLabKpT3j1Jr0dbZ8tKENpVqO1MUwi6Oqh5PWRrQheClHv1ZSizIIdq+CdvSVUhQP16
         LRHA==
X-Gm-Message-State: AOAM530xVAFBE0cJhSsxMd9NJfxQT9/AW8DGKl526b7dvWDbQoy03YJv
        lTBI+euMpEVuVr7V/ct+WDfLisYMajw=
X-Google-Smtp-Source: ABdhPJwuEFJMXX59NVCwP/IQqF26qKU01Z8lRqUlF9oF2HT0FrBzCyw7C5SpJOQoR8lvpKmzkIB93g==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr1989071pgb.127.1625182431071;
        Thu, 01 Jul 2021 16:33:51 -0700 (PDT)
Received: from localhost ([118.209.250.144])
        by smtp.gmail.com with ESMTPSA id j3sm1157167pfe.98.2021.07.01.16.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:33:50 -0700 (PDT)
Date:   Fri, 02 Jul 2021 09:33:45 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] nohz: nohz idle balancing per node
To:     Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20210701055323.2199175-1-npiggin@gmail.com>
        <YN2Wav1CSVq+6cS+@hirez.programming.kicks-ass.net>
        <20210701131139.GD3772@suse.de>
In-Reply-To: <20210701131139.GD3772@suse.de>
MIME-Version: 1.0
Message-Id: <1625181736.w1x011tuds.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Mel Gorman's message of July 1, 2021 11:11 pm:
> On Thu, Jul 01, 2021 at 12:18:18PM +0200, Peter Zijlstra wrote:
>> On Thu, Jul 01, 2021 at 03:53:23PM +1000, Nicholas Piggin wrote:
>> > Currently a single nohz idle CPU is designated to perform balancing on
>> > behalf of all other nohz idle CPUs in the system. Implement a per node
>> > nohz balancer to minimize cross-node memory accesses and runqueue lock
>> > acquisitions.
>> >=20
>> > On a 4 node system, this improves performance by 9.3% on a 'pgbench -N=
'
>> > with 32 clients/jobs (which is about where throughput maxes out due to
>> > IO and contention in postgres).
>>=20
>> Hmm, Suresh tried something like this around 2010 and then we ran into
>> trouble that when once node went completely idle and another node was
>> fully busy, the completely idle node would not run ILB and the node
>> would forever stay idle.
>>=20
>=20
> An effect like that *might* be visible at
> https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-=
nohznuma-v1r1/html/network-tbench/hardy2/
> at the CPU usage heatmaps ordered by topology at the very bottom of
> the page.
>=20
> The heatmap covers all client counts so there are "blocks" of activity fo=
r
> each client count tested. The third block is for 8 thread counts so a nod=
e
> is not fully busy yet.

I'm not sure what I'm looking at. Where are these blocks? Along the x=20
axis?

> However, with the vanilla kernel, there is some
> load on each node but with the patch all the load is on one node. This
> did not happen on the two other test machines so the observation is not
> reliable and could be a total coincidence.

tbench is pretty finicky so it could be.

>=20
> That said, there were some gains but large losses depending on the client
> count across the 3 machines for tbench which is a concern. Other results,
> like pgbench mentioned in the changelog, will not complete until tomorrow
> to see if it is a general pattern or tbench-specific.
>=20
> https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-=
nohznuma-v1r1/html/network-tbench/bing2/
> https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-=
nohznuma-v1r1/html/network-tbench/hardy2/
> https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-=
nohznuma-v1r1/html/network-tbench/marvin2/

All 2-node. How many runs does it do at each clinet count? There's a big=20
regression at one clinet with one of them, but the other two have small=20
gains.

Thanks,
Nick
