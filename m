Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC23B8B68
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 02:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhGAAsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 20:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238259AbhGAAsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 20:48:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 638F661424
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 00:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625100372;
        bh=0OplSnVaoxKOPAKIj0YXj4H1e8gkOZHWvzcV1/ElgJA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YQvrmmvRQztIwU6L7vDKUtlM29SnA6smSKQNMHpw0MNk8ZYFltQE1kTnxXMr/JhMC
         WwW19dhj2NRSDywPQY6odxYiRb3lBx56D2oOw+vDJ33meaxFx3bflxogQMunJM7j5u
         Uf4s47mQN/T2mW0QFotYo1hSWwhTv/jgZfmvwQgYFJ20hvI2RzezdnwRwSqJIMDt+t
         qa0kgtvxyKMKtEXQCwqHHT68PZb43z/QGtJhM5qCD5IzucN6TfH4K/8J3FX5mkS8rC
         BWKgKVCjNrDy6I6wOF3Qj1P4tb0/3zLVxc6Kvh0+q9GcsW8cqbLV+P6t2x1UVdDEzh
         x7Cq/8QD7mDEA==
Received: by mail-lf1-f50.google.com with SMTP id q18so8520149lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:46:12 -0700 (PDT)
X-Gm-Message-State: AOAM530IUGEQm1vQ53Tn+Fgm8aj+F0uy3LK5KHrQGHHlb6ol6bDn/y7a
        0Eq26lEz6pGKdvfzBBepKuqmLiVBXajhUstdSujVuQ==
X-Google-Smtp-Source: ABdhPJxUMSsYleMar6Ny4OBozaHRTablcTTgOJypvmdOI2KwxsSVPgnD113vOEQRqSPVn4WCmT84R/kKOTjaT4scv4A=
X-Received: by 2002:a05:6402:4393:: with SMTP id o19mr49699733edc.263.1625100360517;
 Wed, 30 Jun 2021 17:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
In-Reply-To: <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 30 Jun 2021 17:45:49 -0700
X-Gmail-Original-Message-ID: <CALCETrW7Mm6xNwdhsEd9LZFJNJ_5ZtBPfTiqs=np3V7cqo=cAA@mail.gmail.com>
Message-ID: <CALCETrW7Mm6xNwdhsEd9LZFJNJ_5ZtBPfTiqs=np3V7cqo=cAA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 11:51 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Jun 23, 2021 at 12:28 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > In modern systems it's not unusual to have a system component monitoring
> > > memory conditions of the system and tasked with keeping system memory
> > > pressure under control. One way to accomplish that is to kill
> > > non-essential processes to free up memory for more important ones.
> > > Examples of this are Facebook's OOM killer daemon called oomd and
> > > Android's low memory killer daemon called lmkd.
> > > For such system component it's important to be able to free memory
> > > quickly and efficiently. Unfortunately the time process takes to free
> > > up its memory after receiving a SIGKILL might vary based on the state
> > > of the process (uninterruptible sleep), size and OPP level of the core
> > > the process is running. A mechanism to free resources of the target
> > > process in a more predictable way would improve system's ability to
> > > control its memory pressure.
> > > Introduce process_reap system call that reclaims memory of a dying process
> > > from the context of the caller. This way the memory in freed in a more
> > > controllable way with CPU affinity and priority of the caller. The workload
> > > of freeing the memory will also be charged to the caller.
> > > The operation is allowed only on a dying process.
> >
> > At the risk of asking a potentially silly question, should this just
> > be a file in procfs?
>
> Hmm. I guess it's doable if procfs will not disappear too soon before
> memory is released... syscall also supports parameters, in this case
> flags can be used in the future to support PIDs in addition to PIDFDs
> for example.
> Before looking more in that direction, a silly question from my side:
> why procfs interface would be preferable to a syscall?

It avoids using a syscall nr.  (Admittedly a syscall nr is not *that*
precious of a resource.)  It also makes it possible to use a shell
script to do this, which is maybe useful.

--Andy
