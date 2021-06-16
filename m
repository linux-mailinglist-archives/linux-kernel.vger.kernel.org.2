Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616A53A903F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhFPECu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhFPECt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:02:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE873C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:00:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c15so354353pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=3Xn68yu1x6qsTSouE+NahyiZXsqFlqPyo+fdBqLvNOU=;
        b=iaYfGmb4286My4x/h6/j7MlLd8CjA5xHsGAy2S28yPACYjLv8shJ+ZYSuk0xHkgR6P
         99ml5TFzCViw0vLtpL1FOZl/8n6DTvv5YN3p1nO2BUtAj+z6Ga0JeqFV5ZySBB/9cTsT
         TCrLdKDz6fewZSRTaJJ/2wQqZ5EWLie0uWu9CHybKG+FUMprafnTXRYMJS3n2tSi71re
         erCeQgJnt6yOgmkhJ0yVSobXvKrJaSM9AC1YadcpKwkgI1JR7SUpaJ0pL6gpUskPQo89
         dHq5qPH4YJEduUaKaN+ubaKOKS/HIN/T7s2HR2udeLeWWE7ujkMSjnOGn21U0fn/p3Cc
         rSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=3Xn68yu1x6qsTSouE+NahyiZXsqFlqPyo+fdBqLvNOU=;
        b=KlESgXiAi6EOirN3IQbX9bLR23VXbGBzFlI/Bu+RA6w8OU7Vfp0QC9yycSIhfHxewZ
         ym0UxgwTO+0osa0jrce1KpldgFNUEqoEOPSyRdmgVIYOvdImre3RvOMZSGMWx/I3eB9d
         1MwfJ8E6Vfwze9BA0jIiPuLXLcrmlmq5p8NisZY5+YfhexSUl+9Ui+APsRNUhIzkVdzO
         Hqpk9w2CTT23aPKcAV3XrXS56G7po9iWzAGo/47KYOZFmx/+80sm9wa78bvgkOIdcr1Y
         qPQufLi7moS8uYD6H7bbq+qFq6KVSWNuRimTS+wzGzwxK044rtBG8A7JKPiTpadURdBh
         F6rQ==
X-Gm-Message-State: AOAM532+R+y15DqefmW9G5VXI+G0NG8UftQ58QLGE/OfnvcuK6klp8+x
        Yfu+nQ/YND58AysJMURc1d8=
X-Google-Smtp-Source: ABdhPJzx89+hIWB4Isy3iwKiyArPeWHbZaZQjShRlf/qZCE8V/8V0mZFyiOPNFeG3SgQaI0YwBfQtg==
X-Received: by 2002:a17:90a:5504:: with SMTP id b4mr2791594pji.208.1623816042444;
        Tue, 15 Jun 2021 21:00:42 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id i14sm577967pjv.15.2021.06.15.21.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:00:42 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:00:37 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/8] membarrier: Document why membarrier() works
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1623813516.git.luto@kernel.org>
        <b648efcb72feb257b9fe004bd132f581805ec0d6.1623813516.git.luto@kernel.org>
In-Reply-To: <b648efcb72feb257b9fe004bd132f581805ec0d6.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Message-Id: <1623814509.xcl6pmt93d.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
> We had a nice comment at the top of membarrier.c explaining why membarrie=
r
> worked in a handful of scenarios, but that consisted more of a list of
> things not to forget than an actual description of the algorithm and why =
it
> should be expected to work.
>=20
> Add a comment explaining my understanding of the algorithm.  This exposes=
 a
> couple of implementation issues that I will hopefully fix up in subsequen=
t
> patches.
>=20
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  kernel/sched/membarrier.c | 55 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index b5add64d9698..3173b063d358 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -7,6 +7,61 @@
>  #include "sched.h"
> =20

Precisely describing the orderings is great, not a fan of the style of the
comment though.

