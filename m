Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FF4375BD7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhEFTgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhEFTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:36:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730A4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:35:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o16so8572620ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdU9Md/ZEnFqkNVL+G+IKWqe9EBJenIvEGFNr2WgUBQ=;
        b=LEMnkErIjPgcIDwHms3q0zOAtS50UHI+a9ZL0CZgTd+rmkjE2HouoLZ0jAAZXHD19F
         6GvTYBMGhGbNhiKYl0+Ee7v/ziEIHmIVBvnFSWywVtHZ3IcQJ87GgAoSnX66nrOBVF9g
         OdpUHwDPusQ4AjWT2Odglr9ixxGlEuP4gnMTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdU9Md/ZEnFqkNVL+G+IKWqe9EBJenIvEGFNr2WgUBQ=;
        b=Wca7TI5RjQk8kvFBcuW4rCroosZAVkGenJ/dOJ+S+UVF8lLgYnwYA7lat4hHS4Q3U7
         ZQYyn5Bn+vykQc49ibUGTRVFVgqItBimG2WPzlUBUXjtReKgvJB6GEJr1G4JTRjjLpXg
         BkFETabuv5ulnxhYB91B+jwsrVqUvVi35Quu+PxOLubElpOq12GEeKxaH0WRVU+ptJ3D
         vfFW/rWBGeZeaTHSEbX1+Zn1BL7Klg4EaSpui1lEPP/1nkjsyJy7eTl9fK8MImCwBU+H
         ZUg1RqYdXb9HwzmDPytWyzsIUGHOStn/vC98nSDh1uQPZJ8TZvvVrs3i5BX3W+l4BJFI
         O21g==
X-Gm-Message-State: AOAM531VYECnetVCviBwj9cxD5Pd55fY7dlFb26XMD2HHHw1caDnqq2E
        TKBY3OubxRulRmNOCkuDYWZd2pwSA2KXBGBf3rSCZg==
X-Google-Smtp-Source: ABdhPJzQTBjaoky6mN03F3dlTeWS0iOGX6tCJscw6EM0f8PcTVEP2VLfuOdfM/FbLyfLR1wSdpe+afsBgJColOjkfdk=
X-Received: by 2002:a05:651c:39d:: with SMTP id e29mr4956482ljp.97.1620329751943;
 Thu, 06 May 2021 12:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210430204939.5152-1-sargun@sargun.me> <20210430204939.5152-3-sargun@sargun.me>
 <CALCETrXWFbB7v8wRKeNC-gxMqUZ9ZJUZx9nQiLu64qYi2Bx5FQ@mail.gmail.com> <CAMp4zn8A2n7EtbR_=fG99MPgpDTgn-Ju-AzQ8F2rYU9Fri3YTg@mail.gmail.com>
In-Reply-To: <CAMp4zn8A2n7EtbR_=fG99MPgpDTgn-Ju-AzQ8F2rYU9Fri3YTg@mail.gmail.com>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Thu, 6 May 2021 21:35:16 +0200
Message-ID: <CACaBj2a3OGci7A9buLdmB9sMoh5dRaYN_K7p8X7esNfmPPLhvQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Andy Lutomirski <luto@kernel.org>,
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

On Sat, May 1, 2021 at 2:10 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> On Fri, Apr 30, 2021 at 4:23 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Fri, Apr 30, 2021 at 1:49 PM Sargun Dhillon <sargun@sargun.me> wrote:
> > >
> > > The user notifier feature allows for filtering of seccomp notifications in
> > > userspace. While the user notifier is handling the syscall, the notifying
> > > process can be preempted, thus ending the notification. This has become a
> > > growing problem, as Golang has adopted signal based async preemption[1]. In
> > > this, it will preempt every 10ms, thus leaving the supervisor less than
> > > 10ms to respond to a given notification. If the syscall require I/O (mount,
> > > connect) on behalf of the process, it can easily take 10ms.
> > >
> > > This allows the supervisor to set a flag that moves the process into a
> > > state where it is only killable by terminating signals as opposed to all
> > > signals. The process can still be terminated before the supervisor receives
> > > the notification.
> >
> > This is still racy, right?  If a signal arrives after the syscall
> > enters the seccomp code but before the supervisor gets around to
> > issuing the new ioctl, the syscall will erroneously return -EINTR,
> > right?
> >
> > Can we please just fully fix this instead of piling a racy partial fix
> > on top of an incorrect design?
> >
> > --Andy
>
> I thought that you were fine with this approach. Sorry.
>
> Maybe this is a dumb question, what's wrong with returning an EINTR if the
> syscall was never observed by the supervisor?

