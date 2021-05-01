Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B897370450
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 02:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhEAAKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 20:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhEAAKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 20:10:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4B8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:10:03 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b10so11534446iot.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nmI0Z6GpJ669OoqTL4ZRS5HBzAE6mZbx+jGtxyj3s4=;
        b=TAk5su9x4YNFiIahiV9a5aaJzJsZ734/S9ixVX7Bz0n5yF+3hMGaPGzcXNECetsqWg
         JkHS1ySxd3AQSEDQjy+xEZqIembgrUUi7vL6ea9plM5m16ZqVnUV0HCviU/AnqQAXtPQ
         WY0OTMD6LH4B6yZmmlK4gYsgcNJM2o8nMR04c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nmI0Z6GpJ669OoqTL4ZRS5HBzAE6mZbx+jGtxyj3s4=;
        b=CrgO/bSUT7b8ks5pTUTI3TMfrcsZWZXNWR4cxmk4dqn6SVIwraFW5sonMgLUnpH3DL
         xlLHVrY1m0samsLkWDsKB2VXqF8tujVJognyF/Vit/XAsNWLQLiv0NLoczlTmE7FL5sD
         VQ/M3HVEmBziSuljk6jQU1pvQNpuU6YBukd8ZzB8PsbYZm9564F5PkXfOA7TvQUuZLVh
         /S+KGtvtBUZja0Bocc+cLeiFGWNoXX86Tzvn7xGjfRrJAkx4vZOtoBpWG95pE6VgNA+j
         /DU7qXAEEoMyiQnCHiqI2VPcZaGWVOTxTpkmD1h5AmhX4yfSumOAlHm4hpe8hzcHZ4R7
         Sk7Q==
X-Gm-Message-State: AOAM533D1QTG0aX2hoATXvZOY9odO92tYhdJhpTCkVtuMzm8X8ybdJYg
        PxfM7RvSAEMOQ7yWzgNRupJ1gc4qVRUmaj41obEaRg==
X-Google-Smtp-Source: ABdhPJyT0j0QeyzLWjQB1x7+UCsurnHz/q9/z3ussQHoMN5YDGUGkx6sJfukt1wBMQ+0ZnLAhavewmPl1lpbl04zjDE=
X-Received: by 2002:a5d:84c5:: with SMTP id z5mr5722665ior.33.1619827802465;
 Fri, 30 Apr 2021 17:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210430204939.5152-1-sargun@sargun.me> <20210430204939.5152-3-sargun@sargun.me>
 <CALCETrXWFbB7v8wRKeNC-gxMqUZ9ZJUZx9nQiLu64qYi2Bx5FQ@mail.gmail.com>
In-Reply-To: <CALCETrXWFbB7v8wRKeNC-gxMqUZ9ZJUZx9nQiLu64qYi2Bx5FQ@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 30 Apr 2021 17:09:26 -0700
Message-ID: <CAMp4zn8A2n7EtbR_=fG99MPgpDTgn-Ju-AzQ8F2rYU9Fri3YTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 4:23 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Apr 30, 2021 at 1:49 PM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > The user notifier feature allows for filtering of seccomp notifications in
> > userspace. While the user notifier is handling the syscall, the notifying
> > process can be preempted, thus ending the notification. This has become a
> > growing problem, as Golang has adopted signal based async preemption[1]. In
> > this, it will preempt every 10ms, thus leaving the supervisor less than
> > 10ms to respond to a given notification. If the syscall require I/O (mount,
> > connect) on behalf of the process, it can easily take 10ms.
> >
> > This allows the supervisor to set a flag that moves the process into a
> > state where it is only killable by terminating signals as opposed to all
> > signals. The process can still be terminated before the supervisor receives
> > the notification.
>
> This is still racy, right?  If a signal arrives after the syscall
> enters the seccomp code but before the supervisor gets around to
> issuing the new ioctl, the syscall will erroneously return -EINTR,
> right?
>
> Can we please just fully fix this instead of piling a racy partial fix
> on top of an incorrect design?
>
> --Andy

I thought that you were fine with this approach. Sorry.

Maybe this is a dumb question, what's wrong with returning an EINTR if the
syscall was never observed by the supervisor?

I think that the only other reasonable design is that we add data to the
existing action which makes it sleep in wait_killable state.
