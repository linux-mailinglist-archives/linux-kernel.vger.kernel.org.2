Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778A93BA9D8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 19:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhGCRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGCRcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 13:32:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49451C061762
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jul 2021 10:30:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n25so17726317edw.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/Cf3otuOvWyQfaTcpliJ/TLz+yQ8Qx38VKrP1qZU38=;
        b=vlmLnlLIPtILCfGr4FB2TU4tFKjn0fp5aIKgqXuUAyNLBEu6JJiU8mr9R86Ogfhq/8
         Z/VjZmITl1uFnHeQs6OVBh1iMnMEfolNV01GQwZqmbJXeOPP2nwjAo0dzaYIWOqicy/+
         yCCbwIW4qSetSioLQquavM918OvxpGEt59NovqhR0Mf8fxbyauVEYzLxRVGQv8kMmZWr
         xlNUcKAOAKoEDUJrCUV2+u74/E0KpA5AK6RlDj1veSn+jrygh7p2YiIfw9tj406HZ/1Z
         TYfuPXjKzxCnTbrLi4+/nzBFhgcGm1tBpshBaiugwpZZECJdacbsZEjklGWPMcfiZeWn
         LpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/Cf3otuOvWyQfaTcpliJ/TLz+yQ8Qx38VKrP1qZU38=;
        b=muqY8syfTFiBoxUsrQrLwcp0jVj8bwpfwJ6R0HeGjxKqvwzEpMZQjQJsTVeOCxO3Wk
         K4BRAXECD50UaZxgRl5cxfYAPj3ePOoCXN48Hw9nNaqXR7lmgwfGxcZU8rF84JvXNcea
         OL1Pqw6xLnkoDxybxOTROyVXohdqnGs3ELnoqvjhSHm4cet7U2p7OqhjpMkKm6LAlp9f
         m1nE42pwA0G8+sNIiSqjWiELLzJ2tN6L3sj9glXDs6KcRQ5jPEzMnvU2BywmEdY/uzgB
         iei8t1RKTUmHK2Z5N+fSe8dT5Us5SfIwIf8bSm1hpsbYJW4oZSnvos+Q3LYHUW+wdMJi
         v+vQ==
X-Gm-Message-State: AOAM5309GngSpRVa9wsjJ7gu53VDIoxVWRNh77pgxoZJhUoQPBY/izuq
        GEznsTN8ohfkzCXeETs3YB4I/vmbStqITfc1E/T1Vu2VKlY=
X-Google-Smtp-Source: ABdhPJzI+6mZB+XPRDtLkkcwUiGI9U8X4VqL7Lj64nEzA19QZEHHFBw46leR/3DBUVdPZXqgZmSK/ZDbLdYVtcF3GgI=
X-Received: by 2002:a50:f0ce:: with SMTP id a14mr5593180edm.176.1625333407745;
 Sat, 03 Jul 2021 10:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210627064911.2179786-1-ani@anisinha.ca>
In-Reply-To: <20210627064911.2179786-1-ani@anisinha.ca>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Sat, 3 Jul 2021 22:59:56 +0530
Message-ID: <CAARzgwyUb9QgvDKZ+BWG4GnRizn=hyV+0fvsT3ecT8YqvUz3sg@mail.gmail.com>
Subject: Re: [PATCH v1] Print a log when the sched clock is marked unstable
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

On Sun, Jun 27, 2021 at 12:19 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> In other parts of the kernel when the sched clock transitions from
> stable to unstable and vice versa, a kernel info log is printed.
> When the sched clock is marked explicitly as unstable, we should
> print an information log as well. This patch addresses this. It is
> useful in cases where for example, we want to understand why a
> certain feature like NOHZ, which depends on a stable sched clock, is
> not available.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  kernel/sched/clock.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> See also thread
> https://lkml.org/lkml/2021/6/20/32
>
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index c2b2859ddd82..5a403b2c9b3f 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -192,8 +192,10 @@ void clear_sched_clock_stable(void)
>
>         smp_mb(); /* matches sched_clock_init_late() */
>
> -       if (static_key_count(&sched_clock_running.key) == 2)
> +       if (static_key_count(&sched_clock_running.key) == 2) {
> +               pr_info("sched_clock: Marking unstable.\n");
>                 __clear_sched_clock_stable();
> +       }
>  }
>
>  static void __sched_clock_gtod_offset(void)
> --
> 2.25.1
