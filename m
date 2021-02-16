Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43A931D093
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 19:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBPS7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 13:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhBPS72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:59:28 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA810C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 10:58:47 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id v19so5141770qvl.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 10:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wt+ZHvAgSTUKt5QUMiIbljM+Pr2E5QTPlCGcPzizKN0=;
        b=b8MYAZfy9wNHfl9P1mzairwhFshuwFre3PsstwFebRHuxeQDvZZjfNlUhnNktUlYPu
         SMi+emP0f7jHL/LPtaT4tpMIMBas3sWHQYOZJb/LuffDnK9amIGY+Ow9nXICLs/cvs9Q
         ZVlXa5e6WkEmbXDXotarC+VNim7MiTbbZymbW7Q2MNOwEyXUEFfdoMSqb+W1QCnDkolr
         Kd9ixx8bYMAt04v2Lc7RBvzypFA7SNklB6/7ZbHwErdmooA+6H7J8Fwb8nU4z4rcknHX
         ZyE+tCfYIdYCAtFeDfIElNSEGOauTmTJqRk4UKoBKcVFNlE2gfJW16tg4Y5rGVtac2T1
         /D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wt+ZHvAgSTUKt5QUMiIbljM+Pr2E5QTPlCGcPzizKN0=;
        b=V9yOm0hAdAum71dHRw75O9TS2L/MTBngVOXoxsiTLe8Xn63DiRvBu6lryZMGx2p6K1
         Drznt2+yr1o60vQjxvDTdAMDBJYpZrA1YRZFRxKI7WOoaVD5VFQjEfRB0QMV+6mt4ZqG
         wTvpb5ULXNEXzVrNLCUPkuDc9zdH6B9/pF3QuEQP4XfIpFCf5LcMogQm14PIRrei4+I+
         ZeXcoVvwjoqJzY46KrlQo3bu2ToffpJjKiiQXw3QbhGzoCFEhCkeQ8jqRV8UTZTT1Ltb
         DlUf1V4noeIiLROsPlbx/GUBcFeShOAhh+f7PUI2rjK2gl7z5EEF5xqi4L+vh8Y8PY1u
         yLdw==
X-Gm-Message-State: AOAM533W1vtxzAZ00LdJ/2PgRNKa2VUIQ6MccnmqHF8Lmm38ObNrUQBd
        B9xpx6snYjeEUDfhaahv/xf4YmCzsbsG96Pv65uUeg==
X-Google-Smtp-Source: ABdhPJwLaR4CJWMvkEAmGhulm+O1MUMlKdyloBiPmqKX4ljT+0eNuTbkjaTSddV4WzHZtSQnIW1TNNtR8tDKcx/j4bc=
X-Received: by 2002:a0c:ef85:: with SMTP id w5mr14157633qvr.15.1613501927049;
 Tue, 16 Feb 2021 10:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20210214000611.2169820-1-zzyiwei@android.com> <20210216091128.GA3973504@infradead.org>
In-Reply-To: <20210216091128.GA3973504@infradead.org>
From:   =?UTF-8?B?WWl3ZWkgWmhhbmfigI4=?= <zzyiwei@android.com>
Date:   Tue, 16 Feb 2021 10:58:36 -0800
Message-ID: <CAKB3++aXuCS3WRf1mfrM2oZ0KiJ4xP4ib-ZbJXr8cXVEkU-sXw@mail.gmail.com>
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 5:28 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sun 2021-02-14 00:06:11, Yiwei Zhang wrote:
> > The existing kthread_mod_delayed_work api will queue a new work if
> > failing to cancel the current work due to no longer being pending.
> > However, there's a case that the same work can be enqueued from both
> > an async request and a delayed work, and a racing could happen if the
> > async request comes right after the timeout delayed work gets
> > scheduled,
>
> By other words, you want to modify the delayed work only when
> it is still waiting in the queue. You do not want to queue new
> work when it has not been already queued. Do I get it correctly?
>
Yes, you are correct.

> Could you please provide a patch where the new API is used?
>
Currently it will only get used in a downstream gpu driver.

> > because the clean up work may not be safe to run twice.
>
> This looks like a bad design of the code. There is likely
> another race that might break it. You should ask the following
> questions:
>
> Why anyone tries to modify the clean up work when it has been already
> queued? There should be only one location/caller that triggers the clean up.
>
The clean up work was initially queued as a safe timeout work just in
case the userspace doesn't queue the cleanup work(e.g. process
crashing), which leaves the global driver in an incorrect driver
state(e.g. power state due to some hinting). In addition, the cleanup
work will also have to clean the cache allocated work struct as well
in the racing scenario.

> Could anyone queue any work to the workqueue after the clean up
> work was queued? The cleanup work should be the last queued one.
> The workqueue user must inform all other users that the queue
> is being destroyed and nobody is allowed to queue any work
> any longer.
>
User can queue the initial work(internally it queues a cleanup work
with a big timeout in case user doesn't queue it later). Then after
user has done stuff within the scope, the user will queue the cleanup
work again to cancel out the effect, which is when it may race with
the underlying timeout'ed cleanup work.

> Best Regards,
> Petr

On Tue, Feb 16, 2021 at 1:12 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Feb 14, 2021 at 12:06:11AM +0000, Yiwei Zhang wrote:
> > The existing kthread_mod_delayed_work api will queue a new work if
> > failing to cancel the current work due to no longer being pending.
> > However, there's a case that the same work can be enqueued from both
> > an async request and a delayed work, and a racing could happen if the
> > async request comes right after the timeout delayed work gets scheduled,
> > because the clean up work may not be safe to run twice.
>
> Who is going to use this?  Please submit it together with the actual
> user.

I'm not sure what I should do if there's no users in the main kernel
tree. Currently it's only potentially used in a downstream gpu driver.
I was proposing here to see if this behavior is reasonable for this
mod function.(My guts feel, when folks are calling this mod function,
they do want to modify "the" exact pending work instead of requeuing
another if the pending one already gets scheduled...)

Best regards,
Yiwei
