Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7143A33BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFJTNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:13:38 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:39794 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFJTNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:13:37 -0400
Received: by mail-lj1-f181.google.com with SMTP id c11so6370600ljd.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMdGbg5qY7Xril8PIwC2aCilKl3gyih4vJXN13qnRQs=;
        b=cqfvjt39dMqE03b8Qk8T6nxGqG5CE1oOqhjvJmr5822PMJQr4Sbq2nJYsWDStaAAwb
         iZ8tDefBwOO4B7DqY2HZw7POkKfUguqqt97g4qUSfGrtUCu0Qk1R3Aww0cBYlsV+BMuQ
         btfcXVmLIGGv1LLx4UfLfPNWQHDLhab4yvwWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMdGbg5qY7Xril8PIwC2aCilKl3gyih4vJXN13qnRQs=;
        b=VJmLGUHp2EazorO2FhOlxZQpMAkhIlTrA72olTy1Zn8ph8Bhr4FeV8cW4a0NgKm2ye
         KmbXQMU7yb7w00EGY4bucVadpitj+cF7aqWFaI4RG/rtykq9IIURmvDmXIE8I7Imzifn
         MQQNzo146vnm4LIN74GEj6Fg6qr8lP6JHZRcHKbfoMag9Pr/i8v+aeyttBGgxwnu4USX
         BAVmoDKiTc/xhHF+FJ6cLV3akNplE+OomJyRqt/5mj6729bM0s20lUPc6cXERttzaBQk
         /3sZ0XDGQ+q/NETljVZvDpR/UamKJROI8+xZpE8ct/SzDRAah5ae4dXNXx8vPKL96z5A
         eZ6w==
X-Gm-Message-State: AOAM5314CgSNYDtymF+K9KRz4lMWGbzeT/iJc9n+qBIhKfdBXXC19wsd
        ENPL8p1chf1Z11sVdkSyQt+lvBJMQX75HN5xRYE=
X-Google-Smtp-Source: ABdhPJzwvkAwti0UuxFL29o3I3zbSV0rPRmrvlx/Rz3onuC/3EIffpn/zyTa2088FbnoQFrAKaSDeg==
X-Received: by 2002:a2e:9a96:: with SMTP id p22mr55404lji.389.1623352239396;
        Thu, 10 Jun 2021 12:10:39 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id c16sm378241lfi.18.2021.06.10.12.10.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 12:10:37 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 131so6412496ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:10:37 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr50548ljh.507.1623352236538;
 Thu, 10 Jun 2021 12:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
 <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
 <87h7i694ij.fsf_-_@disp2133> <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
 <198e912402486f66214146d4eabad8cb3f010a8e.camel@trillion01.com>
 <87eeda7nqe.fsf@disp2133> <b8434a8987672ab16f9fb755c1fc4d51e0f4004a.camel@trillion01.com>
 <87pmwt6biw.fsf@disp2133> <87czst5yxh.fsf_-_@disp2133>
In-Reply-To: <87czst5yxh.fsf_-_@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jun 2021 12:10:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiax83WoS0p5nWvPhU_O+hcjXwv6q3DXV8Ejb62BfynhQ@mail.gmail.com>
Message-ID: <CAHk-=wiax83WoS0p5nWvPhU_O+hcjXwv6q3DXV8Ejb62BfynhQ@mail.gmail.com>
Subject: Re: [CFT}[PATCH] coredump: Limit what can interrupt coredumps
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Olivier Langlois <olivier@trillion01.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov>" <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:01 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index f7c6ffcbd044..83d534deeb76 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -943,8 +943,6 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
>         sigset_t flush;
>
>         if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
> -               if (!(signal->flags & SIGNAL_GROUP_EXIT))
> -                       return sig == SIGKILL;
>                 /*
>                  * The process is in the middle of dying, nothing to do.
>                  */

I do think this part of the patch is correct, but I'd like to know
what triggered this change?

It seems fairly harmless - SIGKILL used to be the only signal that was
passed through in the coredump case, now you pass through all
non-ignored signals.

But since SIGKILL is the only signal that is relevant for the
fatal_signal_pending() case, this change seems irrelevant for the
coredump issue. Any other signals passed through won't matter.

End result: I think removing those two lines is likely a good idea,
but I also suspect it could/should just be a separate patch with a
separate explanation for it.

Hmm?

              Linus
