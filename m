Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465733D7DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhG0SpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0SpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:45:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2B3B60F9E;
        Tue, 27 Jul 2021 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627411500;
        bh=v57DgBNvmeqirO4JsBMcPzDZ5h2ihzb/QkuymdY559Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=luPjGCY16ahdowVwdbkAR5x4M7Ggpmr/adW5bCBeoda1BQ802QASAcxG+3oGuAtTg
         yDXM0DKXhHwE7IgJqqbNU26DCBWUmNF18o6zDVrRDIL04Xdyoz4CRf1L8QBdIUbiln
         XQI0JE2XFBHJDjZYmgCT1pfr1XkaNkHyF0n6kEEs=
Date:   Tue, 27 Jul 2021 20:44:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
Message-ID: <YQBUKrCWpM3uDp/Q@kroah.com>
References: <20210714091747.2814370-1-morbo@google.com>
 <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com>
 <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com>
 <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com>
 <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
 <YQBJfAuMJhvd2TcJ@kroah.com>
 <CAKwvOdkbgr5uPBUC815nrJ_-fHQD2KEYmZ0E8qZRBLL9uQ2WFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkbgr5uPBUC815nrJ_-fHQD2KEYmZ0E8qZRBLL9uQ2WFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:31:38AM -0700, Nick Desaulniers wrote:
> On Tue, Jul 27, 2021 at 10:59 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jul 27, 2021 at 10:39:49AM -0700, Nick Desaulniers wrote:
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
> >         __unused int error;
> >
> >         error = do_thing(...);
> > }
> >
> > Or something else to get the compiler to be quiet about error being set
> > and never used?  There HAS to be that option somewhere anyway as we need
> > it for other parts of the kernel where we do:
> >         write_bus(device, &value);
> >         value = read_bus(device);
> > and then we ignore value as it is not needed, but yet we still HAVE to
> > call read_bus() here, yet read_bus() is set as warn_unused_result()
> > because, well, it is a read function :)
> 
> Such wrappers are trivial with __attribute__((alias(""))):
> https://godbolt.org/z/j5afPbGcM
> 
> At least then it's very obvious if someone adds more call sites to
> such an alias. Then that calls for closer inspection in code review
> that yes, this is one of those 0.01% of cases.  Since they occur 0.01%
> of the time, I don't expect such aliases to occur too frequently.

That is just, well, horrible.  Seriously horrible.  Wow.

And that is the "documented" way to do this?  That feels like an abuse
of the already-horrible-why-do-they-do-that-for-variables use of the
alias attribute.

How badly are compiler people going to complain to me about this if
it's in this file?

I can take a patch for that, but I feel the comments involved will make
people, including myself when I have to look a the code again in 5
years, even more confused...

ick, I feel dirty...

greg k-h
