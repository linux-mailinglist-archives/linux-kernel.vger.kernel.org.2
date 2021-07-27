Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F333D7E38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhG0TCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhG0TCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:02:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50839C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:02:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d18so23461643lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcEEZ5DizsTOmmJZcJXignnsvoK6Y8UwOPAH4fOFfVg=;
        b=sT2KLROvmdqyeSq9gUZfrZCkCpV5fvuyuDEMnHA+mUEUuejXjAqRzHEGOVaCI1aw03
         eFpNXHxArfRRafTyP2hIJZPSmwDRGMNEEn2ZSVG9hr4tnquVejhdlJbC1FZLUTUQ15Ya
         L7ru17gyCuwrB4/Ea2y5AUHuKQjwzXQd+btL3565nPgXkgzNrdh8j3hCJ+yDJf1GT3UR
         jqnvWsvxCmjt4Wh3AqcrcVd7cTyvN5Iy2+2lXKtp6/VcLWfZjv2tT/Czcxli/LjgkqD6
         SGNqUOk0DZshaqOCij4NitxMgVzupNvONqE5CB8HVzix0WGfhZ2ZTGAT8nm6mR8es39d
         udoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcEEZ5DizsTOmmJZcJXignnsvoK6Y8UwOPAH4fOFfVg=;
        b=Kj5VmVby+IwbZUxzTuF5nGnKbskZFkMsFAHE+3B9tRX/Y5aVomWRdwS21zusilZM47
         GpGSa1lIgSJTB/zTZ3/pHWq8jGqa88pC2zmoKrN8DElaqrSFMiMwH9j31vHAAk8xxyHB
         CEkKcGvFBcxA0uxhMo1M6972t8wkWpBlv/3rR9tJEz8GeRKeKPfr/h6vVkvMDbTNr1Hh
         czGYNFEOV6qpydXFGZ+1JtSesTdadcKCUiQXvKPO9Sv3BQ2J1CrJrJgetxIVG6gsx0do
         lc4UW8QU1rhVSc81cAyOA/qUce1/3nQn1fnH23JWGqDnon3cht0hnrC5iUxyEzYh5sx9
         rIgg==
X-Gm-Message-State: AOAM532myEKKcqTfHUdcFbUqAIIfm93rtQs7F5sVol2TDHGLgsEwrp40
        SsVarSZbbiasHeYiqpU17uSPowVpewu0AR35SwN9jA==
X-Google-Smtp-Source: ABdhPJylkMZhUDt4uIXbOcMOosSEb8mJDEQSz6R2BYshHysKDy9vxF19Ecc+0ox+UQdDAnmpMCnqIWF5aKwFChPvdbQ=
X-Received: by 2002:a05:6512:3296:: with SMTP id p22mr17292681lfe.543.1627412564309;
 Tue, 27 Jul 2021 12:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com> <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
 <YQBJfAuMJhvd2TcJ@kroah.com> <CAKwvOdkbgr5uPBUC815nrJ_-fHQD2KEYmZ0E8qZRBLL9uQ2WFw@mail.gmail.com>
 <YQBUKrCWpM3uDp/Q@kroah.com>
In-Reply-To: <YQBUKrCWpM3uDp/Q@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Jul 2021 12:02:33 -0700
Message-ID: <CAKwvOdkmwAYCyWYoSntLhJkMTN7UU=09hROABDU8eN193n8-qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:45 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 27, 2021 at 11:31:38AM -0700, Nick Desaulniers wrote:
> > On Tue, Jul 27, 2021 at 10:59 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jul 27, 2021 at 10:39:49AM -0700, Nick Desaulniers wrote:
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
> > >         __unused int error;
> > >
> > >         error = do_thing(...);
> > > }
> > >
> > > Or something else to get the compiler to be quiet about error being set
> > > and never used?  There HAS to be that option somewhere anyway as we need
> > > it for other parts of the kernel where we do:
> > >         write_bus(device, &value);
> > >         value = read_bus(device);
> > > and then we ignore value as it is not needed, but yet we still HAVE to
> > > call read_bus() here, yet read_bus() is set as warn_unused_result()
> > > because, well, it is a read function :)
> >
> > Such wrappers are trivial with __attribute__((alias(""))):
> > https://godbolt.org/z/j5afPbGcM
> >
> > At least then it's very obvious if someone adds more call sites to
> > such an alias. Then that calls for closer inspection in code review
> > that yes, this is one of those 0.01% of cases.  Since they occur 0.01%
> > of the time, I don't expect such aliases to occur too frequently.
>
> That is just, well, horrible.  Seriously horrible.  Wow.

Yeah, well, that's how I feel about warn_unused_result_except_I_didn't_mean_it.

> And that is the "documented" way to do this?  That feels like an abuse
> of the already-horrible-why-do-they-do-that-for-variables use of the
> alias attribute.

You could also use #pragma's to disable the warning locally, with a
good comment about why it's ok to ignore the return code.

> How badly are compiler people going to complain to me about this if
> it's in this file?
> I can take a patch for that, but I feel the comments involved will make
> people, including myself when I have to look a the code again in 5
> years, even more confused...
>
> ick, I feel dirty...
>
> greg k-h

-- 
Thanks,
~Nick Desaulniers
