Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0934436734E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243130AbhDUTTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243035AbhDUTTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:19:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE9CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:18:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x19so38059168lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50kzeCPGjm2JMXyK7PkTEiD0mm3C2OtO1PpsOLUYSss=;
        b=T5uVrfbF8qU1G524RKlJRFgst7C0N8b4H2i02+jwmhpvtNGQJmtRwATMQyisjPGKwT
         gsYjxwjD/BmmQlIvAf37RXRIKswGX+Hv5IHJWeJIGmVhisndacaJ5qoPcN/oMkAWKI2K
         rXoWb3LP/jKJJcJoTQxXEwTnmALDSCLAr8aF4kENjxcOQsR1FiyM3YpiQEEA+/MirhaW
         +P/0OecI6/mj//o2QV4f3/hm4ceifXZNLLqS/ltvN0Gkvy/DDlCZBBrWKzInmGXh+DJB
         lq2C30XJHf5e6QSu2w8xVzy48r71MroUUoeyLBA+TWWQtRq16jzncXwVIx0S3LBgkBnU
         pXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50kzeCPGjm2JMXyK7PkTEiD0mm3C2OtO1PpsOLUYSss=;
        b=coNGE2iTwOUJ5dR64QQiCte4ifJOI0VvIFO4mtIXL0L8XuU+X7pWSdaUSKOOT8hCGd
         VAOodWeLcZoIvGjKlRJYKC36a23ilxUhSng9YUKjjSmg3AVAQAXh2BtAkLYMnFKIrvSO
         EbrRKr2w8hTmtxjQQDtXzeENhnejPvqu/uoCGYki34ETz+vLqTUKB5X7aYnNxJWFx4dq
         WG5dwahfLxXaWZlOrgmvwx/WZe/cCmEPRm8V+e8i6IWgoOuKaQgPQGPEaP5490ps9o/W
         yQ5IcSolCwGz0IEpJIxeHXlhq6ObFKHYynqkyvI1IzCGo/6FoPfz38jF4JXRnkiOS4zo
         w9vA==
X-Gm-Message-State: AOAM531Yd2NTmPq4aVTMEPfIHDiO5gn3fFpLXOEE+actzs1RRpQ1e6eB
        hpnZpdkZ3CFvF/d2Kp5p3jFiLtkEnx+2+9oa+Aasrg==
X-Google-Smtp-Source: ABdhPJwRkaAF9GTcHU5UKL5G1pkSHZyZA+8YQsNebm8e4OwSf5Vk/lYmA3YonXQ9Ur4PbdStzCCHWudt0MGus1u4DzI=
X-Received: by 2002:a05:6512:92e:: with SMTP id f14mr14648390lft.347.1619032713794;
 Wed, 21 Apr 2021 12:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <699e51ba-825d-b243-8205-4d8cff478a66@sony.com> <CALvZod7AEjzWa6AR4Ym1jpfzT32hmepxvci6hXvNJTEQvcQqEw@mail.gmail.com>
 <1f8d300b-9a8b-de09-6d5d-6a9c20c66d24@sony.com>
In-Reply-To: <1f8d300b-9a8b-de09-6d5d-6a9c20c66d24@sony.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 21 Apr 2021 12:18:22 -0700
Message-ID: <CALvZod5+5ycobmSt=NC3VJF4FRMFmBQEN7SQgipyTDbzHEbPUQ@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     peter enderborg <Peter.Enderborg@sony.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:46 AM <Peter.Enderborg@sony.com> wrote:
>
> On 4/21/21 8:28 PM, Shakeel Butt wrote:
> > On Wed, Apr 21, 2021 at 10:06 AM peter enderborg
> > <peter.enderborg@sony.com> wrote:
> >> On 4/20/21 3:44 AM, Shakeel Butt wrote:
> > [...]
> >> I think this is the wrong way to go.
> > Which one? Are you talking about the kernel one? We already talked out
> > of that. To decide to OOM, we need to look at a very diverse set of
> > metrics and it seems like that would be very hard to do flexibly
> > inside the kernel.
> You dont need to decide to oom, but when oom occurs you
> can take a proper action.

No, we want the flexibility to decide when to oom-kill. Kernel is very
conservative in triggering the oom-kill.

> >
[...]
> > Actually no. It is missing the flexibility to monitor metrics which a
> > user care and based on which they decide to trigger oom-kill. Not sure
> > how will watchdog replace psi/vmpressure? Userspace keeps petting the
> > watchdog does not mean that system is not suffering.
>
> The userspace should very much do what it do. But when it
> does not do what it should do, including kick the WD. Then
> the kernel kicks in and kill a pre defined process or as many
> as needed until the monitoring can start to kick and have the
> control.
>

Roman already suggested something similar (i.e. oom-killer core and
extended and core watching extended) but completely in userspace. I
don't see why we would want to do that in the kernel instead.

> >
> > In addition oom priorities change dynamically and changing it in your
> > system seems very hard. Cgroup awareness is missing too.
>
> Why is that hard? Moving a object in a rb-tree is as good it get.
>

It is a group of objects. Anyways that is implementation detail.

The message I got from this exchange is that we can have a watchdog
(userspace or kernel) to further improve the reliability of userspace
oom-killers.
