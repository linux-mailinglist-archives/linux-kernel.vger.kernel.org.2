Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3737610F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhEGHR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhEGHRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:17:23 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F37C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 00:16:23 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id o9so1767571ilh.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XiQZNJ9GSHRyiC2RqTi9uOLJ/fl0xwROOEKRFdIPDDg=;
        b=x/VDLOCT0ywp2zIrategOgLLqyXEvqeb+fBDSe67W0HQIspRHB/cDx4IDicW/ZUvqH
         2fKle/W+onau063uWNxhtUjOktg1+ApUOXoCCNnrzDS5X2wl1Hz+xzTTHPZiyFKzpHm8
         lNbYR+Ac6eGUlnxkZTcq2ugPTVFobEwvqMi/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XiQZNJ9GSHRyiC2RqTi9uOLJ/fl0xwROOEKRFdIPDDg=;
        b=NR+BqpBwGK1iOTkkzSg/LM1bM/i7yHAZ6uEHrQQJcc9U+rpfQJgdb2zHX5Aw0Bn5RF
         5u1555w1b1i0yUVnrUlcwePXWA0fR63O3MxIKS9MQOdvB4KiEYwjFo3d86nc2gDwfDVU
         WNnLyDTksOIClGUWjAyYyXv/6pOweD6621evFg6ypvC2bN1ogFbO3sW600HAe2FKuu0z
         nqye6p3k/Fx4JN/Jr2gDqiOqjc9tDa/Ax9LyY5ysxMIknZ+73Y+X8o41F6nWrDEaYHDp
         1ilO0YeSPd7ZYEcKQmoshSlQJe+HNhdSj1jP0fWdTVWtYpOoUN17mgP3kOyhpxibsREf
         iP2g==
X-Gm-Message-State: AOAM533ITxjQ/oaNxdpYaSdMsSlaSjWyq84ql1MfWe/LoGKWPAe6an4+
        0gITocU9bmYhcc7UQkHILsIj2YV83zXr5mpIZ73WQ4JVaXZesg==
X-Google-Smtp-Source: ABdhPJywTaFWf82wegsRBabuw9xXRAfOmaUUvLW4oUooX3nEFg4edt+oVF9TDUo5yGu/JAbkBuBwrDUnh2zCqnH2G1E=
X-Received: by 2002:a92:c7a6:: with SMTP id f6mr8000215ilk.17.1620371783010;
 Fri, 07 May 2021 00:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210430204939.5152-1-sargun@sargun.me> <20210430204939.5152-3-sargun@sargun.me>
 <CALCETrXWFbB7v8wRKeNC-gxMqUZ9ZJUZx9nQiLu64qYi2Bx5FQ@mail.gmail.com>
 <CAMp4zn8A2n7EtbR_=fG99MPgpDTgn-Ju-AzQ8F2rYU9Fri3YTg@mail.gmail.com>
 <CACaBj2a3OGci7A9buLdmB9sMoh5dRaYN_K7p8X7esNfmPPLhvQ@mail.gmail.com> <CALCETrX5UJ075oH6-Cm3Uxz_XZQffi_5vZOtc8Yq3ZRmKfcDhg@mail.gmail.com>
