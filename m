Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD46D41BC29
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 03:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbhI2B2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 21:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243515AbhI2B2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 21:28:03 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D2CC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 18:26:22 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r9so1063766ile.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 18:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yKjtYZb1vFeje+/v7H50Z05W1LiVJk+HS5cGOWDNWM=;
        b=akx8EEkxVTVDnMZ4KsK7+9IMUxMQo4clufsOyvssa7nyaO/Don4FknCOoQhikgjUic
         YztF2vxY/rILnAmUq0VWMLoDSdtETk5qBA2rbvmgqYBsD3t/YPSyu0wSnuQYJHZKls1n
         pRdG67LInITqA1ZfqeiHZ4h1H6VL+Oei5fKkwM2D1bzl1vQJJu418NpsUw9pYdLAeJNp
         XycBvjtIiZZnH8fhm5v4Ykvk2iqo1actV+tMvyvsdw07crizY85h3vSbKzSB7fhG8JA9
         9tNZx5/3sNN3pd2c9JlbLy2riYGPM720RgwQMB4JUbOCfGx90+NP/xhTxPiMXAuIRoXn
         WfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yKjtYZb1vFeje+/v7H50Z05W1LiVJk+HS5cGOWDNWM=;
        b=gVA6i282p4soCG2JN9OoNyEUM5skGPMGgFh3Fra84yG81g84sj3169BGoRRfwjdSqA
         b4JqD53TQMaUbgnK4LmfOpHZLGm/LYRIXudqQuDOKusf42HjuM5oS1fn/8oTXHJdeb5d
         /ju2T68exE937lt2gGgm4xqbwtpRCiK9FlTIWwhUzRBkqaY/VMEsmTdyNhboF+GGfx4o
         LWd94Q0+tfV+GhMQZHnVxxLpunpQaDWk18NhPsDE1FI9rJJdZju6OGbLhhN14L7Ke+Ap
         nM8QH6o7ZEkmN4PgpVn0gd0WWLVq1VfaZc9tVaXbr1l8992YvzHpSR7VCpXG4gIGnZJS
         QBig==
X-Gm-Message-State: AOAM531SLd3zkmbjd1GzrJQ2Gw7/Ln6vqWw+IwBueq0Ad+1BFb9FV3Kb
        GL8ElJVWDejicM5mm7/0FZfuzS82EZmez7OgbcI=
X-Google-Smtp-Source: ABdhPJyUMgM3xtIbPmuO1v3jB2EpNzmdr9hJncKwAjDftWY4qh75TX8dNN1GKYV/7diZrCjwb8lORg8KvYTmkQV83cU=
X-Received: by 2002:a05:6e02:14c8:: with SMTP id o8mr6189520ilk.125.1632878781936;
 Tue, 28 Sep 2021 18:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <87sfxoai2l.ffs@tglx>
In-Reply-To: <87sfxoai2l.ffs@tglx>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Wed, 29 Sep 2021 09:26:10 +0800
Message-ID: <CAJhGHyBwVLpcWoizJaMvQUFhAO_rz4CBQ1=D8hZ2iAadruh7WQ@mail.gmail.com>
Subject: Re: sched: Remove pointless preemption disable in sched_submit_work()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Oskolkov <posk@posk.io>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 10:31 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Neither wq_worker_sleeping() nor io_wq_worker_sleeping() require to be invoked
> with preemption disabled:
>
>   - The worker flag checks operations only need to be serialized against
>     the worker thread itself.
>
>   - The accounting and worker pool operations are serialized with locks.
>
> which means that disabling preemption has neither a reason nor a
> value. Remove it.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/sched/core.c |    2 --
>  1 file changed, 2 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6327,12 +6327,10 @@ static inline void sched_submit_work(str
>          * requires it.
>          */
>         if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {

Hello

The comment about preemption above this if branch and wq_worker_sleeping()
needs to be removed.

Thanks
Lai

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

> -               preempt_disable();
>                 if (task_flags & PF_WQ_WORKER)
>                         wq_worker_sleeping(tsk);
>                 else
>                         io_wq_worker_sleeping(tsk);
> -               preempt_enable_no_resched();
>         }
>
>         if (tsk_is_pi_blocked(tsk))
