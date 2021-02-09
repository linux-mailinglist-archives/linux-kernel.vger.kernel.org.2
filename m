Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2666B314FFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhBINSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhBINSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:18:17 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACCBC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:17:36 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e18so22179189lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHt/2t6Gccb30RHK0fDTAMtzIA8Iw7ZTM9DKWCLwJV0=;
        b=tWFRS1GROXoY79U8gYzCoUhPSriqjYvfqbMb4n+DladfnLpRBdFPX/ePj/ipyZmc1t
         ynAjOlyyIYj/7aftlGs8FVpcmyx+osjcrR1yMN90+KwvFtLPAABUICZBzWzFw3DDdubU
         yh01Desa1mlBJC6DT5o9zK3lypWAga6XJ+lmZDlOFhXmwd0DemiEnysBkbcGiEvssGIu
         K1VXXFEeKBncggDTEj4VBpD+fZQ2hO8ajRX7u/korKv38VEsUhGkG0VymPGlzYsWKkGH
         zdiBR4uh6HAqnvGbleoWmQJmGUs1PD1hGGGFusxTCAXOOWBDdXeD709i48wGVDwJk3PH
         +xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHt/2t6Gccb30RHK0fDTAMtzIA8Iw7ZTM9DKWCLwJV0=;
        b=neio61LAxah0TfIVPRTCYfpNxUk7vvykLh4wytk4ua2B/nS4wN0jZt+A2fMBDK0opl
         YglQMdOVYXi1ewwL4jxZ7U8IBR1Lfx5ZfR+4P6NhpodhibkV337lmaWqjMn0puQBmZbg
         voeoCgqwB58o7kAVSzJQS5LynmSX9JiLACv33nYIoWOzg5wap1pIk61iuizj2cJ1dG/N
         i/nK2f6mA4JDsJMe85Rq/8mriWFeXVJ06055aBUZmKR9mFIcUBpbTB1vREJ5F3H758Cx
         XUFMWc7ayFJc4tg9W2SnNQSICfuIn1m9imHeUflZxkW6fh77ehgQ2S76yqkn3BTYuFPM
         T/9Q==
X-Gm-Message-State: AOAM532oyj26OlnF8QCs53v2BaQwHDEPwsO7WfFj9kLNquVBRZjHt//8
        SiUMyK0/vjDW6WmT1bgYTaZmBQ==
X-Google-Smtp-Source: ABdhPJzYoE6XiVt0ypBzNvCt5TTw8d/IQKHdkTg/Itxi0vlEoTZOvxOG6U84NqQScpb6but7XqkOLA==
X-Received: by 2002:a2e:b896:: with SMTP id r22mr14332708ljp.234.1612876654695;
        Tue, 09 Feb 2021 05:17:34 -0800 (PST)
Received: from xps.home ([2001:4647:9b4f:c:a1b6:e56:6469:3494])
        by smtp.gmail.com with ESMTPSA id g4sm2528374lfu.283.2021.02.09.05.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:17:34 -0800 (PST)
From:   Odin Ugedal <odin@uged.al>
To:     changhuaixin@linux.alibaba.com
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com, tj@kernel.org
Subject: Re: [PATCH v3 0/4] sched/fair: Burstable CFS bandwidth controller
Date:   Tue,  9 Feb 2021 14:17:19 +0100
Message-Id: <20210209131719.1193428-1-odin@uged.al>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi! This looks quite useful, but I have a few quick thoughts. :)

I know of a lot of people who would love this (especially some
Kubernetes users)! I really like how this allow users to use cfs
in a more dynamic and flexible way, without interfering with those
who like the enforce strict quotas.


> +++ b/kernel/sched/core.c
> @ -7900,7 +7910,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64
> [...]
> +	/* burst_onset needed */
> +	if (cfs_b->quota != RUNTIME_INF &&
> +			sysctl_sched_cfs_bw_burst_enabled &&
> +			sysctl_sched_cfs_bw_burst_onset_percent > 0) {
> +
> +		burst_onset = do_div(burst, 100) *
> +			sysctl_sched_cfs_bw_burst_onset_percent;
> +
> +		cfs_b->runtime += burst_onset;
> +		cfs_b->runtime = min(max_cfs_runtime, cfs_b->runtime);
> +	}

I saw a comment about this behavior, but I think this can lead to a bit of
confusion. If sysctl_sched_cfs_bw_burst_onset_percent=0, the amount of
bandwidth when the first process starts up will depend on the time between
the quota was set and the startup of the process, and that feel a bit like
a "timing" race that end user application then will have to think about.

I suspect contianer runtimes and/or tools like Kubernetes will then have
to tell users to set the value to a certan amount in order to make it
work as expected.

Another thing is that when a cgroup has saved some time into the
"burst quota", updating the quota, period or burst will then reset the
"burst quota", even though eg. only the burst was changed. Some tools
use dynamic quotas, resulting in multiple changes in the quota over time,
and I am a bit scared that don't allowing them to control "start burst"
on a write can be limiting.

Maybe we can allow people to set the "start bandwidth" explicitly when setting
cfs_burst if they want to do that? (edit: that might be hard for cgroup v1, but
would I think that is a good solution on cgroup v2).

This is however just my thoughts, and I am not 100% sure about what the
best solution is, but if we merge a certain behavior, we have no real
chance of changing it later.


> +++ b/kernel/sched/sched.h
> @@ -367,6 +367,7 @@ struct cfs_bandwidth {
>  	u64			burst;
>  	u64			buffer;
>  	u64			max_overrun;
> +	u64			previous_runtime;
>  	s64			hierarchical_quota;

Maybe indicate that this was the remaining runtime _after_ the previous
period ended? Not 100% sure, but maybe sometihing like
'remaining_runtime_prev_period' or 'end_runtime_prev_period'(as inspiration).   


> +++ b/kernel/sched/core.c
> @@ -8234,6 +8236,10 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>  		seq_printf(sf, "wait_sum %llu\n", ws);
>  	}
>  
> +	seq_printf(sf, "current_bw %llu\n", cfs_b->runtime);
> +	seq_printf(sf, "nr_burst %d\n", cfs_b->nr_burst);
> +	seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
> +
>  	return 0;
>  }

Looks like these metrics are missing from the cgroup v2 stats.

Are we sure it is smart to start exposing cfs_b->runtime, since it makes it
harder to change the implementation at a later time? I don't thin it is that
usefull, and if it is only exposed for debugging purposes people can probably
use kprobes instead? Also, it would not be usefull unless you know how much
wall time is left in the current period. In that sense,
cfs_b->previous_runtime would probably be more usefull, but still not sure if
it deserves to be exposed to end users like this.

Also, will "cfs_b->runtime" keep updating if no processes are running, or
will it be the the same here, but update (with burst via timer overrun)
when a process starts again? If so, the runtime available when a process
starts on cgroup inint can be hard to communicate if the value here doesn't
update.


> +++ b/kernel/sched/fair.c
> +void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b, int init)
> [...]
> +	/*
> +	 * When period timer stops, quota for the following period is not
> +	 * refilled, however period timer is already forwarded. We should
> +	 * accumulate quota once more than overrun here.
> +	 */


Trying to wrap my head around this one... Is not refilling here, as the
behavior before your patch causing "loss" in runtime and causing unnecessary
possibly causing a cgroup throttle?.


A am not that familiar how cross subsystem patches like these are handled, but
I am still adding the Tejun Heo (cgroup maintainer) as a CC. Should maybe cc to
cgroup@ as well?

Sorry for a long mail, in retrospect it should have been one per patch...
