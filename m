Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD63D7CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhG0R72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhG0R71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:59:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 355AE60F11;
        Tue, 27 Jul 2021 17:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627408766;
        bh=qcnOTXvQQRLrEpMDfnNsMx0CgBFaL4s67ION9/yXglY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Od+86odsfNiQoLt2LFFLrZZcT+/AZFciKkWT/e06V3Jkv+bz0zej6eArv3gc2hv9J
         AJV8DOZkqXHXqh3GB7lHB9AbKE3Z5i8GbbiGwKLyiOq3A4Qt4Qjklcpz0YVVnAZFAi
         u8XsOMwQgOS5h1/8wOuF1OcxgKHUYR3swDbIIj8c=
Date:   Tue, 27 Jul 2021 19:59:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
Message-ID: <YQBJfAuMJhvd2TcJ@kroah.com>
References: <20210714091747.2814370-1-morbo@google.com>
 <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com>
 <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com>
 <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com>
 <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:39:49AM -0700, Nick Desaulniers wrote:
> > > > > Original post:
> > > > >
> > > > > https://lore.kernel.org/r/20210726201924.3202278-2-morbo@google.com/
> > > > >
> > > > > On 7/26/2021 1:19 PM, 'Bill Wendling' via Clang Built Linux wrote:
> > > > > > Fix the following build warning:
> > > > > >
> > > > > >    drivers/base/module.c:36:6: error: variable 'no_warn' set but not used [-Werror,-Wunused-but-set-variable]
> > > > > >          int no_warn;
> > > >
> > > > That's not going to be a good warning to ever have the kernel use due to
> > > > how lots of hardware works (i.e. we need to do a read after a write but
> > > > we can throw the read away as it does not matter).
> > > >
> > > >
> > > > > >
> > > > > > This variable is used to remove another warning, but causes a warning
> > > > > > itself. Mark it as 'unused' to avoid that.
> > > > > >
> > > > > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > > >
> > > > > Even though they evaluate to the same thing, it might be worth using
> > > > > "__always_unused" here because it is :)
> > > >
> > > > But it is not unused, the value is written into it.
> > > >
> > > I believe that only matters if the variable is marked "volatile".
> >
> > "volatile" means nothing anymore, never use it or even think about it
> > again please :)
> 
> What Greg is getting at is that the use of the volatile keyword in
> variable declarations is slightly frowned on by the kernel community.
> It's less flexible than making accesses volatile qualified via casts.
> Then you have flexibility for some accesses to be volatile (ie. not
> CSE'd), and some not (ie. CSE'd), if needed.
> 
> Though just because you assign to a variable doesn't mean that the
> compiler generates an access, especially if the result is unused.
> This warning is all about dead stores.  The cast to a volatile
> qualified pointer then dereference is what guarantees the access.
> 
> https://godbolt.org/z/7K7369bGG
> 
> (To be explicit, IMO Greg's point about volatile stores is orthogonal
> to discussions about dead stores.)

I didn't bring up that dirty word, Bill did :)

> > > Otherwise, the variable itself is never used. A "variable that's
> > > written to but not read from," in fact, is the whole reason for the
> > > warning.
> >
> > But that is ok!  Sometimes you need to do this with hardware (like all
> > PCI devices).  This is a legitimate code flow for many hardware types
> > and if a C compiler thinks that this is not ok, then it is broken.
> >
> > So be VERY careful when changing drivers based on this warning.  Because
> > of this, I do not think you can enable it over the whole kernel without
> > causing major problems in some areas.
> >
> > But that is independent of this specific issue you are trying to patch
> > here, I say this to warn you of a number of stupid places where people
> > have tried to "optimize away" reads based on this compiler warning in
> > drivers, and we have had to add them back because it broke
> > functionality.
> >
> > > > So this isn't ok, sometimes we want to write to variables but never care
> > > > about the value, that does not mean the compiler should complain about
> > > > it.
> > > >
> > > Typically, if you don't care about the return value, you simply don't
> > > assign it to a variable (cf. printf). However, the functions that
> > > assign to "no_warn" have the "warn_unused_result" attribute. The fact
> > > that the variable is named "no_warn" seems to indicate that it's meant
> > > to remain unused, even if it probably should be checked.
> >
> > These functions have warn_unused_result set on them because for 99% of
> > the time, I want the value to be checked.  But as you can see in this
> > use, as per the comments in the code, we do not care about the result
> > for a very good reason.  So we just assign it to a variable to make the
> > compiler quiet.
> 
> I think warn_unused_result should only really be used for functions
> where the return value should be used 100% of the time.

