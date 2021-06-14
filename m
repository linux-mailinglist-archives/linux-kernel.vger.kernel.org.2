Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4285D3A6AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhFNPvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhFNPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:51:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ACBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:49:11 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id k8so3912592lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvxA21VumxeBH80QU+YFcZjpYmFJP2YEnOU9brfcC/Q=;
        b=ov3+e6XcGW7aaTgitcXgtvPoIULYqS4OqrYI5NXLHClAO16OfPyuCdmO7oUzbB28/H
         gnbpQAf6lHGUsrfpiqjqCgd9aNJD9pwFRPL0alRWw9U2qb7IEe1DbA5apv1b85+0YQRI
         fPGBmONGKxwlX/8gkRyO/vXXjiNE+mJzYbMPtt3KlNBDE547jiPlu+4o1lT/czrP+VdA
         zYWXsFZU7WgMWs0TY+3JRQPoF+VPj5NmeRDIFB7Ilmtz5XaFBxsUkgF51mXrbRvsmSFJ
         KdLw88W3xU2OhiBJdEyQ+0c4qfxTGwO1puVM0UB9ZE4qGoS+QDgB/MMQG4hH3N7wMF/D
         UOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvxA21VumxeBH80QU+YFcZjpYmFJP2YEnOU9brfcC/Q=;
        b=s1nYxoQdFQ7W/axx9hdgHx4BVJj6+NIvc637MpH78ygoWgiLbTM9z15iPSRuOyZx3c
         8xuoHeDBV0HlU08JPaBdNgIkV1OafSlRvm/4BcClfSYyspdzfYbijGRRBTRpZRfNFVlw
         w9JjGi5byGuqlXw3YDf7kqvwpYoxMUlfgnDRnbTqO9/9ZXDTPen8+wMC8BerN+JX7caQ
         1BsmixAhwLGZrQZ9Q4ks9j8f7M3UoKH4lPUpRbdUJAR1NgAUrh0te+O11+R/+1JB/Gg3
         35YDjr1URUmTj6QZ0tMTGJlpcOP9xRE5R6jKrCz/pzqGHkPKdfpT2daJS9yqQly7bgy6
         0oeQ==
X-Gm-Message-State: AOAM531m7oF09su2B2LMtJcdryx6Ufavq62tSbB5HJHlBtf+Ufbxjx2k
        RH3Gzfm+bL5pcIieXhZftFTxvSwos6vz9cDeJWb6Ww==
X-Google-Smtp-Source: ABdhPJxznhPx2RrVYUHfLp6eoaT4EB22Qs8+vOyCmJDNT5wKOpSDC4gZ0LhLmFc7sPRynmyvbZJGPqcDnBVdMWCtsmY=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr6984068ljg.401.1623685750313;
 Mon, 14 Jun 2021 08:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210610150324.22919-1-lukasz.luba@arm.com> <20210610150324.22919-3-lukasz.luba@arm.com>
 <81d7bd73-a61a-5501-f8ec-77e195355013@arm.com>
In-Reply-To: <81d7bd73-a61a-5501-f8ec-77e195355013@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Jun 2021 17:48:58 +0200
Message-ID: <CAKfTPtDcOt6ELdUXk9yoTc4QtAcT-5iad9UAB4COPyrN8z5umg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>, amitk@kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 at 17:29, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
> Gentle ping. Could you have a look at this implementation, please?

Ah yes, this has been lost in my inbox. Let me have a look at it

>
>
> On 6/10/21 4:03 PM, Lukasz Luba wrote:
>
> [snip]
>
> > @@ -6527,8 +6527,12 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> >       struct cpumask *pd_mask = perf_domain_span(pd);
> >       unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
> >       unsigned long max_util = 0, sum_util = 0;
> > +     unsigned long _cpu_cap, thermal_pressure;
> >       int cpu;
> >
> > +     thermal_pressure = arch_scale_thermal_pressure(cpumask_first(pd_mask));
> > +     _cpu_cap = cpu_cap - thermal_pressure;
>
> I've done the implementation according to your suggestion. That should
> provide the consistent usage.
>
> Regards,
> Lukasz
