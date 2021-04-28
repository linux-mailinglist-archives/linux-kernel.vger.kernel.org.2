Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC136D634
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhD1LMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbhD1LMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:12:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCD2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:11:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x20so68230894lfu.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyfujupd+nn5QDO9renTFnifqj77qdb+Pu4FnljETRM=;
        b=gtHUnUjcLgmxwsgWIIOf8S/iDfnzWUGSnw/WqI9y2//8sFp6qgXEM166UhuVsXcx/R
         qGlFx9kB/9NKu/QNkYaAe2i6SpgZAoxyFQM2GLXntmB5DijUeMqcwhHV07sFAvuHQHIP
         OFvq2LbO/SqGzD2czTrq8ZGIJxCIEHXVnD3Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyfujupd+nn5QDO9renTFnifqj77qdb+Pu4FnljETRM=;
        b=NP6WuOBc5Yv9gWehMncmZD2A0zACuYjhnxz6rqto8sjLZHdz8ElavEBhsve5t8NbuA
         opFyP7u9VzElRD+EyXjB5xThuU/HXTGPnLV6IT0rmgsXNNEgXpXbA387wWvyJPULsVnL
         tc0Kkfxdul2ko54fjJdttBx4AJiOzIQD2QHCBlwhG4LctsUwEnl0y6o176vvTSa+7cC5
         pyz0FlcxWO5LONmoT7eck5Nsp1rRZ25IU7pXKFqNGPpoctCNpYlG54C1F04B/vJjZ5m7
         7Wx+SrU7pCH+5681oQqn+QKIHDTY2AXkTDXPF9YOHKmm2MP3h++Bi+ALRwFtNSKUyLVp
         CjUg==
X-Gm-Message-State: AOAM532xEObZaURCXpEd923yQucyu6m8hmqZGacdNIH8IXrQm9gp5QoS
        BaPv/fG238cT+HOv8NRaq83zy7B8KFFiwqIIF/y6Sg==
X-Google-Smtp-Source: ABdhPJyRqU7x9LfIz6OKejPVBvLcSRnhU++Q8NTEmQA868KtvCUuU4zOr7es0Wue0SowhX2xTymnzaz6O0rKw4WYcfw=
X-Received: by 2002:ac2:5335:: with SMTP id f21mr20269909lfh.288.1619608284816;
 Wed, 28 Apr 2021 04:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210426180610.2363-1-sargun@sargun.me> <20210426180610.2363-3-sargun@sargun.me>
 <20210426190229.GB1605795@cisco> <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
 <20210427134853.GA1746081@cisco> <CALCETrVrfBtQPh=YeDEK4P9+QHQvNxHbn8ZT3fdQNznpSeS5oQ@mail.gmail.com>
 <20210427170753.GA1786245@cisco> <20210427221028.GA16602@ircssh-2.c.rugged-nimbus-611.internal>
 <CALCETrX9JnHE9BOhRxCc1bCvEBfbOY8bb2rxeKTsDNxfMruntQ@mail.gmail.com> <20210428002215.GB1786245@cisco>
In-Reply-To: <20210428002215.GB1786245@cisco>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Wed, 28 Apr 2021 13:10:49 +0200
Message-ID: <CACaBj2ZchRGzHpGn5TD2FE=yKWZotVRNZ7M78TmvGfM9BoHF4g@mail.gmail.com>
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

On Wed, Apr 28, 2021 at 2:22 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Tue, Apr 27, 2021 at 04:19:54PM -0700, Andy Lutomirski wrote:
> > User notifiers should allow correct emulation.  Right now, it doesn't,
> > but there is no reason it can't.
>
> Thanks for the explanation.
>
> Consider fsmount, which has a,
>
>         ret = mutex_lock_interruptible(&fc->uapi_mutex);
>         if (ret < 0)
>                 goto err_fsfd;
>
> If a regular task is interrupted during that wait, it return -EINTR
> or whatever back to userspace.
>
> Suppose that we intercept fsmount. The supervisor decides the mount is
> OK, does the fsmount, injects the mount fd into the container, and
> then the tracee receives a signal. At this point, the mount fd is
> visible inside the container. The supervisor gets a notification about
> the signal and revokes the mount fd, but there was some time where it
> was exposed in the container, whereas with the interrupt in the native
> syscall there was never any exposure.

IIUC, this is solved by my patch, patch 4 of the series. The
supervisor should do the addfd with the flag added in that patch
(SECCOMP_ADDFD_FLAG_SEND) for an atomic "addfd + send".

That means when using the atomic "addfd+send" what happens is: either
we add the fd _and_ the added fd value is returned to the syscall or
the fd is not added at all and the container sees the syscall as
interrupted. Therefore, the fd is only visible to the container when
it should.


Best,
Rodrigo