I too want a shiny new pony.

But here in the real world, sometimes you have functions that for 99% of
the users, you do want them to check the return value, but when you use
them in core code or startup code, you "know" you are safe to ignore the
return value.

That is the case here.  We have other fun examples of where people have
tried to add error handling to code that runs at boot that have actually
introduced security errors and they justify it with "but you have to
check error values!"

> If there are
> cases where it's ok to not check the return value, consider not using
> warn_unused_result on function declarations.

Ok, so what do you do when you have a function like this where 99.9% of
the users need to check this?  Do I really need to write a wrapper
function just for it so that I can use it "safely" in the core code
instead?

Something like:

void do_safe_thing_and_ignore_the_world(...)
{
	__unused int error;

	error = do_thing(...);
}

Or something else to get the compiler to be quiet about error being set
and never used?  There HAS to be that option somewhere anyway as we need
it for other parts of the kernel where we do:
	write_bus(device, &value);
	value = read_bus(device);
and then we ignore value as it is not needed, but yet we still HAVE to
call read_bus() here, yet read_bus() is set as warn_unused_result()
because, well, it is a read function :)

> That said, we have a very similar issue throughout LLVM that Bill
> should recognize. In LLVM, we have pretty aggressive usage of
> assertions.  Rather than:
> 
> assert(someReallyLongExpression && "error message");
> 
> where that statement might wrap across multiple lines, instead it
> might be clearer to write:
> 
> bool IsOk = someReallyLongExpression;
> assert(IsOk && "error message");
> 
> which looks nicer but now produces -Wunused-but-set-variable on IsOk
> for release builds where assertions are disabled.  The common fix in
> LLVM is to write:
> 
> bool IsOk = someReallyLongExpression;
> assert(IsOk && "error message");
> (void)IsOk;
> 
> The cast to void is technically a use that doesn't result in a dead
> store.  That pattern could be used in the kernel rather than
> 
> int no_warn;
> no_warn = warn_unused_result_fn();
> 
> at least to avoid -Wunused-but-set-variable.  Oh, looks like a curious
> difference between compilers:
> https://godbolt.org/z/GvznMM6o1
> Filed https://bugs.llvm.org/show_bug.cgi?id=51228.  So I guess we
> can't use the cast-to-void to avoid -Wunused-but-set-variable, since
> that triggers -Wunused-result, at least with GCC.  :( Nevermind...
> 
> Though I still think the use of warn_unused_result on
> sysfs_create_link() is worth revisiting.

Nope, not at all, I WANT users to check this as it is something that has
caused problems in drivers and subsystems in the past.

And doing the (void)sysfs_create_link(); hack is horrid, I thought we
were better than that.

Surely there is a "this variable is going to be assigned something but
never used" option somewhere?  This can't be the first time it has come
up, right?

> > > Would you rather the warning be turned off on some level?
> >
> > Which warning?
> >
> > The code here, as-is, is correct.  We already have 1 compiler warning
> > work around in place, do you want to add another one?  How many can we
> > stack on top of each other?
> 
> Isn't -Wunused-but-set-variable enabled only for W=1 builds?

No idea, as long as it is not a normal build option, that's fine.  "W=1"
is for kernel newbies wanting to clean up subsystems and get some patch
counts merged :)

thanks,

greg k-h
