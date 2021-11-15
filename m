Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB68A45229E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbhKPBPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245138AbhKOTTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:19:32 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF0BC0386CC
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:11:28 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so28842884otk.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7DOXi4ZM5FLAUD83SAzyJhtRItBmD8aCEord4L/i2U=;
        b=Z9CpxgeIP4Aat3GlURGnb7kaa7nuTGd2PhkLliM9RxnEoB0L2ihKJkSIf2pQHOGbGr
         FPdovtbvJbXfVAcwJjuLkmh5Ca0VKaoTMut/F8K+XHZ0mXq9gGP6l1UB/n08cYmabqzQ
         GvkvjO93EabtKwNy3RvC/b4FC14pknK/WxzC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7DOXi4ZM5FLAUD83SAzyJhtRItBmD8aCEord4L/i2U=;
        b=KIOlchf6TzYdYn7BDE4njYb4AOlnGr6H/UoxiZEdmjDW3XwjayLru/3ePKP7hZb+pd
         4r1EpAdHf1qBGPwRkZ4HaLkvWSbsk9UY/hfwWxA2kSFmSwSFItnTvZw0lioUfYy0Ecmg
         466WRHekDZ1R4Mlwwv/NKKZFrZ7n7iYP4AkOO0tSDmaIv44Ow/SJ2CI4tQ8hpmTDibBQ
         1MRqQ/I+tgLOLg5NLtDyQQ59pcthguGbbpzQ2Jkoo8vG047qqlk6P2/d8PqgBjzFXa6I
         fehh2fcl4uHM5OOF9wplLDgdYFjP8s0TuG9C7bYziqNF3jNKBuN29XxP0lVRWJC/pnd3
         HdcQ==
X-Gm-Message-State: AOAM530/cuTCwDk4IEikQpEgEdVv5JhsLvZT4RALbVBGbHylu8BhhWLo
        9SICwnG7vIB/k9J7Lwkz3z5PzL880K235/sI
X-Google-Smtp-Source: ABdhPJxKDrfY5JVmLOCZZazpkB1bpMZW9x5cy0VWaib+djFzxSo4fBZXeC5y39bA7VxUS05DrxIxAw==
X-Received: by 2002:a9d:4604:: with SMTP id y4mr770567ote.241.1636999887470;
        Mon, 15 Nov 2021 10:11:27 -0800 (PST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id s17sm3104878otp.20.2021.11.15.10.11.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 10:11:26 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id r26so36559381oiw.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:11:26 -0800 (PST)
X-Received: by 2002:aca:62c1:: with SMTP id w184mr541079oib.159.1636999886368;
 Mon, 15 Nov 2021 10:11:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net> <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
In-Reply-To: <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Nov 2021 10:10:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wis4sMKEB1EWJW-+jgc4j31S297sx7nq4a_MS92r8-HgA@mail.gmail.com>
Message-ID: <CAHk-=wis4sMKEB1EWJW-+jgc4j31S297sx7nq4a_MS92r8-HgA@mail.gmail.com>
Subject: Re: Linux 5.16-rc1
To:     Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 9:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> parisc:allmodconfig: Lots of build failures in arch/parisc/include/asm/jump_label.h.
> Not fixed in -next. The problem seens to be related to the thread_info changes,
> or at least bisect points to commit 01463374c50e ("Merge tag 'cpu-to-thread_info-v5.16-rc1'
> of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux").

I don't think they are related to the thread_info changes except very
incidentally.

From the errors ("expected ':' before '__stringify'") it looks like
__stringify() isn't defined there, and I do think that header file
should include <linux/compiler.h> to get it.

I don't actually see how that merge commit you bisected to could
possibly matter (the diff doesn't show any header file include
changes, or any parisc ones), but I suspect you might have bisected to
it because we did end up having actual thread_info errors on parsic
that weren't fixed until commit 2a2e8202c7a1 ("parisc: move CPU field
back into thread_info").

So I suspect the parisc build problems started with thread_info issues
at that merge commit you pinpoint, and then by commit 2a2e8202c7a1
some other header file simplification had exposed that "no
__stringify()" thing).

Helge - apparently from allmodconfig and others, we have:

   arch/parisc/include/asm/jump_label.h: In function 'arch_static_branch':
   arch/parisc/include/asm/jump_label.h:18:18: error: expected ':'
before '__stringify'

and others, which does look like just a missing header file (that was
presumably previously implicitly included earlier, and now the
implicit include is gone).

                    Linus