>  /*
> + * The basic principle behind the regular memory barrier mode of membarr=
ier()
> + * is as follows.  For each CPU, membarrier() operates in one of two
> + * modes.

membarrier(2) is called by one CPU, and it iterates over target CPUs,=20
and for each of them it...

> Either it sends an IPI or it does not. If membarrier() sends an
> + * IPI, then we have the following sequence of events:
> + *
> + * 1. membarrier() does smp_mb().
> + * 2. membarrier() does a store (the IPI request payload) that is observ=
ed by
> + *    the target CPU.
> + * 3. The target CPU does smp_mb().
> + * 4. The target CPU does a store (the completion indication) that is ob=
served
> + *    by membarrier()'s wait-for-IPIs-to-finish request.
> + * 5. membarrier() does smp_mb().
> + *
> + * So all pre-membarrier() local accesses are visible after the IPI on t=
he
> + * target CPU and all pre-IPI remote accesses are visible after
> + * membarrier(). IOW membarrier() has synchronized both ways with the ta=
rget
> + * CPU.
> + *
> + * (This has the caveat that membarrier() does not interrupt the CPU tha=
t it's
> + * running on at the time it sends the IPIs. However, if that is the CPU=
 on
> + * which membarrier() starts and/or finishes, membarrier() does smp_mb()=
 and,
> + * if not, then membarrier() scheduled, and scheduling had better includ=
e a
> + * full barrier somewhere for basic correctness regardless of membarrier=
.)
> + *
> + * If membarrier() does not send an IPI, this means that membarrier() re=
ads
> + * cpu_rq(cpu)->curr->mm and that the result is not equal to the target
> + * mm.

If membarrier(2) reads cpu_rq(target)->curr->mm and finds it !=3D=20
current->mm, this means it doesn't send an IPI. "Had read" even would at=20
least make it past tense. I know what you mean, it just sounds backwards as
worded.

> Let's assume for now that tasks never change their mm field.  The
> + * sequence of events is:
> + *
> + * 1. Target CPU switches away from the target mm (or goes lazy or has n=
ever
> + *    run the target mm in the first place). This involves smp_mb() foll=
owed
> + *    by a write to cpu_rq(cpu)->curr.
> + * 2. membarrier() does smp_mb(). (This is NOT synchronized with any act=
ion
> + *    done by the target.)
> + * 3. membarrier() observes the value written in step 1 and does *not* o=
bserve
> + *    the value written in step 5.
> + * 4. membarrier() does smp_mb().
> + * 5. Target CPU switches back to the target mm and writes to
> + *    cpu_rq(cpu)->curr. (This is NOT synchronized with any action on
> + *    membarrier()'s part.)
> + * 6. Target CPU executes smp_mb()
> + *
> + * All pre-schedule accesses on the remote CPU are visible after membarr=
ier()
> + * because they all precede the target's write in step 1 and are synchro=
nized
> + * to the local CPU by steps 3 and 4.  All pre-membarrier() accesses on =
the
> + * local CPU are visible on the remote CPU after scheduling because they
> + * happen before the smp_mb(); read in steps 2 and 3 and that read prece=
eds
> + * the target's smp_mb() in step 6.
> + *
> + * However, tasks can change their ->mm, e.g., via kthread_use_mm().  So
> + * tasks that switch their ->mm must follow the same rules as the schedu=
ler
> + * changing rq->curr, and the membarrier() code needs to do both derefer=
ences
> + * carefully.

I would prefer the memory accesses and barriers and post-conditions made=20
in a more precise style like the rest of the comments. I think it's a=20
good idea to break down the higher level choices, and treat a single=20
target CPU at a time, but it can be done in the same style

   p =3D rcu_dereference(rq->curr);
   if (p->mm =3D=3D current->mm)
     // IPI case
   else
     // No IPI case

   // IPI case:
   ...

   // No IPI case:
   ...

> + *
> + *
>   * For documentation purposes, here are some membarrier ordering
>   * scenarios to keep in mind:

And I think it really needs to be integrated somehow with the rest of=20
the comments that follow. For example your IPI case and the A/B cases
are treating the same subject, just with slightly different levels of=20
detail.

Thanks,
Nick
