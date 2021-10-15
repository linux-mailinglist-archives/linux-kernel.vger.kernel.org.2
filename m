Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D81F42E65D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhJOCIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhJOCIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:08:38 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA10C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 19:06:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d125so6061257iof.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 19:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ez587ft9rqr8sTeod+Afv+LsY8b+Xmu4wMHtAealLmU=;
        b=FbzUk1lC6UGTtGCEL3MXXivdBwD/G3cAIjD7Ih8LpdBtbTVuFjJ+2S4MhJJonliG6u
         4ry/NRCSREmFB0NxVjW9zdPgBFl/nBquFHnkI8wM/nlxf/j3YNVxNgC7CDqHWR+0q9Ad
         IcnD9xZh8J2ywWzt10LmGKS9svnEQAVaFloLjGMo7d0Vv1I1eDhA7EXk83N6Ve0lm8co
         kmGL9PZhWQ06ozuBhiYh4TfEWLtGe+PawtMfGR0s40hZEsrPYbf9+PSJtWYMsQpR0fRW
         LDJNg+7OCIIbro+a/5NRidfAyc0stYNhdnji4ZVqys2hx/DpigBhTz+q+q+iSLRzu5ew
         2REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ez587ft9rqr8sTeod+Afv+LsY8b+Xmu4wMHtAealLmU=;
        b=V+IxFl41Rs4nKdTPCXRAbWMqtVkstHT9cexdYTmVmuOmyBn2bZg/1hmKNwYWEjvlHg
         58Tw4U/Yfcvd2CDk88MaL+BZxkMM6ELfWH/cJU29l0sJQhMaetQbqvf//CfMC/UZoIML
         HqnttF7pKQqDzRiYpJP4eyXuzkYjSEMQtnacdHilySx/ax5e+hEAsb69/fQbrS4A1UiS
         dIW4WmWBLYpOEmfZ2yCINKNSSB9kp3ygx2g7t74Agtr0B2LGCIBrnvm8TYnrZUTtkayt
         K7cv2vD6tRfs71h1yaY2GpJ/BWxyCJ3WyEqkSLNYyKrka8BZefZ9F9RQzdJ5L1eFSDlu
         Xnfw==
X-Gm-Message-State: AOAM532d2/aBJHpkcq00a7kqtHYvgwse+KiL8iXZei10BY43YBEGQQrn
        PJ9Jih+2Jcnfl9mQTraepesQNtna4zBlXiUqULo=
X-Google-Smtp-Source: ABdhPJyF6K3gLFM7HtRbgXXhFfdoW8ppZhJnP8vBqqSzDphdligAw3eLw83kq1SVc5ZZ5cP5U4lBhX8ai1o7qhXj3J8=
X-Received: by 2002:a05:6602:27d4:: with SMTP id l20mr1840790ios.94.1634263592376;
 Thu, 14 Oct 2021 19:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020>
 <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
 <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
 <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com>
 <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com>
 <CALOAHbBTxLvuiuT4tT2_7C+jaXBoh0uTjzLRm+njO4tKxCtPwg@mail.gmail.com>
 <1171592945.14099.1634219447199.JavaMail.zimbra@efficios.com>
 <CALOAHbAhT1bTAThrmA1zYE5q8shR4dxZf5fqcq_9wVrV+XwVEQ@mail.gmail.com> <202110140910.295E856@keescook>
In-Reply-To: <202110140910.295E856@keescook>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 15 Oct 2021 10:05:56 +0800
Message-ID: <CALOAHbAQ06+G776+7WqWBag+Q1gO5M+Qg3axYd4=Tpbzx1i=tg@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
To:     Kees Cook <keescook@chromium.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        acme <acme@kernel.org>, rostedt <rostedt@goodmis.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qiang Zhang <qiang.zhang@windriver.com>,
        robdclark <robdclark@chromium.org>,
        christian <christian@brauner.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        bristot <bristot@redhat.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:14 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 14, 2021 at 10:40:04PM +0800, Yafang Shao wrote:
