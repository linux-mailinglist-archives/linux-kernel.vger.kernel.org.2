Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640C63D5AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhGZNDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhGZNDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:03:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5C1C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:44:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m9so11321329ljp.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLycPxviRjQS2vlWYgAqhStL9LKdE5LJjJtFS7Jae4Y=;
        b=kM3ffQibqdlLWCaxU3irV+dXOOAiJRgpArqXCrZqUlURkhV3Uj7T8ux2Ir7Z9cReit
         sl0WxaiR7gwq+eJ/XKMu6TRVKV1my3wGtPAGwJ2G3Qm+9koRzZtV+JdcqyUzr2EhIcfX
         ufHWsMiRjGklH8iHGZD4IGM6CFSx+vFneLC8532Df/g/4zOZ5s5OuUE0gHkaWpz/aIH0
         d5KATqF9cmZJGa/LlkElPYuMQubU9BvAUrDd7RNkVvdTbwypVi4BJheSfkGPEY7EHTTD
         iqyA7t9AjMkRHoUSEBnmRaMdq0wJ7r9mri8PykgK+wl00Zw8d52GCbEaSjmhABtQmzWK
         jg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLycPxviRjQS2vlWYgAqhStL9LKdE5LJjJtFS7Jae4Y=;
        b=XGvQaf4ucGu783bKd6yp9KqZiPYsu6d+AcEZoxVS3N47T+zGOt+cSXFjDcp2o6GHmB
         mD/dY8RVrXE1oAmQ4xN8Ct2y1pgwixJGSOS3rjNseKWY/dQkxbluSTIC9HlskS1C9bQV
         uWmuTCxVnsX6tBMuk3X38usxal5rWpaQ7lCGCwfXD/2lrLZ/9LfsSAVJKGUPTE/+mnKI
         HMpJSJpYNUutSQEWJExjfNfrTdDCxwcNkO/KgMPwP0hSSVuFKHWyz5uu7rZXf376Y/7q
         KE9FTUB/UCpkU2EK257dLBbVLZdYix6JREQsxI1uroaCfSvZJp2b64q9tPx0boX4GrbI
         E6tQ==
X-Gm-Message-State: AOAM531YFd628kJuRn62qo/b7RmkOD5FOuUwZTiZy6sWUr0az+VVjXxU
        zGR+lrVuPm0sFB9ngA+1Qcqna2U9xDU9y8VBD6/rIg==
X-Google-Smtp-Source: ABdhPJwAkFnDG7NuQtWLLexIiDYnWTWvIxBeII4m/0QIeM7dBhx7GXfH+UoikLc0g6EgogQ1N+7fjJ6zmkJsQ7tEbhE=
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr12408419ljj.279.1627307041973;
 Mon, 26 Jul 2021 06:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz> <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <YPqDnqULylkkzQG5@dhcp22.suse.cz> <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
 <CAJuCfpGmpwTv92joNuVPaEJg1PigtGQn2daywHaqF4TXjuiCWQ@mail.gmail.com>
 <CALvZod7Vb2MKgCcSYtsMd8F4sFb2K7jQk3AGSECYfKvd3MNqzQ@mail.gmail.com> <YP5jyLeYsN3JtdX8@dhcp22.suse.cz>
In-Reply-To: <YP5jyLeYsN3JtdX8@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Jul 2021 06:43:50 -0700
Message-ID: <CALvZod4M6mF3VvAdade3n5fE1E0LQp+CeJHWLc+pHmZqqAhepg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
>
> Is process_mrelease on all of them really necessary? I thought that the
> primary reason for the call is to guarantee a forward progress in cases
> where the userspace OOM victim cannot die on SIGKILL. That should be
> more an exception than a normal case, no?
>

I am thinking of using this API in this way: On user-defined OOM
condition, kill a job/cgroup and unconditionally reap all of its
processes. Keep monitoring the situation and if it does not improve go
for another kill and reap.

I can add additional logic in between kill and reap to see if reap is
necessary but unconditionally reaping is more simple.

>
> > An alternative would be to have a cgroup specific interface for
> > reaping similar to cgroup.kill.
>
> Could you elaborate?
>

I mentioned this in [1] where I was thinking if it makes sense to
overload cgroup.kill to also add the SIGKILLed processes in
oom_reaper_list. The downside would be that there will be one thread
doing the reaping and the syscall approach allows userspace to reap in
multiple threads. I think for now, I would go with whatever Suren is
proposing and we can always add more stuff if need arises.

[1] https://lore.kernel.org/containers/CALvZod4jsb6bFzTOS4ZRAJGAzBru0oWanAhezToprjACfGm+ew@mail.gmail.com/
