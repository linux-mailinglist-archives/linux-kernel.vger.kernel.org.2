Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81470326600
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBZQ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZQ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:59:09 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 08:58:28 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e2so4207196ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WUdKhQY+xq/0ykcS0wukNY6TaVLA1g3VwB9kQiLATkU=;
        b=IO9tUUram6woqaQuM8XDAeVhA6g7QzPV0dmut1n4WDhWTTgmd+SZ/CiSxuOnoeiQng
         tNq8SJRhkgaDYs0G9A70mD0BnenY4s9FWapnfEVygPkZl9YA6CyHaQhM0kuJa8y+rRW7
         m2TaMPdhENyX8XdOf7eSsk17dc3fGKXhw2pek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WUdKhQY+xq/0ykcS0wukNY6TaVLA1g3VwB9kQiLATkU=;
        b=TyaT//M+HfWQOGMzhCX6GS0eg0QN58vIoupoFaqa1FMXhmg5k0fqkx3gLAfYs6ALEh
         LyING3P+AGZ9iD0qL3kxtbE2zKMQnamJcaP1Mjn3u3HiYOMvn4yZNOnkCg8JkhbVkoY0
         naF5c+egpvL9AJgjRx846cVRHC5KQHmUSmOKR5vABTpn9e7r27mYWCPd3+x1IqfjBxcL
         T+3oTIcDIWe73iK0Sktq3OIgBbyFUpA4yn6gvhczMCMUQiGRIxUSst0sFEkVCPfXztEz
         VWxzrfNWwt0f7ln/9nb5PxF5KR+Iwckj900pDn4OMwGqiH9NbbOKkjHYHb6XXdYRUzAj
         QTZw==
X-Gm-Message-State: AOAM530xrr04UgbP4zC6I5Bz+KKW550jevmwlGRUt2NoM/lBcP7JclyL
        YOqkyVXqNrva9YtuHtwBlvrJ+qbAh1fqYTQ9OIpYPQ==
X-Google-Smtp-Source: ABdhPJxq/os9g7uPZGuA8EvpjbkS3G2WX12NWmEU3cD/wsG2JGD31Ael6iuU/4nxtLSJMDuEW5NsGgPLsazEwq0dIK4=
X-Received: by 2002:a2e:b5cc:: with SMTP id g12mr2332254ljn.8.1614358707170;
 Fri, 26 Feb 2021 08:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20210220090502.7202-1-sargun@sargun.me> <20210220090502.7202-3-sargun@sargun.me>
