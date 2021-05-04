Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3D2372D57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhEDPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhEDPyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:54:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A741CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 08:53:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w4so3087084ljw.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVnIyduqThWIuCSGmh6rkTvxRGJjTH2vw8gJzQUQqCk=;
        b=dPZVHdVaqUDQqirKTBXog102xqhau6F+cdFhgg66hNUFeXGQ3MrsQZ5wHxXgN6uo3s
         Toz3aiZBRHppQQNK07cct1a8+yyoVZhgyoEVnQ1mJepF8F/wyr+fFIUWbpglgntON38j
         gjVZedE1O9Ahj3dNS0hcyZDzDjLr1aS/M8QXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVnIyduqThWIuCSGmh6rkTvxRGJjTH2vw8gJzQUQqCk=;
        b=SgoAoxvl8zLvrHGDicSz8TZV+2KX2NxZEsCLLS6vnofrYN+m6NECbZOSABQVm0Y510
         D7lKjV5Uh7YeWVL89lAXjbSIz+eFf7Peo8kKYIEajh3OosEG6YlP9j11Nfm87RLAs8Hk
         3RRvAhNrcddB6gEZwB1TY0RYJCvtPIQ8kBrdXF8G8pDjWMrDSBJED0d4POFCvYvpRvqA
         0DdTRDFQNb/l0h+1a06lMRiEjCdctQru7A9s4850Uc7TDZcUDHPW2Dh4OZ1P/USPZVL0
         RJUNy89jtBAGa/KlZ6coz3sWB8UGjE40HrLr1fdcD1YMhv1Bhu5jy6Tg8P+JK3qr4Gad
         Kylg==
X-Gm-Message-State: AOAM531AUmLI3A/ajSi97m9lsbmIk6o1dy81jGHNxYeHmeXzh4SUF/bw
        VODF7JKjfu6WXwq20jHs6RdmzI/LBATtj6fJ
X-Google-Smtp-Source: ABdhPJyIgKJkJr6WsIqYhqO7dGdjzQeqW44ct9e5HETVd/AsAh0UK3BHYA5hZ96Gt5HMBt1RKJRcUw==
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr13033442ljq.164.1620143603908;
        Tue, 04 May 2021 08:53:23 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u13sm296875lfk.193.2021.05.04.08.53.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 08:53:23 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 12so13943268lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 08:53:22 -0700 (PDT)
X-Received: by 2002:a19:c30b:: with SMTP id t11mr17206391lff.421.1620143602614;
 Tue, 04 May 2021 08:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <8735v3ex3h.ffs@nanos.tec.linutronix.de> <3C41339D-29A2-4AB1-958F-19DB0A92D8D7@amacapital.net>
 <CAHk-=wh0KoEZXPYMGkfkeVEerSCEF1AiCZSvz9TRrx=Kj74D+Q@mail.gmail.com>
 <CALCETrV9bCenqzzaW6Ra18tCvNP-my09decTjmLDVZZAQxR6VA@mail.gmail.com>
 <CAHk-=wgo6XEz3VQ9ntqzWLR3-hm1YXrXUz4_heDs4wcLe9NYvA@mail.gmail.com>
 <d26e3a82-8a2c-7354-d36b-cac945c208c7@kernel.dk> <CALCETrWmhquicE2C=G2Hmwfj4VNypXVxY-K3CWOkyMe9Edv88A@mail.gmail.com>
 <CAHk-=wgqK0qUskrzeWXmChErEm32UiOaUmynWdyrjAwNzkDKaw@mail.gmail.com>
 <8735v3jujv.ffs@nanos.tec.linutronix.de> <CAHk-=wi4Dyg_Z70J_hJbtFLPQDG+Zx3dP2jB5QrOdZC6W6j4Gw@mail.gmail.com>
 <12710fda-1732-ee55-9ac1-0df9882aa71b@samba.org> <CAHk-=wiR7c-UHh_3Rj-EU8=AbURKchnMFJWW7=5EH=qEUDT8wg@mail.gmail.com>
 <59ea3b5a-d7b3-b62e-cc83-1f32a83c4ac2@kernel.dk> <4d0bb1e7-acbd-4afb-e6d6-a2e7f78ccaaa@samba.org>
In-Reply-To: <4d0bb1e7-acbd-4afb-e6d6-a2e7f78ccaaa@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 May 2021 08:53:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEFPg-2br0ptKxHUBrD4L+0stgEM=5Ck2uuMUEkUtjhw@mail.gmail.com>
Message-ID: <CAHk-=whEFPg-2br0ptKxHUBrD4L+0stgEM=5Ck2uuMUEkUtjhw@mail.gmail.com>
Subject: Re: [PATCH] io_thread/x86: don't reset 'cs', 'ss', 'ds' and 'es'
 registers for io_threads
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 4:39 AM Stefan Metzmacher <metze@samba.org> wrote:
>
> I'm currently testing this (moving things to the end and resetting ->ip = 0 too)

This part is not right (or at least very questionable):

> +       if (!ret && unlikely(p->flags & PF_IO_WORKER)) {

That testing "ret" is misleading, in my opinion.

If PF_IO_WORKER is set, there is no way we  wouldn't want to do the
kthread_frame_init().

Now, ret can never be non-zero, because PF_IO_WORKER will never have
CLONE_SETTLS set, so this is kind of moot, but it does mean that the
test for 'ret' is just pointless, and makes the code look like it
would care.

For similar reasons, we probably don't want to go down to the whole
io_bitmap_share() case - the IO bitmap only makes sense in user space,
so going through all that code is pointless, but also would make
people think it might be relevant (and we _would_ copy the io bitmap
pointer and increment the ref if the real user thread had one, so we'd
do all that pointless stuff that doesn't actually matter).

So don't move that code down. It's best done right after the register
initialization.

Moving it down to below the setting of 'gs' for the 32-bit case is ok,
though. I think my original patch had it above it, but technically it
makes sense to do it below - that's when all the register state really
is initialized.

As to:

> +               childregs->ip = 0;
> [..]
> which means the output looks like this:
>
> (gdb) info threads
>   Id   Target Id                  Frame
> * 1    LWP 4863 "io_uring-cp-for" syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
>   2    LWP 4864 "iou-mgr-4863"    0x0000000000000000 in ?? ()
>   3    LWP 4865 "iou-wrk-4863"    0x0000000000000000 in ?? ()
> (gdb) thread 3
> [Switching to thread 3 (LWP 4865)]
> #0  0x0000000000000000 in ?? ()
> (gdb) bt
> #0  0x0000000000000000 in ?? ()
> Backtrace stopped: Cannot access memory at address 0x0

Yeah, that's probably sensible.

I'm not sure it's a bad idea to show the IO thread as being in the
original system call - that makes perfect sense to me too, but I guess
it could go either way. So I don't think it's wrong to clear the user
space ->ip.

> What do you think? Should I post that as v2 if my final testing doesn't find any problem?

Yes, please, with the above "move the IO thread return up a bit"
comment, please do post a tested version with some nice commit log,
and we can close this issue.

It even looks like gdb will be cleaned up too. Yay. But I think having
that separate test for PF_IO_WORKER is a good idea regardless, since
it just makes clear that an IO worker isn't the same thing as a kernel
thread in that code.

         Linus
