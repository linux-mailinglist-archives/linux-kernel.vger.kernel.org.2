Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8223E38F494
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhEXUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhEXUwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:52:24 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F38C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:50:56 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e10so24549076ilu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMvdJ6e0TGJthcew58hIcfEGy6yVN34K0vE2tf/+Bz8=;
        b=KR49QNaO3RaeLTWOp0O3Ikqj0zvsIuqdHw4FQcsF0j8WugcIZTn0elIwpJTORZ7IIY
         nmjT4lUolNjUAPdvei9EcfHHow9nKEbb/7172md9Yp0deLZKcFbXz6C/sXwO0aIKCdPH
         Id4WO3vuPXuzBsOZq2S58mK512e7S6DGBPACI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMvdJ6e0TGJthcew58hIcfEGy6yVN34K0vE2tf/+Bz8=;
        b=Egr/3x7bZdDkxO1f+nfixciFMX2LOQnttarVGViIhBTRVFP6Fzo0+EYdlhk4sTIbFM
         uw8XavL+dwnD9OZBBJdZAWixLaqZFuHUZaxctW8r221rE5aYLLFW1IS9UBc8cH6HiQPa
         RopqUVyCG7DlhBMZ034s8SG0JfmF0JpBr4XUnd8fGMdcyA0KHzan/7Cd18qgbTxrbk+j
         HNX2uYxUBlEYrfK5rbaaZSVS+aIcXdD5Z1/32f4W328Of0awUF9FflTIpF+duD7DXred
         xAA3dgCyFg5ZCt9RyiIQHwMox2S9yUJMI5Op3ZxQUrLCReONJVgQnECE6rI2wo19lxkl
         ue4A==
X-Gm-Message-State: AOAM53279FdB9BH4duxAheersFt49JMAmeONqDg0/58MdHxx68FpiARE
        D13aIqXBqHVVt8Z3K/68/B7yB4A5ktYm6Z2uS6yUDSy6DDs=
X-Google-Smtp-Source: ABdhPJyyoGj9PWdUjgkqXrWmUEaoj5bkUnq6X4d09L6bceIL2V/SZ1veJDO63pab6+vcHA5ChcJUWDVg9r+acYzLKwc=
X-Received: by 2002:a05:6e02:1d82:: with SMTP id h2mr15039646ila.78.1621889454492;
 Mon, 24 May 2021 13:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
 <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net> <CAEXW_YRxOqQCF2FgXAjL3xkZhRD4rdFuxvyPd-ESXYQQ78cyfQ@mail.gmail.com>
 <YKe2vVvq9oSsNsTD@hirez.programming.kicks-ass.net>
In-Reply-To: <YKe2vVvq9oSsNsTD@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 24 May 2021 16:50:43 -0400
Message-ID: <CAEXW_YSC_Ee=EnX7csVkhoEF6KFYbusuNx=mQcyxfdu2R7a3Cg@mail.gmail.com>
Subject: Re: config SCHED_CORE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 9:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 21, 2021 at 07:57:35AM -0400, Joel Fernandes wrote:
>
> > > ---
> > >  kernel/Kconfig.preempt | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> > > index ea1e3331c0ba..3c4566cd20ef 100644
> > > --- a/kernel/Kconfig.preempt
> > > +++ b/kernel/Kconfig.preempt
> > > @@ -104,4 +104,16 @@ config SCHED_CORE
> > >         bool "Core Scheduling for SMT"
> > >         default y
> > >         depends on SCHED_SMT
> > > -
> > > +       help
> > > +         This option enables Core scheduling, a means of coordinated task
> > > +         selection across SMT siblings with the express purpose of creating a
> > > +         Core wide privilidge boundary. When enabled -- see prctl(PR_SCHED_CORE)
> > > +         -- task selection will ensure all SMT siblings will execute a task
> > > +         from the same 'core group', forcing idle when no matching task is found.
> > > +
> > > +         This provides means of mitigation against a number of SMT side-channels;
> > > +         but is, on its own, insufficient to mitigate all known side-channels.
> > > +         Notable: the MDS class of attacks require more.
> > > +
> > > +         Default enabled for anything that has SCHED_SMT, when unused there should
> > > +         be no impact on performance.
> >
> > This description sort of makes it sound like security is the only
> > usecase. Perhaps we can also add here that core-scheduling can help
> > performance of workloads where hyperthreading is undesired, such as
> > when VM providers don't want to share hyperthreads.
> >
> > Thoughts?
>
> You're right. And there's this whole class of people who want to use
> this to eliminate SMT interference.

That's good, even more core scheduling users ;-)

> I'll see if I can work that in
> without turning the whole thing into a novella or so ;-/

Your patch looked good to me (delta Randy/Hugh's comments). I still
owe you the documentation patch refresh, I'll send it out soon.
Thanks,

- Joel
