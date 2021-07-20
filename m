Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB8D3CFCB6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhGTOMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbhGTN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:57:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23F2C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:37:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f30so29559533lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rWWfzd6bQ9JjiqpPAkEm1e3rkA1YDcLMgeBdbZjGHE=;
        b=HKe/MM/CDpZt+dke7UDYRel5+FRRKk9Yw6Ua0mr69h36UDVSDxKhSkQS1pzI4Y98W/
         y9V69UHqD7m34WnU6PrkwK3yGSuLP5zBohcyW58x0hhg1sGMDyI9FqRhry3tPeBwpA3A
         wxKT6nknH9sF39nV/H5aFR2RJ4Pgoa3ct4OomK3jR1Nv0VSdwgVafX2iQd1FrKCgp9mT
         m5MZPkk27YwTaW7uI1/Y3Zmv6urRYetSrbVohznAjnU5JvElKLo3vqpDE+23PISKCKNm
         VILMxJLM9e+5ZjO2fV2cugUIjQQBULGIXVOu4Lw1FTaXea6seyt0GtoMI4IedHwa9+Xe
         bnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rWWfzd6bQ9JjiqpPAkEm1e3rkA1YDcLMgeBdbZjGHE=;
        b=P3s2M2DJGUxEkE6IqrnRtvQvLwwBQA88i95taH9o4CQAn78hLedKQN3cGWTRuZFf/O
         Qs3hQOuqUetejzhF2rbqCgDsBNOzXpWOu7pzaE1AzAaYEr2Fe9wM999F5IwqEYVzUFBs
         /qbYngX7rToBVGJwRBmfsBJEi+CVDUcbqgpT2RyIH8LhwAqeYMhFnP4BmZrs1uHsmGDg
         A9OzcvzTiyLFcBSLiS+hyv3+dH0+T3iv0R0VV8S5YNxh9vlbZckwoL1FpCmkQNV/8sP4
         Te/4H9EiT4w6wIIy871l70+KiC1IGybKV3OtzgACxd/l2UznbHh/knfyjDUcrKegoETy
         smqQ==
X-Gm-Message-State: AOAM530lvFuEUChmtHBD5iCzDsn1Y4iQOOu+d8TIjNYp6nSSkCVvM6jt
        SCIY0HHgpUmaosiriEVGOvsGa69TFfuQvdeMwSPLAA==
X-Google-Smtp-Source: ABdhPJzl9cEjTBW0ixoKmmdc2G7MbGTamkbs5Ag1DoLmJrzrRTrOjbe/FiP7e6yjIbYJNoecT0KuU0fx+hZ4c6ybxJA=
X-Received: by 2002:a19:ad4d:: with SMTP id s13mr21787072lfd.432.1626791854890;
 Tue, 20 Jul 2021 07:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod66KF-8xKB1dyY2twizDE=svE8iXT_nqvsrfWg1a92f4A@mail.gmail.com>
 <cover.1626688654.git.vvs@virtuozzo.com> <b19f065e-f3c9-2b20-2798-b60f0fc6b05f@virtuozzo.com>
 <87k0lmryyp.fsf@disp2133> <56816a9d-c2e5-127d-4d90-5d7d17782c8a@virtuozzo.com>
In-Reply-To: <56816a9d-c2e5-127d-4d90-5d7d17782c8a@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Jul 2021 07:37:23 -0700
Message-ID: <CALvZod7durMR7vYQ-5Uw5S=4UFTE5ojb=Vqk5oTEmRageH8zOg@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] memcg: enable accounting for signals
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 1:35 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> On 7/19/21 8:32 PM, Eric W. Biederman wrote:
> > Vasily Averin <vvs@virtuozzo.com> writes:
> >
> >> When a user send a signal to any another processes it forces the kernel
> >> to allocate memory for 'struct sigqueue' objects. The number of signals
> >> is limited by RLIMIT_SIGPENDING resource limit, but even the default
> >> settings allow each user to consume up to several megabytes of memory.
> >> Moreover, an untrusted admin inside container can increase the limit or
> >> create new fake users and force them to sent signals.
> >
> > Not any more.  Currently the number of sigqueue objects is limited
> > by the rlimit of the creator of the user namespace of the container.
> >
> >> It makes sense to account for these allocations to restrict the host's
> >> memory consumption from inside the memcg-limited container.
> >
> > Does it?  Why?  The given justification appears to have bit-rotted
> > since -rc1.
>
> Could you please explain what was changed in rc1?
> From my POV accounting is required to help OOM-killer to select proper target.
>
> > I know a lot of these things only really need a limit just to catch a
> > program that starts malfunctioning.  If that is indeed the case
> > reasonable per-resource limits are probably better than some great big
> > group limit that can be exhausted with any single resource in the group.
> >
> > Is there a reason I am not aware of that where it makes sense to group
> > all of the resources together and only count the number of bytes
> > consumed?
>
> Any new limits:
> a) should be set properly depending on huge number of incoming parameters.
> b) should properly notify about hits
> c) should be updated properly after b)
> d) do a)-c) automatically if possible
>
> In past OpenVz had own accounting subsystem, user beancounters (UBC).
> It accounted and limited 20+ resources  per-container: numfiles, file locks,
> signals, netfilter rules, socket buffers and so on.
> I assume you want to do something similar, so let me share our experience.
>
> We had a lot of problems with UBC:
> - it's quite hard to set up the limit.
>   Why it's good to consume N entities of some resource but it's bad to consume N+1 ones?
>   per-process? per-user? per-thread? per-task? per-namespace? if nested? per-container? per-host?
>   To answer the questions host admin should have additional knowledge and skills.
>
> - Ok, we have set all limits. Some application hits it and fails.
>   It's quite hard to understand that application hits the limit, and failed due to this reason.
>   From users point of view, if some application does not work (stable enough)
>   inside container => containers are guilty.
>
> - It's quite hard to understand that failed application just want to increase limit X up to N entities.
>
> As result both host admins and container users was unhappy.
> So after years of such fights we decided just to limit accounted memory instead.
>
> Anyway, OOM-killer must know who consumed memory to select proper target.
>

Just to support Vasily's point further, for systems running multiple
workloads, it is much more preferred to be able to set one limit for
each workload than to set many different limits.

One concrete example is described in commit ac7b79fd190b ("inotify,
memcg: account inotify instances to kmemcg"). The inotify instances
which can be limited through fs sysctl inotify/max_user_instances and
be further partitioned to users through per-user namespace specific
sysctl but there is no sensible way to set a limit and partition it on
a system that runs different workloads.
