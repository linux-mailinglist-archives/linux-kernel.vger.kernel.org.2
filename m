Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0835736CA41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbhD0RWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:22:32 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:37555 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235777AbhD0RWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:22:04 -0400
X-Greylist: delayed 784 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Apr 2021 13:22:04 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 35B56ED0;
        Tue, 27 Apr 2021 13:08:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Apr 2021 13:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=dpGNdB47HMr5A69m6IUz+7x1trW
        JQi1zXaT6OT2QXA4=; b=PXT+9VIDs49kPYTvrSz7FM5f52topR9XxP6s1r8vuky
        Kt4mYJx7BwwDAI3y1GRkdLqelmRNI98CnTN8Qs8xfTGRC+xLbMjSpT7wOc6SepR9
        1vA1Ny3lW9L3y9Qh6bgBPAImWOJAol4KwubCGx0icPIcr0O5jswkQEAK9XW3/jv4
        1UWH/iAKReo4b2lWH/mnCcoK4oxeCMP3llycSwTnIe98z7nkfV1JcoM+3GKnvap0
        j2WQ9IcF12oeQHoYgzGuWbbyaLAymqDbHpEnumcvHCjiAhDumxDmi4X7fxOvQLuT
        AE4pTRCGqOEf/2WrnPJgKHr/mwSZ0yIiQ2tyF96DjBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dpGNdB
        47HMr5A69m6IUz+7x1trWJQi1zXaT6OT2QXA4=; b=kpT0hcz8VM2PoNbz9AF9k0
        iWcgJ6rDbRZ8H/Bg3gECnFJCaBOAkSwwYzkwv1A/z8BZGLSZl0rNt3M0WRxdZb24
        URgu5Hot1wwouS39Bhn3VMRrt7ibC3xu975bCyRtnrUqOyY+406HcgX8egS4Di/K
        5HbjssSpaVhGA1W6vsdVfaObK1XxZysUrDFL6UpRuxJMdUAwriVy1uXbtTnlCLw5
        u0v83XYikpKsHVM20tHklTIH5/TyY94OV+f8nSs74NiO8fJJeqXl8kZXmE/jvEmC
        rGmMTyMWDMBuXRC6n8sdoOtg0IZG33CpecosKo0Od1nfQujMKkfXICYowb1TQeNg
        ==
X-ME-Sender: <xms:8ESIYI8uvaD7iiFRgrvJzwO-_weub7lGvqzQ1GpDyfQnAIRtuDJDiA>
    <xme:8ESIYAtpK547yQGq-c_Pyfx62v4aCKy5daGwFiwJz3K_pLTXH6wVcUYjbp7jSwC-l
    rzCxqB3j1-mPcHu-D8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvtddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepgeekfeejgeektdejgfefudelkeeuteejgefhhfeugffffeelheegieef
    vdfgtefhnecukfhppedujeefrdefkedruddujedrkedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiii
    rg
X-ME-Proxy: <xmx:8ESIYODzX7D_vX0KASKjHdztk6L5GmwmoczCu6Ushlv533ayINg86A>
    <xmx:8ESIYIeCWaXZfizAqSor6qLfgWZ8x2YFEdrTfvdqeIyx_Dgzx-Uj8Q>
    <xmx:8ESIYNOhGXX5YLzmHehje95NTyu5OINC4d9LTBKQQJ2aMBlOsES5dA>
    <xmx:8USIYGiUc0H1ZMr4VMrXLh2tFIQTaxkyf7y-Al_-QSLXk0xdUDvq_ES5hxY>
Received: from cisco (unknown [173.38.117.80])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 27 Apr 2021 13:07:59 -0400 (EDT)
Date:   Tue, 27 Apr 2021 11:07:53 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>, Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH RESEND 2/5] seccomp: Add wait_killable semantic to
 seccomp user notifier
