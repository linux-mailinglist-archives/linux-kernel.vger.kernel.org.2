Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4603C5AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhGLKgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbhGLKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:36:05 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A485BC08EA3B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 03:32:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so18355314otq.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hEyAkHkInoJotPHkAfN0wodjsUHpYTw3naBo9WfZZI=;
        b=F5afFXcZ+9ghtWqcOutMJAHUlfgrHnNxqJ1BaAL0FeHqhlADIU4WewWZ+7lEidJJEM
         MDWZ5fPxKt+RdAVtf38zGqUZZdPq4xGVrfpV2fjD2XaXmNH8Y3GYykKc/yf9PH8QeLeQ
         Rnhuqvnpuf5Esg3W0RDHGp4wc/eecEY8Nl4wT9I5OnH8iJlAM9yGPBEcVgOLa9gInteg
         fIVn30QAvaeowSYG3fizYXe7sMHx6/i0jFR3d7Y9R8xcWFqEtdPgkXR2Df6Mwc3d0eH0
         11D3w5c47q62DFT6jMYAhaasjylQbcOVnEoYmwPjkXyChsUAM9+OQkcZQs0jqHDOslLy
         rC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hEyAkHkInoJotPHkAfN0wodjsUHpYTw3naBo9WfZZI=;
        b=CnE7IcsEAMkqlbs5due95rp4vPsxG2uGZ7m+Y8SRpG6niBliW5LSigyfsSKTmfkXcp
         OvFtHSgSXVMf6H4mLT6JUdAa0wq9IauSBHrX4bwDg4A+ZZfMWQQE9Og1Pzi5xbFy1Wz7
         q17eRhvqvfy2E+ehWzw7fDgpqtl/Y3vF05qr85ZONq5sVmaxvJJyXnePYY6Kp1v4XZZH
         NA4cE883T2Kj/wSsYAxXVEs9HJKzOeTKL46qGhyCYDiZdcSQtFpEB39fgWsMZodA4mD0
         B97Bnjot5aZFiYpVNfh7du3daDFZGKcgDvhPrtfl7IbpK4/kCvOHzc3rluh9GDJ0g+i/
         S1dQ==
X-Gm-Message-State: AOAM531zL8ThIr2QrI5ZPxw1c4S8HQJAU515KNwgnQvFP2saFX/wlWuD
        PIhnFE3f4mAuAPzgVpw3zWUBh+1Lw6JpJIU/X8scJA==
X-Google-Smtp-Source: ABdhPJxFghSlOXue0bs+uwqobpo7cI8sIEg9IDF5ibUxHIb/e7alSJi47P5evIhXER5Fjeu7fnsftbugg+ShnCwX2AU=
X-Received: by 2002:a9d:650e:: with SMTP id i14mr12659704otl.233.1626085964667;
 Mon, 12 Jul 2021 03:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210705084453.2151729-1-elver@google.com>
In-Reply-To: <20210705084453.2151729-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 12 Jul 2021 12:32:33 +0200
Message-ID: <CANpmjNP7Z0mxaF+eYCtP1aabPcoh-0aDSOiW6FQsPkR8SbVwnA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf: Fix required permissions if sigtrap is requested
To:     elver@google.com, peterz@infradead.org
Cc:     tglx@linutronix.de, mingo@kernel.org, dvyukov@google.com,
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

It'd be good to get this sorted -- please take another look.

Many thanks,
-- Marco

On Mon, 5 Jul 2021 at 10:45, Marco Elver <elver@google.com> wrote:
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
