Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51538C58B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhEULUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhEULU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:20:29 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A9CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:19:06 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e10so16272381ilu.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTX0Qm7AhkbA+fOvtExalJbmxjADAm11mbIn/fnNRss=;
        b=dO9akwikK1L7MlwcbXdnTRLps4QJgB1xha1wQPogUygScSXJaW5du/XlzXm1MqgnIJ
         46PcP23fGM3LplYjIe7s6XbMZMdSQI6+E7YfV+PbBFA5+YU4yPfRqISwKlBas/90OXtR
         ei3QPH09z3illmcMTrv/HD/jbcCnyBjGUFbYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTX0Qm7AhkbA+fOvtExalJbmxjADAm11mbIn/fnNRss=;
        b=VyR6x6opovWDaoJHrnRVnd4ACcA09g4acEHv8pYbN/17Xg8AveidwPVkSgP9yPqroN
         CiwMsXBBdSJJCIwO7JcRX4+K7u/Jr1HWxPfXxK3sWV2z7tIng5lz9kylkR58nWtbQuco
         Hjcol80LKt9raMf7omylSM9eOl67Pkgg+A9I4KMVLIzb0VIaaplszQzi8ymWNCk2jpwb
         i73ZkF1VpW8SwvP1xP8Jn5JrsTBsFXj4NLbf5YHZ1fMmU8vuthLdClMzrTmrIQR0d8qE
         mqHM+Nr8AZHREtyo7IMqM6EBOVqXTF4jsi8xVBEu1M6O0jjEGgLihjRrZu4w2UDta/e/
         7zzg==
X-Gm-Message-State: AOAM533dxVHRhXkh1dT/HaZUKk7QSpzIRbe5gVePeyrPAcymR+38TxLY
        q26o27A0GrSSnE76VImSeaoSCNE5dQHngRAlJBVBI/wj0fE=
X-Google-Smtp-Source: ABdhPJw5ytoDllcHq6I92P84Wr865tY27OzpDBbzLRRAvV5Um8VzMHHupjvRWHZIdegH+u1OfTN4J0qXz8eb1UQbH4M=
X-Received: by 2002:a05:6e02:1d82:: with SMTP id h2mr9616080ila.78.1621595945554;
 Fri, 21 May 2021 04:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils> <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net>
In-Reply-To: <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 21 May 2021 07:18:54 -0400
Message-ID: <CAEXW_YRjuGJtCao+=TcKhLgFidmW_xJLWUyBcXUeK9x6Ao6oPw@mail.gmail.com>
Subject: Re: config SCHED_CORE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 3:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 20, 2021 at 08:06:07PM -0700, Hugh Dickins wrote:
> > Hi Peter,
> >
> > make oldconfig gave me no help at all on how to decide whether to choose
> > SCHED_CORE Y or n, beyond it recommending Y.  Maybe you'll delete that
> > option later, or maybe removing the prompt string would silence it.
>
> Ah, you're quite right. I never seem to have gotten around to actually
> writing anything useful there :/ Similarly the documentation for all
> this seems to have gone missing too.
>
> Joel, could I ask you to refresh the document to match the current state
> of things and repost? I still whole hartedly despise this RST crud, it
> makes it so hard to read / modify the files.
>
> ( I think the latest version is here:
>   https://lkml.kernel.org/r/20210324214020.34142-8-joel@joelfernandes.org
> )
>
> Anyway, how is something like the below, Joel can add a reference to the
> document once it's there.

Sure thing, Peter! I will work on it and post a patch.

- Joel


>
> ---
>  kernel/Kconfig.preempt | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index ea1e3331c0ba..3c4566cd20ef 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -104,4 +104,16 @@ config SCHED_CORE
>         bool "Core Scheduling for SMT"
>         default y
>         depends on SCHED_SMT
> -
> +       help
> +         This option enables Core scheduling, a means of coordinated task
> +         selection across SMT siblings with the express purpose of creating a
> +         Core wide privilidge boundary. When enabled -- see prctl(PR_SCHED_CORE)
> +         -- task selection will ensure all SMT siblings will execute a task
> +         from the same 'core group', forcing idle when no matching task is found.
> +
> +         This provides means of mitigation against a number of SMT side-channels;
> +         but is, on its own, insufficient to mitigate all known side-channels.
> +         Notable: the MDS class of attacks require more.
> +
> +         Default enabled for anything that has SCHED_SMT, when unused there should
> +         be no impact on performance.
