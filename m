Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5883341F1E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhJAQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhJAQOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:14:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1D1C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:12:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dn26so36528138edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADTH4O/xVdp0zOdiyrZ3pudKmhw84Ea6QbVkbGyXPnU=;
        b=YzUMn2zHMYqwvQBKhiWEsku2N+eKNBTI+NgPXvgIUqUC5qxgHv60MignLHtVF/VZ0x
         E6MW9T+m3/Us0J7G/+hgFygVnCvRy+NUXWIpA+wfzrzC5iWN8479sevsActE3Ldd/snx
         3uRUG8jjFlV9VwcpiETLWajM/me+mNTimHbLkm7r2lLf+25So73QHs8QnhfAvni7GlGZ
         eJJhJBz4XWqV7zhpAv+xhJQKKHtIVjkScUbpXc9iDz7N+jgr84PoK7EnB3bT6UbGY2IH
         ot2zwIAKydfo7GyAfMVsV32fpZ1y9mr0Ed9tNLXimKC54msw9BiZY83gsp6oqyhQyVfX
         nCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADTH4O/xVdp0zOdiyrZ3pudKmhw84Ea6QbVkbGyXPnU=;
        b=iG24ofXhDEXDChpm8HC3Rteyzg0ec2VXCLwHxLn1svg8lBgBIXCbYb/npWlCCDYlUM
         +WmGAcyf8oIyes658dddsbVj6PGnL8YhqH0TKJSDi2Z0NWLShigqgpAgSJd+f43Xjmd+
         n6DABaXUvSejunQ1I5pojs56+ej9dKGLOJQ0bdyaFyASzvpM/HOdyjumpPs0LrtatM72
         HvYRmiWkvtE1qJSDkaaFfwSPxugPOpwyW6XrfbAzGes09vnLWHEt5lkCNcDpFis3yA9k
         7317lMZ7JROcMkifQfSK9ubI2XRqUabEVb3Iabwu1HYJ0IMycPS+LTwi//v3vEIz2KzP
         XWJw==
X-Gm-Message-State: AOAM530tDPDctNxw0XfP9PLxx4Tj+NHXBE+bJ3v/f3sWfQXuP7o7AYWc
        N8UuQbgDETRB0/+l4MNbU2s6TGHJomCfdj1qE1w67g==
X-Google-Smtp-Source: ABdhPJwVoqKY1frUnuINUHM9ti7r8x1XUX0LdXrIumCujyF3cyWBggs5dXcf5xUvt6tJHIjcg/97oLVEFqtllUEfsGw=
X-Received: by 2002:a17:906:8e0c:: with SMTP id rx12mr7225749ejc.423.1633104768129;
 Fri, 01 Oct 2021 09:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210928122339.502270600@linutronix.de> <20210928122411.593486363@linutronix.de>
 <YVRT6QbX5zwiIJkI@hirez.programming.kicks-ass.net>
In-Reply-To: <YVRT6QbX5zwiIJkI@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 1 Oct 2021 09:12:34 -0700
Message-ID: <CALCETrVP3asoqWyNqEe+rDs+YECd9gnp9eFb1==X0140oMZ41g@mail.gmail.com>
Subject: Re: [patch 4/5] sched: Delay task stack freeing on RT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 4:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Sep 28, 2021 at 02:24:30PM +0200, Thomas Gleixner wrote:
>
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -172,6 +172,11 @@ static void delayed_put_task_struct(stru
> >       kprobe_flush_task(tsk);
> >       perf_event_delayed_put(tsk);
> >       trace_sched_process_free(tsk);
> > +
> > +     /* RT enabled kernels delay freeing the VMAP'ed task stack */
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +             put_task_stack(tsk);
> > +
> >       put_task_struct(tsk);
> >  }
>
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4846,8 +4846,12 @@ static struct rq *finish_task_switch(str
> >               if (prev->sched_class->task_dead)
> >                       prev->sched_class->task_dead(prev);
> >
> > -             /* Task is done with its stack. */
> > -             put_task_stack(prev);
> > +             /*
> > +              * Release VMAP'ed task stack immediate for reuse. On RT
> > +              * enabled kernels this is delayed for latency reasons.
> > +              */
> > +             if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > +                     put_task_stack(prev);
> >
> >               put_task_struct_rcu_user(prev);
> >       }
>
>
> Having this logic split across two files seems unfortunate and prone to
> 'accidents'. Is there a real down-side to unconditionally doing it in
> delayed_put_task_struct() ?
>
> /me goes out for lunch... meanwhile tglx points at: 68f24b08ee89.
>
> Bah.. Andy?

Could we make whatever we do here unconditional?  And what actually
causes the latency?  If it's vfree, shouldn't the existing use of
vfree_atomic() in free_thread_stack() handle it?  Or is it the
accounting?


-- 
Andy Lutomirski
AMA Capital Management, LLC
