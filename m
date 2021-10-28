Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5769643E0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhJ1MSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhJ1MSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:18:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9E1C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:15:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 192so4016620wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hTsaHD+w0QczYgd8STqc5PXAbEsXQQXxYrvU1QF5rzo=;
        b=yuvBvsn/MnbXRX9mjN8lsmT16b7pfKJGbM8V7aOBxZx8MZzf8gyJj7qoFRQeetk87Q
         Vl7siPBE+6xd9MzClY55jygp+ENc/sjSxYyITPxtq2Z8byV6gdV6iwFn7MckeL37lK6v
         mgTQ9rXqmj0EjTfflHoaLlYwf7jRyXWSnIbA+WfQhsf/DhbAqbFqx7b4lHF+dAoycCRC
         LhMsUxHNpcXdxnZT7joMGykHSMn1bk+Lb+mFvLELL8k5jNQJ4kxpzUvzFNQfpPKOJDpu
         4tg+0ky5aAtwe5U+7GJYTGX2tF+EodDT5Fs6rKz8DhTpkXJIXfRuBQKHoUiz1t+F9PNJ
         p/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hTsaHD+w0QczYgd8STqc5PXAbEsXQQXxYrvU1QF5rzo=;
        b=UiEOuLsl2Zl/S6YfTcJaHLFUgIKiHP1+gWVyrd68NrTYRD4fdiK1YcTAcM3HTgKMVi
         0vSv0PeLfaASgPqIDspdMq4OP9eWc7NB5pM8wWPFc7r1x2uu3U/QqfA4OkznGyQjDZ17
         AWW+88amE84wr6wfHJWHbWa5s/rSw2Tf20gkYN49aLS8PzRqeNVCP3LKXdqP09lSTtTg
         QagV6Arungh0oyTVTWGQj/OgTiOVprf/Mo4pUQqyimEcSrCRfozWb84dqYQYE2TgwgSK
         Nurdf4SP7uvcJuJv3HQhxKvGHg74wcJLZbMKOTyTo13lHBTTEl3YsGsjyuNDgPxX11AP
         lKqw==
X-Gm-Message-State: AOAM532iMeUj7qwcNkHGqrKX28yM4xh0uMRpKNJpuW4Qh2mJU6/8R8ea
        zlw1KTjkwH9v1d4uaCEUepJLnQ==
X-Google-Smtp-Source: ABdhPJz2h2vsU+LSIENFL7V+PEekkO2pDz3I74SKNuaNewWJoXoE2lMnAq12N453FeTl3lqGqN/jBg==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr4053035wmk.2.1635423333117;
        Thu, 28 Oct 2021 05:15:33 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:ac5e:7a99:ff44:4f9a])
        by smtp.gmail.com with ESMTPSA id y6sm1578635wrh.18.2021.10.28.05.15.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Oct 2021 05:15:32 -0700 (PDT)
Date:   Thu, 28 Oct 2021 14:15:30 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
Message-ID: <20211028121530.GA19512@vingu-book>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <7128695d64e9161637b67315b5beb51c4accdc82.camel@linux.intel.com>
 <CAKfTPtAv7vPGYAwUSmGL5wtbY=if8G+3geWMKpHu3vLGqthPfg@mail.gmail.com>
 <720fd26424927dd27fea4e5719dafe8a0afaa8c4.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <720fd26424927dd27fea4e5719dafe8a0afaa8c4.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 27 oct. 2021 à 13:53:32 (-0700), Tim Chen a écrit :
> On Wed, 2021-10-27 at 10:49 +0200, Vincent Guittot wrote:
> > 
> > > Looking at the profile on update_blocked_averages a bit more,
> > > the majority of the call to update_blocked_averages
> > > happens in run_rebalance_domain.  And we are not
> > > including that cost of update_blocked_averages for
> > > run_rebalance_domains in our current patch set. I think
> > > the patch set should account for that too.
> > 
> > nohz_newidle_balance keeps using sysctl_sched_migration_cost to
> > trigger a _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
> > This would probably benefit to take into account the cost of
> > update_blocked_averages instead
> > 
> 
> For the case where
> 
> 	this_rq->avg_idle < sysctl_sched_migration_cost
> 
> in newidle_balance(), we skip to the out: label
> 
> out:
>         /* Move the next balance forward */
>         if (time_after(this_rq->next_balance, next_balance))
>                 this_rq->next_balance = next_balance;
> 
>         if (pulled_task)
>                 this_rq->idle_stamp = 0;
>         else
>                 nohz_newidle_balance(this_rq);
> 
> and we call nohz_newidle_balance as we don't have a pulled_task.
> 
> It seems to make sense to skip the call
> to nohz_newidle_balance() for this case? 

nohz_newidle_balance() also tests this condition :
(this_rq->avg_idle < sysctl_sched_migration_cost)
and doesn't set NOHZ_NEWILB_KICKi in such case

But this patch now used the condition :
this_rq->avg_idle < sd->max_newidle_lb_cost
and sd->max_newidle_lb_cost can be higher than sysctl_sched_migration_cost

which means that we can set NOHZ_NEWILB_KICK:
-although we decided to skip newidle loop
-or when we abort because this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost 

This is even more true when sysctl_sched_migration_cost is lowered which is your case IIRC

The patch below ensures that we don't set NOHZ_NEWILB_KICK in such cases:

---
 kernel/sched/fair.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c19f4bb3df1a..36ddae208959 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10779,7 +10779,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	int this_cpu = this_rq->cpu;
 	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
-	int pulled_task = 0;
+	int pulled_task = 0, early_stop = 0;
 
 	update_misfit_status(NULL, this_rq);
 
@@ -10816,8 +10816,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
-		if (sd)
+		if (sd) {
 			update_next_balance(sd, &next_balance);
+
+			/*
+			 * We skip new idle LB because there is not enough
+			 * time before next wake up. Make sure that we will
+			 * not kick NOHZ_NEWILB_KICK
+			 */
+			early_stop = 1;
+		}
 		rcu_read_unlock();
 
 		goto out;
@@ -10836,8 +10844,10 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 		update_next_balance(sd, &next_balance);
 
-		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
+		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
+			early_stop = 1;
 			break;
+		}
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 
@@ -10887,7 +10897,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
-	else
+	else if (!early_stop)
 		nohz_newidle_balance(this_rq);
 
 	rq_repin_lock(this_rq, rf);
-- 

> We expect a very short idle and a task to wake shortly.  
> So we do not have to pull a task
> to this idle cpu and incur the migration cost.
> 
> Tim
> 
> 
> 
> 
