Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4217636C988
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbhD0Qfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbhD0Qft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:35:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90669C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:35:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b9so8185722iod.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INHOzD23PluMifB464PN3y3YCplArL1gtSHLIv2/4JU=;
        b=XoZF0rMHVUDwD8/V3ZaMnpFrCUzlDeaxMJtq6++MJ9jF5ZWA3V8SUFzQn4RDwb8Lkm
         QQU4mpE/WKOlTiUpcQpEjyWqO3LCJn1lk/T7UZusGYcp3Q0RQFFLEBcHT10Vy7ER/Krp
         Sfgvxkz8NRGLI1Fxh+yS75N4rrdcJdojdlilo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INHOzD23PluMifB464PN3y3YCplArL1gtSHLIv2/4JU=;
        b=hrsm5TvqlwEoYMXa6HIs+nQoNLcNs6zCKjxOLjPCeSb3X3pKIdPbleKYzI/qMi4urN
         6jKaeNMe13SuFeskgdATwc19KskBHqVO0VMMZpxES1pHhUnTn3fQm6FLh2YWJLXNz5DI
         mfhdOJAOLjC1mSJxxZO+CyzWDzioxhHGKVdLNiXR82Aaxhg7Qng1NnaDT7tqquJ8Odsf
         hEu86qtnF6gEz7k36AVr9s5UzAiquH25kvNTn4rGhcr04XmceSkhk7sIqQAltq3VgPpi
         GMMLhH7q3luFzx3KToq2VsQFGu6hSeanOsTbtO4TnpzjbnBtFOU+Z4G0yaDKOI3/1O/m
         Fs7g==
X-Gm-Message-State: AOAM533XefJvVU12LmOlFLnx7a4I0SOgA7iBZOEa3jgINveEec0CfALk
        DDsWEOu5XRbofEOx6FIYtqDoymRRBlQzAl/Pzpjmag==
X-Google-Smtp-Source: ABdhPJzQns1HjP3hSguwiYnNN8zYmAtz0ZNRJCCQEjDVSMXuKi29IJ4y6tTcPiOgDQhO69i9e8pkcNn6c00dltZYxsU=
X-Received: by 2002:a05:6638:35ab:: with SMTP id v43mr22446989jal.65.1619541303738;
 Tue, 27 Apr 2021 09:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210426180610.2363-1-sargun@sargun.me> <20210426180610.2363-3-sargun@sargun.me>
 <20210426190229.GB1605795@cisco> <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
 <20210427134853.GA1746081@cisco>
In-Reply-To: <20210427134853.GA1746081@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Tue, 27 Apr 2021 09:34:26 -0700
Message-ID: <CAMp4zn8MPvkWmt6Yqo+nQCd-HRNRc_=rVYAAF4LjvY2F7-OdGQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/5] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 6:48 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Mon, Apr 26, 2021 at 10:15:28PM +0000, Sargun Dhillon wrote:
> > On Mon, Apr 26, 2021 at 01:02:29PM -0600, Tycho Andersen wrote:
> > > On Mon, Apr 26, 2021 at 11:06:07AM -0700, Sargun Dhillon wrote:
> > > > @@ -1103,11 +1111,31 @@ static int seccomp_do_user_notification(int this_syscall,
> > > >    * This is where we wait for a reply from userspace.
> > > >    */
> > > >   do {
> > > > +         interruptible = notification_interruptible(&n);
> > > > +
> > > >           mutex_unlock(&match->notify_lock);
> > > > -         err = wait_for_completion_interruptible(&n.ready);
> > > > +         if (interruptible)
> > > > +                 err = wait_for_completion_interruptible(&n.ready);
> > > > +         else
> > > > +                 err = wait_for_completion_killable(&n.ready);
> > > >           mutex_lock(&match->notify_lock);
> > > > -         if (err != 0)
> > > > +
> > > > +         if (err != 0) {
> > > > +                 /*
> > > > +                  * There is a race condition here where if the
> > > > +                  * notification was received with the
> > > > +                  * SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE flag, but a
> > > > +                  * non-fatal signal was received before we could
> > > > +                  * transition we could erroneously end our wait early.
> > > > +                  *
> > > > +                  * The next wait for completion will ensure the signal
> > > > +                  * was not fatal.
> > > > +                  */
> > > > +                 if (interruptible && !notification_interruptible(&n))
> > > > +                         continue;
> > >
> > > I'm trying to understand how one would hit this race,
> > >
> >
> > I'm thinking:
> > P: Process that "generates" notification
> > S: Supervisor
> > U: User
> >
> > P: Generated notification
> > S: ioctl(RECV...) // With wait_killable flag.
> > ...complete is called in the supervisor, but the P may not be woken up...
> > U: kill -SIGTERM $P
> > ...signal gets delivered to p and causes wakeup and
> > wait_for_completion_interruptible returns 1...
> >
> > Then you need to check the race
>
> I see, thanks. This seems like a consequence of having the flag be
> per-RECV-call vs. per-filter. Seems like it might be simpler to have
> it be per-filter?
>
> Tycho

You're right.

I think an alternative solution would be to make it on a per-action
basis, and in the filter have a different action for non-preemptible
user notifications.

Since you can only install one filter, I do not think we want to make
it so we do it on a entire filter basis, in case a filter handles a combination
of preemptible and non-preemptible syscalls. For example if you mix
mount and accept.
