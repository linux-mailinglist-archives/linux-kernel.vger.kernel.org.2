Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42F63D7F32
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhG0UZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhG0UZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:25:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0360BC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:25:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hp25so725292ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AI4/qExA29kX+ZlXltNVAZTRQGQesnOkv1LSMsqDoFE=;
        b=tMYiXAyZOrO7jqe0mTC780X3prSp0zEIc5UIe9x5NT/7FjDTK+Hma1zn1YIl1W2d45
         QSQDseRJsug/Fwjfy7i5tM4QcBnOwEsQO2afVU+XcUptoga+iBhn60589PbGhCtVyIgm
         7l7UWRaJJ4v/My45utwSxpuvyLz9bipEBO6MCbd5I3gcYQk0lkX66JVmRhIuzYEGd9xW
         yae9RLXadL2POqaY+DwHxXz/yKewwNaE82o0hlrDw75vMI/kRQxGr9aekTwFP6B9679s
         ccOUh+cCzx/dhsglwq6dvjeg/SFEmPhkzAYaYK8Fp/7jB6Qltja/baDANcs3BdzFqPby
         WtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AI4/qExA29kX+ZlXltNVAZTRQGQesnOkv1LSMsqDoFE=;
        b=SCkstgpc6B6ZvItC/o4ck+gh8r7mlAFl7mn03qqLviTXcMAi8h27AxtlQSha7CxHeO
         cXkz2Q16UJFp7JT5lMHiaAF1ucXSJJ2uN5BFfgXq90EeNsNUQ3RwxLyrzqWJUNbkAloK
         SI/zK38LizY6D/fYlvSepQ9UuYh17+KIMhEj1CpD3KT68frqlZHxO1q1SiUZMfOGQC4q
         Yjwh0CtU+TbH4aisLdTLtYtzfU0QTj6OtUz1QTYnroDRpPXNC68nh/u9EDa5hmzK86eL
         p0LCaeUvTTU/SAJxLmQ8TRV0ICfn5ZAYGhJrye3i3yvLTIabRdD931eKz0I3QfXczRnI
         UCBw==
X-Gm-Message-State: AOAM532ASBJPSLIZSAhBpsKE4mwswnfJMpAOMBT1dxT/Q5CtZihsqI+i
        xqKt9hcoujxiEjyHV2yHil54OOdaIuMAZDc8fgp6
X-Google-Smtp-Source: ABdhPJw5XiHIHg6ae8uV3WrVdFrxw1uvMxCloM4AI8JGRZKEEHOrSXAfx185ENkDdDaMeEbQ9KhcFwvY6OSTrZEcBro=
X-Received: by 2002:a17:906:468d:: with SMTP id a13mr24138094ejr.419.1627417500385;
 Tue, 27 Jul 2021 13:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com> <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
 <YQBJfAuMJhvd2TcJ@kroah.com> <20210727201328.GY1583@gate.crashing.org> <CAGG=3QVWxdYnjZshsYVwf+jVj8Mb9=44SZA64cL0g414JncWGw@mail.gmail.com>
In-Reply-To: <CAGG=3QVWxdYnjZshsYVwf+jVj8Mb9=44SZA64cL0g414JncWGw@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 27 Jul 2021 13:24:49 -0700
Message-ID: <CAGG=3QUgnahba_-6hk6VoZW4T3a_Qa2KTBx4+DswNf_KBEWOmw@mail.gmail.com>
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

On Tue, Jul 27, 2021 at 1:22 PM Bill Wendling <morbo@google.com> wrote:
>
> On Tue, Jul 27, 2021 at 1:17 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > On Tue, Jul 27, 2021 at 07:59:24PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jul 27, 2021 at 10:39:49AM -0700, Nick Desaulniers wrote:
> > > > I think warn_unused_result should only really be used for functions
> > > > where the return value should be used 100% of the time.
> > >
> > > I too want a shiny new pony.
> > >
> > > But here in the real world, sometimes you have functions that for 99% of
> > > the users, you do want them to check the return value, but when you use
> > > them in core code or startup code, you "know" you are safe to ignore the
> > > return value.
> > >
> > > That is the case here.  We have other fun examples of where people have
> > > tried to add error handling to code that runs at boot that have actually
> > > introduced security errors and they justify it with "but you have to
> > > check error values!"
> > >
> > > > If there are
> > > > cases where it's ok to not check the return value, consider not using
> > > > warn_unused_result on function declarations.
> > >
> > > Ok, so what do you do when you have a function like this where 99.9% of
> > > the users need to check this?  Do I really need to write a wrapper
> > > function just for it so that I can use it "safely" in the core code
> > > instead?
> > >
> > > Something like:
> > >
> > > void do_safe_thing_and_ignore_the_world(...)
> > > {
> > >       __unused int error;
> > >
> > >       error = do_thing(...);
> > > }
> > >
> > > Or something else to get the compiler to be quiet about error being set
> > > and never used?
> >
> > The simplest is to write
> >         if (do_thing()) {
> >                 /* Nothing here, we can safely ignore the return value
> >                  * here, because of X and Y and I don't know, I have no
> >                  * idea actually why we can in this example.  Hopefully
> >                  * in real code people do have a good reason :-)
> >                  */
> >         }
> >
> > which should work in *any* compiler, doesn't need any extension, is
> > quite elegant, and encourages documenting why we ignore the return
> > value here.
> >
> Or better still, use sysfs_create_link_nowarn() instead of
> sysfs_create_link(). We'll just have to take the "__must_check"
> attribute off the sysfs_create_link_nowarn() declaration.
>
Strike that. I mistook the nowarn.
-bw