Message-ID: <20210427170753.GA1786245@cisco>
References: <20210426180610.2363-1-sargun@sargun.me>
 <20210426180610.2363-3-sargun@sargun.me>
 <20210426190229.GB1605795@cisco>
 <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
 <20210427134853.GA1746081@cisco>
 <CALCETrVrfBtQPh=YeDEK4P9+QHQvNxHbn8ZT3fdQNznpSeS5oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVrfBtQPh=YeDEK4P9+QHQvNxHbn8ZT3fdQNznpSeS5oQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:23:42AM -0700, Andy Lutomirski wrote:
> On Tue, Apr 27, 2021 at 6:48 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> >
> > On Mon, Apr 26, 2021 at 10:15:28PM +0000, Sargun Dhillon wrote:
> > > On Mon, Apr 26, 2021 at 01:02:29PM -0600, Tycho Andersen wrote:
> > > > On Mon, Apr 26, 2021 at 11:06:07AM -0700, Sargun Dhillon wrote:
> > > > > @@ -1103,11 +1111,31 @@ static int seccomp_do_user_notification(int this_syscall,
> > > > >    * This is where we wait for a reply from userspace.
> > > > >    */
> > > > >   do {
> > > > > +         interruptible = notification_interruptible(&n);
> > > > > +
> > > > >           mutex_unlock(&match->notify_lock);
> > > > > -         err = wait_for_completion_interruptible(&n.ready);
> > > > > +         if (interruptible)
> > > > > +                 err = wait_for_completion_interruptible(&n.ready);
> > > > > +         else
> > > > > +                 err = wait_for_completion_killable(&n.ready);
> > > > >           mutex_lock(&match->notify_lock);
> > > > > -         if (err != 0)
> > > > > +
> > > > > +         if (err != 0) {
> > > > > +                 /*
> > > > > +                  * There is a race condition here where if the
> > > > > +                  * notification was received with the
> > > > > +                  * SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE flag, but a
> > > > > +                  * non-fatal signal was received before we could
> > > > > +                  * transition we could erroneously end our wait early.
> > > > > +                  *
> > > > > +                  * The next wait for completion will ensure the signal
> > > > > +                  * was not fatal.
> > > > > +                  */
> > > > > +                 if (interruptible && !notification_interruptible(&n))
> > > > > +                         continue;
> > > >
> > > > I'm trying to understand how one would hit this race,
> > > >
> > >
> > > I'm thinking:
> > > P: Process that "generates" notification
> > > S: Supervisor
> > > U: User
> > >
> > > P: Generated notification
> > > S: ioctl(RECV...) // With wait_killable flag.
> > > ...complete is called in the supervisor, but the P may not be woken up...
> > > U: kill -SIGTERM $P
> > > ...signal gets delivered to p and causes wakeup and
> > > wait_for_completion_interruptible returns 1...
> > >
> > > Then you need to check the race
> >
> > I see, thanks. This seems like a consequence of having the flag be
> > per-RECV-call vs. per-filter. Seems like it might be simpler to have
> > it be per-filter?
> >
> 
> Backing up a minute, how is the current behavior not a serious
> correctness issue?  I can think of two scenarios that seem entirely
> broken right now:
> 
> 1. Process makes a syscall that is not permitted to return -EINTR.  It
> gets a signal and returns -EINTR when user notifiers are in use.
> 
> 2. Process makes a syscall that is permitted to return -EINTR.  But
> -EINTR for IO means "I got interrupted and *did not do the IO*".
> Nevertheless, the syscall returns -EINTR and the IO is done.
> 
> ISTM the current behavior is severely broken, and the new behavior
> isn't *that* much better since it simply ignores signals and can't
> emulate -EINTR (or all the various restart modes, sigh).  Surely the
> right behavior is to have the seccomped process notice that it got a
> signal and inform the monitor of that fact so that the monitor can
> take appropriate action.

This doesn't help your case (2) though, since the IO could be done
before the supervisor gets the notification.

> IOW, I don't think that the current behavior *or* the patched opt-in
> behavior is great.  I think we would do better to have the filter
> indicate that it is signal-aware and to document that non-signal-aware
> filters cannot behave correctly with respect to signals.

I think it would be hard to make a signal-aware filter, it really does
feel like the only thing to do is a killable wait.

Tycho
