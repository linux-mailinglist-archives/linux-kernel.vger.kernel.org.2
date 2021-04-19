Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13743646D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbhDSPOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhDSPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:14:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA0BC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:13:59 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i4so1595921ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36vwzvQKHGNtNCW2ZUnMCMtobdyASLNJa9tZKeMvkEQ=;
        b=czTjya+URdUiMwXGnHagZwTFuPInlRrTc3wRPHOQw5l93EMk3BWr3PTm6Qb2J+tiMc
         58cs6nPNphdDoVxv+Hkgbr21HhD3zEoZa4Xl7Mhd53JshzbevB0YxVeFFpSZHZ2mi7zO
         lER3lLDVLxfBRy9Ee0nGVzowhPXLnhRjRTKtZVjLCniQ5G80oGGtpVbVcp0LE1AVb/gN
         N3c1ewRFeTJh8qI3+8pGgAWjJQfQmh9X7HYlXYfvJ39RjjJrMXwtE0ljmLA5SkctCOfr
         M92Uh3HtEOaywf5vNGwsfIVeVmJQmTDYbKXPDnUaRwhMwUmMhby9KM4eFfaxLGcRowpL
         uFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36vwzvQKHGNtNCW2ZUnMCMtobdyASLNJa9tZKeMvkEQ=;
        b=OHBQmHcZqJSteiHyiSUnhOWGR3o762Fnwop+q3f5KarmJMPUbo9l+KR1NlGotNVqKg
         lOZ+qVpeL0mtMR2k5LZTM3iRc7Lpktwc6k/rICjLpTHZm9FPnn4v4GZ4DC07EMLEzYwa
         RKENlCH8EaV3Y9nL3aO7EBc2oryYVTA7ynqfzRHC+aLShMiKSgoHlz7GS7E9b85mj1Wt
         d0o3C5JOZv4cDNomweEMnyTBI89f7acb/Be8epJxTgQf25AWSC1QSAVkNfhGS0zrnZUc
         uh7JObUFmKPQ90HdRI9vX1gVDL+YQa4UG40ClnQXGyJVr1rp/uCHA7p/ESMJ0TEDcwF8
         Xv0w==
X-Gm-Message-State: AOAM5315oZ1zwRxx4b9fVW+WUmbPn3Hwy8YyQ5LwG/9KpKUW/6zetY8+
        ot0XDpNfGjzMhfIF8G9AIRq5YJRmvj6FlX+lATe01Q==
X-Google-Smtp-Source: ABdhPJxAU6EK+Ci3bFffn6VjCF6gBAVpg/AidJqINewRXOSkH344Bvq6EHCF/rHnRbglHa41rdgJiMpUL1ULY2xRrz8=
X-Received: by 2002:a5b:48c:: with SMTP id n12mr18798826ybp.273.1618845238403;
 Mon, 19 Apr 2021 08:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <20210416221414.GF22348@zn.tnic> <CALCETrUo+tR+YmfoBPWV9z_7QhU74=7tmCBD_zsfa24ZxNvfxg@mail.gmail.com>
 <202104161529.D9F98DA994@keescook> <87fszpu92e.ffs@nanos.tec.linutronix.de> <875z0ltdv8.ffs@nanos.tec.linutronix.de>
In-Reply-To: <875z0ltdv8.ffs@nanos.tec.linutronix.de>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 19 Apr 2021 08:13:47 -0700
Message-ID: <CABCJKueKDX+6DJnoVns1K35B9htRXRHLdYUckJ25dDhbWUezFw@mail.gmail.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 3:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, Apr 17 2021 at 01:02, Thomas Gleixner wrote:
> > On Fri, Apr 16 2021 at 15:37, Kees Cook wrote:
> >
> >> On Fri, Apr 16, 2021 at 03:20:17PM -0700, Andy Lutomirski wrote:
> >>> But obviously there is code that needs real function pointers.  How
> >>> about making this a first-class feature, or at least hacking around it
> >>> more cleanly.  For example, what does this do:
> >>>
> >>> char entry_whatever[];
> >>> wrmsrl(..., (unsigned long)entry_whatever);
> >>
> >> This is just casting. It'll still resolve to the jump table entry.
> >>
> >>> or, alternatively,
> >>>
> >>> extern void func() __attribute__((nocfi));
> >>
> >> __nocfi says func() should not perform checking of correct jump table
> >> membership for indirect calls.
> >>
> >> But we don't want a global marking for a function to be ignored by CFI;
> >> we don't want functions to escape CFI -- we want specific _users_ to
> >> either not check CFI for indirect calls (__nocfi) or we want specific
> >> passed addresses to avoid going through the jump table
> >> (function_nocfi()).
> >
> > And that's why you mark entire files to be exempt without any rationale
> > why it makes sense.
>
> The reason why you have to do that is because function_nocfi() is not
> provided by the compiler.
>
> So you need to hack around that with that macro which fails to work
> e.g. for the idt data arrays.
>
> Is there any fundamental reason why the compiler does not provide that
> in a form which allows to use it everywhere?

I'm not aware of a fundamental reason why the compiler couldn't
provide a built-in here. This series attempts to work with what's
available at the moment, and admittedly that's not quite ideal on x86.

> It's not too much asked from a tool which provides new functionality to
> provide it in a way which is usable.

Sure, that's reasonable. I'll talk to our compiler folks and see how
we can proceed here.

Sami
