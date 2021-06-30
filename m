Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DAC3B8253
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhF3Mp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhF3Mp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:45:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C84C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:42:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u8so3453513wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GH3eDDlIhhzC5YYUSXzbXcyeMUM12l/VQtqBde75cxY=;
        b=g8Vc9HiiqGpCCdnXbMmpfPHSBeEKH/sIApjC946R2p27sZT6rDij07rzdDrKpcWNV0
         21nM+W0421NmYGGDApDZuulIjfWqVlQ0CNLg9ls1UwwMRfoLWfSw4dNv3/63Bf36WwiQ
         bbjGxmknfOooBvP8JZFdTFLAGRUMNaQ5lEIFPJrs7dxGWvwzK2lBizhqM/rdX4cbEpVA
         GbNANCewxlMQ65vBXCZelIabE2Fw5oXXMJhfEhR0O041xGy9OjH3uxi/twtP4/0H69Qp
         qjogb+MzQ/kAzflzIuYE6SHNio4Ys9ktoW5tC5SxarpSOtlqyjTVyx+u6eWHoEjdVymP
         hJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GH3eDDlIhhzC5YYUSXzbXcyeMUM12l/VQtqBde75cxY=;
        b=imeDNt53A/sB9TrYJRcEhgGLmi85v+JIhwu+pa+KrFa64PQZ/hyL6OMk7eXXGOS4CS
         Pmu0uMPWl9G+VKsWUVZ7/A26sKITZuqx5gXqn5zZuqVkbSkuPoLn6oYWvnWQ+Vz7+BMP
         fsx3G8JS9dGN/HsIwjdd/M8PPGcjsm6IJcijsqxx7ktcrFJoy5JADvtoonSobzz7MeBe
         HoxYItXWvnwdVLXqJf72eDczoxG308i15DC+P6MzqC9Gm9blyeGI7AAvE2iG/KCqIfd8
         19WELD2nviiTp05+X9/Kpg4BKUSdKKiWKenKm7JL5mut4nXLbQSJW4jMYq1H+Xt1Y248
         GIbA==
X-Gm-Message-State: AOAM532LM51dRb+os0UVsMx7NcQtKRYvjm9ALrXbDhk1dcBmIhrKqkQa
        3myZxtIuwjWchoTC0rt+l9SxgQ==
X-Google-Smtp-Source: ABdhPJyxeUMm3N5mON2rwouCk9rz+UnOSWe5m58WSIxdEkdrWBONo1YUOGFyEqq3dwYWQ9IlWHXzkg==
X-Received: by 2002:a5d:65c1:: with SMTP id e1mr40845057wrw.196.1625056975754;
        Wed, 30 Jun 2021 05:42:55 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:8b0e:c57f:ff29:7e4])
        by smtp.gmail.com with ESMTPSA id r16sm13220921wrx.63.2021.06.30.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:42:54 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:42:49 +0200
From:   Marco Elver <elver@google.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kasan-dev@googlegroups.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Require CAP_KILL if sigtrap is requested
Message-ID: <YNxmyRYcs/R/8zry@elver.google.com>
References: <20210630093709.3612997-1-elver@google.com>
 <CAFqZXNtaHyKjcOmh4_5AUfm0mek6Zx0V1TvN8BwHNK9Q7T3D8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNtaHyKjcOmh4_5AUfm0mek6Zx0V1TvN8BwHNK9Q7T3D8w@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 01:13PM +0200, Ondrej Mosnacek wrote:
> On Wed, Jun 30, 2021 at 11:38 AM Marco Elver <elver@google.com> wrote:
[...]
> > +static inline bool kill_capable(void)
> > +{
> > +       return capable(CAP_KILL) || capable(CAP_SYS_ADMIN);
> 
> Is it really necessary to fall back to CAP_SYS_ADMIN here? CAP_PERFMON
> and CAP_BPF have been split off from CAP_SYS_ADMIN recently, so they
> have it for backwards compatibility. You are adding a new restriction
> for a very specific action, so I don't think the fallback is needed.

That means someone having CAP_SYS_ADMIN, but not CAP_KILL, can't perform
the desired action. Is this what you'd like?

If so, I'll just remove the wrapper, and call capable(CAP_KILL)
directly.

> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index fe88d6eea3c2..1ab4bc867531 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -12152,10 +12152,21 @@ SYSCALL_DEFINE5(perf_event_open,
> >         }
> >
> >         if (task) {
> > +               bool is_capable;
> > +
> >                 err = down_read_interruptible(&task->signal->exec_update_lock);
> >                 if (err)
> >                         goto err_file;
> >
> > +               is_capable = perfmon_capable();
> > +               if (attr.sigtrap) {
> > +                       /*
> > +                        * perf_event_attr::sigtrap sends signals to the other
> > +                        * task. Require the current task to have CAP_KILL.
> > +                        */
> > +                       is_capable &= kill_capable();
> 
> Is it necessary to do all this dance just to call perfmon_capable()
> first? Couldn't this be simply:
> 
> err = -EPERM;
> if (attr.sigtrap && !capable(CAP_KILL))
>         goto err_cred;

Not so much about perfmon_capable() but about the ptrace_may_access()
check. The condition here is supposed to be:

	want CAP_PERFMON and (CAP_KILL if sigtrap)
		OR
        want ptrace access (which includes a check for same thread-group and uid)

If we did what you propose, then the ptrace check is effectively ignored
if attr.sigtrap, and that's not what we want.

There are lots of other ways of writing the same thing, but it should
also remain readable and sticking it all into the same condition is not
readable.

> Also, looking at kill_ok_by_cred() in kernel/signal.c, would it
> perhaps be more appropriate to do
> ns_capable(__task_cred(task)->user_ns, CAP_KILL) instead? (There might
> also need to be some careful locking around getting the target task's
> creds - I'm not sure...)
 
That might make sense. AFAIK, the locking is already in place via
exec_update_lock. Let me investigate.

> > +               }
> > +
> >                 /*
> >                  * Preserve ptrace permission check for backwards compatibility.
> >                  *
> > @@ -12165,7 +12176,7 @@ SYSCALL_DEFINE5(perf_event_open,
> >                  * perf_event_exit_task() that could imply).
> >                  */
> >                 err = -EACCES;
> 
> BTW, shouldn't this (and several other such cases in this file...)
> actually be EPERM, as is the norm for capability checks?

I'm not a perf maintainer, so I can't give you a definitive answer.
But, this would change the ABI, so I don't think it's realistic to
request this change at this point unfortunately.

Thanks.
