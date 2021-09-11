Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4A140747F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 03:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhIKBsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 21:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKBsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 21:48:15 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C69AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 18:46:59 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b7so4682023iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLw2TL8UPXc4r1gryWLjpyv4oMOEhXomyJrIWr+1tU0=;
        b=hvfDmWr3HgDUChaCLxNRDbK3rIsECMWGHQz4vPoSSXTv3V6klp48d51q/IjuyMKh0B
         BnhgVgTWOydyQO0qV6UMZLjyI7UiJeUPfmmveVaT1sF7JecXcaEP2HXnpBynuMFgdHAZ
         fjXtDxVwKSc53OMLAQgxKr4X3gs46Ppfdt/NcmzbLCUAOT9SrnLyH/8L6AjI/0hDdKab
         8I0hY4Oe+1WXk7LnidnoacTbEfHW8eX3C9Oa1FDCans0NKx7AgfNDEybU5AIGmlEIarp
         d71RVAXOhJwUd9iHLzM2VrypIcH4ccnQMgmxI+xlsmk0aDKtVKK2QNSQ2ewArQJ8tdWk
         ldjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLw2TL8UPXc4r1gryWLjpyv4oMOEhXomyJrIWr+1tU0=;
        b=XGOsV63xridtMXknpv4YSAmFLfN4Q9p0kUugVwsc1p+DYUkNX4RSP9zvLgNmhf0/X5
         la7YIvgKdjB7wnClGtY6w2rke7xdsBEa9F+2XXE9qMLfaHfh5QMITP64Et2QVVyav2dE
         U3hBQhmug4BT3VVgyWZiRp2hWNEikxkK3v82r7foX77+Fv2TvmBzDQCE6NtktIBNNufI
         /gYMklehuVWIXBzczkA7aq1Y75dh3xMTLO+EQp25pHrNxl9UcCrUDI8lBXQckIx1OD7W
         iXkSamNqh3+vDWESDPHwkybVR83thdGE74R2QtgwTIH982VjAB0vrmIdbiVbhPFz7vfI
         d/dQ==
X-Gm-Message-State: AOAM5314X/pvuV8vCNAmraRu/WjN+dS7l0N/Y4WHo8kVuf4/un3FucQw
        uUuYe6fCFu6dE7aEBpXrUdtryKEoAzHRb7pWDHSDzFi5LCaFxg==
X-Google-Smtp-Source: ABdhPJzuQkzmTXj3pyWG8kHCns+U2/19qCMa4fNLhvR2VKiUUC2krgOzSIVwV4uk4/E2u5+naU8ECNbgdzhMHO0yty0=
X-Received: by 2002:a05:6602:2e13:: with SMTP id o19mr524829iow.9.1631324817226;
 Fri, 10 Sep 2021 18:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <202109110214.oh62aoIq-lkp@intel.com>
