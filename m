Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539203E05FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbhHDQbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbhHDQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:31:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051ABC061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 09:31:28 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u3so5438656lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mbke9nvjw7+ZeekiQRXLpz0LVFhUcu96Nb3OTfXE7BU=;
        b=PZ1SUNe5srVpzwzOaifNxeDnFelZQ09VVBF0S+czoEleI8H7NaXtf6BgmLYsKuLNiC
         LTcU8OYPWLuF/4NphS6i+l1ci/XnoMb+i+upOTt69bQAT3JgDhcod/J5a5/zqAWUQ5CE
         n8TsxAIOFru99StbsoS1slJejG91rgTWWoOlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mbke9nvjw7+ZeekiQRXLpz0LVFhUcu96Nb3OTfXE7BU=;
        b=KFmZ0f9IC5MSvp+Bp+bI3ZqlJV555ACRZ108a48SLYl7vVY46jW7sZhkC510drSdIZ
         mZ5ENvqxJkv2r1v2MYvzCXUCuzvoH6Xq6J25NA+D/7xM1U2jgCXifPI7crADFdIT7FPE
         DOHnM7XA5PegVQDP0o53ODA5Eme3voMlPoelCEvG9yCWF3obd3fzu6czeOimDTHxkL3n
         3yeiC5A4FCabmppvgRzW4FQV34I6iTrWc3bFkBmrTMAMB08BVY/uefvxGnr8q3CLEjGV
         +8QF7aYkShAn38CUoNfWLfLLiZw1YEiJaWH8rxpSS1ur1BtMAKcxANz3jL0jRXwrhfTJ
         T13g==
X-Gm-Message-State: AOAM531HmuI/eVhx8/GZs0XezhLCWoBZbBIhfSG0h9Qvv+cP2TbjCIaB
        sfrUPxZatDEdr8mGQEdv/icF4YOWQCH+VVkm
X-Google-Smtp-Source: ABdhPJwR9Usl02UBaLmPrJLJrxQ3+nWeaD+xwnvdxUx4gb33tspNy8Mo37dhirg504g/0Az8GXtILg==
X-Received: by 2002:ac2:4569:: with SMTP id k9mr101799lfm.178.1628094686232;
        Wed, 04 Aug 2021 09:31:26 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id n17sm239399lfu.201.2021.08.04.09.31.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:31:18 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id g30so1202975lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 09:31:18 -0700 (PDT)
X-Received: by 2002:a19:fc06:: with SMTP id a6mr62531lfi.377.1628094677755;
 Wed, 04 Aug 2021 09:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <1628086770.5rn8p04n6j.none.ref@localhost> <1628086770.5rn8p04n6j.none@localhost>
In-Reply-To: <1628086770.5rn8p04n6j.none@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Aug 2021 09:31:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLr55zHUWNzmp3DeoO0DUaYp7vAzQB5KUCni5FpwC7Uw@mail.gmail.com>
Message-ID: <CAHk-=wiLr55zHUWNzmp3DeoO0DUaYp7vAzQB5KUCni5FpwC7Uw@mail.gmail.com>
Subject: Re: [REGRESSION?] Simultaneous writes to a reader-less, non-full pipe
 can hang
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, acrichton@mozilla.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your program is buggy.

On Wed, Aug 4, 2021 at 8:37 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
>     pipe(pipefd);
>     printf("init buffer: %d\n", fcntl(pipefd[1], F_GETPIPE_SZ));
>     printf("new buffer:  %d\n", fcntl(pipefd[1], F_SETPIPE_SZ, 0));

Yeah, what did you expect this to do? You said you want a minimal
buffer, you get a really small buffer.

Then you try to write multiple messages to the pipe that you just said
should have a minimum size.

Don't do that then.

> /proc/x/stack shows that the remaining thread is hanging at pipe.c:560.
> It looks like not only there needs to be space in the pipe, but also
> slots.

Correct. The fullness of a pipe is not about whether it has the
possibility of merging more bytes into an existing not-full slot, but
about whether it has empty slots left.

Part of that is simply the POSIX pipe guarantees - a write of size
PIPE_BUF or less is guaranteed to be atomic, so it mustn't be split
among buffers.

So a pipe must not be "writable" unless it has space for at least that
much (think select/poll, which don't know the size of the write).

The fact that we might be able to reuse a partially filled buffer for
smaller writes is simply not relevant to that issue.

And yes, we could have different measures of "could write" for
different writes, but we just don't have or want that complexity.

Please don't mess with F_SETPIPE_SZ unless you have a really good
reason to do so, and actually understand what you are doing.

Doing a F_SETPIPE_SZ, 0 basically means "I want the mimimum pipe size
possible". And that one accepts exactly one write at a time.

Of course, the exact semantics are much more complicated than that
"exactly one write". The pipe write code will optimistically merge
writes into a previous buffer, which means that depending on the
pattern of your writes, the exact number of bytes you can write will
be very different.

But that "merge writes into a previous buffer" only appends to the
buffer - not _reuse_ it - so when each buffer is one page in size,
what happens is that you can merge up to 4096 bytes worth of writes,
but then after that the pipe write will want a new buffer - even if
the old buffer is now empty because of old reads.

That's why your test program won't block immediately: both writers
will actually start out happily doing writes into that one buffer that
is allocated, but at some point that buffer ends, and it wants to
allocate a new buffer.

But you told it not to allocate more buffers, and the old buffer is
never completely empty because your readers never read _everythign_,
so it will hang, waiting for you to empty the one minimal buffer it
allocated. And that will never happen.

There's a very real reason why we do *not* by default say "pipes can
only ever use only one buffer".

I don't think this is a regression, but if you have an actual
application - not a test program - that does crazy things like this
and used to work (I'm not sure it has ever worked, though), we can
look into making it work again.

That said, I suspect the way to make it work is to just say "the
minimum pipe size is two slots" rather than change the "we want at
least one empty slot". Exactly because of that whole "look, we must
not consider a pipe that doesn't have a slot writable".

Because clearly people don't understand how subtle F_SETPIPE_SZ is.
It's not really a "byte count", even though that is how it's
expressed.

                   Linus
