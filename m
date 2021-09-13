Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B1C409D51
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347516AbhIMTlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347574AbhIMTlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:41:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7F3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:40:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k13so23416002lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYRVHO8cNvTUfI7h2IWXEITGn+qlCQp4sdgo2JmuNh0=;
        b=fWT5fY+4rdaJMWHxT8KUJzHZfGaI3EdcgjUV8iuAYLytKAio/YEKsMoF9aKRmop8IH
         OVDKZQDT8y6WBmWNKA4uWrWO4Osbe581NBV8Ug9XDXrGbq4A6BWN6w9yHVqCBDxCHTx1
         0gnt0rCZ1E1DVPuzwGkvCuAz1Kxnnmq/9Sw4kmOJ36N5xA1MGl0NzhZ5EK9e3/qGDbUB
         zsJvqU8y3qXngpIhYbk8XJ18rQTxxYVv88jtrILK20SVyecmNz+CvOO/n0Ncfe5kwVtj
         O0MPQpLaqTlOJz+Lo5mq2fY5Epyd4O3TidJ4wUOxzbsiGIJgyJ0FZx1OGn6ALcRmZKyC
         4hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYRVHO8cNvTUfI7h2IWXEITGn+qlCQp4sdgo2JmuNh0=;
        b=WOqCWiDMnSapaCX2EIaAJNUBXb/UjNRsvfRYOHobdVZ4esj6OSLIOgYrYGXdr0uJXB
         Lec5Jut77L24isn9ByrE4bKpT0FzCLnACmFyCM6kaE+9QSsCjMtrP7T9t7pTNuppfL/V
         gdvbET2jZkzN6Rh46ZA8isCTdkAkMO7AvgOBEQM1nBh+4Y04yvm7QHV/QRgvOgyE56lw
         /L6S9nIj/ifObR4elqozhWMRapcb2F2wA+a2wOyhOi4DMq8tYA9u1stEceSe/7a9bdwz
         w3TzAg0sqTDjz1ALCWtdqPyv4D5P5rVoe8RS2/dkx0PUIZwzJY6Ctn1usxtZ711/y27e
         93mQ==
X-Gm-Message-State: AOAM530Ki2ESGllHCyfQN69u4FS9RGzsYfJqzK+DE6jx3wtV6UUOdiMM
        KyMlNYvAMwT8+izxoOQjuVybMBd94XmTi6f0O6D45Y+pbLOMVw==
X-Google-Smtp-Source: ABdhPJzQlFvVHpnMlYjVK6Yk/42YJiJ3vW/zUKuOLscn3iFKoKKaGn7IIPoDL3SercT69OhfN6AoE6z7v14q9+DrI78=
X-Received: by 2002:a05:6512:36c3:: with SMTP id e3mr1477626lfs.8.1631562017448;
 Mon, 13 Sep 2021 12:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210902215504.dSSfDKJZu%akpm@linux-foundation.org>
 <20210905124439.GA15026@xsang-OptiPlex-9020> <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
 <20210907033000.GA88160@shbuild999.sh.intel.com> <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
 <20210912111756.4158-1-hdanton@sina.com> <20210912132914.GA56674@shbuild999.sh.intel.com>
 <CALvZod4VbdSux5RaQuhqbC7ENm39UbdkJF8LhYedbFwHKyJgfw@mail.gmail.com>
In-Reply-To: <CALvZod4VbdSux5RaQuhqbC7ENm39UbdkJF8LhYedbFwHKyJgfw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 13 Sep 2021 12:40:06 -0700
Message-ID: <CALvZod7Oa7q=P0gzfA3F26bHPrNz+F-d6G9qKpSiHy9g=msM_w@mail.gmail.com>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
To:     Feng Tang <feng.tang@intel.com>, Tejun Heo <tj@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tejun Heo

[ threads start at
https://lore.kernel.org/all/20210905124439.GA15026@xsang-OptiPlex-9020/T/#ma938a101f415ad784ac08612c7ef31f260a2b678]

On Mon, Sep 13, 2021 at 9:41 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Sun, Sep 12, 2021 at 6:29 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > On Sun, Sep 12, 2021 at 07:17:56PM +0800, Hillf Danton wrote:
> > [...]
> > > > +// if (!(__this_cpu_inc_return(stats_flush_threshold) % MEMCG_CHARGE_BATCH))
> > > > +   if (!(__this_cpu_inc_return(stats_flush_threshold) % 128))
> > > >             queue_work(system_unbound_wq, &stats_flush_work);
> > > >  }
> > >
> > > Hi Feng,
> > >
> > > Would you please check if it helps fix the regression to avoid queuing a
> > > queued work by adding and checking an atomic counter.
> >
> > Hi Hillf,
> >
> > I just tested your patch, and it didn't recover the regression, but
> > just reduced it from -14% to around -13%, similar to the patch
> > increasing the batch charge number.
> >
>
> Thanks Hillf for taking a look and Feng for running the test.
>
> This shows that parallel calls to queue_work() is not the issue (there
> is already a test and set at the start of queue_work()) but the actual
> work done by queue_work() is costly for this code path.
>
> I wrote a simple anon page fault nohuge c program, profiled it and it
> seems like queue_work() is significant enough.
>
>    - 51.00% do_anonymous_page
>       + 16.68% alloc_pages_vma
>         11.61% _raw_spin_lock
>       + 10.26% mem_cgroup_charge
>       - 5.25% lru_cache_add_inactive_or_unevictable
>          - 4.48% __pagevec_lru_add
>             - 3.71% __pagevec_lru_add_fn
>                - 1.74% __mod_lruvec_state
>                   - 1.60% __mod_memcg_lruvec_state
>                      - 1.35% queue_work_on
>                         - __queue_work
>                            - 0.93% wake_up_process
>                               - try_to_wake_up
>                                  - 0.82% ttwu_queue
>                                       0.61% ttwu_do_activate
>       - 2.97% page_add_new_anon_rmap
>          - 2.68% __mod_lruvec_page_state
>             - 2.48% __mod_memcg_lruvec_state
>                - 1.67% queue_work_on
>                   - 1.53% __queue_work
>                      - 1.25% wake_up_process
>                         - try_to_wake_up
>                            - 0.94% ttwu_queue
>                               + 0.70% ttwu_do_activate
>                  0.61% cgroup_rstat_updated
>         2.10% rcu_read_unlock_strict
>         1.40% cgroup_throttle_swaprate
>
> However when I switch the batch size to 128, it goes away.
>

I did one more experiment with same workload but with system_wq
instead system_unbound_wq and there is clear difference in profile:

With system_unbound_wq:
-    4.63%     0.33%  mmap  [kernel.kallsyms]  [k] queue_work_on
     4.29% queue_work_on
      - __queue_work
         - 3.45% wake_up_process
            - try_to_wake_up
               - 2.46% ttwu_queue
                  - 1.66% ttwu_do_activate
                     - 1.14% activate_task
                        - 0.97% enqueue_task_fair
                             enqueue_entity

With system_wq:
-    1.36%     0.06%  mmap  [kernel.kallsyms]  [k] queue_work_on
     1.30% queue_work_on
      - __queue_work
         - 1.03% wake_up_process
            - try_to_wake_up
               - 0.97% ttwu_queue
                    0.66% ttwu_do_activate

Tejun, is this expected? i.e. queuing work on system_wq has a
different performance impact than on system_unbound_wq?
