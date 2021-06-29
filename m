Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24263B715C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhF2Lhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbhF2Lhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:37:32 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC572C061766
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 04:35:04 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h3so6247188qto.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LZBNoVMafaZdSt9KOA/GfK+2t3WWU0PS2M5jLE524Ts=;
        b=HDlA19tX64xTq11pK4BeWQtGUbir13Nei7u7jJZetqIbUhQUxBYPIu/Y+U3FUAD0Tr
         kRrYkRfgLRfU9x0qonM6k0KcOTCjksUD+uppxHjAU3bwHDU2YDfQzI97JhiSgU26lz1T
         utVhiHj9wKcxhUU6Ek58S7i+tiPGWEQWxczx1RBP6c8JMbfMyq4fwojMZEpM/DH1Ef7U
         JIL7AeF3nqtXis34npPe0w5faG11nrzZ5Q5SJiGvEgSkeAf4ssDRtsCiwUDTJ4i+RuNH
         hcRU/AbF6vGGzo+aRN56bOLnjjdoKtMCccsdtnmODokUEGfheSbtW0Qe8eGWZ1ZxeUK3
         3kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LZBNoVMafaZdSt9KOA/GfK+2t3WWU0PS2M5jLE524Ts=;
        b=dNG1PAEyXU4hmMjrrU+jLGWLitp+NZKYDubbtRDllW4Z0VoGP0+kOofU0YUSTY1bhG
         OmlEDZ+gfFkS+0i7ul4HKXkzW+ehBhuHyaWEKM1NVSItZKrzVsuMN9xAkIzqIfwpf005
         L/5d2fklPiajaa3heV+/Y4Vjl0x6o3A857X3DJ9oixx0G6Gf+7saStTsXq0Hi1nfPMqh
         UlNOiL6paFNVQyuBxfAUtLIDdH/0GJqBXSgv6IBIurhm5SlSfq1A16XjjtsAVdQDZAzy
         WU6yzcJibr6DY5SXWXZDODQ1qln5tGrA6baFxteBltBpu1rQAwsQs2m8EkZkyedqCEv7
         74ig==
X-Gm-Message-State: AOAM532cAeWLf/r0eMk0wTiZ6D9y0SQVr/W0QFRtoB4t6fBfsxSnSaV4
        bwx8Sm3Y8GwN/FgzO5FjlyDIRPs5k6/M8IfwjdjnpQ==
X-Google-Smtp-Source: ABdhPJxp9GVjsHZh+3nOD/YB31cmBNdWln9F1a0cZkPaVRn7sHwODcJaovj1osFc1+2O962+ycSayDEL/+n7ZLgPeH4=
X-Received: by 2002:ac8:5bc4:: with SMTP id b4mr22629588qtb.180.1624966503664;
 Tue, 29 Jun 2021 04:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210629113323.2354571-1-elver@google.com>
In-Reply-To: <20210629113323.2354571-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 29 Jun 2021 13:34:27 +0200
Message-ID: <CAG_fn=V2H7UX8YQYqsQ08D_xF3VKUMCUkafTMVr-ywtki6S0wA@mail.gmail.com>
Subject: Re: [PATCH] kfence: show cpu and timestamp in alloc/free info
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Joern Engel <joern@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 1:33 PM Marco Elver <elver@google.com> wrote:
>
> Record cpu and timestamp on allocations and frees, and show them in
> reports. Upon an error, this can help correlate earlier messages in the
> kernel log via allocation and free timestamps.
>
> Suggested-by: Joern Engel <joern@purestorage.com>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Alexander Potapenko <glider@google.com>

Thanks!

