Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455E23C62C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhGLSmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 14:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLSmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:42:11 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3596EC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 11:39:22 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a16so30580601ybt.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ho/Rg+kWQBT3g0s4WUPaNn7FgGVbD55gWWoqdPMQr/Y=;
        b=cZPpg3JNJSZsY/M2IDNiSomK8Bf2SHwo5L67jNM4nDO+nxG8cUbpV2UP/O1+xGbJJQ
         N3yHipF+FIfrgTJWdYILf8fxMwvIVBaoaYn+UaFaoIBpviZL0ck9f+OvxI2rj5X6igu2
         9MOcR63E99EXetd822cmkj3AislCImB4DqhqpLJQpS1xq4z6p3vJnKixW2tJYI5oCcwR
         5Uo+ye3cBtP++OBYZEpkuTZ/vXgj6CkeDTkVV3MXb65iOlqhkGUbYAEA8JlatVoA+wCW
         3ifxHwcoVqscoVRkxNZRWTH4HEgOkH/YoxoQVHfm7bIpd/cdTorb/vS+UG9NHgjbZmNd
         FOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ho/Rg+kWQBT3g0s4WUPaNn7FgGVbD55gWWoqdPMQr/Y=;
        b=Pldfsh80M/C4bBzqRH/Mxl/YFLfwBv4eK+nG+zkf8E/TqN5Yqw4+a+alQ0GcLb3kmm
         kiGxBiGHhz3Vsa/+KwNMs8Xdqgs8RisnMPtumvREii40sSBzEheEAx/3/3SxPV7ljBLQ
         ua8ChhmgBeNsqF8KsYprDq9MNQuYx9nV+CBwLuq+iRDynGTEttAnXoFHDgWPE5HOdR9y
         opz4bFLDMsNmt2+l7aeqXgUXxGVd51YheMqwLzmdTNq6rQlF1qxICKEJm8ef0K4bXgQg
         /+7hzPFuL5M263Lznm9MuAgKDfqPebQrRTsJ1IzrrIM5vMtTcJMGpJxJOdKKdEWX38Ml
         fc6w==
X-Gm-Message-State: AOAM532KHwZJss1Tb16BwGjwTa/nctO5aaNGBCvSewzAaTtUcO3EWuzz
        C9CPtyjMWEeFGKF06rIJ0s0wqmkqOcTwYCdp1k9K7A==
X-Google-Smtp-Source: ABdhPJw2Wd3lkFyCSaKE1R+Gmhq+CNRD3Sbcu3fX63Ehl7Ot2KbpAfryBXz7PS6nVCtlP1bo0qoVMzukbaU1xdsEhdc=
X-Received: by 2002:a25:71c4:: with SMTP id m187mr414827ybc.397.1626115161245;
 Mon, 12 Jul 2021 11:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <87sg0qa22l.fsf@oldenburg.str.redhat.com>
 <CAJuCfpEWpvw+gW+NvBPOdGqUOEyucFoT8gdC2uk18dMBQFbhqw@mail.gmail.com>
 <87wnq1z7kl.fsf@oldenburg.str.redhat.com> <CAJuCfpFt55Dw1uW3S6_AincNfPaAtwdi6iXYVvFr7x3fvt4uzw@mail.gmail.com>
 <q2s48op3-n660-p8r4-op50-po43r2249r24@vanv.qr>
In-Reply-To: <q2s48op3-n660-p8r4-op50-po43r2249r24@vanv.qr>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 12 Jul 2021 11:39:10 -0700
Message-ID: <CAJuCfpF6v9QMzo81kn9zT1VEftKTHsot1ytE8Gfh3UZzqZ9WBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
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
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 5:51 AM Jan Engelhardt <jengelh@inai.de> wrote:
>
>
> On Thursday 2021-07-08 08:05, Suren Baghdasaryan wrote:
> >>
> >> That explains very clearly the requirement, but it raises the question
> >> why this isn't an si_code flag for rt_sigqueueinfo, reusing the existing
> >> system call.
> >
> >I think you are suggesting to use sigqueue() to deliver the signal and
> >perform the reaping when a special value accompanies it. This would be
> >somewhat similar to my early suggestion to use a flag in
> >pidfd_send_signal() (see:
> >https://lore.kernel.org/patchwork/patch/1060407) to implement memory
> >reaping which has another advantage of operation on PIDFDs instead of
> >PIDs which can be recycled.
> >kill()/pidfd_send_signal()/sigqueue() are supposed to deliver the
> >signal and return without blocking. Changing that behavior was
> >considered unacceptable in these discussions.
>
> The way I understood the request is that a userspace program (or perhaps two,
> if so desired) should issue _two_ calls, one to deliver the signal,
> one to perform the reap portion:
>
>         uinfo.si_code = SI_QUEUE;
>         sigqueue(pid, SIGKILL, &uinfo);
>         uinfo.si_code = SI_REAP;
>         sigqueue(pid, SIGKILL, &uinfo);

This approach would still lead to the same discussion: by design,
sigqueue/kill/pidfd_send_signal deliver the signal but do not wait for
the signal to be processed by the recipient. Changing that would be a
behavior change. Therefore we would have to follow this pattern and
implement memory reaping in an asynchronous manner using a
kthread/workqueue and it won't be done in the context of the calling
process. This is undesirable because we lose the ability to control
priority and cpu affinity for this operation and work won't be charged
to the caller.
That's why the proposed syscall performs memory reaping in the
caller's context and blocks until the operation is done. In this
proposal, your sequence looks like this:

pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
process_reap(pidfd, 0);

except we decided to rename process_reap() to process_mrelease() in
the next revision.
