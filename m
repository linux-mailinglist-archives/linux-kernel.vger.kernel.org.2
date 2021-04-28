Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD9D36DDF9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbhD1ROb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhD1RO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:14:29 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C273C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:13:43 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p8so10663483iol.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooT7AWKBiLRbLDiDxglHtQCKmVnoRiy1bmtiucHGkh4=;
        b=KhqAVRWwQscEwvGBMS+mDXMj0e7K2zmCCJ1Bw1N7CpwQQB8REHnna3pQN7wY9J2xm/
         jX4G+whsufvmbwYRPELfw1v1Y9BTSIJR0Aii2E7MWOsjb3etRrjBMg+IhZC3A0fbHAmc
         uMasgnBQtpi/DWICXFEaAFt65LtWj2ZfmL96k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooT7AWKBiLRbLDiDxglHtQCKmVnoRiy1bmtiucHGkh4=;
        b=afvoQP20tku8pDDfbS+fvVYTePkU6hlPnINEel/4FHzX3SF+Wd9q1AlH8BdvN7J88M
         08SfgnqJmCT/QJ8ZsPU+KtK9Puv0c4mh2zA1I9jl0k+KEFB6R+esyGmQnqCc8LxFYgEA
         gMgnzM6aYYE/fbtrU/LloYhZh4ofjHWlG4Bv4eDO1AH8/10M8N/msy771Y8ghS9qJdXE
         lJgC7utYx94A/qCmmmZ4omE/xBo09lcRhQucCVbhMrAKy3EkgS6DUO/7Itucs5ReBHU0
         2Qr0rVlUmCi2SIihx6ttyBD6lkA7NOMJrmskORJGpvVP0OSWuqGWSO5kj2VJRQYxlScI
         8d9g==
X-Gm-Message-State: AOAM5312BFGeHT8aUMrLPtv4IsWnoYsCvMQpHEO256pmOJ1VKWzcnss6
        kMIrfeGHH74MY1qboud2Xc9lDRxZMnG04Wx1hlEVRA==
X-Google-Smtp-Source: ABdhPJz3j0YVNwm95J9ouvrww6lRpo5IoB1zZUqN6MURcLBbeK+4T9hZYBGZdnnS365uavZpq9IIiY0s5hckIqWppUs=
X-Received: by 2002:a02:a695:: with SMTP id j21mr17121924jam.29.1619630022507;
 Wed, 28 Apr 2021 10:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210426190229.GB1605795@cisco> <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
 <20210427134853.GA1746081@cisco> <CALCETrVrfBtQPh=YeDEK4P9+QHQvNxHbn8ZT3fdQNznpSeS5oQ@mail.gmail.com>
 <20210427170753.GA1786245@cisco> <20210427221028.GA16602@ircssh-2.c.rugged-nimbus-611.internal>
 <CALCETrX9JnHE9BOhRxCc1bCvEBfbOY8bb2rxeKTsDNxfMruntQ@mail.gmail.com>
 <20210428002215.GB1786245@cisco> <CACaBj2ZchRGzHpGn5TD2FE=yKWZotVRNZ7M78TmvGfM9BoHF4g@mail.gmail.com>
 <CACaBj2aSnzQnbZG0sMM2Vae_yWGzxKWrGUz9xJVL_7akF8DvNA@mail.gmail.com> <20210428140817.GA1965193@cisco>
In-Reply-To: <20210428140817.GA1965193@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Wed, 28 Apr 2021 10:13:06 -0700
Message-ID: <CAMp4zn_j+g8gAEPNRo0hD4ioc9a5hEPD=6gcbh8fXs2XxN95mQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/5] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Rodrigo Campos <rodrigo@kinvolk.io>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 7:08 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Wed, Apr 28, 2021 at 03:20:02PM +0200, Rodrigo Campos wrote:
> > On Wed, Apr 28, 2021 at 1:10 PM Rodrigo Campos <rodrigo@kinvolk.io> wrote:
> > >
> > > On Wed, Apr 28, 2021 at 2:22 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > > >
> > > > On Tue, Apr 27, 2021 at 04:19:54PM -0700, Andy Lutomirski wrote:
> > > > > User notifiers should allow correct emulation.  Right now, it doesn't,
> > > > > but there is no reason it can't.
> > > >
> > > > Thanks for the explanation.
> > > >
> > > > Consider fsmount, which has a,
> > > >
> > > >         ret = mutex_lock_interruptible(&fc->uapi_mutex);
> > > >         if (ret < 0)
> > > >                 goto err_fsfd;
> > > >
> > > > If a regular task is interrupted during that wait, it return -EINTR
> > > > or whatever back to userspace.
> > > >
> > > > Suppose that we intercept fsmount. The supervisor decides the mount is
> > > > OK, does the fsmount, injects the mount fd into the container, and
> > > > then the tracee receives a signal. At this point, the mount fd is
> > > > visible inside the container. The supervisor gets a notification about
> > > > the signal and revokes the mount fd, but there was some time where it
> > > > was exposed in the container, whereas with the interrupt in the native
> > > > syscall there was never any exposure.
> > >
> > > IIUC, this is solved by my patch, patch 4 of the series. The
> > > supervisor should do the addfd with the flag added in that patch
> > > (SECCOMP_ADDFD_FLAG_SEND) for an atomic "addfd + send".
> >
> > Well, under Andy's proposal handling that is even simpler. If the
> > signal is delivered after we added the fd (note that the container
> > syscall does not return when the signal arrives, as it happens today,
> > it just signals the notifier and continues to wait), we can just
> > ignore the signal and return that (if that is the appropriate thing
> > for that syscall, but I guess after adding an fd there isn't any other
> > reasonable thing to do).
>
> Yes, agreed. After thinking about this more, my example is bogus: the
> kernel doesn't sleep after it installs the fd, so it would ignore any
> signals too.
>
> Even if the kernel *did* sleep after installing the fd, it would still
> be correct emulation to install it and then do whatever the kernel did
> during that sleep. So I withdraw my objection :)
>
> Thanks,
>
> Tycho

Great.

I'll respin the series and add a
SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE command.

We can do the other aforementioned optimizations above when
specific use cases come up. I would like to work on preemption
notification after this lands though.
