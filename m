Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD94436AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 20:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhKBTuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 15:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhKBTuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:50:11 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7757C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 12:47:35 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d21so260996qtw.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b7uuIGAE6dU+80dbHoY1inA6eQKnX0OFGz2j4fCtsbA=;
        b=Oy74Ittz5VkqIbU9sWofCKN2a+vdqqnHjjID3frgpqAzufxGrkilvz7TrOlRVnqJvE
         bg15rLe36m3FqUPPFho9tTPIXZ+8QMqfWafew5ja076XFL9Uf4EKmVQxE6SFZEDxrnl6
         Z3xRyUolp1FQ7Ks+sfI419B47bWAji/CxLtNEh8Ll/nwu5SX/0/hmX+n8bCHiCD9/+UM
         mkZvEINz2RnYNqbGah/pOU08AnGq3J9rRqwxi3bsrQKpIQ6szxFUgtr2dd3ZWl6VLHRK
         XCAp8a+yiHQtEt5ryXiB1YooqJRGLdm6bhyCP/ipIERh4xMgh+3NFacy7hy5nzHlEGxR
         iPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b7uuIGAE6dU+80dbHoY1inA6eQKnX0OFGz2j4fCtsbA=;
        b=Pq71PIVx4VT9bFlkQfg+E4LNUOpoKa7oG5eMVU5+Cw3WzEGc8pPw4AuwwWuBgocv0I
         9Yehn4kc3VdoSXfj148mUvBzftwNVNb6y0Y4XIOm+x5zCzKchXz6g+3NguEHOAc2YjJ9
         GUzalUgA/eeqQtGdKPwvMxvdDJ9yXV5tegANdCLavfnQwN+ydBXG//heusYMUgWWABt7
         Ep3PII5XcO4V4VWVYx7RYeVjlv0mGQURzaaPidEda/6nDewGms1N3ziaiedRXkVECYCl
         Ju8yU8oyzL2uolhkqInGmGze85oBBUKaEJJV6/qyUPo2WfRUUp5bUw6BqJ2e/KWmlJA4
         rnzA==
X-Gm-Message-State: AOAM532h9tENYnyfspjoxugGLjJzXMWVSeLhajlmIMmoQLWY6FnPDEIV
        dDN/tAChmmH5lYUMNgsTy6jg3A==
X-Google-Smtp-Source: ABdhPJx64f36cNSzziePdqfwvy6Rqywsyu65wyN2vJ0S2xZ+37SuGAyDMubbC55a7DXhNaqwmcMePw==
X-Received: by 2002:a05:622a:2ce:: with SMTP id a14mr14731004qtx.72.1635882454952;
        Tue, 02 Nov 2021 12:47:34 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id v15sm13843872qkl.91.2021.11.02.12.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 12:47:34 -0700 (PDT)
Date:   Tue, 2 Nov 2021 15:47:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
Message-ID: <YYGV1TxsZXzGXFmx@cmpxchg.org>
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC peterz as well for rt and timekeeping magic

On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> In an EAS enabled system, there are two scenarios discordant to current design,
> 
> 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> RT task usually preempts CFS task in little core.
> 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> ignore the preempted time by RT, DL and Irqs.
> 
> With these two constraints, the percpu nonidle time would be mainly consumed by
> none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
> via the proportion of cfs_rq's utilization on the whole rq.
> 
> eg.
> Here is the scenario which this commit want to fix, that is the rt and irq consume
> some utilization of the whole rq. This scenario could be typical in a core
> which is assigned to deal with all irqs. Furthermore, the rt task used to run on
> little core under EAS.
> 
> Binder:305_3-314    [002] d..1   257.880195: psi_memtime_fixup: original:30616,adjusted:25951,se:89,cfs:353,rt:139,dl:0,irq:18
> droid.phone-1525    [001] d..1   265.145492: psi_memtime_fixup: original:61616,adjusted:53492,se:55,cfs:225,rt:121,dl:0,irq:15
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  kernel/sched/psi.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3c..754a836 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -182,6 +182,8 @@ struct psi_group psi_system = {
>  
>  static void psi_avgs_work(struct work_struct *work);
>  
> +static unsigned long psi_memtime_fixup(u32 growth);
> +
>  static void group_init(struct psi_group *group)
>  {
>  	int cpu;
> @@ -492,6 +494,21 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
>  	return growth;
>  }
>  
> +static unsigned long psi_memtime_fixup(u32 growth)
> +{
> +	struct rq *rq = task_rq(current);
> +	unsigned long growth_fixed = (unsigned long)growth;
> +
> +	if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> +		return growth_fixed;
> +
> +	if (current->in_memstall)
> +		growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> +					- rq->avg_irq.util_avg + 1) * growth, 1024);
> +
> +	return growth_fixed;
> +}
> +
>  static void init_triggers(struct psi_group *group, u64 now)
>  {
>  	struct psi_trigger *t;
> @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
>  	}
>  
>  	if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> +		delta = psi_memtime_fixup(delta);

Ok, so we want to deduct IRQ and RT preemption time from the memstall
period of an active reclaimer, since it's technically not stalled on
memory during this time but on CPU.

However, we do NOT want to deduct IRQ and RT time from memstalls that
are sleeping on refaults swapins, since they are not affected by what
is going on on the CPU.

Does util_avg capture that difference? I'm not confident it does - but
correct me if I'm wrong. We need length of time during which and IRQ
or an RT task preempted the old rq->curr, not absolute irq/rt length.

(Btw, such preemption periods, in addition to being deducted from
memory stalls, should probably also be added to CPU contention stalls,
to make CPU pressure reporting more accurate as well.)
