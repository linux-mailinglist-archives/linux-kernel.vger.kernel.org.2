Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6ED42805E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJJKCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhJJKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:02:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11899C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:00:31 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id g2so13855330ild.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxU9s++4m8Jcx7P0Dv5tNUg+Qx08M5zlGy6Sk47Zz8I=;
        b=O+LJ7te8Zvt/npubcIUEUwNHBUl0AdKm0bmpnzPADGd6LrJKt8Ley5uZRFKMkU1o7I
         QG75dji0Azv8QGYwc5qDDavvS7gt30ZBXNocpWVLaDfHyHWzmCIkjN7nsD+DhPVtIikQ
         DFazb+nHcTPDEyKMNLPT2Bi1pngIS8lcHwKxQuvzCI7j7ozZWDsK86CH0p5yau5F3OHk
         mJxcB5yTwt686G4PvokWViJS4p2da8HYnRcv9HvHyyKyh5mhY/SI49EByNJqoC0G+dF9
         AMXNu53gDhiHR2npCQrDrW475wq07NPaNZyXrnO8pt3YKrDaeomv4d17tSCW463jFiYa
         mi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxU9s++4m8Jcx7P0Dv5tNUg+Qx08M5zlGy6Sk47Zz8I=;
        b=SGsz+7cTQWokHfToV1sC4ppZ7Ro3paBZiZ8JnCn1sxW0MF4RKIqNZiaX9VVINYfgUv
         699fG/ukhfjnwBp6PD18VGnP4RGNh3bDxt2H7Ikd2OwdvQTIRFrk3KuZPRNUPpSInqqE
         Rbx9/Nt4ppLhfCwtZxgEDe+qwXLXo/S7rC0jw74g8Q2PoLzFtyH5v2oIjIFn+5tMNzfU
         wt9M9+BF8o13ayefQ05R6nCmefC0Wuw/ysNle7Qb3/Km2ki/gAjUOs0IdoXgE0m2QzBM
         WACuIWicrePi4SQpKPxTfOhRM6U35VrYzRb0bXFdDiFYZDhrEXIdOtFQqd52+p1dr+Ia
         6upw==
X-Gm-Message-State: AOAM530pN6EoNICJubhjL7HQUlY6njZaPBbMWkjO19mGnrciR+AzT3JJ
        tyFXe2w1KhfEx3OLgQKE/bbWu92U9qIL8n1UPYyivXNDjJz3pg==
X-Google-Smtp-Source: ABdhPJwyWhk0bYjC6JKVP3ScNHzxqFJSDsg+sYpSQZuawDUax5pO+suS5WBoYCPey0SgIu5r52xcqGJQ0WNHjVneGso=
X-Received: by 2002:a05:6e02:1cab:: with SMTP id x11mr15386541ill.254.1633860030232;
 Sun, 10 Oct 2021 03:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <202110100928.bK8nPf4x-lkp@intel.com>
In-Reply-To: <202110100928.bK8nPf4x-lkp@intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 10 Oct 2021 17:59:54 +0800
Message-ID: <CALOAHbAo91dYPtHFH8E9cXPbn-pY960z06908-twAMb1xWUM_A@mail.gmail.com>
Subject: Re: [tip:sched/core 13/47] kernel/sched/core.c:10400:42: error:
 variable 'stats' set but not used
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 9:38 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> head:   b2d5b9cec60fecc72a13191c2c6c05acf60975a5
> commit: ceeadb83aea28372e54857bf88ab7e17af48ab7b [13/47] sched: Make struct sched_statistics independent of fair sched class
> config: microblaze-buildonly-randconfig-r002-20211010 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):

It is a  W=1 warning.
It seems that we don't need to fix the warning.

>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ceeadb83aea28372e54857bf88ab7e17af48ab7b
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip sched/core
>         git checkout ceeadb83aea28372e54857bf88ab7e17af48ab7b
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=microblaze
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    kernel/sched/core.c: In function 'ttwu_stat':
>    kernel/sched/core.c:3482:20: error: variable 'rq' set but not used [-Werror=unused-but-set-variable]
>     3482 |         struct rq *rq;
>          |                    ^~
>    kernel/sched/core.c: In function 'cpu_cfs_stat_show':
> >> kernel/sched/core.c:10400:42: error: variable 'stats' set but not used [-Werror=unused-but-set-variable]
>    10400 |                 struct sched_statistics *stats;
>          |                                          ^~~~~
>    cc1: all warnings being treated as errors
>
>
> vim +/stats +10400 kernel/sched/core.c
>
>  10389
>  10390  static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>  10391  {
>  10392          struct task_group *tg = css_tg(seq_css(sf));
>  10393          struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
>  10394
>  10395          seq_printf(sf, "nr_periods %d\n", cfs_b->nr_periods);
>  10396          seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
>  10397          seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
>  10398
>  10399          if (schedstat_enabled() && tg != &root_task_group) {
>  10400                  struct sched_statistics *stats;
>  10401                  u64 ws = 0;
>  10402                  int i;
>  10403
>  10404                  for_each_possible_cpu(i) {
>  10405                          stats = __schedstats_from_se(tg->se[i]);
>  10406                          ws += schedstat_val(stats->wait_sum);
>  10407                  }
>  10408
>  10409                  seq_printf(sf, "wait_sum %llu\n", ws);
>  10410          }
>  10411
>  10412          seq_printf(sf, "nr_bursts %d\n", cfs_b->nr_burst);
>  10413          seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
>  10414
>  10415          return 0;
>  10416  }
>  10417  #endif /* CONFIG_CFS_BANDWIDTH */
>  10418  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  10419
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Thanks
Yafang
