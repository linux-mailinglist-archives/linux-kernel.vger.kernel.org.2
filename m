Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DADB3BA9D6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhGCRcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 13:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGCRcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 13:32:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3845C061762
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jul 2021 10:29:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y40so2590990ede.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9Iem/lMag2RPHwMZ9nBzIAPE7ruGDDVMReqojOyreo=;
        b=IxlnDe2lJwZtAR4ELgMRJoHTJjujG0dQrYQbmyVSGmQKZfZuFWkLX2jyQ6h2nP8fwP
         a8o1BqCJcZjJUPRRVxrySwvLh9HDVzjjYugLf0phIpziWJXGGo1E9D8jOBPh6QAMDCsI
         uPWXzZdVX7C+D4bVeFp307aOi3EkDl5NXx3iPwb8ZgMdkMOFRqhP2PHmPwG43Pxptujm
         KeUb2tpeq7rTINg2QNP2Ihp7SQEKoMhLOA1wLN55gR0qxIWF8SlB6+aSRuuvMdnfeFfK
         GKBlffmnbjht6i5Xy4n8Q6oasrVwiRoZNLfjkJVa1mgQOMLFRlPs4x+RQUpMSDMW4FRo
         ew3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9Iem/lMag2RPHwMZ9nBzIAPE7ruGDDVMReqojOyreo=;
        b=djjy3tFd1wGabWCAr9U/ttXPP0sk7H3kGo9lXZRe9KIivEY4+aWduMEUUaZKgf6lsc
         CkJM/uHncKxoQ72sC79+DsTDOGNm+GMsBrdT86PPg+skEdVWcMSqBco5C1Mf431ZoJIU
         RVPmdU5jyZtwPYUK4HjqL4y614cENQ2TFLnqniWczSw4DIyN/nJQ+43CQK4UHrGU27I5
         SV+89aPlzSsXemW/gPkBeVRyK5acJ0RZUZ5kj6sXR15jNGhRjgFZYaZ+EbBRN9lqeIE9
         Oea6QShkHvaWGZvQ251U0G9v8lrIxLZZqn7q0QfbDjxHjKQ2OR8gHEqA3V6YeqkJVd7w
         oDPQ==
X-Gm-Message-State: AOAM530VucmMZJ/6zBmaELY/hZgnu3Ju73aDM6fV+Zb7K7YrDgCRE2QW
        D+TUqc1xMikGgrnEbkzailM2kq5ueU+vrDX8Xy8LMyjDM/U=
X-Google-Smtp-Source: ABdhPJyYFlHs7cjbwLH0Stf4MCif/zWZykYcyHD0iQq1ImnAHQa50S+a7mWEFwaQsAMKWZrxC0i8PjpVrxEET9++2kk=
X-Received: by 2002:aa7:cb03:: with SMTP id s3mr6291730edt.189.1625333386227;
 Sat, 03 Jul 2021 10:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210627072833.2199463-1-ani@anisinha.ca>
In-Reply-To: <20210627072833.2199463-1-ani@anisinha.ca>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Sat, 3 Jul 2021 22:59:35 +0530
Message-ID: <CAARzgww4ZO3MtVxEM+yRNJ1Um-5DuVfUxh2+Hnjt5MKf-Rv8og@mail.gmail.com>
Subject: Re: [PATCH v1] Add info log when user enables NOHZ in commandline but
 NOHZ is not possible
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

On Sun, Jun 27, 2021 at 12:58 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> Commit 4f49b90abb4aca ("sched-clock: Migrate to use new tick
> dependency mask model") had also removed the kernel warning
> message informing the user that it was not possible to turn
> on NO_HZ_FULL. This warning was added in commit e12d0271774fe
> ("nohz: Warn if the machine can not perform nohz_full") in order
> to warn users when they enabled NOHZ using the kernel commandline
> but kernel could not enable NOHZ. Removal of this log defeats this
> purpose because we still do not want users thinking that they are
> getting the benefit of nohz when their machine can not support it.
> Hence this patch brings back the information log.
>
> If at some point the conditions that prevented NOHZ from being
> enabled goes away and the previous info log was printed, we print
> another log informing the user that NOHZ was again possible.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  kernel/time/tick-sched.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> See also thread: https://lkml.org/lkml/2021/6/20/32
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 828b091501ca..fbef95b57b1d 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -930,6 +930,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
>  {
>  #ifdef CONFIG_NO_HZ_FULL
>         int cpu = smp_processor_id();
> +       static bool no_tick_warned;
>
>         if (!tick_nohz_full_cpu(cpu))
>                 return;
> @@ -937,10 +938,24 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
>         if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
>                 return;
>
> -       if (can_stop_full_tick(cpu, ts))
> +       if (can_stop_full_tick(cpu, ts)) {
>                 tick_nohz_stop_sched_tick(ts, cpu);
> -       else if (ts->tick_stopped)
> -               tick_nohz_restart_sched_tick(ts, ktime_get());
> +               if (no_tick_warned) {
> +                       pr_info("NO_HZ_FULL is now enabled in the system.\n");
> +                       no_tick_warned = false;
> +               }
> +       } else {
> +               /*
> +                * Don't allow the user to think they can get
> +                * full NO_HZ with this machine.
> +                */
> +               if (!no_tick_warned && tick_nohz_full_running) {
> +                       pr_info("NO_HZ_FULL has been disabled in the system.");
> +                       no_tick_warned = true;
> +               }
> +               if (ts->tick_stopped)
> +                       tick_nohz_restart_sched_tick(ts, ktime_get());
> +       }
>  #endif
>  }
>
> --
> 2.25.1
>
