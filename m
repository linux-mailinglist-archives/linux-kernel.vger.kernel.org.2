Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE2C3AF90C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhFUXRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFUXRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:17:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BECC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:14:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p7so32699972lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSpCTvtqwlFJ06T40MsJFhKBN6aTybvqDQph3piqU3c=;
        b=ej8PSbPXAb0zIPa9apzD7OWAABcayKzztY2Gl8qbjCjYcakYI2cbU1Xi2FhqAdGS23
         7NquMnu4HBnT8zfyZ8CSmagToFSLIKrWjMMs8/+Ru7rfccWvgOKMc4CMWM1hXZDx2u2Y
         vd34mqkS+oueuqgdEbosrH2qeR1zCtN6Gblvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSpCTvtqwlFJ06T40MsJFhKBN6aTybvqDQph3piqU3c=;
        b=ryk3NklGt42rPvlwS5pYmjvcv6sBXSpRwXVizUqFZSmEqEKomBHFTvCkqyV9O0X7Eg
         gylPx9s/syY0bIFJLmuOZAGecTOU6Gzk+JnKa6f+deQGSQ8MiC1VVCXo5JX8/Ucc475F
         4n/stUsKA3g+QaPBkQTLmRBg0rvw7XSPFhsDw0vn8vGoo6Pvp4bDTlrQ9m46lB/W+ALZ
         nPKSCk9MuwA1XZcAsIVxps6WEcu6+OH0uYiWHcxsRcPz9S5Gol+FcxI5+G2ZSRFHTRC8
         JYKXZ8Fxem6O3iG3aNpNFLeLJAg1Y1G363z+xKc3B3kn6cm/0nj40Fmt9vDO+i2d2eED
         er1Q==
X-Gm-Message-State: AOAM530k6DJntDJtTmJs5ja6cLt9W+8/b8IEIiKQM/Ca7qaX1RpKHpM0
        yx0OTYXdY8bd5LKk7oIPKjnuqZxS2nRXhQvsD+U=
X-Google-Smtp-Source: ABdhPJwOIPdSS3OlztY+rZxmQxjkgz39n4FSQggWN3zzd6RKRNlCuYH8vaP0Bx7xh6/G0Wsk0wo+gQ==
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr473099lfc.363.1624317292605;
        Mon, 21 Jun 2021 16:14:52 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b11sm2010429lfi.292.2021.06.21.16.14.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:14:52 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id t17so12666231lfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:14:52 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr470683lfs.377.1624317291959;
 Mon, 21 Jun 2021 16:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com> <YNDsYk6kbisbNy3I@zeniv-ca.linux.org.uk>
In-Reply-To: <YNDsYk6kbisbNy3I@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 16:14:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
Message-ID: <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 12:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Looks like sys_exit() and do_group_exit() would be the two places to
> > do it (do_group_exit() would handle the signal case and
> > sys_group_exit()).
>
> Maybe...  I'm digging through that pile right now, will follow up when
> I get a reasonably complete picture

We might have another possible way to solve this:

 (a) make it the rule that everybody always saves the full (integer)
register set in pt_regs

 (b) make m68k just always create that switch-stack for all system
calls (it's really not that big, I think it's like six words or
something)

 (c) admit that alpha is broken, but nobody really cares

> In the meanwhile, do kernel/kthread.c uses look even remotely sane?
> Intentional - sure, but it really looks wrong to use thread exit code
> as communication channel there...

I really doubt that it is even "intentional".

I think it's "use some errno as a random exit code" and nobody ever
really thought about it, or thought about how that doesn't really
work. People are used to the error numbers, not thinking about how
do_exit() doesn't take an error number, but a signal number (and an
8-bit positive error code in bits 8-15).

Because no, it's not even remotely sane.

I think the do_exit(-EINTR) could be do_exit(SIGINT) and it would make
more sense. And the -ENOMEM might be SIGBUS, perhaps.

It does look like the usermode-helper code does save the exit code
with things like

                kernel_wait(pid, &sub_info->retval);

and I see call_usermodehelper_exec() doing

        retval = sub_info->retval;

and treating it as an error code. But I think those have never been
tested with that (bogus) exit code thing from kernel_wait(), because
it wouldn't have worked.  It has only ever been tested with the (real)
exit code things like

                if (pid < 0) {
                        sub_info->retval = pid;

which does actually assign a negative error code to it.

So I think that

                kernel_wait(pid, &sub_info->retval);

line is buggy, and should be something like

                int wstatus;
                kernel_wait(pid, &wstatus);
                sub_info->retval = WEXITSTATUS(wstatus) ? -EINVAL : 0;

or something.

            Linus
