Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510893DBC2B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbhG3PXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239355AbhG3PXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627658609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rlpYEUP1fPYxSgEcVW4sk69FHL0RWRTkK44MBixj09Y=;
        b=C5dshoVIwr5aZ7GFGIFwj35LYob6TzNJgDz4Yd+Irrj78YflhmQBFZu2sYqtwiMumMrqQi
        7qtXP9QblfNm5De0qkUvolkF9zyHR7klhLkzrBxmTdkgH3HbhODKcBOuRCk3oe9F0t6tuV
        ajlzc6LqcSKFs5inbcqKe9GkeTRC1bI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-ZRH1P4gWOQWVBW5qQsHHXA-1; Fri, 30 Jul 2021 11:23:27 -0400
X-MC-Unique: ZRH1P4gWOQWVBW5qQsHHXA-1
Received: by mail-ot1-f69.google.com with SMTP id 16-20020a9d04100000b02904cdb63ceafcso3913372otc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 08:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlpYEUP1fPYxSgEcVW4sk69FHL0RWRTkK44MBixj09Y=;
        b=SjWwECcL5Mufmk6Qfjoj0+ba3LttEJvmxTSRNJg+UuSvymzsEc4Wmo8x3MKMdlBNBC
         ypypXxWYTmj97/sFAm1A8v/W3PpjNKUnZIMgDv9pEEqyLwd4bFurDPPtXy8u+c04iKjA
         8QdaKxGRVmBTQ8JXHJwNUNxzfs8xDBFUOjCYjz5UNfeWd8jKzO/3MiuRh6bfyJbPpX4p
         N8sIWt5p0sx/tA/vU9TQ/hW1zwQiv5hLSbEEi59xyvKACBid9D7y49xYMCqXL5fZSbbw
         /JUBJvwjpU9UWT4OtlKk+G4ca1Zi7ioZv7uykj9XKM53xlD2fvdGz5umU+RGjLE7FDJI
         CWmg==
X-Gm-Message-State: AOAM533Fuq8ahIc/G49P5kocUlWbi+ITmoYz2/zhebkTX6ImUlNk6KSW
        pws2CXe/trGxzYYKLHI1FNtsUk3J9xzqVqtyWI9OzG/dsHr5C8GlRravAzAha6RWZKP4jltrY8z
        TMLqrdZTSFqW8hV1VkcN1kThYlcCrgZhuQ9l//f9V
X-Received: by 2002:a05:6808:1887:: with SMTP id bi7mr2168239oib.115.1627658607160;
        Fri, 30 Jul 2021 08:23:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAkIxOoxTGpKbq3vstvHFS3+FBdzu91X0ATz48bfJejhQugTZ5UfQaonBLpYic53MzOmS4bc6K9kxoDjplIEY=
X-Received: by 2002:a05:6808:1887:: with SMTP id bi7mr2168225oib.115.1627658607019;
 Fri, 30 Jul 2021 08:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4oOgrb8n=Qyuky-M0dYPEo_HNMdbNuj2SF4a=aQTE_xvw@mail.gmail.com>
 <d86333e7-bcde-2adb-e566-21ec97cda8bf@arm.com> <CA+QYu4rCRR_pNQVxSwGpzcLWJKLUA3F7LAtBiU9hPzz3D0k0Cg@mail.gmail.com>
 <f5b4beb9-4e75-0f4e-da8b-b7ccc12fee68@arm.com> <1ea2fa5c-ae81-2389-7f02-2227636582e4@arm.com>
In-Reply-To: <1ea2fa5c-ae81-2389-7f02-2227636582e4@arm.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Fri, 30 Jul 2021 17:23:15 +0200
Message-ID: <CA+QYu4q3k8d60u5BwLy+mhRFjBd0cukiSmWAXRiMN2SbZ1XavQ@mail.gmail.com>
Subject: Re: WARNING: CPU: 112 PID: 2041 at kernel/sched/sched.h:1453
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     CKI Project <cki-project@redhat.com>, linux-kernel@vger.kernel.org,
        nathan@kernel.org, Memory Management <mm-qe@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 2:22 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 29/07/2021 16:38, Dietmar Eggemann wrote:
> > On 29/07/2021 14:36, Bruno Goncalves wrote:
> >> On Wed, Jul 28, 2021 at 5:55 PM Dietmar Eggemann
> >> <dietmar.eggemann@arm.com> wrote:
> >>>
> >>> On 28/07/2021 15:11, Bruno Goncalves wrote:
> >
> > [...]
> >
> >>> Can't reproduce it on my Juno (arm64) (slow-switching (scpi-cpufreq
> >>> driver)).
> >>
> >> We seem to be able to reproduce this only on Ampere Altra machines,
> >> specifically on mtjade and mtsnow cpus.
> >>
> >> # cpupower frequency-info
> >> analyzing CPU 0:
> >>   driver: cppc_cpufreq
> >>   CPUs which run at the same hardware frequency: 0
> >>   CPUs which need to have their frequency coordinated by software: 0
> >>   maximum transition latency:  Cannot determine or is not supported.
> >>   hardware limits: 1000 MHz - 2.80 GHz
> >>   available cpufreq governors: conservative ondemand userspace
> >> powersave performance schedutil
> >>   current policy: frequency should be within 2.00 GHz and 2.80 GHz.
> >>                   The governor "schedutil" may decide which speed to use
> >>                   within this range.
> >>   current CPU frequency: 1.55 GHz (asserted by call to hardware)
> >>
> >> # ps -eTo comm,pid,pri,class | grep sugov
> >> sugov:0            1082 140 DLN
> >> sugov:1            1085 140 DLN
> >> ...
> >> sugov:78           1319 140 DLN
> >> sugov:79           1320 140 DLN
> >
> > Thanks! In the meantime I got access to an Ampere Altra so I can try
> > 5.14.0-rc1 later today.
>
> The task causing this seem to be the new `cppc_fie` DL task introduced
> by commit 1eb5dde674f5 "cpufreq: CPPC: Add support for frequency
> invariance" in v5.14-rc1.
>
> With `CONFIG_ACPI_CPPC_CPUFREQ_FIE=y` and schedutil cpufreq governor on
> slow-switching system:
>
> DL task curr=`sugov:X` makes p=`cppc_fie` migrate and since it is in
> `non_contending` state, migrate_task_rq_dl() calls
>
>   sub_running_bw()->__sub_running_bw()->cpufreq_update_util()->
>   rq_clock()->assert_clock_updated()
>
> on p.
>
> Can you try this snippet? It should fix it.

Thank you, I've tried the patch and it fixes the issue.

Bruno

>
> --8<--
>
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Date: Fri, 30 Jul 2021 14:03:40 +0200
> Subject: [PATCH] sched/deadline: Fix missing clock update in
>  migrate_task_rq_dl()
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/deadline.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index aaacd6cfd42f..4920f498492f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1733,6 +1733,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
>          */
>         raw_spin_rq_lock(rq);
>         if (p->dl.dl_non_contending) {
> +               update_rq_clock(rq);
>                 sub_running_bw(&p->dl, &rq->dl);
>                 p->dl.dl_non_contending = 0;
>                 /*
> --
> 2.25.1
>

