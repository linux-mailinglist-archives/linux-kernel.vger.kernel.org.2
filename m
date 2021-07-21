Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5258B3D1A82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhGUXET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 19:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhGUXET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 19:04:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE66C061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 16:44:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b26so5759522lfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNOH2/EWCWyCcPN5nRIw6bxj97ptFU8T1+ifaWUKe/8=;
        b=kOhQvf4IYIR3eicIInu7WQAw4TeGseyHNyfhxD8/0BCDQy3CsTHZ4Dl23AGMsLz04W
         y1ML+adGVROT4tVrPgBccrE9+bkaPwqDvpBOAMKUKi/sIOEUhmy79Iws2adnaizbtE33
         GEYRCeg2RM2GYsUXMySCTe4qfZ0Cb1zdjmNaI5OsSd1EA0RG06d9D0BgZDMSb1sUcyWM
         SI/7aUwB0Yfy1m61g1RGlA22fyohWzm5Mrvb+K8U4qVkRksZWY4SPl+bznvraWv2T6Aj
         2teoNzB+HhGYfHYpaPpE7t0UFe/kEF/8JYuSynrBOJC2j9cDOofuN3RKT28yBQmxDARh
         UUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNOH2/EWCWyCcPN5nRIw6bxj97ptFU8T1+ifaWUKe/8=;
        b=EyYn41FJrrmvQdGl9170c5y2J3fBoZOU1aXg3kNBuh0MjIh0CjDIm7NcYSkq+vVo+1
         Z/I2JUo6niz7s5uedCCBmHXzoLmPHhdZLG3uh5ReXH+3BMV7suYFAJyLMvkF59VF7r0z
         fZH3FQ5nZ/0iAO3b/LtuQUuajB6d/31i5Tv4I/GJsi4yZV8orsa/d/A18f/uDkVb6IcZ
         FzDMxd4MOXRFR/3aagmmyts9QCUhFHrkcN9xblWz7etGViYufhpgze33HFOm2J99AeWR
         3KSbZx/Slpdm5GTK9qYJXXo/+MZnnVP62na8FoDPU+y1rTJ/2XQEWbw18Uk4LI3Pw7kS
         3qqQ==
X-Gm-Message-State: AOAM533cz73//QY1kxqJD7eW8LFLwVP/R7EtTggQD9NnkXwZuBHeaX4F
        xLRsPmyv0gczntgQwqDBH27AVnj8+WVQQjiOt4mIFA==
X-Google-Smtp-Source: ABdhPJzIb3/1vnWsrv1PxosdK2G+pBcYWqNar5sYdp62k3WAaBXBHkQpQxX83KMbaIyPRxJPcepynZMAyEUU8e9SMXk=
X-Received: by 2002:a19:7110:: with SMTP id m16mr27279438lfc.125.1626911065544;
 Wed, 21 Jul 2021 16:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210716184719.269033-5-posk@google.com> <2c971806-b8f6-50b9-491f-e1ede4a33579@uwaterloo.ca>
 <CAPNVh5cmhFEWr4bmODkDDFhV=mHLcO0DZJ432GEL=OitzPP80g@mail.gmail.com>
 <c8ea4892-51e5-0dc2-86c6-b705e8a23cde@uwaterloo.ca> <CAFTs51XW0H1UJKv0t2tq+5VLfgPMtZmDcxQVUQ5HkgDe38jHpw@mail.gmail.com>
 <5790661b-869c-68bd-86fa-62f580e84be1@uwaterloo.ca>
In-Reply-To: <5790661b-869c-68bd-86fa-62f580e84be1@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 21 Jul 2021 16:44:14 -0700
Message-ID: <CAPNVh5ecidSmKFW2ck0ASw44GUnP20m7baSP1+KXnGfkM8FLLg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4 v0.3] sched/umcg: RFC: implement UMCG syscalls
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     Peter Oskolkov <posk@posk.io>, Andrei Vagin <avagin@google.com>,
        Ben Segall <bsegall@google.com>, Jann Horn <jannh@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-api@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Buhr <pabuhr@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 12:56 PM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
>  > Yes, this is naturally supported in the current patchset on the kernel
>  > side, and is supported in libumcg (to be posted, later when the kernel
>  > side is settled); internally at Google, some applications use
>  > different "groups" of workers/servers per NUMA node.
>
> Good to know. Cforall has the same feature, where we refer to these groups
> as "clusters". https://doi.org/10.1002/spe.2925 (Section 7)
>
>  > Please see the attached atomic_stack.h file - I use it in my tests,
>  > things seem to be working. Specifically, atomic_stack_gc does the
>  > cleanup. For the kernel side of things, see the third patch in this
>  > patchset.
>
> I don't believe the atomic_stack_gc function is robust enough to be
> offering
> any guarantee. I believe that once a node is unlinked, its next pointer
> should
> be reset immediately, e.g., by writing 0xDEADDEADDEADDEAD. Do your tests
> work
> if the next pointer is reset immediately on reclaimed nodes?

In my tests reclaimed nodes have their next pointers immediately set
to point to the list head. If the kernel gets a node with its @next
pointing to something else, then yes, things break down (the kernel
kills the process); this has happened occasionally when I had a bug in
the userspace code.

>
> As far as I can tell, the reclaimed nodes in atomic_stack_gc still contain
> valid next fields. I believe there is a race which can lead to the kernel
> reading reclaimed nodes. If atomic_stack_gc does not reset the fields,
> this bug
> could be hidden in the testing.

Could you, please, provide a bit more details on when/how the race can
happen? Servers add themselves to the list, so there can be no races
there (servers going idle: add-to-the-list; wait; gc (under a lock);
restore @next; do stuff).

Workers are trickier, as they can be woken by signals and then block
again, but stray signals are so bad here that I'm thinking of actually
not letting sleeping workers wake on signals. Other than signals
waking queued/unqueued idle workers, are there any other potential
races here?

>
> An more aggressive test is to put each node in a different page and
> remove read
> permissions when the node is reclaimed. I'm not sure this applies when the
> kernel is the one reading.
>
>
>  > To keep the kernel side light and simple. To also protect the kernel
>  > from spinning if userspace misbehaves. Basically, the overall approach
>  > is to delegate most of the work to the userspace, and keep the bare
>  > minimum in the kernel.
>
> I'll try to keep this in mind then.
>
>
> After some thought, I'll suggest a scheme to significantly reduce
> complexity.
> As I understand, the idle_workers_ptr are linked to form one or more
> Multi-Producer Single-Consumer queues. If each head is augmented with a
> single
> volatile tid-sized word, servers that want to go idle can simply write
> their id
> in the word. When the kernel adds something to the idle_workers_ptr
> list, it
> simply does an XCHG with 0 or any INVALID_TID. This scheme only supports
> one
> server blocking per idle_workers_ptr list. To keep the "kernel side
> light and
> simple", you can simply ask that any extra servers must synchronize
> among each
> other to pick which server is responsible for wait on behalf of everyone.
>

I'm not yet convinced that the single-linked-list approach is
infeasible. And if it is, a simple fix would be to have two pointers
per list in struct umcg_task: head and next.

Thanks,
Peter
