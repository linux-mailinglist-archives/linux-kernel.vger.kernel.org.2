Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5685036BB87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhDZWQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhDZWQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:16:13 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:15:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i22so5141632ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=35JE14+U46LYE27Y6OGkQt/0x6BwuS4vBffRxgk3Bik=;
        b=Pwf6jVJ8R2S4o1XwZ2UFmoLLEj98OH9UhK967+HXKQPF5cEHyeAfVpuSotNh0jUoTq
         S6OR0N3aqSFQ5AbCkosdrTrR/iUQXM5NZfa2Tpdexe0PFKSWNDMal7ed6OLsV1nNxBeh
         4HH/h/abhCmIuOOK9nqSSCw/rb7qD5p5V+KB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=35JE14+U46LYE27Y6OGkQt/0x6BwuS4vBffRxgk3Bik=;
        b=daCNagTCwUh9+mUa4KxdbIZnXP3w8hZWmraRcBswyXnylSUlwztaeYC2xfEYBt/ew8
         9AhdyJLo4xtPICB776GcYjxZ2QQGggVPNuYjn+polvk68JPqEsHUARVMCjRzbh189xmK
         p5F3mGNDYE7dHhPBFiehikPB8rDmFFi1/KRCnUm6xTZpo94FrbKmiuV/DHnFpTWqB06Y
         8MPWO6BWQPIhBijZnVpUqeowe68uCwF5B8cqVT6sfkcJ8VkT+nkgcfOFIkwwIziTUA/m
         qyEBk9GWNFmA6eQwBXD9eScwBctYbPZSBTNCCY+6kSHqiZPlB8Qy9V+q8KjgPm4OFE0A
         rE5g==
X-Gm-Message-State: AOAM532MrKZ63G12miBmo2HIWRG1NS1EGE9qK5smIN/636KDTAFW5XCy
        MelImq3DdcCuCPHiOwHi4LgDGw==
X-Google-Smtp-Source: ABdhPJzD2GN88KsTOP4gOv5Ai8WTzKLO2wAKxc6jXZTCiQU2iXaipVDFRyZP1xUof74SRwkiOgz3sQ==
X-Received: by 2002:a05:6e02:92c:: with SMTP id o12mr16072169ilt.256.1619475330555;
        Mon, 26 Apr 2021 15:15:30 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id h17sm490657ilh.55.2021.04.26.15.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Apr 2021 15:15:30 -0700 (PDT)
Date:   Mon, 26 Apr 2021 22:15:28 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>, Giuseppe Scrivano <gscrivan@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH RESEND 2/5] seccomp: Add wait_killable semantic to
 seccomp user notifier
Message-ID: <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
References: <20210426180610.2363-1-sargun@sargun.me>
 <20210426180610.2363-3-sargun@sargun.me>
 <20210426190229.GB1605795@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426190229.GB1605795@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 01:02:29PM -0600, Tycho Andersen wrote:
> On Mon, Apr 26, 2021 at 11:06:07AM -0700, Sargun Dhillon wrote:
> > @@ -1103,11 +1111,31 @@ static int seccomp_do_user_notification(int this_syscall,
> >  	 * This is where we wait for a reply from userspace.
> >  	 */
> >  	do {
> > +		interruptible = notification_interruptible(&n);
> > +
> >  		mutex_unlock(&match->notify_lock);
> > -		err = wait_for_completion_interruptible(&n.ready);
> > +		if (interruptible)
> > +			err = wait_for_completion_interruptible(&n.ready);
> > +		else
> > +			err = wait_for_completion_killable(&n.ready);
> >  		mutex_lock(&match->notify_lock);
> > -		if (err != 0)
> > +
> > +		if (err != 0) {
> > +			/*
> > +			 * There is a race condition here where if the
> > +			 * notification was received with the
> > +			 * SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE flag, but a
> > +			 * non-fatal signal was received before we could
> > +			 * transition we could erroneously end our wait early.
> > +			 *
> > +			 * The next wait for completion will ensure the signal
> > +			 * was not fatal.
> > +			 */
> > +			if (interruptible && !notification_interruptible(&n))
> > +				continue;
> 
> I'm trying to understand how one would hit this race,
> 

I'm thinking:
P: Process that "generates" notification
S: Supervisor
U: User

P: Generated notification
S: ioctl(RECV...) // With wait_killable flag.
...complete is called in the supervisor, but the P may not be woken up...
U: kill -SIGTERM $P
...signal gets delivered to p and causes wakeup and
wait_for_completion_interruptible returns 1...

Then you need to check the race
> > @@ -1457,6 +1487,12 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
> >  	unotif.pid = task_pid_vnr(knotif->task);
> >  	unotif.data = *(knotif->data);
> >  
> > +	if (unotif.flags & SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE) {
> > +		knotif->wait_killable = true;
> > +		complete(&knotif->ready);
> > +	}
> > +
> > +
> >  	knotif->state = SECCOMP_NOTIFY_SENT;
> >  	wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
> >  	ret = 0;
> 
> Seems like the idea is that if someone does a ioctl(RECV, ...) twice
> they'll hit it? But doesn't the test for NOTIFY_INIT and return
> -ENOENT above this hunk prevent that?
> 
> Thanks,
> 
> Tycho
