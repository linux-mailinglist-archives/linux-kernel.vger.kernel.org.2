Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7D42A239
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhJLKiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbhJLKiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:38:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2160C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 03:36:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y26so86625618lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 03:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zd7HH8xjPS277anp7AVHGXl11wuo7iH5UTX9lFK8Jik=;
        b=qs9HCnZUsi4FMmOGxCOknKYuFP0jCo5vAxH5I56RZV1lzzgoIwLaZppRmTYYMRSm7h
         JyBwda8JgRwvdZJtKeN22PpOdblzTn1ZK6FVsnZDpGzKu7NFjht+xIi4fElnVHecQYwD
         /ERjXllLTrtEPVhCOIo3Qr19/zP5edzNIFRowQIK51/1o9RypQdOYmBY/9d9o54RXwOJ
         8HKbGoLuxwL4zlhX1NxgbO9NT5EviEP6RZiWLluHS9yv1yww84C9qWmYdlPrgFmF87fJ
         YJRo3is8ue4TF2ZfYVCzISC6e+gaNZ0g6nfKhSHXHsDqZrxND7QxBbSVQDs88mcDx4Ko
         vgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zd7HH8xjPS277anp7AVHGXl11wuo7iH5UTX9lFK8Jik=;
        b=daZ+D0xt37pxjw32AB076P0srNtJtfYKqN9fysrPpR8IzNU2CHLeIjA+EQw3onuVmd
         9g1iVhfE2x5jIxX5fgsrFcjkZyck12/24GjDX/vE7bN8JpGUzUtnMQL3HYoj/dsKoyLP
         fTsBYwyIpF5c+iF105qr2zqAMOi/jLmyHT7crxzL8TMdwk78sARJrtuhqNyDTFQuj176
         tOsk/VT3SrGEs13kYo7lMQbwTJcQVq+1NZnFzFuyoH6ipe0qwSCZ5mT4RJEK7bxGS75F
         1hd+4txU72J1U3rYCqkKmvnYCeDHzTMRNNENmW2X96Qv14yq27iqjRQPmipXoYA9dhHY
         /JhQ==
X-Gm-Message-State: AOAM530ytRyifYa3j80kHdqiEmE+/mjSVmfm6Ptjmkq7nnaB7WIGUamz
        Z5DWqreonh+e3EPrNlZjU6EC29DY0rMUzH8Kur4yFIEy9Sqy8w==
X-Google-Smtp-Source: ABdhPJyOxC21lKgBgR72WPxUF/KnmDu2sFDTRBOs5JiACV34lhD7VIHc1oK+EsD+LqjvLCv3zC6GM9NRz27orcpoboU=
X-Received: by 2002:a2e:bc16:: with SMTP id b22mr30286158ljf.500.1634034959954;
 Tue, 12 Oct 2021 03:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211012083521.973587-1-woodylin@google.com> <87zgrek1gl.mognet@arm.com>
In-Reply-To: <87zgrek1gl.mognet@arm.com>
From:   Woody Lin <woodylin@google.com>
Date:   Tue, 12 Oct 2021 18:35:48 +0800
Message-ID: <CAHn4Dec0Jyc30vWMLAXwQ-ge4eS5S26hxfMky-e4f-TTtFrbEQ@mail.gmail.com>
Subject: Re: [PATCH] sched/scs: Reset the shadow stack when idle_task_exit
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Ben Segall <bsegall@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 6:00 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 12/10/21 16:35, Woody Lin wrote:
> > There was a 'init_idle' that resets scs sp to base, but is removed by
> > f1a0a376ca0c. Without the resetting, the hot-plugging implemented by
> > cpu_psci_cpu_boot will use the previous scs sp as new base when starting
> > up a CPU core, so the usage on scs page is being stacked up until
> > overflow.
> >
> > This only happens on idle task since __cpu_up is using idle task as the
> > main thread to start up a CPU core, so the overflow can be fixed by
> > resetting scs sp to base in 'idle_task_exit'.
> >
>
> Looking at init_idle() for similar issues, it looks like we might also want
> to re-issue kasan_unpoison_task_stack() on the idle task upon hotplug.
>
> > Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
> > Signed-off-by: Woody Lin <woodylin@google.com>
> > ---
> >  kernel/sched/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 1bba4128a3e6..f21714ea3db8 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8795,6 +8795,7 @@ void idle_task_exit(void)
> >               finish_arch_post_lock_switch();
> >       }
> >
> > +     scs_task_reset(current);
> >       /* finish_cpu(), as ran on the BP, will clean up the active_mm state */
>
> So AIUI for SCS that works just fine - one thing I'm unclear on is how the
> following pops are going to work given the SP reset happens in the middle
> of a call stack, but AFAICT that was already the case before I messed about
> with init_idle(), so that must already be handled.

Hi Valentin,

Thanks for the question. The 'scs_task_reset' here resets only the
'.thread_info.scs_sp' of the task, so the register (on arm64 it's x18)
is still pointing to the same location for popping and storing call
frames. The register will be updated to '.thread_info.scs_sp' in
'__secondary_switched', which starts a new core and there is no popping
after the updating, so it won't introduce an underflow.

>
> I'm not familiar enough with KASAN to say whether that
> kasan_unpoison_task_stack() should rather happen upon hotplugging the CPU
> back (rather than on hot-unplug). If that is the case, then maybe somewhere
> around cpu_startup_entry() might work (and then you could bunch these two
> "needs to be re-run at init for the idle task" functions into a common
> helper).

unpoison looks more like an one-time thing to me; the idle tasks will
reuse the same stack pages until system resets, so I think we don't need
to re-unpoison that during hotplugging as long as it's unpoisoned in
'init_idle'.

>
> >  }
> >
> > --
> > 2.33.0.882.g93a45727a2-goog