IIUC It is partially observed by the supervisor.

If you are polling on the seccomp-fd, you _will see_ the POLLIN,
right? That is sent a few lines before the wait, here[1]. And it can
happen that after seeing the POLLIN, by the time we run the recv ioctl
we hang up waiting _for a new syscall to be issued_. Because the
previous syscall could have been interrupted by a signal before we
issued the recv ioctl. IOW, we have spurious wake-ups and no way to
tell when there is something to receive or not for the recv ioctl.
Seems fishy, especially since this is supposed to be a "recv that
blocks signals" ioctl but it can be interrupted by a signal anyways if
they happen before we issue the ioctl.

Another problem is that the container/target will see EINTR on a
syscall that maybe doesn't return EINTR. The program might not handle
that case, as in fact shouldn't ever happen. This is a problem today
too, though, but it is what I understand Andy asks to improve. For
sure it is not proper syscall emulation if the emulated returns things
that should/are never be returned by a regular syscall.

Also, a third problem: if the go runtime gives like ~10ms in some
cases between signals, it is not clear how many times we will issue
the recv ioctl before the runtime sends a signal and interrupts the
container waiting. Furthermore the race is still there, just the
window is smaller.

The main point being the second issue I mentioned: it will never be
correct emulation if an emulated syscall returns different things than
a real one (and things that can't be returned at all by some
syscalls). Additionally, the emulated syscall behaviour should also be
compatible with the real, etc.

>  I think that the only other reasonable design is that we add data to the existing action which makes it sleep in wait_killable state.

I don't think the wait should be doing a wait_killable under Andy's idea.

We want to be woken-up in seccomp_do_user_notification() so we know we
received a signal and notify to the supervisor about it. IMHO, we want
an additional "if" here[2], like (haven't checked the retun codes of
functions) "if err != 0"  and do a "wake_up_poll(&match->wqh, EPOLLIN
| EPOLLRDNORM);" or POLLPRI or something, and then "goto wait". IOW,
we only return when the supervisor tells us to, if a signal arrives we
just let the supervisor know and continue waiting for a response. The
proper response might be "I wrote partial data, return only 3 bytes",
etc. This way we can properly emulate it.

What is not clear to me, and I'd like others to comment is:

1. How should this new "the supervisor should handle signals" mode be enabled?
   a. If we use an extra ioctl, as Andy suggested, I think we have a
race too: from the moment the seccomp syscall is issued until the new
ioctl is called there is a race. If the container does a syscall in
that window, it _can_ incorrectly return EINTR as it does now. This
race can be very small and the ioctl can make _all the next syscalls_
wait in this new mode, so maybe the race is so small that we don't
care in practice.
   b. But if we want to really fully solve the issue, the other option
that comes to mind is adding a new flag for the seccomp syscall, to
signal that the supervisor will handle signals and should be
forwarded. This way, if the container does a new syscall it will be
put to wait in this new mode (we have the information that the new
mode should be used already). Something like
SECCOMP_FILTER_FLAG_NEW_LISTENER_SOMETHING (today we have
SECCOMP_FILTER_FLAG_NEW_LISTENER). Ideally shorter :D

2. What should we notify to the supervisor? Only that a signal arrived
or also which signal it was? If we do the EPOLLPRI thingy, as Andy
mentioned in a previous thread, IIUC we will only notify that _a_
signal arrived, but not _which_. To notify which signal arrived might
be complex, though, (not sure, I haven't explored how that should be).

3. How should we notify whatever we want to notify? If we only notify
that a signal arrived, that is probably simple. But if we want to
notify which signal arrived it might be tricker and would like to know
what others think about how that interface should be (adjust the
struct seccomp_notif I guess?), if there are strong opinions, etc.


I'll be away for a few weeks now, but I'll catch up with the discussion ASAP.


Best,
Rodrigo

[1]: https://github.com/torvalds/linux/blob/8404c9fbc84b741f66cff7d4934a25dd2c344452/kernel/seccomp.c#L1107
[2]: https://github.com/torvalds/linux/blob/8404c9fbc84b741f66cff7d4934a25dd2c344452/kernel/seccomp.c#L1116
