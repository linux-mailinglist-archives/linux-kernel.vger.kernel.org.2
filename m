Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3283E305D32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhA0N3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbhA0N1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:27:34 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253E3C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 05:26:54 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f19so2074952ljn.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 05:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+sDR/w7Eveczq8LB44W6tmFFVi8mdamvh+W/eB0wyk=;
        b=YzMKb5u3Pd0f6J/JY15610qaqHWx0lOdWq2Y+LPU558lxjp0E+dhdIr7xJsCTfboDV
         0o0GZDQV83L3rTzVPuNF2QmSwr3154vfvBC4LVbvymfcywpOCcXQp4j8Zt3MKh+1nPrt
         mkLAvhVoCzvxyazyt4o6gL8BBqEIyRvTzL3JNnQaK63oQ8B2yqCn312nHIHM0t5Pa3b2
         jpM1QlkyaxvY3K5hD4761tDt2iOtXx519N2e23KP85qIidkBSckQiRwWaaGlZ0Z5wdM7
         m1cRjqaZ7tLzI31aP6wgbr9UF2LRrIzH+/TyE2G0iJch8nAJNJqIomwxoTD6iQyzPBKz
         KE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+sDR/w7Eveczq8LB44W6tmFFVi8mdamvh+W/eB0wyk=;
        b=b/g0T8jJzZcAqVINoF87a3RZVvAUcK3gNCWr/kolzYdPFVf0l8TqzacDMpG06LPKAT
         P/vKZBcrElpmiNKB1vQzsQbKcBTpy2jOQ4pXdmnF6dldKxcrWbP0kz57JaW6h3aFqtDM
         AbZSvXPKAW6SyKyAlm/106tcDVWLZt+NqdCvDjeIfOjNvXdEB7+gm/sL7CCKcCDh5vmd
         aNIoc+9pQdrty7Jg4JNiNvFwvaylDzDNk7v5LXrwHEo/omOpHD+t4elGGxB6EFZI7LUH
         4lDgIoddiuSu+DDPDSsDVvPZbThVIEw75rJhLbZS/72k7eK4LSvZggV4W4O4AsN2WHI6
         nGaA==
X-Gm-Message-State: AOAM532LxOK9B/CFLArObwNLzU0pP5w95OHY5zKDjmK2/WHOzy2pKCY2
        OiXsk1yFYlv3Lbb4+k6V1Xqfq2fmrqSoiHx4vKCHBQIOH+0=
X-Google-Smtp-Source: ABdhPJwx2AfZRejfUBPa2m+p7nl3nJztqNAkOI5JiBWNEDmoO7wFDH/An2XTLLifR2n89nWtcV2VUGbOJ/IQ38RNKw4=
X-Received: by 2002:a2e:9548:: with SMTP id t8mr5031008ljh.284.1611754012645;
 Wed, 27 Jan 2021 05:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20210125085909.4600-1-mgorman@techsingularity.net>
 <20210125085909.4600-5-mgorman@techsingularity.net> <CAKfTPtBhq25D8iZ67n+kkf9Mdyf+OradvVC5pG0MeZEMKZmU2g@mail.gmail.com>
 <20210127120245.GC3592@techsingularity.net> <CAKfTPtB=vh0FzszeOS5ND4Voq3ck2AQgruF-4zC-K1hSSsbT_A@mail.gmail.com>
 <20210127132121.GD3592@techsingularity.net>
In-Reply-To: <20210127132121.GD3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 27 Jan 2021 14:26:41 +0100
Message-ID: <CAKfTPtB3_t_FBB21drYbcT7aUp10tZ-rtZ91Rh08+H+a-h==RQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: Merge select_idle_core/cpu()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 at 14:21, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 27, 2021 at 02:07:50PM +0100, Vincent Guittot wrote:
> > > @@ -6162,18 +6162,16 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > >
> > >         for_each_cpu_wrap(cpu, cpus, target) {
> > >                 if (smt) {
> > > -                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > -                       if ((unsigned int)i < nr_cpumask_bits)
> > > -                               return i;
> > > +                       idle_cpu = select_idle_core(p, cpu, cpus, &idle_cpu);
> >
> > but how do you differentiate idle core (return value) and an idle cpu
> > in the core set in &idle_cpu
> >
> > You will return as soon as a cpu is idle and before testing all cores
> >
>
> Bah, I'm sorry, I was context switching between multiple tasks and failed
> to engage brain. I'll apply your hunk and resend. I don't think this

That's also happen to me

> merits retesting as the saving of avoiding the intermeriate is marginal.

I agree. You can add my Reviewed-by

>
> --
> Mel Gorman
> SUSE Labs
