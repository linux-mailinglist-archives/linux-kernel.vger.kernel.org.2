Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26650308028
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhA1VEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhA1VEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:04:16 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C956C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:03:36 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id i187so9505169lfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdDuCRzkz9xp+XJsVq7mYn0DfZeI0K4LQW2Z/nEcmQg=;
        b=CuBesJ1LP2UaDvKAEEK9ty4JNIugW6e5APVFSm9E7fiJHWA1KPAf2iH8izI6RoPs65
         G836VUTI89SC+kl1ZPl9l4OgX/cECS+G1kYkfmV/UQBF0i1mf5GuGzIwbuCYArHK+FB6
         knl7IYoNkyPRHrFhmo03wZoUvIqYUTzW/LwZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdDuCRzkz9xp+XJsVq7mYn0DfZeI0K4LQW2Z/nEcmQg=;
        b=sCAPiC4ORsODWzRtXwuouPZ2ws+73fN9xkWLSdHICpZNW+GqD+0b68DsocdXemjgFN
         lzwK4Rkf8Zqr3fDwnK0thev9a7R1uAY+1+/UUVt7oty1TB7XWmiT5bpUQtswFd/AiIqS
         TXvF+cyvZqJwAh5079EHmSEItXkabj4LKxTBQ9ajyTXi4F5rmgfkj6YSGoovwr5JxGdG
         ++Cw3jt4bxlFj5poR21PHkQMxxdNJ9L2Ha1GcCJI9snaG11CApsR53JEG2LtUBZSq6So
         Fs5L2pPNrhvLlnHFbkVQWgEjc46zKYynEbG58OuD1zzpZ+gUa8bTUCMbhOoRGju+mowr
         HGtg==
X-Gm-Message-State: AOAM533Ad0X0NrgphY4yl5vq/Y+BjWvAwzR0UcVNAJDVVEPL7q5FLqaL
        5GBHZ3eDh75hh9KrV9ha/g7YdwQtHRgmOw==
X-Google-Smtp-Source: ABdhPJyIrOyNhtl/RzUH5RxlmIFOqN5g5TppnU6N3n2aPwVbSQZvqpceRlejnFn8nasAsw6+QZ8YeA==
X-Received: by 2002:a05:6512:6f:: with SMTP id i15mr480030lfo.426.1611867814235;
        Thu, 28 Jan 2021 13:03:34 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m18sm1024851ljb.138.2021.01.28.13.03.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 13:03:33 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id f1so9515453lfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:03:32 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr424761lfh.377.1611867812567;
 Thu, 28 Jan 2021 13:03:32 -0800 (PST)
MIME-Version: 1.0
References: <fff056a7c9e6050c2d60910f70b6d99602f3bec4.1611863075.git.jpoimboe@redhat.com>
 <CAHk-=wih0rLHsPXodpXJw_0F3bJqu=Pb_YNmPCSsYU_huoMwZA@mail.gmail.com> <20210128205207.awdbh4bmx56pxxjl@treble>
In-Reply-To: <20210128205207.awdbh4bmx56pxxjl@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jan 2021 13:03:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgh4DaZvTcFfBcDMKc1QXkKjwny_Z0H5JfzdwMTNTBkSw@mail.gmail.com>
Message-ID: <CAHk-=wgh4DaZvTcFfBcDMKc1QXkKjwny_Z0H5JfzdwMTNTBkSw@mail.gmail.com>
Subject: Re: [PATCH RFC] kbuild: Prevent compiler mismatch with external modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:52 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Huh?  Why would you do a "make oldconfig" on a distro-released kernel
> before building an OOT module?

I guarantee you that this patch will *make* people do that.

> Hm?  Are you saying the check is too strict, since GCC9 binaries _might_
> be compatible with GCC10?

I'm saying that your argument about minor and major versions is bogus.

There is absolutely nothing that makes gcc9 object files not
compatible with gcc10.

And this is not just some theoretical issue: this is a fundamental
fact of EVERY SINGLE LIBRARY OUT THERE.

Do you think that when you compile your binaries with gcc-10, you need
to link against a standard library that has been compiled with gcc-10?

I really think the whole compiler version check is purely voodoo programming.

                 Linus
