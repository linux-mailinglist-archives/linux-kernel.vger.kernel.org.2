Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2F3D6F93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhG0Gla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234349AbhG0Gl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:41:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1522B610CC;
        Tue, 27 Jul 2021 06:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627368089;
        bh=AoyWoF1D5doHgtd19s96Flzqjdd4xHkWhHEHb4V+3qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUo++3tvzYTMJSncnVs5K7CLlUKIzSM74Espnl1hzcqqZrcRKEkNx0OegX7xpU+46
         aMkSJFBNVOU1GuCvpquKtcNX9symC83F561NqnNLsiaRY0I/vPrtIDHghJZxl+H0p+
         SGi20GHhFrhKlmCYn31XidHMigIpvv4LaQFv+ckY=
Date:   Tue, 27 Jul 2021 08:41:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
Message-ID: <YP+ql3QFYnefR/Cf@kroah.com>
References: <20210714091747.2814370-1-morbo@google.com>
 <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com>
 <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com>
 <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:15:52PM -0700, Bill Wendling wrote:
> On Mon, Jul 26, 2021 at 10:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Jul 26, 2021 at 01:47:33PM -0700, Nathan Chancellor wrote:
> > > + Greg and Rafael as the maintainer and reviewer of drivers/base/module.c
> > > respectively, drop everyone else.
> >
> > Odd no one cc:ed us originally, I guess they didn't want the patch ever
> > merged?  :(
> >
> > >
> > > Original post:
> > >
> > > https://lore.kernel.org/r/20210726201924.3202278-2-morbo@google.com/
> > >
> > > On 7/26/2021 1:19 PM, 'Bill Wendling' via Clang Built Linux wrote:
> > > > Fix the following build warning:
> > > >
> > > >    drivers/base/module.c:36:6: error: variable 'no_warn' set but not used [-Werror,-Wunused-but-set-variable]
> > > >          int no_warn;
> >
> > That's not going to be a good warning to ever have the kernel use due to
> > how lots of hardware works (i.e. we need to do a read after a write but
> > we can throw the read away as it does not matter).
> >
> >
> > > >
> > > > This variable is used to remove another warning, but causes a warning
> > > > itself. Mark it as 'unused' to avoid that.
> > > >
> > > > Signed-off-by: Bill Wendling <morbo@google.com>
> > >
> > > Even though they evaluate to the same thing, it might be worth using
> > > "__always_unused" here because it is :)
> >
> > But it is not unused, the value is written into it.
> >
> I believe that only matters if the variable is marked "volatile".

"volatile" means nothing anymore, never use it or even think about it
again please :)

> Otherwise, the variable itself is never used. A "variable that's
> written to but not read from," in fact, is the whole reason for the
> warning.

But that is ok!  Sometimes you need to do this with hardware (like all
PCI devices).  This is a legitimate code flow for many hardware types
and if a C compiler thinks that this is not ok, then it is broken.

So be VERY careful when changing drivers based on this warning.  Because
of this, I do not think you can enable it over the whole kernel without
causing major problems in some areas.

But that is independent of this specific issue you are trying to patch
here, I say this to warn you of a number of stupid places where people
have tried to "optimize away" reads based on this compiler warning in
drivers, and we have had to add them back because it broke
functionality.

> > So this isn't ok, sometimes we want to write to variables but never care
> > about the value, that does not mean the compiler should complain about
> > it.
> >
> Typically, if you don't care about the return value, you simply don't
> assign it to a variable (cf. printf). However, the functions that
> assign to "no_warn" have the "warn_unused_result" attribute. The fact
> that the variable is named "no_warn" seems to indicate that it's meant
> to remain unused, even if it probably should be checked.

These functions have warn_unused_result set on them because for 99% of
the time, I want the value to be checked.  But as you can see in this
use, as per the comments in the code, we do not care about the result
for a very good reason.  So we just assign it to a variable to make the
compiler quiet.

> Would you rather the warning be turned off on some level?

Which warning?

The code here, as-is, is correct.  We already have 1 compiler warning
work around in place, do you want to add another one?  How many can we
stack on top of each other?

And again, why did you not cc: the maintainers of this code for this
change?  That's not good...

thanks,

greg k-h
