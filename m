Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C842B238
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 03:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhJMBZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 21:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhJMBZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 21:25:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12F6C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 18:23:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r19so4312482lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 18:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVi/APDdqSZMHreULpsgHcZuFlI60O4HhHetcQYYqQg=;
        b=XDUgFJIs9eeMSx8N9tKRspYGtgb+QTCl9oYv8HzYdzjglQoLg7i/rcGK3R1+WczgHm
         KywPgQGbYcZKDds4qTovMAmI5y/upHT4GN9ktjjUN+ernyIq3wS4v1IkRTDpgJoeHXqr
         miFatnL1Y8cmYTFODsxWjOYautBGkBfmwFKHLRXL5wMLiV+UpUtjv4ih1o//OxghxdRA
         1top+SqUulVcmJs1OJJ0J/356vR8t3Ylk/FWywjpoZ/AUQz8S2P93yRuxLjvOcMewZjw
         J+y97K9f0bjJC9j1IJqy8pilVdwa9eQ3Iok4Zp035sCJj0IIyVZQO8XeC0yDglxhGYu8
         bhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVi/APDdqSZMHreULpsgHcZuFlI60O4HhHetcQYYqQg=;
        b=xpmyRbp0IeeH1j0DRw9X4fc/mHN9MHR+biudCor5rPk87ih+YsBPCSQjzibU9hlTl5
         RX9b4Z2GK0VjfDqE4URP+Cz5YBASrewqZIgYcIH3EMZk0doa4yXkUTt/zv8kSZIQhHE5
         TllMmuhqwFKIrjCNoED7gFDc6DxvWHOyciBmxzSDyl3SAZeuGmb0pF0DttKbr5A/yeja
         OMIDLc/kzUMnwj+ydLFghM3yJqE0IW3y6kzwcugNdtB84EcLzyITS1BsiuEKYi25avcM
         HgEetdUtZhDxPQWgz/HozAOarbAQYbdiCdahjm/KRFMdnj6y1YklgipNhgTX766U58fQ
         2JcQ==
X-Gm-Message-State: AOAM530Ek3RDkAQm+Oakx0ng3kw+Fs5WKY04OPkgyAugNhlZBG9zlrgJ
        NxVtddfIpyGn8J0v5QR22PMRrdovrmMU3NOeQwPESA==
X-Google-Smtp-Source: ABdhPJxej28Um/+1vk3QWPE3S2BNE6R2RdaTdYrKrcuN0OVQKKsrKTicBgIul2NYLIVQr/wbeQYdGpn44aemygMVV9s=
X-Received: by 2002:a2e:a889:: with SMTP id m9mr22955291ljq.83.1634088181991;
 Tue, 12 Oct 2021 18:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211012083521.973587-1-woodylin@google.com> <87zgrek1gl.mognet@arm.com>
 <CAHn4Dec0Jyc30vWMLAXwQ-ge4eS5S26hxfMky-e4f-TTtFrbEQ@mail.gmail.com> <87wnmijysj.mognet@arm.com>
In-Reply-To: <87wnmijysj.mognet@arm.com>
From:   Woody Lin <woodylin@google.com>
Date:   Wed, 13 Oct 2021 09:22:50 +0800
Message-ID: <CAHn4DedEV953QULZLAPOuXyHAw_mWRTdFj8bSm6zk3rNjFJj-A@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 6:57 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 12/10/21 18:35, Woody Lin wrote:
> > On Tue, Oct 12, 2021 at 6:00 PM Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> So AIUI for SCS that works just fine - one thing I'm unclear on is how the
> >> following pops are going to work given the SP reset happens in the middle
> >> of a call stack, but AFAICT that was already the case before I messed about
> >> with init_idle(), so that must already be handled.
> >
> > Hi Valentin,
> >
> > Thanks for the question. The 'scs_task_reset' here resets only the
> > '.thread_info.scs_sp' of the task, so the register (on arm64 it's x18)
> > is still pointing to the same location for popping and storing call
> > frames. The register will be updated to '.thread_info.scs_sp' in
> > '__secondary_switched', which starts a new core and there is no popping
> > after the updating, so it won't introduce an underflow.
> >
>
> I think I got it; __secondary_switched() -> init_cpu_task() -> scs_load()
>
> Thanks!
>
> >>
> >> I'm not familiar enough with KASAN to say whether that
> >> kasan_unpoison_task_stack() should rather happen upon hotplugging the CPU
> >> back (rather than on hot-unplug). If that is the case, then maybe somewhere
> >> around cpu_startup_entry() might work (and then you could bunch these two
> >> "needs to be re-run at init for the idle task" functions into a common
> >> helper).
> >
> > unpoison looks more like an one-time thing to me; the idle tasks will
> > reuse the same stack pages until system resets, so I think we don't need
> > to re-unpoison that during hotplugging as long as it's unpoisoned in
> > 'init_idle'.
> >
>
> I would tend to agree, but was bitten by s390 freeing some memory on
> hot-unplug and re-allocating it upon hotplug:
>
>   6a942f578054 ("s390: preempt: Fix preempt_count initialization")
>
> This makes me doubt whether we can assert the idle task stack pages are
> perennial vs hotplug on all architectures.

I made a quick study on memory-hotplug and seems that only memory contains
nothing other than migratable pages can be unplugged. So process stack
pages should not be a concern for this, since which is an unmovable
memory.

However I don't have a chance to work on a system that enables
memory-hotplug so far, so couldn't verify this assumption further. Guess
we can create a separate thread to clarify this more.

Regards,
Woody

>
> >>
> >> >  }
> >> >
> >> > --
> >> > 2.33.0.882.g93a45727a2-goog
