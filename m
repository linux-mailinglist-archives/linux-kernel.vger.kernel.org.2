Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8427C393D11
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhE1G2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 02:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhE1G2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 02:28:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DF1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 23:26:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id e17so3751705lfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pcPeM9wIRz+ZVVtEgOoKIlWK/XJmHprXXczkYzaUkco=;
        b=fUxZIWK9IAU3hpA+lujI8aNk7uZfF5gR5gI7VA4rTiHpaV2PGzkgayC23C4ywz3PrW
         0yk5zPClOn7RBF+JbITpQ2fD6wr1VLQCtzFgz9wv+VKAjMw7ErvxN40NnZZtb9vKJPZA
         omhQGiUR0hEooNGs4451ln4LB1j7lrfGMTJq/9/ExFlz9jqgdNVBwAVWFYX3N3dgfD6q
         tFY5ssmzENSOKZQV888ZHu900SziTw9zeUDQI4yz/cALHl8b5873WApAnom2ItA5xDiR
         dLathv50Q+7ghMPotGsyaUB+yEZl+CJphAJblM0uMmIhigog7gG5XS5M6NXfsRLMRr2q
         8pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcPeM9wIRz+ZVVtEgOoKIlWK/XJmHprXXczkYzaUkco=;
        b=fuWkg2rIyQUovFrGPKUkjNatADHm5OVJkxWAOh4B694C4gUtBTDjZzdUeP/1llF9ML
         +ot6Tw9QLxsewC6kUKbXjKfgNfC5MU8NHY/kCZPGvII8A72YaClNeLKT7/p8zkFbPYoz
         WwsiwfOHfSDSAXdQVnd1XdsMTnLaGnBeTzqPkjZknVOOdHEo9TyWKnXwG+tWjSODXGkt
         RRRSLFI+AyHQ/fiy6UbJb1wc7Hcp1HpNeGV198Wk5sip3NYPaCQuPt++/pBDCkmhvRUk
         zashZVkNqwEtFWp3j5wUA1TyjaBfAzShpBkErUlJpjQYj8DsnfrNUlNA/ilrOM/iWDb6
         JAlQ==
X-Gm-Message-State: AOAM533Bc4v+ew7jX0E71jj6/7nWRU8dR/K1xBT6G0WoyDnY8AT1ffWM
        WtfuYMtUObzHX+sMF8YwE3pbGsr2GpXPg3ZYwOc=
X-Google-Smtp-Source: ABdhPJzANJFTNM+8+vfMjfYS4hL7h4c1JydtKO4kh4wrTtrNs1lqRlpwu3/qNhvZdsPZpNUy67VQ/x+oM5FttsWBImE=
X-Received: by 2002:a05:6512:3488:: with SMTP id v8mr4691448lfr.622.1622183186208;
 Thu, 27 May 2021 23:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210514103748.737809-1-dietmar.eggemann@arm.com>
 <20210519160633.GA230499@e120877-lin.cambridge.arm.com> <cb72557a-6039-df95-7e25-a7f37d3f9cef@arm.com>
 <CAB8ipk8POOzM2Dut0gcqsgNO0r2585GGv4SG+a1mOmMnrW=Vrw@mail.gmail.com> <a8ab9455-a9be-2349-d23a-676aa89fbf2d@arm.com>
In-Reply-To: <a8ab9455-a9be-2349-d23a-676aa89fbf2d@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Fri, 28 May 2021 14:25:29 +0800
Message-ID: <CAB8ipk93Qux6C4X01oHJRUNumYxR7QbZXWx28DCyUZo8KDvi3A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 6:38 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 27/05/2021 07:41, Xuewen Yan wrote:
> > Hi
> >
> > On Wed, May 26, 2021 at 10:59 PM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 19/05/2021 18:06, Vincent Donnefort wrote:
> >>> On Fri, May 14, 2021 at 12:37:48PM +0200, Dietmar Eggemann wrote:
>
> [...]
>
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index c7e7d50e2fdc..0a0bca694536 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -357,6 +357,16 @@ struct util_est {
> >>  #define UTIL_EST_WEIGHT_SHIFT          2
> >>  } __attribute__((__aligned__(sizeof(u64))));
> >>
> >> +/*
> >> + * This flag is used to synchronize util_est with util_avg updates.
> >> + * When a task is dequeued, its util_est should not be updated if its util_avg
> >> + * has not been updated in the meantime.
> >> + * This information is mapped into the MSB bit of util_est.enqueued at dequeue
> >> + * time. Since max value of util_est.enqueued for a task is 1024 (PELT util_avg
> >> + * for a task) it is safe to use MSB.
> >> + */
> >> +#define UTIL_AVG_UNCHANGED 0x80000000
> >> +
> >
> > IMHO, Maybe it would be better to put it in the util_est structure
> > just like UTIL_EST_WEIGHT_SHIFT?
>
> Yeah, can do.
>
> I just realized that 'kernel/sched/pelt.h' does not include
> <linux/sched.h> directly (or indirectly via "sched.h". But I can easily
> move cfs_se_util_change() (which uses UTIL_AVG_UNCHANGED) from pelt.h to
> pelt.c, its only consumer anyway.

Since there are so many questions, why not add ( #include "pelt.h" )
directly into (kernel/sched/debug.c)?

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 9c882f20803e..dde91171d4ae 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -7,6 +7,7 @@
  * Copyright(C) 2007, Red Hat, Inc., Ingo Molnar
  */
 #include "sched.h"
+#include "pelt.h"

 /*
  * This allows printing both to /proc/sched_debug and