> > On Thu, Oct 14, 2021 at 9:50 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > >
> > > ----- On Oct 14, 2021, at 9:11 AM, Yafang Shao laoar.shao@gmail.com wrote:
> > >
> > > > On Thu, Oct 14, 2021 at 9:09 PM Mathieu Desnoyers
> > > > <mathieu.desnoyers@efficios.com> wrote:
> > > >>
> > > >> ----- On Oct 14, 2021, at 9:05 AM, Yafang Shao laoar.shao@gmail.com wrote:
> > > >> [...]
> > > >> >> If it happens that this ABI break is noticed by more than an in-tree test
> > > >> >> program, then
> > > >> >> the kernel's ABI rules will require that this trace field size stays unchanged.
> > > >> >> This brings
> > > >> >> up once more the whole topic of "Tracepoints ABI" which has been discussed
> > > >> >> repeatedly in
> > > >> >> the past.
> > > >> >>
> > > >> >
> > > >> > I will check if any other in-tree tools depends on TASK_COMM_LEN.
> > > >>
> > > >> That's a start, but given this is a userspace ABI, out-of-tree userland
> > > >> tools which depend of this to be fixed-size are also relevant.
> > > >>
> > > >
> > > > TASK_COMM_LEN isn't defined in include/uapi/ directory, so it seems
> > > > that it isn't the uerspace ABI?
> > >
> > > One case where this 16 bytes size is expected by userspace is prctl(2) PR_GET_NAME
> > > and PR_SET_NAME.
> > >
> >
> > the prctl(2) man page says that:
> > : PR_SET_NAME
> > :        If the length of the string, including the terminating
> > :        null byte, exceeds 16 bytes, the string is silently truncated.
> > : PR_GET_NAME
> > :         The buffer should allow space for up to 16 bytes
> > :          the returned string will be null-terminated.
> >
> > As the string returned to user space is null-terminated, extending
> > task comm won't break the prctl(2) user code.
>
> If userspace was:
>
>         char comm[16];
>         int important_values;
>
>         ...
>
>         prctl(PR_GET_NAME, pid, comm);
>
> the kernel will clobber "important_values", so prctl() must enforce the
> old size (and terminate it correctly). It's not okay for us to expect
> that userspace get recompiled -- old binaries must continue to work
> correctly on kernel kernels.
>
>         case PR_GET_NAME:
>                 get_task_comm(comm, me);
>                 if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
>                         return -EFAULT;
>                 break;
>
> This looks like it needs to be explicitly NUL terminated at 16 as well.
>

Right. After replacing strncpy with strscpy_pad() in
__get_task_comm(), the string will be NUL terminated.

> I'd say we need a TASK_COMM_LEN_V1 to use in all the old hard-coded
> places.
>

Sure, it will be easy to grep then.

> >
> > > The other case I am referring to is with ftrace and perf:
> > >
> > > mount -t tracefs nodev /sys/kernel/tracing
> > > cat /sys/kernel/tracing/events/sched/sched_switch/format
> > >
> > > name: sched_switch
> > > ID: 314
> > > format:
> > > [...]
> > >         field:char prev_comm[16];       offset:8;       size:16;        signed:1;
> > > [...]
> > >         field:char next_comm[16];       offset:40;      size:16;        signed:1;
> > >
> > > Both of those fields expose a fixed-size of 16 bytes.
> > >
> > > AFAIK Steven's intent was that by parsing this file, trace viewers could adapt to
> > > changes in the event field layout. Unfortunately, there have been cases where
> > > trace viewers had a hard expectation on the field layout. Hopefully those have
> > > all been fixed a while ago.
> > >
> >
> > I don't have a clear idea what will happen to trace viewers if we
> > extend task comm.
> >
> > Steven, do you have any suggestions ?
> >
> > --
> > Thanks
> > Yafang
>
> --
> Kees Cook



-- 
Thanks
Yafang
