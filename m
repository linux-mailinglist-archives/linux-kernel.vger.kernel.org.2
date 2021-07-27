Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F33D6FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhG0HIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhG0HIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:08:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2F4C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:08:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hp25so20344247ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61u8UCMEnO7wATC11PhF1oS3yaK+Qc9yAnlIV6nisfQ=;
        b=uhzcnEfMnvchsYv1lvr6vaCBwt5MT4FmuD6X8rCB/sDMGPXEktXQsXPWDdQwM9G9RN
         aqscBCaOQsDB+1xi4HVtHilV/9CHue4wMwF3eP31P1onBN1sEMbF00hC5YLyOTPxXoT7
         Y17eBp45b36h8sw60hlqmO8vJf9aMUdYg9pY/QIPla4PvFWdvFzTQR0ZCVaR842+oh/w
         Q4F4l+deST5RhkiMQs5SsvMCOiZofYrvDZXtcScpn6Yjo2hSLJ1Uy3Mw1ApJLpjrXQtH
         xuOatnhrWj6PaGnZNdqGq5TfAIiXRUNddQ+qJTC2lrt5Z7I+Uu2MWGT2K9nJFw8L/dsE
         I4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61u8UCMEnO7wATC11PhF1oS3yaK+Qc9yAnlIV6nisfQ=;
        b=lSpOub2hIuYmcPSQcjggtyQxuiABqlswrjafjgtslecoJCPNUVpwGYMKBvO954XoNW
         Qm0bRUzCcgp/bZezWLn3XkKNfnL1l1GRa/PrvNcMSF+rnzKMK6lP9C6J2eCXfKuT7ov7
         wi3B8dbDMstUvMJZflzO1NsvIwFRKYms/virAUYgSrDjhnUg0EWiBLBsN+eoQCz0GbEv
         Bcsh9n0oo/bZqi6sV6P1lXcngK8sz32SjGhzxXdzbBPk8U9GAtYMGVNOtpF3B58D5+Sd
         9nW3PT5p/LqK/mkw52xLygCX0J8z3eGxTpuQECH/QqcAblFbcGyn6uFf1hyXcRjK2YQJ
         2r8Q==
X-Gm-Message-State: AOAM531BD45oaPotG/y4nxDLmVgbO55pXg9eMaKSf07zpBTnQ6SYOXHh
        Qnz5JX6MzKCYGkvMz50lDiU8b8/7geK6+CdzMgHc
X-Google-Smtp-Source: ABdhPJy7WeEGDsRY0V+xDJi1MYzzpE8SF52Wu7BnkNytoY54DA0FfoacLn9W9jAfPuj3Dk97hq0ALKu9h3xwR5DmaDk=
X-Received: by 2002:a17:906:404:: with SMTP id d4mr20426224eja.449.1627369728555;
 Tue, 27 Jul 2021 00:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com>
In-Reply-To: <YP+ql3QFYnefR/Cf@kroah.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 27 Jul 2021 00:08:37 -0700
Message-ID: <CAGG=3QVc_OZoKi2J8tqRoBKcPekgAMMi=6Uphg1hNGNDK1qJUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Jul 26, 2021 at 11:15:52PM -0700, Bill Wendling wrote:
> > On Mon, Jul 26, 2021 at 10:27 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Mon, Jul 26, 2021 at 01:47:33PM -0700, Nathan Chancellor wrote:
> > > > + Greg and Rafael as the maintainer and reviewer of drivers/base/module.c
> > > > respectively, drop everyone else.
> > >
> > > Odd no one cc:ed us originally, I guess they didn't want the patch ever
> > > merged?  :(
> > >
I don't believe I saw you or Rafael listed in the
"script/get_maintainers" output. I tried to copy everyone who showed
up.

> > > >
> > > > Original post:
> > > >
> > > > https://lore.kernel.org/r/20210726201924.3202278-2-morbo@google.com/
> > > >
> > > > On 7/26/2021 1:19 PM, 'Bill Wendling' via Clang Built Linux wrote:
> > > > > Fix the following build warning:
> > > > >
> > > > >    drivers/base/module.c:36:6: error: variable 'no_warn' set but not used [-Werror,-Wunused-but-set-variable]
> > > > >          int no_warn;
> > >
> > > That's not going to be a good warning to ever have the kernel use due to
> > > how lots of hardware works (i.e. we need to do a read after a write but
> > > we can throw the read away as it does not matter).
> > >
> > >
> > > > >
> > > > > This variable is used to remove another warning, but causes a warning
> > > > > itself. Mark it as 'unused' to avoid that.
> > > > >
> > > > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > >
> > > > Even though they evaluate to the same thing, it might be worth using
> > > > "__always_unused" here because it is :)
> > >
> > > But it is not unused, the value is written into it.
> > >
> > I believe that only matters if the variable is marked "volatile".
>
> "volatile" means nothing anymore, never use it or even think about it
> again please :)
>
Never use what? ;-)

> > Otherwise, the variable itself is never used. A "variable that's
> > written to but not read from," in fact, is the whole reason for the
> > warning.
>
> But that is ok!  Sometimes you need to do this with hardware (like all
> PCI devices).  This is a legitimate code flow for many hardware types
> and if a C compiler thinks that this is not ok, then it is broken.
>
Well, no. A C compiler cares about the C language. A variable that's
assigned to but not otherwise used isn't useful in the language. Like
most warnings, the compiler warns because these situations have led to
errors in the past (e.g. maybe someone assigned to the wrong variable
because they mistyped the name or something). So this is a perfectly
valid warning for a C compiler to emit. This especially holds true
when the function being called is marked as requiring the return value
to be checked, as is the case with the functions whose values are
assigned 'no_warn'.

> So be VERY careful when changing drivers based on this warning.  Because
> of this, I do not think you can enable it over the whole kernel without
> causing major problems in some areas.
>
> But that is independent of this specific issue you are trying to patch
> here, I say this to warn you of a number of stupid places where people
> have tried to "optimize away" reads based on this compiler warning in
> drivers, and we have had to add them back because it broke
> functionality.
>
I definitely agree that we shouldn't blindly remove code just because
the return value assigned to a variable isn't used. That's not what
this patch is doing.

> > > So this isn't ok, sometimes we want to write to variables but never care
> > > about the value, that does not mean the compiler should complain about
> > > it.
> > >
> > Typically, if you don't care about the return value, you simply don't
> > assign it to a variable (cf. printf). However, the functions that
> > assign to "no_warn" have the "warn_unused_result" attribute. The fact
> > that the variable is named "no_warn" seems to indicate that it's meant
> > to remain unused, even if it probably should be checked.
>
> These functions have warn_unused_result set on them because for 99% of
> the time, I want the value to be checked.  But as you can see in this
> use, as per the comments in the code, we do not care about the result
> for a very good reason.  So we just assign it to a variable to make the
> compiler quiet.
>
Right. And because you[1] had to hack around that warning, it led to
another warning. This is typical with hacks.

[1] Okay, maybe not *you* explicitly, but "you" in the general sense
of "the person who wrote this code."

> > Would you rather the warning be turned off on some level?
>
> Which warning?
>
The one this patch is for.

> The code here, as-is, is correct.  We already have 1 compiler warning
> work around in place, do you want to add another one?  How many can we
> stack on top of each other?
>
This one change should suffice.

> And again, why did you not cc: the maintainers of this code for this
> change?  That's not good...
>
I guess the maintainers didn't show up in the scripts/get_maintainers
list when I ran it. I CC'ed everyone that did show up. There's a long
list of emails in the "To" section. I don't know what else to say...

-bw
