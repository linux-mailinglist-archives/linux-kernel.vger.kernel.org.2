Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62DD35C61E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhDLMWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbhDLMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:22:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D864BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:22:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n138so21089463lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jGUYvG/VpC5dfomQS+f5L/i07bp1VPDdzETKNMiL1s=;
        b=uNsHyYk5XOw/ru9fHS2JRlmrhXQ0+AH9AV4jC/P07+q/ZsjeP37Tys7h6eX17FaC1+
         uH/cXTES6FoGYRsFVqMuAdP/DBfXpCD0Cr18XAmq24G+F+YM2rVFRtxpSL6qmZMMLsV8
         qUYUhkltcPYAYYlIjSRZgMN/MCoVmwrRxmCa9PabGe/iH/3lSd3wcTUDeoccI6DAlEjM
         2CTFkuk/mNxyhEU5E2/XYrtcGbpwtRtBTHweAibeOYRnXkSdfLy1Cq128NB4aViM2bw6
         B9XkKp5ItdmBJxb8he1i/MOxSHXPYNm0CjJ1KXh4fJKALspIqwG1cagCnmyo/11bJjtG
         Qpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jGUYvG/VpC5dfomQS+f5L/i07bp1VPDdzETKNMiL1s=;
        b=OPZVbIZwJl4RIslEFCtxeS4Q6f3lMKBZM9+V9/WOzsdJ+KsRkKpwaL1Vk2gVAQdTYW
         s95J7cXKJfS7cGrEIgIRbMRmfXdEsXXEcK7698WrsOcXAWxfd8dzmcrGneHMA0DyMxyQ
         qliR6vHpEpE8xECXdsGoqaaJ4IUSb/QLuJjjlQqtUSwyEeKXYUwa1p/YFqhL0nCmGnxb
         LyKGCWH/FsCYCUGRBjP7lH2Lz5hk04/nv7HkZo4lQYomOTRMvkhDGiREqakf29WaG0TY
         uHeosPrZRJLqva+IHsrpEbh7d1WbVwGT0zAG4PeTgwyNy/q+c/At4tTOhFFpCiZE7bON
         usGg==
X-Gm-Message-State: AOAM531CG5OqHZtcmiVC3iGgz1xuDC/mmMmftFELP0evBsNiGeB3qTLG
        YMfwNrrl5b2pDPQxx3MFzN8Fs7eQ+8qpjqJ05b2Dpg==
X-Google-Smtp-Source: ABdhPJw2aczAxT3OpeQMNApU63p9MloiCGzJo7fc9SRJVYCTmf+bpXSpLlMv8XcfNWJvJIoL1nWNrMoLVT0Eit/FZ1c=
X-Received: by 2002:a19:4082:: with SMTP id n124mr17935716lfa.154.1618230119272;
 Mon, 12 Apr 2021 05:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com>
 <20210412062436.GB2633526@linux.vnet.ibm.com> <20210412093722.GS3697@techsingularity.net>
In-Reply-To: <20210412093722.GS3697@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 12 Apr 2021 14:21:47 +0200
Message-ID: <CAKfTPtDX-p=gWAVgYzLNCNuQ2e=QP2pTeMs=BmNBo31fpGKxrg@mail.gmail.com>
Subject: Re: [RFC/PATCH] powerpc/smp: Add SD_SHARE_PKG_RESOURCES flag to MC sched-domain
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Rik van Riel <riel@surriel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Parth Shah <parth@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 at 11:37, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Apr 12, 2021 at 11:54:36AM +0530, Srikar Dronamraju wrote:
> > * Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2021-04-02 11:07:54]:
> >
> > >
> > > To remedy this, this patch proposes that the LLC be moved to the MC
> > > level which is a group of cores in one half of the chip.
> > >
> > >       SMT (SMT4) --> MC (Hemisphere)[LLC] --> DIE
> > >
> >
> > I think marking Hemisphere as a LLC in a P10 scenario is a good idea.
> >
> > > While there is no cache being shared at this level, this is still the
> > > level where some amount of cache-snooping takes place and it is
> > > relatively faster to access the data from the caches of the cores
> > > within this domain. With this change, we no longer see regressions on
> > > P10 for applications which require single threaded performance.
> >
> > Peter, Valentin, Vincent, Mel, etal
> >
> > On architectures where we have multiple levels of cache access latencies
> > within a DIE, (For example: one within the current LLC or SMT core and the
> > other at MC or Hemisphere, and finally across hemispheres), do you have any
> > suggestions on how we could handle the same in the core scheduler?

I would say that SD_SHARE_PKG_RESOURCES is there for that and doesn't
only rely on cache

> >
>
> Minimally I think it would be worth detecting when there are multiple
> LLCs per node and detecting that in generic code as a static branch. In
> select_idle_cpu, consider taking two passes -- first on the LLC domain
> and if no idle CPU is found then taking a second pass if the search depth

We have done a lot of changes to reduce and optimize the fast path and
I don't think re adding another layer  in the fast path makes sense as
you will end up unrolling the for_each_domain behind some
static_banches.

SD_SHARE_PKG_RESOURCES should be set to the last level where we can
efficiently move task between CPUs at wakeup

> allows within the node with the LLC CPUs masked out. While there would be
> a latency hit because cache is not shared, it would still be a CPU local
> to memory that is idle. That would potentially be beneficial on Zen*
> as well without having to introduce new domains in the topology hierarchy.

What is the current sched_domain topology description for zen ?

>
> --
> Mel Gorman
> SUSE Labs
