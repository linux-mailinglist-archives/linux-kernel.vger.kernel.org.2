Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE653E100A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhHEIQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236074AbhHEIQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628151389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OyR0YfL10Tzc6NgaDRh/ypwnT8Ag5v6wg9jvLHKd/M=;
        b=XPzR8oNojsq7z7q3hL7D+ImjGm86H3szaJ5heuJlJRLja6LXmo/prqWT18PX4EEwI/83Jn
        lStdb7QfUGWE6HDGSb0Ec5hLD34LFH3wTQXqyfPYCxmA4lOVEKrugyvxbCSqCzzL7k9+vs
        azWYFcUOlJt65womdoHu2CmyGQdtBOI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-UO16ge8sNVCwn9zWkvvZNg-1; Thu, 05 Aug 2021 04:16:28 -0400
X-MC-Unique: UO16ge8sNVCwn9zWkvvZNg-1
Received: by mail-ed1-f70.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso2765914edh.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 01:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6OyR0YfL10Tzc6NgaDRh/ypwnT8Ag5v6wg9jvLHKd/M=;
        b=FnCb8BBPbOyBIxwN4pFgtuSpyT2iPxiPZctK/EuXtAYhaYpTt1ih/KknOB9X7HluqN
         Iq2mNcd9lkus2fKDny+yqFO4ptGquZVp4kcGxs+g0jr26g8g4/uXchxFKx9V/v9k6YI3
         wzGy0Vz6KmRc+xOsSiyiswxp+xkTePXh+MwTrwN5iR7eRZsbrn9tyjr9iGXlJ+H4cxDJ
         JErrZJSFIC5iBlFSt33V/nnLGNR/tuDUHzFklzhD5/azAf7jgyuwEdVXPfMRaQgEEgyl
         uSr+k4BbjpQRsY9Tskk9dcCnXyGKGxZKu5CDA4Mzwj9CdrIYCkcR7ycRVgXoWY3WLx2h
         4ufA==
X-Gm-Message-State: AOAM531O2J6hPfXlaerN6MBkyCQdY41b3ZnKvg9SSK1b9xN5igqlcfdU
        qsVWbcpozgCVTzzm1xaFwEaUk7ovT/pzIvjeQPQvRjyHUlVAHk/L8Tywzd+fcWCGesu14W5KXeI
        QbdpY93kr/8YteJOetTfFXWWdCsUfAp3Zg6GoOvM0VOvXlICS8qETZjCL8dlYC3VrIrNq92s08U
        g=
X-Received: by 2002:a17:906:7c86:: with SMTP id w6mr3525127ejo.493.1628151387563;
        Thu, 05 Aug 2021 01:16:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyGY/DfLY8NO+nraUr0WGHor2n79Up5aQSWrTgibfh+xxr7NoXg+UU+z+WjkXoLmCOr5v//A==
X-Received: by 2002:a17:906:7c86:: with SMTP id w6mr3525114ejo.493.1628151387345;
        Thu, 05 Aug 2021 01:16:27 -0700 (PDT)
Received: from x1.bristot.me (host-95-239-202-226.retail.telecomitalia.it. [95.239.202.226])
        by smtp.gmail.com with ESMTPSA id d23sm1457728ejc.4.2021.08.05.01.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 01:16:27 -0700 (PDT)
Subject: Re: [PATCH] sched/deadline: Fix missing clock update in
 migrate_task_rq_dl()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210804135925.3734605-1-dietmar.eggemann@arm.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <57f2dfe5-c1f5-4efb-e565-2e174228ee9a@redhat.com>
Date:   Thu, 5 Aug 2021 10:16:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804135925.3734605-1-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 3:59 PM, Dietmar Eggemann wrote:
> A missing clock update is causing the following warning:
> 
> rq->clock_update_flags < RQCF_ACT_SKIP
> WARNING: CPU: 112 PID: 2041 at kernel/sched/sched.h:1453
> sub_running_bw.isra.0+0x190/0x1a0
> ...
> CPU: 112 PID: 2041 Comm: sugov:112 Tainted: G W 5.14.0-rc1 #1
> Hardware name: WIWYNN Mt.Jade Server System
> B81.030Z1.0007/Mt.Jade Motherboard, BIOS 1.6.20210526 (SCP:
> 1.06.20210526) 2021/05/26
> ...
> Call trace:
>   sub_running_bw.isra.0+0x190/0x1a0
>   migrate_task_rq_dl+0xf8/0x1e0
>   set_task_cpu+0xa8/0x1f0
>   try_to_wake_up+0x150/0x3d4
>   wake_up_q+0x64/0xc0
>   __up_write+0xd0/0x1c0
>   up_write+0x4c/0x2b0
>   cppc_set_perf+0x120/0x2d0
>   cppc_cpufreq_set_target+0xe0/0x1a4 [cppc_cpufreq]
>   __cpufreq_driver_target+0x74/0x140
>   sugov_work+0x64/0x80
>   kthread_worker_fn+0xe0/0x230
>   kthread+0x138/0x140
>   ret_from_fork+0x10/0x18
> 
> The task causing this is the `cppc_fie` DL task introduced by
> commit 1eb5dde674f5 ("cpufreq: CPPC: Add support for frequency
> invariance").
> 
> With CONFIG_ACPI_CPPC_CPUFREQ_FIE=y and schedutil cpufreq governor on
> slow-switching system (like on this Ampere Altra WIWYNN Mt. Jade Arm
> Server):
> 
> DL task `curr=sugov:112` lets `p=cppc_fie` migrate and since the latter
> is in `non_contending` state, migrate_task_rq_dl() calls
> 
>   sub_running_bw()->__sub_running_bw()->cpufreq_update_util()->
>   rq_clock()->assert_clock_updated()
> 
> on p.
> 
> Fix this by updating the clock for a non_contending task in
> migrate_task_rq_dl() before calling sub_running_bw().
> 
> Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel

> ---
>  kernel/sched/deadline.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index aaacd6cfd42f..4920f498492f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1733,6 +1733,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
>  	 */
>  	raw_spin_rq_lock(rq);
>  	if (p->dl.dl_non_contending) {
> +		update_rq_clock(rq);
>  		sub_running_bw(&p->dl, &rq->dl);
>  		p->dl.dl_non_contending = 0;
>  		/*
> 

