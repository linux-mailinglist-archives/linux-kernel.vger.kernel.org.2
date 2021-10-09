Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215B342758F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhJICIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 22:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhJICIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 22:08:32 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F65C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 19:06:36 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h11so4023166ila.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 19:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfeubPf4AKs14dD2DyxJOMlywWvHQ4knhyd24YmHZdo=;
        b=bBEJxWdbJ6JG/DTWs+mk8ayXliCKhY5RTF4pN53cUTpwbCy3vRlh6Gv1Nm/3CC5OXq
         4bdgiJezo1feA+JA9wSlEvxnZ03dEtgIdsRGzGEAZix0hbdituw/J54Kde8e3Z31xlMP
         yScBZlVD0d+7c3YRYoGU6olrfim96b9iIe1BrTVuQL4ETQYUHyyqf3ITohtT2LKnOZlu
         tjRDPwyfDfCTekKIN1IuGI557g8bjtlSAyexxs7E1wSdUdBB8vE7RYzRpwxNxOsrOhNO
         cwnbQxVeH63hAEOFr8tU+ESlNOpBbKCiNiJ8vtfs4wyOn7EqAO45Sjtt8K5eWAZkHy9t
         3qQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfeubPf4AKs14dD2DyxJOMlywWvHQ4knhyd24YmHZdo=;
        b=TbwuTL8ehmgVNiBAYEzN6/5SwLebTLQ54Hc+MlL8ev8ylun2+SF12pu/imx4SVvSSx
         wzLcsutM/ORGSvMZu1HGVQFiw2WkFdQqnI+YG+3VNrBMf+wxceT3UDAxRJRgtXn3LldR
         ckUreF9yvwQ7aTNX5/trakPEYPFJif6AsDeKo2TtYwbRBB37fob4ottsPEKUERhJcrwq
         Ppw5dfiC+hTfkm7/rfK0Teleb8lNtqK9FQcFCtKhSOJKj9NHESCO1uT1EyUez7LHl7pJ
         weZ3jnitFWpefEk97LDX0K2Fkn6fxjdiJa9j6DjkyODaeGOlKvgkiMUbhSlEknTB45YV
         Ucsg==
X-Gm-Message-State: AOAM531VtubQrCA7Ufsk+4/rgUoxIQSph+M3+NRfOXDq15hQ+Rp4nlBW
        XL59ABV5sRVEAJ5pLGBjelUuCADFEa9JsMZxIsT/LD0RQq8=
X-Google-Smtp-Source: ABdhPJx4il+YMXF0+EJoUmjjdQGTzYrNpG8q3Tmqa6F3vSaLRfM4BBqlg2UMOL5CbRZZY24xdAqhzER5VCpfuG7cMEY=
X-Received: by 2002:a05:6e02:1014:: with SMTP id n20mr9633166ilj.222.1633745194966;
 Fri, 08 Oct 2021 19:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211008100454.2802393-1-boqun.feng@gmail.com> <20211008100454.2802393-3-boqun.feng@gmail.com>
In-Reply-To: <20211008100454.2802393-3-boqun.feng@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 9 Oct 2021 10:06:23 +0800
Message-ID: <CAJhGHyDudet_xyNk=8xnuO2==o-u06s0E0GZVP4Q67nmQ84Ceg@mail.gmail.com>
Subject: Re: [RFC 2/2] workqueue: Fix work re-entrance when requeue to a
 different workqueue
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 6:06 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> When requeuing a work to a different workqueue while it's still getting
> processed, re-entrace as the follow can happen:
>
>         { both WQ1 and WQ2 are bounded workqueue, and a work W has been
>           queued on CPU0 for WQ1}
>
>         CPU 0                   CPU 1
>         =====                   ====
>         <In worker on CPU 0>
>         process_one_work():
>           ...
>           // pick up W
>           worker->current_work = W;
>           worker->current_func = W->func;
>           ...
>           set_work_pool_and_clear_pending(...);
>           // W can be requeued afterwards
>                                 queue_work_on(1, WQ2, W):
>                                   if (!test_and_set_bit(...)) {
>                                     // this branch is taken, as CPU 0
>                                     // just clears pending bit.
>                                     __queue_work(...):
>                                       pwq = <pool for CPU1 of WQ2>;
>                                       last_pool = <pool for CPU 0 of WQ1>;
>                                       if (last_pool != pwq->pool) { // true
>                                         if (.. && worker->current_pwq->wq == wq) {
>                                           // false, since @worker is a
>                                           // a worker of @last_pool (for
>                                           // WQ1), and @wq is WQ2.
>                                         }
>                                         ...
>                                         insert_work(pwq, W, ...);
>                                       }
>                                 // W queued.
>                                 <schedule to worker on CPU 1>
>                                 process_one_work():
>                                   collision = find_worker_executing_work(..);
>                                   // NULL, because we're searching the
>                                   // worker pool of CPU 1, while W is
>                                   // the current work on worker pool of
>                                   // CPU 0.
>                                   worker->current_work = W;
>                                   worker->current_func = W->func;
>           worker->current_func(...);
>                                   ...
>                                   worker->current_func(...); // Re-entrance

Concurrent or parallel executions on the same work item aren't
considered as "Re-entrance" if the workqueue is changed.

It allows the work function to free itself(the item) and another
subsystem allocates the same item and reuses it.

"Re-entrance" is defined as:
  work function has not been changed
  wq has not been changed
  the item has not been reinitiated.
  (To reduce the check complication, the workqueue subsystem often
considers it "Re-entrance" if the condition is changed and has changed
back. But the wq users should not depend on this behavior and should avoid
it)


>
> This issue is already partially fixed because in queue_work_on(),
> last_pool can be used to queue the work, as a result the requeued work
> processing will find the collision and wait for the existing one to
> finish. However, currently the last_pool is only used when two
> workqueues are the same one, which causes the issue. Therefore extend
> the behavior to allow last_pool to requeue the work W even if the
> workqueues are different. It's safe to do this since the work W has been
> proved safe to queue and run on the last_pool.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/workqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 1418710bffcd..410141cc5f88 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1465,7 +1465,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>
>                 worker = find_worker_executing_work(last_pool, work);
>
> -               if (worker && worker->current_pwq->wq == wq) {
> +               if (worker) {
>                         pwq = worker->current_pwq;
>                 } else {
>                         /* meh... not running there, queue here */
> --
> 2.32.0
>
