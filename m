Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDA63B1212
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 05:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhFWDTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 23:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFWDTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 23:19:08 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21720C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 20:16:52 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i17so1183593ilj.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 20:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81j1L3Z0NPJObfy71geJUOaAbAIew4nBFk+r15S0NkU=;
        b=JkV8PUtCiP2oRsRojloQpoP46P+MNc85lg/QW9qe5hOPK/jcIeWOSCq/m5Y5w2alCl
         kWxFiq7L0VHAGPqN4i04JArH+D1FF2h5+3zGXR+SLgeh/aiAtLnp48L+ftYvDrVDhj0F
         WA2gNNoH49mWCL37FYLi3XuSQwNdRZX2LvbOV4lZYJ8xDu4NDV1qmpYi0BaBaoo60ida
         bb61Cc63jYsO7kHRaGZ+ToNKx1flrqrOGcqtTJ6LeQsgYdAJf+3BEv5Xk0ED02kMSb0n
         4scbWXfmjxEgmvers+XJTvJggL1ajUH/+B2je0RI1iCyKSSRmtszUPep9NAxjIERmSKd
         04Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81j1L3Z0NPJObfy71geJUOaAbAIew4nBFk+r15S0NkU=;
        b=uToHEMaMgCkZft3SXqSEG6cnKJ0X/Am1xi/Dtt9fmoz6RR7XG4Am7dkciI8NDBH3rI
         B74S5rgvlT2GbasKKwIVcZblle7En6t8b//eY0iWdUPHu6lobrgV8YMIpcy94UGMKlru
         XjZn7UdVbGNQiETh2R57lG+iLCBy8hjtZIx1FKqNmg+zUZUjLuMDQluGli5XKsLfmv4j
         W/somYMdKo2CTiVkLoWZnKG4QjncxQeBegV/vgkhEi/g22Oftw9RmlRlZ/i9x5zEr2YO
         gJ2hrBXBeq7IHLlhSHhXVc/IW5j9RgkP+iQlxKPebUOzyYpJslpXCJoIhz4WZ7j++ZDe
         KHFA==
X-Gm-Message-State: AOAM5329ci0OCPOw5I+uqpo7y86V2BXOcReTVoO/qxIjPOBrO5wrzeDG
        zsQzkd8k/A3OlTR71laGFuaTUGknEeXbnKaMYqgVjhr6Sds=
X-Google-Smtp-Source: ABdhPJxgV67nlwwWQFdrTSpKH0DzzwtRC/WJFLnC2snGJZ/ZnRC6kZmGV+4bIvxpWynSTSXHoL3QX0k4EV8eaCDWtKM=
X-Received: by 2002:a92:c5c2:: with SMTP id s2mr1267534ilt.164.1624418211606;
 Tue, 22 Jun 2021 20:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210622124211.715378-1-qiang.zhang@windriver.com>
In-Reply-To: <20210622124211.715378-1-qiang.zhang@windriver.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 23 Jun 2021 11:16:40 +0800
Message-ID: <CAJhGHyCNXEPEb0t9KLXafx8TPntjWFFH-T9uFUTsuGAQxVcZTw@mail.gmail.com>
Subject: Re: [PATCH v2] workqueue: set the rescuer worker that belong to
 freezable wq is freezable
To:     "Zhang, Qiang" <qiang.zhang@windriver.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 8:42 PM <qiang.zhang@windriver.com> wrote:
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> If the rescuer worker belong to freezable wq, when this wq is
> frozen, the rescuer worker also need to be frozen.

Hello,

From my understanding, the wq subsystem doesn't use set_freezable(),
try_to_freeze() families.  For example, the worker_thread() doesn't
use set_freezable(), neither do in your patch. If kthreads
in the wq subsystem need these functions, please let us know.

The way the wq subsystem to freeze tasks is by freeze_workqueues_begin()
and thaw_workqueues().  When WQs is requested for freezing,
they will stop activating work items.  All the workers including
*rescuers* will be scheduled as TASK_IDLE when all the activated work
items are processed and the whole wq subsystem is frozen unless
there is any semantic change about TASK_IDLE V.S. "frozen".
(rescuers can also only process activated work items.)

Thanks
Lai

>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  v1->v2:
>  use kthread_freezable_should_stop() replaces try_to_freeze().
>
>  kernel/workqueue.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 104e3ef04e33..dd7b78bdb7f1 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2476,6 +2476,9 @@ static int rescuer_thread(void *__rescuer)
>          * doesn't participate in concurrency management.
>          */
>         set_pf_worker(true);
> +
> +       if (wq->flags & WQ_FREEZABLE)
> +               set_freezable();
>  repeat:
>         set_current_state(TASK_IDLE);
>
> @@ -2487,7 +2490,7 @@ static int rescuer_thread(void *__rescuer)
>          * @wq->maydays processing before acting on should_stop so that the
>          * list is always empty on exit.
>          */
> -       should_stop = kthread_should_stop();
> +       should_stop = kthread_freezable_should_stop(NULL);
>
>         /* see whether any pwq is asking for help */
>         raw_spin_lock_irq(&wq_mayday_lock);
> --
> 2.25.1
>
