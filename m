Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDB536CFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbhD1AXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:23:43 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:54519 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235889AbhD1AXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:23:17 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5AFD358096B;
        Tue, 27 Apr 2021 20:22:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 27 Apr 2021 20:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=bPTuTe7blkVLywwWCJqNsQlHWvk
        gDsPComF+4qCOu3Y=; b=8GWExJPszyZ8s4DyPGKY/UyVc6bfmj9RPjmG3uRrBhP
        qAx+PDRD092TF+8bcwDCJ4vuMh17M4gkza25rTXXvUHvm6wh9nGvf90ZlA2NWz4n
        tIH1kLOvpd1p3jA/4w2RtEZ8TVETQYWSNsjoDcHwi/VMcbcGa6Gh+0uvQ/q8FtvB
        WmzMHb2u5Id7eXtjW0qexxNb1Qu9loap1cerF+L+0JXxAzBr5m6HRDZZMO/mpnLs
        3rf9fB8+mNK0uuJjsSnt9zSS4nUd8P6LvoYoADWxuRjDz/Q2MHUKXf4T7wRUFAyH
        qfI+5pqsbz3KLkZglobOMEGel/Eo3UmH3/iDMXPxFRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bPTuTe
        7blkVLywwWCJqNsQlHWvkgDsPComF+4qCOu3Y=; b=tVR8T28R0rAHwIVdWjb08u
        HHkuDl7o0lArL1B72Xsq/Fq96Om07a1VudTh8SDMoFmEb9p08fCnzCB37nS1NbMg
        QX1rXbCH9lBsInT/Nsp51SFMHh8Hy7Jwx2qfcVD8yJTlA0xdjIzsgzDEEdblI410
        F8x3eDYP+yNy3HaiF1uIonpsB129FK9/Xc3W7y6ilfMYxZi55Kih6WpjET3MgxBX
        yugXoiVpmSNCuxCzIhLODHjxqnNhVXgFnMJqJM+QgFy/XTXOCBSz875JtJrR/7th
        U4eT8RccSSEveYv1JeslalftaxPBcDulzANWMCwNQZpORmeQeI5/CKZxGHOa7tbg
        ==
X-ME-Sender: <xms:uqqIYJbTlm_AK0sYc6Td0NVo4ibBmN7xsmHbNs2letPPFkla00aZTw>
    <xme:uqqIYAb3jm-SY0aefqj6OJm-hGXz7ll5bH5BFz82VPtOTK6z0oAQOT1QRogS5v9YR
    eDyltm6BWUjPYBniqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvuddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepudejfedrfeekrdduudejrdektdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:uqqIYL_pttZNVb5IViQGnbatbCt7kXziz0gIR0SSlC4MLf-5Lfl_FA>
    <xmx:uqqIYHqM2iSuKTbibryfLpOPlnCfjTr1HS5LRBNM9PBYyZg72Dcu5Q>
    <xmx:uqqIYEow_5Ol7L_uV7zmu4-xyQS-53j5QfCKmNyd1V_KFcdTYCEoZg>
    <xmx:u6qIYAfAf7SaeoHrFH8z-DxJiQZBGZng2MOA9XMkL4ME8oCSM4I-uw>
Received: from cisco (unknown [173.38.117.80])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 27 Apr 2021 20:22:17 -0400 (EDT)
Date:   Tue, 27 Apr 2021 18:22:15 -0600
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
Message-ID: <20210428002215.GB1786245@cisco>
References: <20210426180610.2363-1-sargun@sargun.me>
 <20210426180610.2363-3-sargun@sargun.me>
 <20210426190229.GB1605795@cisco>
 <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
 <20210427134853.GA1746081@cisco>
 <CALCETrVrfBtQPh=YeDEK4P9+QHQvNxHbn8ZT3fdQNznpSeS5oQ@mail.gmail.com>
 <20210427170753.GA1786245@cisco>
 <20210427221028.GA16602@ircssh-2.c.rugged-nimbus-611.internal>
 <CALCETrX9JnHE9BOhRxCc1bCvEBfbOY8bb2rxeKTsDNxfMruntQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrX9JnHE9BOhRxCc1bCvEBfbOY8bb2rxeKTsDNxfMruntQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 04:19:54PM -0700, Andy Lutomirski wrote:
> On Tue, Apr 27, 2021 at 3:10 PM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > On Tue, Apr 27, 2021 at 11:07:53AM -0600, Tycho Andersen wrote:
> > > On Tue, Apr 27, 2021 at 09:23:42AM -0700, Andy Lutomirski wrote:
> > > > On Tue, Apr 27, 2021 at 6:48 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > > > >
> > > > > On Mon, Apr 26, 2021 at 10:15:28PM +0000, Sargun Dhillon wrote:
> > > >
> > > > ISTM the current behavior is severely broken, and the new behavior
> > > > isn't *that* much better since it simply ignores signals and can't
> > > > emulate -EINTR (or all the various restart modes, sigh).  Surely the
> > > > right behavior is to have the seccomped process notice that it got a
> > > > signal and inform the monitor of that fact so that the monitor can
> > > > take appropriate action.
> > >
> > > This doesn't help your case (2) though, since the IO could be done
> > > before the supervisor gets the notification.
> 
> Tycho, I disagree.  Here's how native syscalls work:
> 
> 1. Entry work is done and the syscall hander does whatever it does at
> the beginning of the function.  This is entirely non-interruptible.
> 
> 2. The syscall handler decides it wants to wait, interruptibly,
> killably or otherwise.
> 
> 3. It gets signaled.  It takes appropriate action.  Appropriate action
> does *not* mean -EINTR.  It means that something that is correct *for
> that syscall* happens.  For nanosleep(), this involves the restart
> block (and I don't think we need to support the restart block).  For
> accept(), it mostly seems to mean that the syscall completes as usual.
> For write(2), it means that, depending on file type and whether any IO
> has occured, either -EINTR is returned and no IO happens, or fewer
> bytes than requested are transferred, or the syscall completes.  (Or,
> if it's a KILL, the process dies early and partial IO is ignored.)
> For some syscalls (some AF_UNIX writes, for example, or ptrace()), the
> syscall indeed gets interrupted, but it uses one of the -ERESTART
> mecahnisms.
> 
> User notifiers should allow correct emulation.  Right now, it doesn't,
> but there is no reason it can't.

Thanks for the explanation.

Consider fsmount, which has a,

        ret = mutex_lock_interruptible(&fc->uapi_mutex);
        if (ret < 0)
                goto err_fsfd;

If a regular task is interrupted during that wait, it return -EINTR
or whatever back to userspace.

Suppose that we intercept fsmount. The supervisor decides the mount is
OK, does the fsmount, injects the mount fd into the container, and
then the tracee receives a signal. At this point, the mount fd is
visible inside the container. The supervisor gets a notification about
the signal and revokes the mount fd, but there was some time where it
was exposed in the container, whereas with the interrupt in the native
syscall there was never any exposure.

How does the supervisor correctly emulate this syscall? Maybe this
doesn't matter and this is just "completes as usual"? But then
handling signals is just a latency issue, not a correctness one. Or
most likely I'm misunderstanding something else :)

Tycho
