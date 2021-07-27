Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BE63D7F27
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhG0UWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhG0UWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:22:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB17BC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:22:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gn26so792798ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMG+Pjc0zpd0uNpV6YIb/P6RindR203i0ZHENXhfOys=;
        b=psO33K89BrKYXY3cfhB61uJ9PSC6boj7ts9dzDfwkRBsY+I+iAqJvIsTF2cEOaMZDq
         Yl8d0/COiae8Tn4tOjVWqkjqoprtkt6X5lgXVU3RcgUCQsSfw2tJFDxnHwdjsa2E/PJw
         bg7w8HqVGwHPZDxdwTW6q4iT6ekOSAMXmWbbftMAUvRlGXnUyDN3fP0qV5IiBgq0jp/3
         yjqQ2LGlkBxbRdhdWKU0ykbIvpIMNIQSGSMVW5glAdYWYw89I5+bxPuXIleBUdnXCLPl
         f1Hwqd8BWmiRV702XVCMANy22y92QF+EXd0byD1tBFpGg/D07DuhxPR3F6Wchj2GYjVw
         2u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMG+Pjc0zpd0uNpV6YIb/P6RindR203i0ZHENXhfOys=;
        b=T3bdAnslFCHOJGz80z+yjW6KLc4noofTqb+4Sni9o03uQf1Db5OQx22M6kobG6LBwv
         m+i+5XYWYTbVzY1VYeIgEiFT0yzLpucG76mpggh++BKLlbZauiJH+kAUMGFI7q2qI4Qq
         6g+A2CO1xM4bWzUTuuaSq5qk94Ae73wE4hZ/I2dHN6LoZenKo/L7Be8M2ZK9Iw8uaBss
         GpXKKKl4bcL+706+MiHXt4+E9HHgZilLB67d/AaB4sZjHd/EXz2MOqJA3pX3njNCHxfR
         q26d+6MDcCcRFvT431SdBWC4dMJLH2LaDNrKov25S4mOIk9kgjvon7/sgcBDYM6x1TVO
         8pjQ==
X-Gm-Message-State: AOAM5304LkWfGmTAq6Kqg4rz9uf4BhsjYioDzz+xa5J9BCEFeerYm8l3
        x0qVzAqoNNg1y0lr1Y+Pn9HKB/ItywYiLDPFIaxs
X-Google-Smtp-Source: ABdhPJwdyb/0U2z31KCqdXFX0sF7Ajhn8CxOWsoX2cWizw1jC3Tc+NEqM9tWzDOGNvG08fByi6anvoeDDlImZ5AYlJg=
X-Received: by 2002:a17:906:7951:: with SMTP id l17mr23806775ejo.529.1627417353173;
 Tue, 27 Jul 2021 13:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com> <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
 <YQBJfAuMJhvd2TcJ@kroah.com> <20210727201328.GY1583@gate.crashing.org>
In-Reply-To: <20210727201328.GY1583@gate.crashing.org>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 27 Jul 2021 13:22:21 -0700
Message-ID: <CAGG=3QVWxdYnjZshsYVwf+jVj8Mb9=44SZA64cL0g414JncWGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 1:17 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Tue, Jul 27, 2021 at 07:59:24PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jul 27, 2021 at 10:39:49AM -0700, Nick Desaulniers wrote:
> > > I think warn_unused_result should only really be used for functions
> > > where the return value should be used 100% of the time.
> >
> > I too want a shiny new pony.
> >
> > But here in the real world, sometimes you have functions that for 99% of
> > the users, you do want them to check the return value, but when you use
> > them in core code or startup code, you "know" you are safe to ignore the
> > return value.
> >
> > That is the case here.  We have other fun examples of where people have
> > tried to add error handling to code that runs at boot that have actually
> > introduced security errors and they justify it with "but you have to
> > check error values!"
> >
> > > If there are
> > > cases where it's ok to not check the return value, consider not using
> > > warn_unused_result on function declarations.
> >
> > Ok, so what do you do when you have a function like this where 99.9% of
> > the users need to check this?  Do I really need to write a wrapper
> > function just for it so that I can use it "safely" in the core code
> > instead?
> >
> > Something like:
> >
> > void do_safe_thing_and_ignore_the_world(...)
> > {
> >       __unused int error;
> >
> >       error = do_thing(...);
> > }
> >
> > Or something else to get the compiler to be quiet about error being set
> > and never used?
>
> The simplest is to write
>         if (do_thing()) {
>                 /* Nothing here, we can safely ignore the return value
>                  * here, because of X and Y and I don't know, I have no
>                  * idea actually why we can in this example.  Hopefully
>                  * in real code people do have a good reason :-)
>                  */
>         }
>
> which should work in *any* compiler, doesn't need any extension, is
> quite elegant, and encourages documenting why we ignore the return
> value here.
>
Or better still, use sysfs_create_link_nowarn() instead of
sysfs_create_link(). We'll just have to take the "__must_check"
attribute off the sysfs_create_link_nowarn() declaration.

-bw
