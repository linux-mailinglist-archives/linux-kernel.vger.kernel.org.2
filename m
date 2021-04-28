Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696DA36D830
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbhD1NV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbhD1NV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:21:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220A3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 06:20:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o5so39104851ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIGj9FC9IzQAq2GBbgZ3dpBuRxuZ1w8kk9zAVN1t/ks=;
        b=Atxh07MDqbbW6/8ErsAvnGFkCNHvXe2vYe9WACJaEyB7bJkjnALZzk1jNN5xtWCwrG
         izIca9U7kp1F/dB6FgQJwUeWw7/HVJ0fhgnwgHlW7VnhUz8cjI9OCl1ep8aGKyoYnpMp
         qwRrem0ZKmJaX7mt0eVuN+e18X4/U3KpboD1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIGj9FC9IzQAq2GBbgZ3dpBuRxuZ1w8kk9zAVN1t/ks=;
        b=rhZxelH75OqbYlQoi0wEnNf0m+AvqMkRWnpZ99gvcUlvAWZLEDxc9pYt6iZtSq8cS0
         qyZRLGeDYPfmONB1cyb9O3CABkQ/L5AN6FplUKVVdmyk+syjufUmHTL5XWEMtLeT/cXe
         Pg3Hu71Ubwh5Pnl0/nhNY2lI5cTKYg0JtfgHSekDvv85cOYmhgHFqJxtltgr+S1TMeHA
         H9Jf3fL74RYmdP/hvSetDBxWKKFDErj4GMtNlBRDHHE5oN9bAXS6j0It9LNbbJ5jh4Lx
         7Hr6pfLtBTGd45/pzGJSt5S1ObMww7Eng+1UCbXu54p47qJOuRktFvWiBIXICQ+6rTCi
         uooQ==
X-Gm-Message-State: AOAM531i3ERciG9peyx1NONxOZc4aDpVF14JVw/7xtKhLlBWSPBkBK1K
        u20Cx8i2NI7uLWlo0gOnZrjjzHFm7ESYch6r8VBzyg==
X-Google-Smtp-Source: ABdhPJx9KA3ejbYEli1zAg5bEg5ZXtE1NsqbHnBRe3FeKasU220+f/H5v10Cq1RRRSRPsxwCH7ZeWuiXmKw0XIS1zCs=
X-Received: by 2002:a2e:9b50:: with SMTP id o16mr21000868ljj.8.1619616039596;
 Wed, 28 Apr 2021 06:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210426180610.2363-1-sargun@sargun.me> <20210426180610.2363-3-sargun@sargun.me>
 <20210426190229.GB1605795@cisco> <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
 <20210427134853.GA1746081@cisco> <CALCETrVrfBtQPh=YeDEK4P9+QHQvNxHbn8ZT3fdQNznpSeS5oQ@mail.gmail.com>
 <20210427170753.GA1786245@cisco> <20210427221028.GA16602@ircssh-2.c.rugged-nimbus-611.internal>
 <CALCETrX9JnHE9BOhRxCc1bCvEBfbOY8bb2rxeKTsDNxfMruntQ@mail.gmail.com>
 <20210428002215.GB1786245@cisco> <CACaBj2ZchRGzHpGn5TD2FE=yKWZotVRNZ7M78TmvGfM9BoHF4g@mail.gmail.com>
In-Reply-To: <CACaBj2ZchRGzHpGn5TD2FE=yKWZotVRNZ7M78TmvGfM9BoHF4g@mail.gmail.com>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Wed, 28 Apr 2021 15:20:02 +0200
Message-ID: <CACaBj2aSnzQnbZG0sMM2Vae_yWGzxKWrGUz9xJVL_7akF8DvNA@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/5] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
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

On Wed, Apr 28, 2021 at 1:10 PM Rodrigo Campos <rodrigo@kinvolk.io> wrote:
>
> On Wed, Apr 28, 2021 at 2:22 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> >
> > On Tue, Apr 27, 2021 at 04:19:54PM -0700, Andy Lutomirski wrote:
> > > User notifiers should allow correct emulation.  Right now, it doesn't,
> > > but there is no reason it can't.
> >
> > Thanks for the explanation.
> >
> > Consider fsmount, which has a,
> >
> >         ret = mutex_lock_interruptible(&fc->uapi_mutex);
> >         if (ret < 0)
> >                 goto err_fsfd;
> >
> > If a regular task is interrupted during that wait, it return -EINTR
> > or whatever back to userspace.
> >
> > Suppose that we intercept fsmount. The supervisor decides the mount is
> > OK, does the fsmount, injects the mount fd into the container, and
> > then the tracee receives a signal. At this point, the mount fd is
> > visible inside the container. The supervisor gets a notification about
> > the signal and revokes the mount fd, but there was some time where it
> > was exposed in the container, whereas with the interrupt in the native
> > syscall there was never any exposure.
>
> IIUC, this is solved by my patch, patch 4 of the series. The
> supervisor should do the addfd with the flag added in that patch
> (SECCOMP_ADDFD_FLAG_SEND) for an atomic "addfd + send".

Well, under Andy's proposal handling that is even simpler. If the
signal is delivered after we added the fd (note that the container
syscall does not return when the signal arrives, as it happens today,
it just signals the notifier and continues to wait), we can just
ignore the signal and return that (if that is the appropriate thing
for that syscall, but I guess after adding an fd there isn't any other
reasonable thing to do).



Best,
Rodrigo
