Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC71137EB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381555AbhELTeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349894AbhELRqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:46:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D066EC061761
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:45:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i9so28369229lfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnLmte8GJt9Bb4Yd8FS7Fvu9RWF8YS8wdhW8/1E4zQQ=;
        b=FdGhpYQR9EJbOPTteKhrCj0ZG6s92OcG2YCJlMUtFF5hCaG7UqrDHELczhFojbbgqn
         eAVv4deyYW5mjRHjJLMGvedL/b+KVwQ9YyO9MQiIvn/VBLfyDaQh4frsubScc4vnJSPr
         M5j7oAfrCStdWjsg9Zhj6FJ0qVw/yVCYo6lqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnLmte8GJt9Bb4Yd8FS7Fvu9RWF8YS8wdhW8/1E4zQQ=;
        b=TWqxw7GF+rzFMkJ0saA8XSxdtlkAvGlASciQyVa2XEK86BSHERNHN8guiMrkV4kUCR
         KS2B/zFxvll1LYcnsqMhm77XnMZll0J4kgnab0y1VeDcaGHZaaJQ+vGBnMWRBjnrsP0q
         PDwB0kROgYFg2Cb5XuDY5IzsHVx/wQGMnp96aIVY41icoYxUY8JqqiTttkf0CpFocDy/
         eWS34n4u/GDfOr6ySBQxbJfVrK+aZIyWeqNRjyfqG824Z82ezBPJ7CdrZ5CpS4ae5OlU
         l+bXy4SEL3OdovA+s24/O5jYEEt87VcmXtW5VFwYDJHk/D78Q3pznR7e9G68Y+9nUoiB
         YmDw==
X-Gm-Message-State: AOAM5319LU23hNffFeYzaV7z6aNesT7zklu4wLcrE5vQe8LPHiVAMlx+
        z1GU3ZE04p/M+J++Qz/6b5Y9rhJDNW3eWQPg
X-Google-Smtp-Source: ABdhPJz+Dqd7UilXhcs/qWlnkAlYyigHiorOuXkFa1UIz9e08pgLuYebZGdnxrkjy5BE9rQZf7pGog==
X-Received: by 2002:ac2:4ed9:: with SMTP id p25mr24955187lfr.576.1620841498735;
        Wed, 12 May 2021 10:44:58 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id z18sm34090lft.57.2021.05.12.10.44.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 10:44:57 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id z9so34909698lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:44:57 -0700 (PDT)
X-Received: by 2002:a19:4cd7:: with SMTP id z206mr11366696lfa.487.1620841496852;
 Wed, 12 May 2021 10:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <8735v3ex3h.ffs@nanos.tec.linutronix.de> <3C41339D-29A2-4AB1-958F-19DB0A92D8D7@amacapital.net>
 <CAHk-=wh0KoEZXPYMGkfkeVEerSCEF1AiCZSvz9TRrx=Kj74D+Q@mail.gmail.com>
 <CALCETrV9bCenqzzaW6Ra18tCvNP-my09decTjmLDVZZAQxR6VA@mail.gmail.com>
 <CAHk-=wgo6XEz3VQ9ntqzWLR3-hm1YXrXUz4_heDs4wcLe9NYvA@mail.gmail.com>
 <d26e3a82-8a2c-7354-d36b-cac945c208c7@kernel.dk> <CALCETrWmhquicE2C=G2Hmwfj4VNypXVxY-K3CWOkyMe9Edv88A@mail.gmail.com>
 <CAHk-=wgqK0qUskrzeWXmChErEm32UiOaUmynWdyrjAwNzkDKaw@mail.gmail.com>
 <8735v3jujv.ffs@nanos.tec.linutronix.de> <CAHk-=wi4Dyg_Z70J_hJbtFLPQDG+Zx3dP2jB5QrOdZC6W6j4Gw@mail.gmail.com>
 <12710fda-1732-ee55-9ac1-0df9882aa71b@samba.org> <CAHk-=wiR7c-UHh_3Rj-EU8=AbURKchnMFJWW7=5EH=qEUDT8wg@mail.gmail.com>
 <59ea3b5a-d7b3-b62e-cc83-1f32a83c4ac2@kernel.dk> <17471c9fec18765449ef3a5a4cddc23561b97f52.camel@trillion01.com>
In-Reply-To: <17471c9fec18765449ef3a5a4cddc23561b97f52.camel@trillion01.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 May 2021 10:44:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoJCocFsQ7+Sqq=dkuzHE+RXxvRdd4ZvyYqnsKBqsKAA@mail.gmail.com>
Message-ID: <CAHk-=whoJCocFsQ7+Sqq=dkuzHE+RXxvRdd4ZvyYqnsKBqsKAA@mail.gmail.com>
Subject: Re: [PATCH] io_thread/x86: don't reset 'cs', 'ss', 'ds' and 'es'
 registers for io_threads
To:     Olivier Langlois <olivier@trillion01.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Stefan Metzmacher <metze@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 9:24 PM Olivier Langlois <olivier@trillion01.com> wrote:
>
> I have reported an issue that I have with a user process using io_uring
> where when it core dumps, the dump fails to be generated.
> https://github.com/axboe/liburing/issues/346

I suspect most kernel developers don't have github notifications
enabled. I know I have them disabled because it would be *way* too
noisy not to.

But maybe Jens does for that libiouring part.

> Pavel did comment to my report and he did point out this thread as
> possibly a related issue.

I don't think this is related. The gdb confusion wouldn't affect core
dump generation.

I don't see why a core-dump shouldn't work from an IO thread these
days - the signal struct and synchronization should all be the same as
for a regular user thread.

That said, I do wonder if we should avoid generating core dumps from
the IO worker thread itself. The IO thread itself should never get a
SIGSEGV/SIGBUS anyway, it should have been turned into -EFAULT.

So maybe the

                if (current->flags & PF_IO_WORKER)
                        goto out;

in kernel/signal.c should be moved up above the do_coredump() logic regardless.

Jens, have you played with core-dumping when there are active io_uring
threads? There's a test-program in that github issue report..

              Linus