In-Reply-To: <20210220090502.7202-3-sargun@sargun.me>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Fri, 26 Feb 2021 17:57:51 +0100
Message-ID: <CACaBj2b_U_oV=cXyZyt8-P3MCRkuD_NrgczUQ+fNn_q0e+wDSQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 10:05 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> The user notifier feature allows for filtering of seccomp notifications i=
n
> userspace. While the user notifier is handling the syscall, the notifying
> process can be preempted, thus ending the notification. This has become a
> growing problem, as Golang has adopted signal based async preemption[1]. =
In
> this, it will preempt every 10ms, thus leaving the supervisor less than
> 10ms to respond to a given notification. If the syscall require I/O (moun=
t,
> connect) on behalf of the process, it can easily take 10ms.
>
> This allows the supervisor to set a flag that moves the process into a
> state where it is only killable by terminating signals as opposed to all
> signals.
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
>
> [1]: https://github.com/golang/go/issues/24543
> ---
>  include/uapi/linux/seccomp.h | 10 ++++++++++
>  kernel/seccomp.c             | 35 +++++++++++++++++++++++++++++------
>  2 files changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 6ba18b82a02e..f9acdb58138b 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -70,6 +70,16 @@ struct seccomp_notif_sizes {
>         __u16 seccomp_data;
>  };
>
> +/*
> + * Valid flags for struct seccomp_notif
> + *
> + * SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE
> + *
> + * Prevent the notifying process from being interrupted by non-fatal, un=
masked

Maybe s/process/task/ to keep the vocabulary from "wait for
completion" barriers?

> + * signals.
> + */
> +#define SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE (1UL << 0)
> +
>  struct seccomp_notif {
>         __u64 id;
>         __u32 pid;
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index b48fb0a29455..f8c6c47df5d8 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -97,6 +97,8 @@ struct seccomp_knotif {
>
>         /* outstanding addfd requests */
>         struct list_head addfd;
> +
> +       bool wait_killable;
>  };
>
>  /**
> @@ -1082,6 +1084,7 @@ static int seccomp_do_user_notification(int this_sy=
scall,
>         long ret =3D 0;
>         struct seccomp_knotif n =3D {};
>         struct seccomp_kaddfd *addfd, *tmp;
> +       bool wait_killable =3D false;
>
>         mutex_lock(&match->notify_lock);
>         err =3D -ENOSYS;
> @@ -1103,8 +1106,14 @@ static int seccomp_do_user_notification(int this_s=
yscall,
>          * This is where we wait for a reply from userspace.
>          */
>         do {
> +               wait_killable =3D n.state =3D=3D SECCOMP_NOTIFY_SENT &&
> +                               n.wait_killable;
> +

The state is set to SENT in seccomp_notify_recv() which can specify
the new flag. So, if that ioctl hasn't been issued yet, the state
won't be SENT and we do an interruptible wait. Do I follow correctly?

Then, if userspace does a SECCOMP_IOCTL_NOTIF_RECV ioctl(), there is a
way below to "switch the waiting" so we switch to a killable wait.
Therefore, it is still possible to receive a signal before the "wait
switch" in which case we will be interrupted anyways. If the go
runtime is sending SIGURG every 10ms, isn't this a problem? Like, in
your use cases almost never happens that the seccomp agent does the
ioctl() to receive the notification after the go runtime sends a
signal and is interrupted?

I see the window is smaller with this change and you have a chance to
handle it (as if you win the first time, it is then not interrupted),
but I wonder if it makes sense to know if we want to
wait_killable/wait_interruptable before the SECCOMP_IOCTL_NOTIF_RECV
ioctl() is done, so here we can just do the proper wait. As long as we
have to guess here, there will be races and "let's switch the wait"
kind of games, IIUC.

Can I ask why a flag for the SECCOMP_IOCTL_NOTIF_RECV ioctl() instead
of before in the flow? Like having to use
SECCOMP_FILTER_FLAG_NEW_LISTENER and a new flag that will make this
wait killable instead of interruptible. I guess code is kind of messy
to achieve that?

Am I missing something? Sorry if I am :)

>                 mutex_unlock(&match->notify_lock);
> -               err =3D wait_for_completion_interruptible(&n.ready);
> +               if (wait_killable)
> +                       err =3D wait_for_completion_killable(&n.ready);
> +               else
> +                       err =3D wait_for_completion_interruptible(&n.read=
y);
>                 mutex_lock(&match->notify_lock);
>                 if (err !=3D 0)
>                         goto interrupted;
> @@ -1455,6 +1466,12 @@ static long seccomp_notify_recv(struct seccomp_fil=
ter *filter,
>         unotif.pid =3D task_pid_vnr(knotif->task);
>         unotif.data =3D *(knotif->data);
>
> +       if (unotif.flags & SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE) {
> +               knotif->wait_killable =3D true;
> +               complete(&knotif->ready);
> +       }
> +
> +

IIUC This triggers the wait switch from interruptible to killable when
the ioctl SECCOMP_IOCTL_NOTIF_RECV is done.

> @@ -1473,6 +1490,12 @@ static long seccomp_notify_recv(struct seccomp_fil=
ter *filter,
>                 mutex_lock(&filter->notify_lock);
>                 knotif =3D find_notification(filter, unotif.id);
>                 if (knotif) {
> +                       /* Reset the waiting state */
> +                       if (knotif->wait_killable) {
> +                               knotif->wait_killable =3D false;
> +                               complete(&knotif->ready);
> +                       }
> +
>                         knotif->state =3D SECCOMP_NOTIFY_INIT;

Haha, so we reset the wait to be interruptible if userspace screws it
up. Semantics are getting tricky, maybe a function can help here?


--
Rodrigo Campos
---
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