> ---
>  Documentation/dev-tools/kfence.rst | 98 ++++++++++++++++--------------
>  mm/kfence/core.c                   |  3 +
>  mm/kfence/kfence.h                 |  2 +
>  mm/kfence/report.c                 | 19 ++++--
>  4 files changed, 71 insertions(+), 51 deletions(-)
>
> diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools=
/kfence.rst
> index fdf04e741ea5..0fbe3308bf37 100644
> --- a/Documentation/dev-tools/kfence.rst
> +++ b/Documentation/dev-tools/kfence.rst
> @@ -65,25 +65,27 @@ Error reports
>  A typical out-of-bounds access looks like this::
>
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read+0xa3/0x22=
b
> +    BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read+0xa6/0x23=
4
>
> -    Out-of-bounds read at 0xffffffffb672efff (1B left of kfence-#17):
> -     test_out_of_bounds_read+0xa3/0x22b
> -     kunit_try_run_case+0x51/0x85
> +    Out-of-bounds read at 0xffff8c3f2e291fff (1B left of kfence-#72):
> +     test_out_of_bounds_read+0xa6/0x234
> +     kunit_try_run_case+0x61/0xa0
>       kunit_generic_run_threadfn_adapter+0x16/0x30
> -     kthread+0x137/0x160
> +     kthread+0x176/0x1b0
>       ret_from_fork+0x22/0x30
>
> -    kfence-#17 [0xffffffffb672f000-0xffffffffb672f01f, size=3D32, cache=
=3Dkmalloc-32] allocated by task 507:
> -     test_alloc+0xf3/0x25b
> -     test_out_of_bounds_read+0x98/0x22b
> -     kunit_try_run_case+0x51/0x85
> +    kfence-#72: 0xffff8c3f2e292000-0xffff8c3f2e29201f, size=3D32, cache=
=3Dkmalloc-32
> +
> +    allocated by task 484 on cpu 0 at 32.919330s:
> +     test_alloc+0xfe/0x738
> +     test_out_of_bounds_read+0x9b/0x234
> +     kunit_try_run_case+0x61/0xa0
>       kunit_generic_run_threadfn_adapter+0x16/0x30
> -     kthread+0x137/0x160
> +     kthread+0x176/0x1b0
>       ret_from_fork+0x22/0x30
>
> -    CPU: 4 PID: 107 Comm: kunit_try_catch Not tainted 5.8.0-rc6+ #7
> -    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1=
 04/01/2014
> +    CPU: 0 PID: 484 Comm: kunit_try_catch Not tainted 5.13.0-rc3+ #7
> +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2=
 04/01/2014
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  The header of the report provides a short summary of the function involv=
ed in
> @@ -96,30 +98,32 @@ Use-after-free accesses are reported as::
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>      BUG: KFENCE: use-after-free read in test_use_after_free_read+0xb3/0x=
143
>
> -    Use-after-free read at 0xffffffffb673dfe0 (in kfence-#24):
> +    Use-after-free read at 0xffff8c3f2e2a0000 (in kfence-#79):
>       test_use_after_free_read+0xb3/0x143
> -     kunit_try_run_case+0x51/0x85
> +     kunit_try_run_case+0x61/0xa0
>       kunit_generic_run_threadfn_adapter+0x16/0x30
> -     kthread+0x137/0x160
> +     kthread+0x176/0x1b0
>       ret_from_fork+0x22/0x30
>
> -    kfence-#24 [0xffffffffb673dfe0-0xffffffffb673dfff, size=3D32, cache=
=3Dkmalloc-32] allocated by task 507:
> -     test_alloc+0xf3/0x25b
> +    kfence-#79: 0xffff8c3f2e2a0000-0xffff8c3f2e2a001f, size=3D32, cache=
=3Dkmalloc-32
> +
> +    allocated by task 488 on cpu 2 at 33.871326s:
> +     test_alloc+0xfe/0x738
>       test_use_after_free_read+0x76/0x143
> -     kunit_try_run_case+0x51/0x85
> +     kunit_try_run_case+0x61/0xa0
>       kunit_generic_run_threadfn_adapter+0x16/0x30
> -     kthread+0x137/0x160
> +     kthread+0x176/0x1b0
>       ret_from_fork+0x22/0x30
>
> -    freed by task 507:
> +    freed by task 488 on cpu 2 at 33.871358s:
>       test_use_after_free_read+0xa8/0x143
> -     kunit_try_run_case+0x51/0x85
> +     kunit_try_run_case+0x61/0xa0
>       kunit_generic_run_threadfn_adapter+0x16/0x30
> -     kthread+0x137/0x160
> +     kthread+0x176/0x1b0
>       ret_from_fork+0x22/0x30
>
> -    CPU: 4 PID: 109 Comm: kunit_try_catch Tainted: G        W         5.=
8.0-rc6+ #7
> -    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1=
 04/01/2014
> +    CPU: 2 PID: 488 Comm: kunit_try_catch Tainted: G    B             5.=
13.0-rc3+ #7
> +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2=
 04/01/2014
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  KFENCE also reports on invalid frees, such as double-frees::
> @@ -127,30 +131,32 @@ KFENCE also reports on invalid frees, such as doubl=
e-frees::
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>      BUG: KFENCE: invalid free in test_double_free+0xdc/0x171
>
> -    Invalid free of 0xffffffffb6741000:
> +    Invalid free of 0xffff8c3f2e2a4000 (in kfence-#81):
>       test_double_free+0xdc/0x171
> -     kunit_try_run_case+0x51/0x85
> +     kunit_try_run_case+0x61/0xa0
>       kunit_generic_run_threadfn_adapter+0x16/0x30
> -     kthread+0x137/0x160
> +     kthread+0x176/0x1b0
>       ret_from_fork+0x22/0x30
>
> -    kfence-#26 [0xffffffffb6741000-0xffffffffb674101f, size=3D32, cache=
=3Dkmalloc-32] allocated by task 507:
> -     test_alloc+0xf3/0x25b
> +    kfence-#81: 0xffff8c3f2e2a4000-0xffff8c3f2e2a401f, size=3D32, cache=
=3Dkmalloc-32
> +
> +    allocated by task 490 on cpu 1 at 34.175321s:
> +     test_alloc+0xfe/0x738
>       test_double_free+0x76/0x171
> -     kunit_try_run_case+0x51/0x85
> +     kunit_try_run_case+0x61/0xa0
>       kunit_generic_run_threadfn_adapter+0x16/0x30
> -     kthread+0x137/0x160
> +     kthread+0x176/0x1b0
>       ret_from_fork+0x22/0x30
>
> -    freed by task 507:
> +    freed by task 490 on cpu 1 at 34.175348s:
>       test_double_free+0xa8/0x171
> -     kunit_try_run_case+0x51/0x85
> +     kunit_try_run_case+0x61/0xa0
>       kunit_generic_run_threadfn_adapter+0x16/0x30
> -     kthread+0x137/0x160
> +     kthread+0x176/0x1b0
>       ret_from_fork+0x22/0x30
>
> -    CPU: 4 PID: 111 Comm: kunit_try_catch Tainted: G        W         5.=
8.0-rc6+ #7
> -    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1=
 04/01/2014
> +    CPU: 1 PID: 490 Comm: kunit_try_catch Tainted: G    B             5.=
13.0-rc3+ #7
> +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2=
 04/01/2014
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  KFENCE also uses pattern-based redzones on the other side of an object's=
 guard
> @@ -160,23 +166,25 @@ These are reported on frees::
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>      BUG: KFENCE: memory corruption in test_kmalloc_aligned_oob_write+0xe=
f/0x184
>
> -    Corrupted memory at 0xffffffffb6797ff9 [ 0xac . . . . . . ] (in kfen=
ce-#69):
> +    Corrupted memory at 0xffff8c3f2e33aff9 [ 0xac . . . . . . ] (in kfen=
ce-#156):
>       test_kmalloc_aligned_oob_write+0xef/0x184
> -     kunit_try_run_case+0x51/0x85
> +     kunit_try_run_case+0x61/0xa0
>       kunit_generic_run_threadfn_adapter+0x16/0x30
> -     kthread+0x137/0x160
> +     kthread+0x176/0x1b0
>       ret_from_fork+0x22/0x30
>
> -    kfence-#69 [0xffffffffb6797fb0-0xffffffffb6797ff8, size=3D73, cache=
=3Dkmalloc-96] allocated by task 507:
> -     test_alloc+0xf3/0x25b
> +    kfence-#156: 0xffff8c3f2e33afb0-0xffff8c3f2e33aff8, size=3D73, cache=
=3Dkmalloc-96
> +
> +    allocated by task 502 on cpu 7 at 42.159302s:
> +     test_alloc+0xfe/0x738
>       test_kmalloc_aligned_oob_write+0x57/0x184
> -     kunit_try_run_case+0x51/0x85
> +     kunit_try_run_case+0x61/0xa0
>       kunit_generic_run_threadfn_adapter+0x16/0x30
> -     kthread+0x137/0x160
> +     kthread+0x176/0x1b0
>       ret_from_fork+0x22/0x30
>
> -    CPU: 4 PID: 120 Comm: kunit_try_catch Tainted: G        W         5.=
8.0-rc6+ #7
> -    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1=
 04/01/2014
> +    CPU: 7 PID: 502 Comm: kunit_try_catch Tainted: G    B             5.=
13.0-rc3+ #7
> +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2=
 04/01/2014
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  For such errors, the address where the corruption occurred as well as th=
e
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index d7666ace9d2e..0fd7a122e1a1 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -20,6 +20,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/random.h>
>  #include <linux/rcupdate.h>
> +#include <linux/sched/clock.h>
>  #include <linux/sched/sysctl.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> @@ -196,6 +197,8 @@ static noinline void metadata_update_state(struct kfe=
nce_metadata *meta,
>          */
>         track->num_stack_entries =3D stack_trace_save(track->stack_entrie=
s, KFENCE_STACK_DEPTH, 1);
>         track->pid =3D task_pid_nr(current);
> +       track->cpu =3D raw_smp_processor_id();
> +       track->ts_nsec =3D local_clock(); /* Same source as printk timest=
amps. */
>
>         /*
>          * Pairs with READ_ONCE() in
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 24065321ff8a..c1f23c61e5f9 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -36,6 +36,8 @@ enum kfence_object_state {
>  /* Alloc/free tracking information. */
>  struct kfence_track {
>         pid_t pid;
> +       int cpu;
> +       u64 ts_nsec;
>         int num_stack_entries;
>         unsigned long stack_entries[KFENCE_STACK_DEPTH];
>  };
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 2a319c21c939..d1daabdc9188 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/kernel.h>
>  #include <linux/lockdep.h>
> +#include <linux/math.h>
>  #include <linux/printk.h>
>  #include <linux/sched/debug.h>
>  #include <linux/seq_file.h>
> @@ -100,6 +101,13 @@ static void kfence_print_stack(struct seq_file *seq,=
 const struct kfence_metadat
>                                bool show_alloc)
>  {
>         const struct kfence_track *track =3D show_alloc ? &meta->alloc_tr=
ack : &meta->free_track;
> +       u64 ts_sec =3D track->ts_nsec;
> +       unsigned long rem_nsec =3D do_div(ts_sec, NSEC_PER_SEC);
> +
> +       /* Timestamp matches printk timestamp format. */
> +       seq_con_printf(seq, "%s by task %d on cpu %d at %lu.%06lus:\n",
> +                      show_alloc ? "allocated" : "freed", meta->alloc_tr=
ack.pid,
> +                      meta->alloc_track.cpu, (unsigned long)ts_sec, rem_=
nsec / 1000);
>
>         if (track->num_stack_entries) {
>                 /* Skip allocation/free internals stack. */
> @@ -126,15 +134,14 @@ void kfence_print_object(struct seq_file *seq, cons=
t struct kfence_metadata *met
>                 return;
>         }
>
> -       seq_con_printf(seq,
> -                      "kfence-#%td [0x%p-0x%p"
> -                      ", size=3D%d, cache=3D%s] allocated by task %d:\n"=
,
> -                      meta - kfence_metadata, (void *)start, (void *)(st=
art + size - 1), size,
> -                      (cache && cache->name) ? cache->name : "<destroyed=
>", meta->alloc_track.pid);
> +       seq_con_printf(seq, "kfence-#%td: 0x%p-0x%p, size=3D%d, cache=3D%=
s\n\n",
> +                      meta - kfence_metadata, (void *)start, (void *)(st=
art + size - 1),
> +                      size, (cache && cache->name) ? cache->name : "<des=
troyed>");
> +
>         kfence_print_stack(seq, meta, true);
>
>         if (meta->state =3D=3D KFENCE_OBJECT_FREED) {
> -               seq_con_printf(seq, "\nfreed by task %d:\n", meta->free_t=
rack.pid);
> +               seq_con_printf(seq, "\n");
>                 kfence_print_stack(seq, meta, false);
>         }
>  }
> --
> 2.32.0.93.g670b81a890-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