In-Reply-To: <CALCETrX5UJ075oH6-Cm3Uxz_XZQffi_5vZOtc8Yq3ZRmKfcDhg@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 7 May 2021 00:15:46 -0700
Message-ID: <CAMp4zn_gOQNA5zmvOHhYDawXrm8d+HVg8xrXVdX9M2K8AObdtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rodrigo Campos <rodrigo@kinvolk.io>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 4:59 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, May 6, 2021 at 12:35 PM Rodrigo Campos <rodrigo@kinvolk.io> wrote:
>
> > We want to be woken-up in seccomp_do_user_notification() so we know we
> > received a signal and notify to the supervisor about it. IMHO, we want
> > an additional "if" here[2], like (haven't checked the retun codes of
> > functions) "if err != 0"  and do a "wake_up_poll(&match->wqh, EPOLLIN
> > | EPOLLRDNORM);" or POLLPRI or something, and then "goto wait". IOW,
> > we only return when the supervisor tells us to, if a signal arrives we
> > just let the supervisor know and continue waiting for a response. The
> > proper response might be "I wrote partial data, return only 3 bytes",
> > etc. This way we can properly emulate it.
> >
> > What is not clear to me, and I'd like others to comment is:
> >
> > 1. How should this new "the supervisor should handle signals" mode be enabled?
> >    a. If we use an extra ioctl, as Andy suggested, I think we have a
> > race too: from the moment the seccomp syscall is issued until the new
> > ioctl is called there is a race. If the container does a syscall in
> > that window, it _can_ incorrectly return EINTR as it does now. This
> > race can be very small and the ioctl can make _all the next syscalls_
> > wait in this new mode, so maybe the race is so small that we don't
> > care in practice.
>
> If the ioctl is sticky, it can presumably avoid the race entirely by
> having whoever calls seccomp() immediately do a dummy syscall or
> otherwise wait for the notifier to confirm that it has done the ioctl.
> Admittedly, this may be annoying.
>
> >    b. But if we want to really fully solve the issue, the other option
> > that comes to mind is adding a new flag for the seccomp syscall, to
> > signal that the supervisor will handle signals and should be
> > forwarded. This way, if the container does a new syscall it will be
> > put to wait in this new mode (we have the information that the new
> > mode should be used already). Something like
> > SECCOMP_FILTER_FLAG_NEW_LISTENER_SOMETHING (today we have
> > SECCOMP_FILTER_FLAG_NEW_LISTENER). Ideally shorter :D
>
> I like that better.
>
> >
> > 2. What should we notify to the supervisor? Only that a signal arrived
> > or also which signal it was? If we do the EPOLLPRI thingy, as Andy
> > mentioned in a previous thread, IIUC we will only notify that _a_
> > signal arrived, but not _which_. To notify which signal arrived might
> > be complex, though, (not sure, I haven't explored how that should be).
>
> Are there any examples in the kernel of syscalls that care *which*
> signal came in?  As far as I know, there are really only three states
> that matter: no signal is pending, a kill is pending, or a regular
> signal is pending.  (The latter means that there's a signal that is
> unmasked, etc and will should therefore interrupt a syscall if the
> syscall can be interrupted.

Andy,
I do not believe we want full preemption on all syscalls. I think we want
the ability to have "safe" (for some definition of safe) preemption on some
syscalls.

For example, a syscall like connect should allow for arbitrary
preemption, even if the supervisor isn't able to get to it in time (using
alarm here is a thing I've seen as a common pattern). If a connect
starts, and is then preempted, you get an EINTR. glibc will retry the
connect, and if it was already in progress, you should get an
EINPROGRESS, otherwise no error. This is "correct" behaviour,
but not all syscalls do this.

I think we can take a slightly lighterweight approach in in the filter
action, we can include a flag in the data of the action that the filter
return which signifies whether or not the call should be preemptible
before being seen by the supervisor, and another flag which indicates
that once the supervisor has RECV'd the notification, it should not
allow for interruption.

I agree though, that if the call is in the non-preemptible state we need to
have a mechanism to notify the supervisor to cancel work, and
return to the notifying process. I think that if we do the POLLPRI thing,
then there should be a RECV_SIGNAL ioctl to read POLLPRI notifications,
that indicate a particular notification has been preempted (signaled). At this
point, the supervisor can do whatever it wants.

There is also a slight other race condition:
1. Notification is generated wait non-preemptible flag in data
2. Program returns signal
3. At this point, should the kernel do POLLPRI or wait for
  the supervisor to first read the notification. Should we add
  some metadata to the notification indicating it was attempted
  to be preempted?

Would the following work:
1. Add a two flags to the data, indicating pre-notification preemption being
  allowed and return -EINTR, and once the notification is picked up by
  the supervisor transitioning into an -EINTR state
2. Make it so if an in-progress notification is interrupted via a
signal, it will
    send a POLLPRI, which is read via RECV_SIGNAL.