In-Reply-To: <202109110214.oh62aoIq-lkp@intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 11 Sep 2021 09:46:21 +0800
Message-ID: <CALOAHbAwXB8Xrb3NJoZC57Y+w8TteL3t+yZyec4ANgqnag_dQA@mail.gmail.com>
Subject: Re: [peterz-queue:sched/core 13/19] kernel/sched/fair.c:892:34:
 warning: variable 'stats' set but not used
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 2:21 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> head:   2dfdb3d20ad50e2ae2cb84cbceb0f0fc75e79e5d
> commit: 445d9e8ba05d5e9e4b26956b7fe529223e29d8d1 [13/19] sched: make struct sched_statistics independent of fair sched class
> config: m68k-buildonly-randconfig-r002-20210910 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=445d9e8ba05d5e9e4b26956b7fe529223e29d8d1
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue sched/core
>         git checkout 445d9e8ba05d5e9e4b26956b7fe529223e29d8d1
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    kernel/sched/fair.c: In function 'update_curr':
>    kernel/sched/fair.c:860:42: warning: unused variable 'stats' [-Wunused-variable]
>      860 |                 struct sched_statistics *stats = __schedstats_from_se(curr);
>          |                                          ^~~~~
>    kernel/sched/fair.c: In function 'update_stats_wait_start':
> >> kernel/sched/fair.c:892:34: warning: variable 'stats' set but not used [-Wunused-but-set-variable]
>      892 |         struct sched_statistics *stats;
>          |                                  ^~~~~
>    kernel/sched/fair.c: In function 'update_stats_wait_end':
>    kernel/sched/fair.c:912:34: warning: variable 'stats' set but not used [-Wunused-but-set-variable]
>      912 |         struct sched_statistics *stats;
>          |                                  ^~~~~
>    kernel/sched/fair.c: In function 'update_stats_enqueue_sleeper':
>    kernel/sched/fair.c:956:34: warning: variable 'stats' set but not used [-Wunused-but-set-variable]
>      956 |         struct sched_statistics *stats;
>          |                                  ^~~~~
>    kernel/sched/fair.c: In function 'set_next_entity':
>    kernel/sched/fair.c:4517:42: warning: unused variable 'stats' [-Wunused-variable]
>     4517 |                 struct sched_statistics *stats = __schedstats_from_se(se);
>          |                                          ^~~~~
>    kernel/sched/fair.c: At top level:
>    kernel/sched/fair.c:5505:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
>     5505 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
>          |      ^~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c:11661:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
>    11661 | void free_fair_sched_group(struct task_group *tg) { }
>          |      ^~~~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c:11663:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
>    11663 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>          |     ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c:11668:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
>    11668 | void online_fair_sched_group(struct task_group *tg) { }
>          |      ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c:11670:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
>    11670 | void unregister_fair_sched_group(struct task_group *tg) { }
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +/stats +892 kernel/sched/fair.c
>
>    840
>    841  /*
>    842   * Update the current task's runtime statistics.
>    843   */
>    844  static void update_curr(struct cfs_rq *cfs_rq)
>    845  {
>    846          struct sched_entity *curr = cfs_rq->curr;
>    847          u64 now = rq_clock_task(rq_of(cfs_rq));
>    848          u64 delta_exec;
>    849
>    850          if (unlikely(!curr))
>    851                  return;
>    852
>    853          delta_exec = now - curr->exec_start;
>    854          if (unlikely((s64)delta_exec <= 0))
>    855                  return;
>    856
>    857          curr->exec_start = now;
>    858
>    859          if (schedstat_enabled()) {
>  > 860                  struct sched_statistics *stats = __schedstats_from_se(curr);
>    861
>    862                  __schedstat_set(stats->exec_max,
>    863                                  max(delta_exec, stats->exec_max));
>    864          }
>    865
>    866          curr->sum_exec_runtime += delta_exec;
>    867          schedstat_add(cfs_rq->exec_clock, delta_exec);
>    868
>    869          curr->vruntime += calc_delta_fair(delta_exec, curr);
>    870          update_min_vruntime(cfs_rq);
>    871
>    872          if (entity_is_task(curr)) {
>    873                  struct task_struct *curtask = task_of(curr);
>    874
>    875                  trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
>    876                  cgroup_account_cputime(curtask, delta_exec);
>    877                  account_group_exec_runtime(curtask, delta_exec);
>    878          }
>    879
>    880          account_cfs_rq_runtime(cfs_rq, delta_exec);
>    881  }
>    882
>    883  static void update_curr_fair(struct rq *rq)
>    884  {
>    885          update_curr(cfs_rq_of(&rq->curr->se));
>    886  }
>    887
>    888  static inline void
>    889  update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
>    890  {
>    891          u64 wait_start, prev_wait_start;
>  > 892          struct sched_statistics *stats;
>    893
>    894          if (!schedstat_enabled())
>    895                  return;
>    896
>    897          stats = __schedstats_from_se(se);
>    898
>    899          wait_start = rq_clock(rq_of(cfs_rq));
>    900          prev_wait_start = schedstat_val(stats->wait_start);
>    901
>    902          if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
>    903              likely(wait_start > prev_wait_start))
>    904                  wait_start -= prev_wait_start;
>    905
>    906          __schedstat_set(stats->wait_start, wait_start);
>    907  }
>    908
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


Thanks for the report.

This build warning happens when CONFIG_SCHEDSTATS is not set, in which
case the schedstat_* functions will be none.
Should add '__maybe_unused' to fix it.

I will send a fix.

-- 
Thanks
Yafang
