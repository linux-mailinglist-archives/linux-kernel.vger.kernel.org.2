Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37ED383C48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhEQSc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbhEQScY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:32:24 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AAEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:31:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t7so5584823qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UIgRSmdq0WSwZaTtDLga+2Wo1ADVfnOj+xZ3R2W4aJE=;
        b=i7yNQh/t5w8KCHFJtkLOXFF/z0IQpwrTuwjqD9dtDYQ2cv3wWZwNmT+5J2eNdbNIsp
         jVc3tBvDnYe7g8TVQ7jB9EgnK+rHhFDzdm6w/+Mev63PyENqwu3wA7uuEDcgno0uUWbV
         pwnNxHmshKit3PlgRbvYerc8maRx/B1pMM85eAr+3yTJHF7ZH3Ws7zj0sfbgs7NzUFnb
         D7yk38tPRufil/zPmCQZyLqyknqyiNzuA+Hr+IUYFCdxIoin1YT3qmOggCDEQoxpgY2W
         Pg6aUbK9WjDk19fq4FplcFRD5XAWKc/hzyhtzryYrhmXdMx19f4cGyXvKyk561xC6+Kr
         LD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UIgRSmdq0WSwZaTtDLga+2Wo1ADVfnOj+xZ3R2W4aJE=;
        b=URismtkevJ2xPtgY7qdnP8JHaPIpdkTYCa0UQfkZh8UzeF2Fjv8Yh8c2G5F40PC93l
         eLaSP1OVflEukGBeikhWMYuWrrpsIQLKBseyeBoz89nGEaFDI7re36AjZtadpTIh9rjW
         u5aYtbIQHwBjehXLGPhoTysWuwT/Rh4aAgHClgy98THIChS5upLAhxby2AKP/yPg5gJg
         C5xauyxGKmhIoOWUn8Xe0Y5BKV65631K2YSO5vfteLo6kT0wfF//Yihy/Mj3A4QEo9d9
         5fo3ECtB0VAkonjXUc40F09YZmoZxwWdCtFTxg3tEG8UbhXITQja1vzx/J60k9PYcUTT
         KmvA==
X-Gm-Message-State: AOAM532jQKOall11RGzCzGaGCO+crK8lnKOwUMwF8B1Nyl6Z+zJwTOFY
        S4Hh0Wd2keQDnpEdHb8z5aXL1Q==
X-Google-Smtp-Source: ABdhPJxsm4usnCyHlHyi2wzcTlQRJx6GHv9pjrNBzmHXQDjs9e+PuobeYdeh41QsPjBb0czMSVzDng==
X-Received: by 2002:ac8:7956:: with SMTP id r22mr127252qtt.361.1621276264239;
        Mon, 17 May 2021 11:31:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8d28])
        by smtp.gmail.com with ESMTPSA id f16sm11036738qtv.82.2021.05.17.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:31:03 -0700 (PDT)
Date:   Mon, 17 May 2021 14:31:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        lizefan.x@bytedance.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        Minchan Kim <minchan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, bristot@redhat.com,
        "Paul E . McKenney" <paulmck@kernel.org>, rdunlap@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, macro@orcam.me.uk,
        Viresh Kumar <viresh.kumar@linaro.org>,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] cgroup: make per-cgroup pressure stall tracking
 configurable
Message-ID: <YKK2ZumDWcaGWvBj@cmpxchg.org>
References: <20210513175349.959661-1-surenb@google.com>
 <YJ5iAvqAmIhzJRot@hirez.programming.kicks-ass.net>
 <CAJuCfpHy+MknCepfjx9XYUA1j42Auauv7MFQbt+zOU-tA4gasA@mail.gmail.com>
 <YJ64xHoogrowXTok@hirez.programming.kicks-ass.net>
 <CAJuCfpGkj9HxbkXnYN58JXJp1j6kVkvQhqscnEfjyB5unKg1NQ@mail.gmail.com>
 <CAJuCfpH2X47_3VvfZXs_eWhYDziOh13qdUwcfxPJe=Zg_Nkvqw@mail.gmail.com>
 <CAJuCfpEznCYhjbM+1=dMdEn1J2NVw88M+4AThD99PBKg41RgTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEznCYhjbM+1=dMdEn1J2NVw88M+4AThD99PBKg41RgTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 12:52:32PM -0700, Suren Baghdasaryan wrote:
> After reworking the code to add a static key I had to expand the
> #ifdef CONFIG_CGROUPS section, so I think a code refactoring below
> would make sense. It localizes config-specific code and it has the
> same exact code for CONFIG_CGROUPS=n and for
> cgroup_psi_enabled()==false. WDYT?:
> 
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -181,6 +181,7 @@ struct psi_group psi_system = {
>  };
> 
>  static void psi_avgs_work(struct work_struct *work);
> +static void cgroup_iterator_init(void);
> 
>  static void group_init(struct psi_group *group)
>  {
> @@ -211,6 +212,8 @@ void __init psi_init(void)
>                  return;
>          }
> 
> +        cgroup_iterator_init();
> +
>          psi_period = jiffies_to_nsecs(PSI_FREQ);
>          group_init(&psi_system);
>  }
> @@ -742,11 +745,31 @@ static void psi_group_change(struct psi_group
> *group, int cpu,
>                  schedule_delayed_work(&group->avgs_work, PSI_FREQ);
>  }
> 
> -static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> +static inline struct psi_group *sys_group_iterator(struct task_struct *task,
> +                                                   void **iter)
>  {
> +        *iter = &psi_system;
> +        return &psi_system;
> +}
> +
>  #ifdef CONFIG_CGROUPS
> +
> +DEFINE_STATIC_KEY_FALSE(psi_cgroups_disabled);
> +
> +static void cgroup_iterator_init(void)
> +{
> +        if (!cgroup_psi_enabled())
> +                static_branch_enable(&psi_cgroups_disabled);
> +}
> +
> +static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> +{
>          struct cgroup *cgroup = NULL;
> 
> +        /* Skip to psi_system if per-cgroup accounting is disabled */
> +        if (static_branch_unlikely(&psi_cgroups_disabled))
> +                return *iter ? NULL : sys_group_iterator(task, iter);
> +
>          if (!*iter)
>                  cgroup = task->cgroups->dfl_cgrp;

That looks over-engineered. You have to check iter whether cgroups are
enabled or not. Pulling the jump label check up doesn't save anything,
but it ends up duplicating code.

What you had in the beginning was better, it just had the system label
in an unexpected place where it would check iter twice in a row.

The (*iter == &psi_system) check inside the cgroups branch has the
same purpose as the (*iter) check in the else branch. We could
consolidate that by pulling it up front.

If we wrap the entire cgroup iteration block into the static branch,
IMO it becomes a bit clearer as well.

How about this?

static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
{
	if (*iter == &psi_system)
		return NULL;

#ifdef CONFIG_CGROUPS
	if (!static_branch_likely(&psi_cgroups_disabled)) {
		struct cgroup *cgroup = NULL;

		if (!*iter)
			cgroup = task->cgroups->dfl_cgrp;
		else
			cgroup = cgroup_parent(*iter);

		if (cgroup && cgroup_parent(cgroup)) {
			*iter = cgroup;
			return cgroup_psi(cgroup);
		}
	}
#endif

	*iter = &psi_system;
	return &psi_system;
}
