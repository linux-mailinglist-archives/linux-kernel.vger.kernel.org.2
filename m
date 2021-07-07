Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2E3BE8EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhGGNl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhGGNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:41:55 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2EFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 06:39:15 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j14so1015918qvu.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NBmnpGkMnjPhE8k+PU98glx9l34cNHET8f7BGXMX2R8=;
        b=NZX10fjCpzb0SE2l2VEWfJG3fn91unHKRPw9ug7EIii+bRg5jDv2gc6WWwVkDFgPGA
         tddDX2jQoE9CabfJBbgPPow7bWTbe1JlPCbILBY5abezCHNVkWhtuvvP5iHSt6vrO3Yr
         FlE9VOUug6ByDE3tJIUMgH0bZEyXc6G27Dkd8vX1zq+DzVFzdYLJijpmrlonM0s6Plr/
         gL90PV11rvVZN17wmmNwRD0cAQnMf4RAIcTDxKJse5LSBruXIM3jNWqXZ8HZmyhFq3/l
         lMEaHdBArGbkDLlV91Fjma9NI5FRfiMOXCQlrLp83d4jju0Y1b8d6z16XZr7VBylq7Bb
         3xVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NBmnpGkMnjPhE8k+PU98glx9l34cNHET8f7BGXMX2R8=;
        b=CgXlUNk5L48qxhDj75DCRqVZmEFE6jhgiZol2CQdQLkJSkKW7WUjw472z3lth+2zC+
         oecASrFG2IRt4OjfRNWLzP0bHcM8eHSDUOLnifownkdDm638jcWUCzwD4swhbW7SHNFE
         NuIQbKg/lx+zdl+vP4AUbu3Q4j4X15lKW7IR5SdPzJYZ9UN+Vieoet3jx1h5kb+W6tLc
         aoYHjM63Zg+HQGNveM3ukFlhLYSEgmpsVQNeBFPJGlT7fk4iSCSn2OiCaP5k6nUEmGqb
         FjXKXz/Y8Z753EGX8XdDv4gfz3xl7Qdk84ohE6Es4dh08PoybZs4zBwtCfspPbYC2KQq
         Gpdg==
X-Gm-Message-State: AOAM530LzzcsxRVErFs6hG3pfaguUukPzvltMbSWZAaEL+RQCr7b0Y7V
        fVJaPHUSpo51od15Y/Tu4YIA+Q==
X-Google-Smtp-Source: ABdhPJzFnW37eDnemMfC+7m8hErzLP3g4Ti2rxVLZO5i1u6e+mzeDOuCmpIWN7gldbHPqWgUXQ5Gvg==
X-Received: by 2002:ad4:56e4:: with SMTP id cr4mr2075482qvb.54.1625665154351;
        Wed, 07 Jul 2021 06:39:14 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id y24sm6649032qtv.97.2021.07.07.06.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:39:13 -0700 (PDT)
Date:   Wed, 7 Jul 2021 09:39:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, matthias.bgg@gmail.com, minchan@google.com,
        timmurray@google.com, yt.chang@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com,
        SH Chen <show-hong.chen@mediatek.com>
Subject: Re: [PATCH v3 1/1] psi: stop relying on timer_pending for poll_work
 rescheduling
Message-ID: <YOWugYxQ9Yfsqba2@cmpxchg.org>
References: <20210707023933.1691149-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707023933.1691149-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks good to me now code wise. Just a comment on the comments:

On Tue, Jul 06, 2021 at 07:39:33PM -0700, Suren Baghdasaryan wrote:
> @@ -559,18 +560,14 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>  	return now + group->poll_min_period;
>  }
>  
> -/* Schedule polling if it's not already scheduled. */
> -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
> +/* Schedule polling if it's not already scheduled or forced. */
> +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> +				   bool force)
>  {
>  	struct task_struct *task;
>  
> -	/*
> -	 * Do not reschedule if already scheduled.
> -	 * Possible race with a timer scheduled after this check but before
> -	 * mod_timer below can be tolerated because group->polling_next_update
> -	 * will keep updates on schedule.
> -	 */
> -	if (timer_pending(&group->poll_timer))
> +	/* xchg should be called even when !force to set poll_scheduled */
> +	if (atomic_xchg(&group->poll_scheduled, 1) && !force)
>  		return;

This explains what the code does, but not why. It would be good to
explain the ordering with poll_work, here or there. But both sides
should mention each other.

> @@ -595,6 +595,28 @@ static void psi_poll_work(struct psi_group *group)
>  
>  	now = sched_clock();
>  
> +	if (now > group->polling_until) {
> +		/*
> +		 * We are either about to start or might stop polling if no
> +		 * state change was recorded. Resetting poll_scheduled leaves
> +		 * a small window for psi_group_change to sneak in and schedule
> +		 * an immegiate poll_work before we get to rescheduling. One
> +		 * potential extra wakeup at the end of the polling window
> +		 * should be negligible and polling_next_update still keeps
> +		 * updates correctly on schedule.
> +		 */
> +		atomic_set(&group->poll_scheduled, 0);
> +		/*
> +		 * Ensure that operations of clearing group->poll_scheduled and
> +		 * obtaining changed_states are not reordered.
> +		 */
> +		smp_mb();

Same here, it would be good to explain that this is ordering the
scheduler with the timer such that no events are missed. Feel free to
reuse my race diagram from the other thread - those are better at
conveying the situation than freeform text.

Thanks
