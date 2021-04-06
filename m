Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57AD355176
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbhDFLAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhDFLAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:00:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD56C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:00:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id v15so22020568lfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJTerO5AkWHj+6I0VUt1HmL8CSDxaLOqq6PtJBKLdqs=;
        b=EFJi2SKCDMZUGLA5X0iauVZ2sUh5vkp3DvVXmjdZO1//IEvKrCqPqMAPJir6iUxlpf
         3YPYCQb1wnHbX+7q6NuKZ2hgK8iVYQXCIdSrGS5NUj9TPe5Edu4IuyW54ObOTM/Y2BRo
         DYzi5L1x3ZTSwuhpsfwz5m+KyA6aoQTpgJUYPF5c0z7gsinA7npCePx8grrVHyvjcu/u
         Hl9d9xTs2uww34ldSPhWOiAAHCvFcYqdWctvfqKqoZPVRIharISGEdJS4lfXVyfwodBA
         Ywuyeb0HefUi0hQ/WUCZfMrrPCEudKNQdZYUVrD3wL3Brpg0VxjyrAzZx6VlCtrNInlY
         mcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJTerO5AkWHj+6I0VUt1HmL8CSDxaLOqq6PtJBKLdqs=;
        b=DC0C681ks4cNUm/eyER+pDJ+xebb5Ou0jHY+jdxfkfei7K/J1YZzic9v8d9VYMIWxi
         gLxrW52uAMMsXycPasELxXQkawWWxBrGZrgY6mSH2oMMcoQrgey5z3uvD6RA6/wAczG8
         kBK6LHV+JESxrviF4gG3g+imfv6Xaz5OQOi1Ww/NVDbCtYpf8YxmdxTJ+CQKdDVO1b+l
         19PRZa+9+6yyfV1+XgqP7lhF/DrKmhF9PVWKM1wDby+3FuzUymNTwkXNs4FZQG5m+NuF
         f1Agrljkkg7QN9z4sdk3m0QM+RJsTNo5xq2tR7dOg0nZohAmD8xnV/sAssUuU6airUsn
         FKNw==
X-Gm-Message-State: AOAM532VdRHEPZGmcQnd4xhV2Pnn6BUPdNdkpH7M45xFurQEMrDHS1LR
        rNqRY/aKO5VdaSLhbWjZg5aySjZ7/TJxONRNGwI=
X-Google-Smtp-Source: ABdhPJzaeLnSmxQR+9e1FPh8akSvEW7J79maDTanNJ6ohT4r94zJ/YHhoqcl1A552ExHvyXaFNAqMvRRjmGhJioIe90=
X-Received: by 2002:a05:6512:314d:: with SMTP id s13mr19902868lfi.95.1617706824606;
 Tue, 06 Apr 2021 04:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
In-Reply-To: <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 6 Apr 2021 18:59:16 +0800
Message-ID: <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in eas
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        quentin.perret@arm.com, Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar

On Fri, Apr 2, 2021 at 2:07 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> +cc: Pierre Gondois <pierre.gondois@arm.com>
>
> On 30/03/2021 11:45, Quentin Perret wrote:
> > Hi,
> >
> > On Tuesday 30 Mar 2021 at 13:21:54 (+0800), Xuewen Yan wrote:
> >> From: Xuewen Yan <xuewen.yan@unisoc.com>
> >>
> >> now the energy delta compute as follow:
> >>
> >> base_energy_pd = compute_energy(p, -1, pd);
> >>      --->Traverse all CPUs in pd
> >>      --->em_pd_energy()
> >> ----------------------------------------------------- \
> >> search for the max_sapre_cap_cpu                       \
> >> ---------------------------------                       search time
> >> cur_delta = compute_energy(p, max_spare_cap_cpu, pd);  /
> >>      --->Traverse all CPUs in pd                   /
> >> ---------------------------------------------------- /
> >>      --->em_pd_energy()
> >> cur_delta -= base_energy_pd;
> >>
> >> During the search_time, or when calculate the cpu_util in
> >> compute_energy(), there may occurred task dequeue or cpu_util change,
> >> it may cause the cur_energy < base_energy_pd, so the cur_delta
> >> would be negative. But the cur_delta is unsigned long, at this time,
> >> the cur_delta would always bigger than best_delta of last pd.
> >>
> >> Change the vars to signed long.
> >
> > Is that really helping though?
> >
> > Yes you will not overflow, but the decision is still 'wrong' if the util
> > values are not stable for the entire wake-up. I think folks on the Arm
> > side had patches to try and cache the util values upfront, and then use
> > them throughout feec() and compute_energy(), which I think would be a
> > better fix.
> >
> > Dietmar, wdyt?
>
> Yes, we have some patches from Pierre Gondois which introduce a pd cache
> to store the CPU utilization values so they can be reused for 'cpu !=
> dst_cpu' calculations within find_energy_efficient_cpu() (feec()).
>
> We did run them in our Jan 2021 EAS integration:
>
> https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integration-20210129
>
>   sched: Allocate pd_cache when EAS is enabled
>   sched/fair: Use pd_cache to speed up find_energy_efficient_cpu()
>
> We haven't posted them since we're still looking for a story to justify
> the extra complexity. The experiments on Arm64 Juno (2 big, 4 little
> CPUs) showed 1-2% failure due to changes of CPU utilization values
> during feec(). There was a 5% (big CPU)-10% (little CPU) runtime
> reduction for feec() with the patches.

I test the patch, but the overflow still exists.
In the "sched/fair: Use pd_cache to speed up find_energy_efficient_cpu()"
I wonder why recompute the cpu util when cpu==dst_cpu in compute_energy(),
when the dst_cpu's util change, it also would cause the overflow.

Thanks
