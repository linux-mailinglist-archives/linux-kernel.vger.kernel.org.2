Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9F3E1183
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbhHEJlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238685AbhHEJk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628156444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dEMJekT4SQCfrAYob2AOPtMj/ao+bPC7JCSbP3yMQIY=;
        b=EeCPrYcSk0/SwZlTix/EEhE4ExL9Psb7JWlhoNZZx61J4FfekePjHy0omF3z0TZ5p3GpX0
        zog+Av+fZl/03fWG7cg8IZqsdqsk8mTngTKvf7Cmcl3BKVdw4BAYQ+bhDscQ5FQivu47zt
        uiML/HUSLr/t7/W/Sl//oQRmcimmA84=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-S33z9J42PvuK07cZNFpdJQ-1; Thu, 05 Aug 2021 05:40:43 -0400
X-MC-Unique: S33z9J42PvuK07cZNFpdJQ-1
Received: by mail-ed1-f69.google.com with SMTP id ay20-20020a0564022034b02903bc515b673dso2883224edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 02:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dEMJekT4SQCfrAYob2AOPtMj/ao+bPC7JCSbP3yMQIY=;
        b=sLJi5PDesy4BPB1Jln6notMr3nwu5ywCXS0i0jF1HhnShGAq9wtqPXSwg7BqWx8U3s
         YnJjsyJJd1r9eaafuReWLGgWAPbwhQr8qHmxCyMqfKE+tu8OXOHf7kTzwS1Vl6i2OVua
         uDarp9sVpPg++thHfYPANwTG+7PSMPxiujTymm/2kHQHV8HtcPMGHylUJWDasmRLzUNY
         +BKQ5URqAruT0jvCr9b8Rl8ZrznzEBqVgPadEUZKA26Q+mt1zZs+2yrepg7r9UO+3bpX
         D2AX/iPVcpHXHpWBDOwxPTIBldnd9kBdnUsBQ9Jxmlu/l+g5HA7rYCH5sSVM+7ZWmTrW
         MTig==
X-Gm-Message-State: AOAM530KbHhs8HkRljq79Pmoz5nIsva4B0NRelQPuZB2BzVoXQRxk3/e
        oMbVZ3ZLcsmP8MdY3gZEWD4HJP62yMT+/CItlsvom9rW8EV5XKGQCMv3KQNxhR5cK5+1xHVXTra
        7sdq/olR759/3VcVcHCfN8EDv
X-Received: by 2002:a05:6402:5214:: with SMTP id s20mr5340590edd.374.1628156440877;
        Thu, 05 Aug 2021 02:40:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2PLFoXwCRnneEPReFWv0f0uv10QdLl+Q/eohE0+iqZQo1qTHDZghd9ELD8IfFkqPBK+0O4Q==
X-Received: by 2002:a05:6402:5214:: with SMTP id s20mr5340571edd.374.1628156440724;
        Thu, 05 Aug 2021 02:40:40 -0700 (PDT)
Received: from localhost.localdomain ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id nd14sm1473976ejc.113.2021.08.05.02.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 02:40:40 -0700 (PDT)
Date:   Thu, 5 Aug 2021 11:40:38 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix missing clock update in
 migrate_task_rq_dl()
Message-ID: <YQuyFqf1nAcqN3Hp@localhost.localdomain>
References: <20210804135925.3734605-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804135925.3734605-1-dietmar.eggemann@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/08/21 15:59, Dietmar Eggemann wrote:
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

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri

