Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4642D5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhJNJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhJNJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:28:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A229FC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:26:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y67so2894054iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhEuFlQbGkl6PsKJjR4IdDPF64+w98wgMrFTERI0+RY=;
        b=EqjqsplVul4oMMBibDLyg+SMqluN4S3s7LRGfLSSQ9U53hwEWiKA4TIR1QgKurQZ/7
         DaV3vSMiCP9lh46GxF5xjDSGXZOVFI/9tm2/5hid+Minj+HMYRb21RglweOWqc+k0w6A
         6bjbTOoYZzz8VWf/wqU5PPWQ9w/3x0BtzgFIBjfEOL8GIecqTqLXN/T8z5qPidoI0gk5
         oeRnbnJS0ReTpl0aOsxfvJOjc/P4uPT3GLiqPIano4MTsA1dqW5yrpNkR5lquy0AZe9f
         hpWJXTCNUy9yEJhIcJK6uW3Ljhu/n7eMguuXz+mplku3MaOgxTluHp5LXoJzeiLHv+Vn
         X5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhEuFlQbGkl6PsKJjR4IdDPF64+w98wgMrFTERI0+RY=;
        b=AGCG+5/SjdAajN52bSNugBMorEiH/w+Ev7XucYbWN7l2rOkCbLvQ6qhk1+aSF6vKZN
         OT6l9ydxcPlJez4K//PWeFN1IH4TU7n+R898jsZI9MPod2/oThpSTz1qypE05PKxSHXF
         qgYNGGQMTgtLgVkVjODjfIRXKIzdsGmooM+7epSPM1+K0TJfmgOi4dq9TcrfXVYdze7M
         GMrXXIamvmoB2pkU3yR9PLZLM3ZcZy1E9eAWw7SxK7cTyjXCPPrlYUC4Hhpu49W1qyMP
         Bo+oJ5dH1OcmTMoFLOOqhpJM1NolsyhoejWxM0JkZM6Rrx6yntDz6OvhBrkkZL9OgVrz
         w4mg==
X-Gm-Message-State: AOAM531QoO21QyfxK5lMknSulxCGeA1wAvLwC/5ucRgjh9JRO3v+tTHG
        /+n6Nw+2vBHlTMeQOtSR4mpYdJEor4X/OpiHPs4=
X-Google-Smtp-Source: ABdhPJzfEfFmY3dUGDBBdZZHiOl1s28h5opeZyjl8LsCwN2m/St8YnPgdXlNyI1BY9IXEMxCUNm+bFnta3749bbBgkg=
X-Received: by 2002:a05:6602:27d4:: with SMTP id l20mr1572323ios.94.1634203612102;
 Thu, 14 Oct 2021 02:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211013102346.179642-1-laoar.shao@gmail.com> <20211013102346.179642-3-laoar.shao@gmail.com>
 <20211013101921.0843aaf0@gandalf.local.home> <CALOAHbCt+rLiPE4_zZO_f5sKybKwYntqupx_L9V_J+yByoFvOw@mail.gmail.com>
 <20211013222418.7ea9727d@oasis.local.home> <202110132148.523C3EA@keescook>
In-Reply-To: <202110132148.523C3EA@keescook>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Oct 2021 17:26:16 +0800
Message-ID: <CALOAHbA8OkrPfWJbYv7Kr988QGHsV0KaHxZwWWimRh6oJDy-8A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] connector: use __get_task_comm in proc_comm_connector
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 12:50 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 13, 2021 at 10:24:18PM -0400, Steven Rostedt wrote:
> > On Thu, 14 Oct 2021 09:48:09 +0800
> > Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > > > __get_task_comm() uses strncpy() which my understanding is, does not add
> > > > the nul terminating byte when truncating. Which changes the functionality
> > > > here. As all task comms have a terminating byte, the old method would copy
> > > > that and include it. This won't add the terminating byte if the buffer is
> > > > smaller than the comm, and that might cause issues.
> > > >
> > >
> > > Right, that is a problem.
> > > It seems that we should add a new helper get_task_comm_may_truncated().
> >
> > Or simply change __get_task_comm() to:
> >
> > char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
> > {
> >       task_lock(tsk);
> >       strncpy(buf, tsk->comm, buf_size);
> >       /* The copied value is always nul terminated */
> >       buf[buf_size - 1] = '\0';
> >       task_unlock(tsk);
> >       return buf;
> > }
> >
> > But that should probably be a separate patch.
>
> strscpy_pad() is the right thing here -- it'll retain the NUL-fill
> properties of strncpy and terminate correctly.
>

strscpy_pad() can also work, and seems more simple.

> The use of non-terminating issue with strncpy() wasn't a problem here
> because get_task_comm() would always make sure task->comm was
> terminated. (It uses strlcpy(), which I think needs to be changed to
> strscpy_pad() too...)
>
> --
> Kees Cook



-- 
Thanks
Yafang
