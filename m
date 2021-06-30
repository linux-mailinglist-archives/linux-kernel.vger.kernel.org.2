Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5513B811D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhF3LP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 07:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234248AbhF3LP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 07:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625051609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wtjN3Md/HDsTchOR16eskClgAhrk26PnBhGXdpdYyVw=;
        b=edqDxc+zPML7rR4r3guA0BO1OgRVGOZcTo5E+T8IDH1Ezz43ASxIjywMQ8Jrn9G/G0fWdi
        gzv7Yaef/spFwFcEfEXPqCXKMe1IWjBnAmnLaTypW1SCDhyNNri5Q9/2D+DwaryIsk/vM0
        cUPnX21l/5iNVP/8+ys8eRpTbZG7Sxg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-aQTKLgqTOK-63Eoiicxtcg-1; Wed, 30 Jun 2021 07:13:26 -0400
X-MC-Unique: aQTKLgqTOK-63Eoiicxtcg-1
Received: by mail-yb1-f199.google.com with SMTP id r5-20020a0569021545b0290557963aad97so558015ybu.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 04:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtjN3Md/HDsTchOR16eskClgAhrk26PnBhGXdpdYyVw=;
        b=TsZqxNMZTf8HBG8FL66343Ba6eF2zhagBAk4O4zgds7lK51wtuoAbKGV1yQpSYgR4m
         f3eaQOr6dJf9miVzqy9Ydvwk01qHE+Us4GTcxAqQwJXUlc3dWu/jJVOqiEfD9MGhNLCl
         G4xBQDywGVTKiSzs21bAwVeTfE6p1jKKygNd335EGudw73Yo9We1YwQGH5tzX5hcdJKc
         tcxyX0/TpmJKAICMuTk9T1FvBuc5DWJU9oufMOrmAnCPiKEQ/A24PLtNmA7MBDlyU5Aq
         1D7o8mzm0yj+BFsRzwKQo78LMDD0sMmu159aZohU/qsi7ocEdKh8/p30jv/Y4i3ipVBq
         6GZg==
X-Gm-Message-State: AOAM533NwKJQYAkUbMcUGOgZmYSgqQ2Fgtrr6r6gI16pm7+uM3Q9jWb8
        i1sR/a16KbaBPAVim0gqxKjnaQu/5ZWnZ4XSgpP1+zVCD13edCBKeja9f4+43pI83rZtjiOsDAA
        O+iSHnn1Aw2/pJM9VGe6PrX+zvmtCL5eVaVXskaQX
X-Received: by 2002:a25:ed0d:: with SMTP id k13mr45134073ybh.439.1625051606342;
        Wed, 30 Jun 2021 04:13:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIWLG9Rj0w7qv8hsCvJ0wX+vJsgSQjMg5IiJ2ybYdUphq/avMtaaQF7RKDDJRnVO4juMDv7zzbejBvVu9eL7U=
X-Received: by 2002:a25:ed0d:: with SMTP id k13mr45134031ybh.439.1625051606119;
 Wed, 30 Jun 2021 04:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210630093709.3612997-1-elver@google.com>
In-Reply-To: <20210630093709.3612997-1-elver@google.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 30 Jun 2021 13:13:14 +0200
Message-ID: <CAFqZXNtaHyKjcOmh4_5AUfm0mek6Zx0V1TvN8BwHNK9Q7T3D8w@mail.gmail.com>
Subject: Re: [PATCH] perf: Require CAP_KILL if sigtrap is requested
To:     Marco Elver <elver@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 11:38 AM Marco Elver <elver@google.com> wrote:
> If perf_event_open() is called with another task as target and
> perf_event_attr::sigtrap is set, and the target task's user does not
> match the calling user, also require the CAP_KILL capability.
>
> Otherwise, with the CAP_PERFMON capability alone it would be possible
> for a user to send SIGTRAP signals via perf events to another user's
> tasks. This could potentially result in those tasks being terminated if
> they cannot handle SIGTRAP signals.
>
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/capability.h |  5 +++++
>  kernel/events/core.c       | 13 ++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 65efb74c3585..1c6be4743dbe 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -264,6 +264,11 @@ static inline bool bpf_capable(void)
>         return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
>  }
>
> +static inline bool kill_capable(void)
> +{
> +       return capable(CAP_KILL) || capable(CAP_SYS_ADMIN);

Is it really necessary to fall back to CAP_SYS_ADMIN here? CAP_PERFMON
and CAP_BPF have been split off from CAP_SYS_ADMIN recently, so they
have it for backwards compatibility. You are adding a new restriction
for a very specific action, so I don't think the fallback is needed.

> +}
> +
>  static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>  {
>         return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fe88d6eea3c2..1ab4bc867531 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12152,10 +12152,21 @@ SYSCALL_DEFINE5(perf_event_open,
>         }
>
>         if (task) {
> +               bool is_capable;
> +
>                 err = down_read_interruptible(&task->signal->exec_update_lock);
>                 if (err)
>                         goto err_file;
>
> +               is_capable = perfmon_capable();
> +               if (attr.sigtrap) {
> +                       /*
> +                        * perf_event_attr::sigtrap sends signals to the other
> +                        * task. Require the current task to have CAP_KILL.
> +                        */
> +                       is_capable &= kill_capable();

Is it necessary to do all this dance just to call perfmon_capable()
first? Couldn't this be simply:

err = -EPERM;
if (attr.sigtrap && !capable(CAP_KILL))
        goto err_cred;

Also, looking at kill_ok_by_cred() in kernel/signal.c, would it
perhaps be more appropriate to do
ns_capable(__task_cred(task)->user_ns, CAP_KILL) instead? (There might
also need to be some careful locking around getting the target task's
creds - I'm not sure...)

> +               }
> +
>                 /*
>                  * Preserve ptrace permission check for backwards compatibility.
>                  *
> @@ -12165,7 +12176,7 @@ SYSCALL_DEFINE5(perf_event_open,
>                  * perf_event_exit_task() that could imply).
>                  */
>                 err = -EACCES;

BTW, shouldn't this (and several other such cases in this file...)
actually be EPERM, as is the norm for capability checks?

> -               if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
> +               if (!is_capable && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
>                         goto err_cred;
>         }
>
> --
> 2.32.0.93.g670b81a890-goog
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

