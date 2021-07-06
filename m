Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58C83BC653
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGFGTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhGFGTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:19:02 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910AC061760
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 23:16:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a6so4000283qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2kc2sPl4mFDGHgoHEBwsK+YcufyFuxpzKrHOh0bOKs=;
        b=Ap8WxFAvaIZM4zzGb0DkHCpmL312tWNnt5K315MXMLh9mc+84ugfzkt3WZRQVA8oq/
         e6ZpWCb/lLpnF2aB95WwZQfG36GfvsnkubQCFEgeost/pPZfWx+1vQeBPkIpes0e97Vm
         NmEizRgK1jeMQK3+KzXLHwhUypPtMSoNSVu2ibj/OYVFZus9423wM7b8I9yk9d5TrG4I
         mE/tP4aiwXr1iOZgxZL9/xZGcRKIJw4cwLThiDcsd7QwrBfLLI6yjla9fNtmzmAfs83k
         TPX+o92klxpBprGGkvoJ0OmtdaY+1Ytopb8gx+BPoJffue0ecqEWzxWxrYt6Yezdao1X
         ltPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2kc2sPl4mFDGHgoHEBwsK+YcufyFuxpzKrHOh0bOKs=;
        b=KQ5QWkIeVkBTjK7Qcaa5K4/ipLYCzookfEIKnfcQ3Jpbc/sAbLijIDpv/cHmol5rVs
         4fQywnaxJkzWPVmzh5IdyVfOr6pz5DmMWlAxJUpUkubjwnnz8Hasj3HTmwN4X0n7YjhT
         IqTJpw/NgODqOHaWWQW8jNNk7K1W24ch2CpoCiOAwHaac0LqvosiyID7DBXZ5b9rthuy
         uibV12EJl/bjVtf+x+76ez2oVIL5o+nuziGlwoOaraDuiT+r4DQdX5gc3UNNQVVpo+/F
         XBJZw/oBZlvFDBw/MiQ37fNNcHAuYcPKnNPSpbRlEgtwGydx55524WdWHo7tdiYb6QSy
         2roA==
X-Gm-Message-State: AOAM53080K/ibGnXClvVZEQTejUyU5RSrQ/5A5MaDFwVkngnXvnc2/iw
        4ZBs6E8bHZuc6S4yqzUoP1Zk8cL/Hk48OcpdXYLLQw==
X-Google-Smtp-Source: ABdhPJzJHfpJ8Cjm37K+ccfE6AIF+fG3X6FSoU1q9BaLRf381cZW/GWLOQl/+5H+zXoOBoiZUrijopPlskRAaVNY7GM=
X-Received: by 2002:a37:6888:: with SMTP id d130mr18540942qkc.265.1625552183218;
 Mon, 05 Jul 2021 23:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210705084453.2151729-1-elver@google.com>
In-Reply-To: <20210705084453.2151729-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 6 Jul 2021 08:16:07 +0200
Message-ID: <CACT4Y+bQovD7=CZajMJ_AZz=Rf37HpDQiTp0qnhi-GhuP0Xdeg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf: Fix required permissions if sigtrap is requested
To:     Marco Elver <elver@google.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, ebiederm@xmission.com,
        omosnace@redhat.com, serge@hallyn.com,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 10:45 AM Marco Elver <elver@google.com> wrote:
>
> If perf_event_open() is called with another task as target and
> perf_event_attr::sigtrap is set, and the target task's user does not
> match the calling user, also require the CAP_KILL capability or
> PTRACE_MODE_ATTACH permissions.
>
> Otherwise, with the CAP_PERFMON capability alone it would be possible
> for a user to send SIGTRAP signals via perf events to another user's
> tasks. This could potentially result in those tasks being terminated if
> they cannot handle SIGTRAP signals.
>
> Note: The check complements the existing capability check, but is not
> supposed to supersede the ptrace_may_access() check. At a high level we
> now have:
>
>         capable of CAP_PERFMON and (CAP_KILL if sigtrap)
>                 OR
>         ptrace_may_access(...) // also checks for same thread-group and uid
>
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Cc: <stable@vger.kernel.org> # 5.13+
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v3:
> * Upgrade ptrace mode check to ATTACH if attr.sigtrap, otherwise it's
>   possible to change the target task (send signal) even if only read
>   ptrace permissions were granted (reported by Eric W. Biederman).
>
> v2: https://lkml.kernel.org/r/20210701083842.580466-1-elver@google.com
> * Drop kill_capable() and just check CAP_KILL (reported by Ondrej Mosnacek).
> * Use ns_capable(__task_cred(task)->user_ns, CAP_KILL) to check for
>   capability in target task's ns (reported by Ondrej Mosnacek).
>
> v1: https://lkml.kernel.org/r/20210630093709.3612997-1-elver@google.com
> ---
>  kernel/events/core.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fe88d6eea3c2..f79ee82e644a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12152,10 +12152,33 @@ SYSCALL_DEFINE5(perf_event_open,
>         }
>
>         if (task) {
> +               unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
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
> +                        * task. Require the current task to also have
> +                        * CAP_KILL.
> +                        */
> +                       rcu_read_lock();
> +                       is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
> +                       rcu_read_unlock();
> +
> +                       /*
> +                        * If the required capabilities aren't available, checks
> +                        * for ptrace permissions: upgrade to ATTACH, since
> +                        * sending signals can effectively change the target
> +                        * task.
> +                        */
> +                       ptrace_mode = PTRACE_MODE_ATTACH_REALCREDS;
> +               }
> +
>                 /*
>                  * Preserve ptrace permission check for backwards compatibility.
>                  *
> @@ -12165,7 +12188,7 @@ SYSCALL_DEFINE5(perf_event_open,
>                  * perf_event_exit_task() that could imply).
>                  */
>                 err = -EACCES;
> -               if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
> +               if (!is_capable && !ptrace_may_access(task, ptrace_mode))
>                         goto err_cred;
>         }
>
> --
> 2.32.0.93.g670b81a890-goog
>
