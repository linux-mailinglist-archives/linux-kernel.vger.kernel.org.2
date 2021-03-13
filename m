Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C6C339A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 01:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhCMABm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 19:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbhCMABX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 19:01:23 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B931C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 16:01:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z25so9422615lja.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 16:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spwItwioBxP+1u6yXKBwsvPAzUEdjy80N3bb4r66aWw=;
        b=nHTfpz61sUQqiBdZwrE/XiZbx3a/t95ZtNDcwXNL2aKhC3rGdfmDYX+ogeTj6Kr5FZ
         TtfqTDd8PSGLRKp+vht4rhkoCe8V6q9IP5lb4RupgtIXDtFP7OHIHkLDVMtmAu6AfnNH
         lGA1DL14esTqgvQLj7nJ10CW+1AMwCMrLLv4zlPxgw2pkMwBzVzSOUxLEWiSmWBkFIr+
         R7NmmxbZ9iUFU3BbBnQLdR2i30BITcndJfswiuxFims9JmA+lQPnbtWKrjd9gJBIVizE
         CgcF99hvgcNiQU/aVybaZjw3bxeJ5xpWiyo3AOnTyGoSyX4kELU6aqcZp2g7l8DH+fiC
         j+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spwItwioBxP+1u6yXKBwsvPAzUEdjy80N3bb4r66aWw=;
        b=QSDGegHZiSGz0wH6+N07G3l4Vajz4RlvdgrDjbSO+mBf1IKGj/nj3Ho1yYon1N8hvZ
         6wHGBlY0xSYbrF3N9E+hW6/R00wKSCJQJGG0LHdD+vZC4dmFDPMT3pa2havICl5Bgpur
         Bk2KPAPohHt/G+NES5+dWSRqmfP7Xlx6U7UpJp9dzk8VZWN8h0nGQprsFKLEPYyp07qr
         71UHV8XUwwP0lobcoLYdsZ4kZqtNSEYA/NWBkFtE1Hs7nqWJJ6r3R+j6QlpTkhGJZGBx
         b3IZ2NpqUIubzT6SBXDnUGfAjlw/R8hU0YIa9JlBMs3fn/+pf+qqBly25B9vnpChME7X
         bcNg==
X-Gm-Message-State: AOAM530gwQ8zQaSPHjTNhc5lS4o5nh36um6smqZ4IesH/mLRHT4ktxlg
        4iWoRGOllFllp27omcf+6lPdVMWWhnBBDY/80sSlrA==
X-Google-Smtp-Source: ABdhPJwMqMBS5LDWLGDE/NDEdHY/fLmjfpyzHgXxDhWSLZD0W6dV63J8wJsuS02jKk45hknjObVdTHyBcT7hCQTNq0A=
X-Received: by 2002:a05:651c:211b:: with SMTP id a27mr3728543ljq.433.1615593681625;
 Fri, 12 Mar 2021 16:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20210311184629.589725-1-dualli@chromium.org> <20210311184629.589725-3-dualli@chromium.org>
In-Reply-To: <20210311184629.589725-3-dualli@chromium.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 12 Mar 2021 16:01:11 -0800
Message-ID: <CAHRSSExs6v7OPcawg+CLdhqfMtXsXn38=mn84vMYmviM8sJjtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binder: use EINTR for interrupted wait for work
To:     Li Li <dualli@chromium.org>
Cc:     Li Li <dualli@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:46 AM Li Li <dualli@chromium.org> wrote:
>
> From: Marco Ballesio <balejs@google.com>
>
> when interrupted by a signal, binder_wait_for_work currently returns
> -ERESTARTSYS. This error code isn't propagated to user space, but a way
> to handle interruption due to signals must be provided to code using
> this API.
>
> Replace this instance of -ERESTARTSYS with -EINTR, which is propagated
> to user space.
>
> Test: built, booted, interrupted a worker thread within
> binder_wait_for_work
> Signed-off-by: Marco Ballesio <balejs@google.com>
> Signed-off-by: Li Li <dualli@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 76ea558df03e..38bbf9a4ce99 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3712,7 +3712,7 @@ static int binder_wait_for_work(struct binder_thread *thread,
>                 binder_inner_proc_lock(proc);
>                 list_del_init(&thread->waiting_thread_node);
>                 if (signal_pending(current)) {
> -                       ret = -ERESTARTSYS;
> +                       ret = -EINTR;
>                         break;
>                 }
>         }
> @@ -4855,7 +4855,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>         if (thread)
>                 thread->looper_need_return = false;
>         wait_event_interruptible(binder_user_error_wait, binder_stop_on_user_error < 2);
> -       if (ret && ret != -ERESTARTSYS)
> +       if (ret && ret != -EINTR)
>                 pr_info("%d:%d ioctl %x %lx returned %d\n", proc->pid, current->pid, cmd, arg, ret);
>  err_unlocked:
>         trace_binder_ioctl_done(ret);
> --
> 2.31.0.rc2.261.g7f71774620-goog
>
