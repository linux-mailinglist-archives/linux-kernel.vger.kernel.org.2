Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D398C3D7C56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhG0RkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhG0RkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:40:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3F3C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:40:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h14so23064968lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45mTCumBg2TxGQr2T3T4Elx7M9ijHLu+/MJFsdG0uTc=;
        b=KG8X/0PdzcRLq74LZUof+BLVWGC89fIN/XWxppT6vVZgGCiKxmd2Nh2O4hJEMrRRR+
         H4PO0oXFleHeZAzAl9WpUm5oIKgV/R9xP/UxJ6WLMSqSNtseLX0A8w1ns5qU2BJSKy66
         bXIqTLcOGDqAOT1CuQAGJaBcm5xZ4seuNReZI/Na2IvO55eEJ3ryAJaJwsG/sgzLbp4K
         YNkpoNNSA2FFtphosmFsRNyTNCnbO0Am5XNs0fBYXRXGxzEc5na2uy+l29JwV/UbCpmi
         QyUjbY9MqPo3Ukn8bN3hJerMbEHAToVj/gCXNXGBH5WSsVKZKVeeyOhi8whQYsLjuADv
         lvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45mTCumBg2TxGQr2T3T4Elx7M9ijHLu+/MJFsdG0uTc=;
        b=HiUCrkSlxNf8gi1HSFwF62O44vXpmwgRQw534cGuXfUx9mPXnJvkoCQGdhPB6y7Cdm
         SeTh//eyAXAIkyLsAijuXP4RNFDNVsg3I/kcoCo7Hrd3xIu3m2Qz4cKJ5725IuemtV2k
         zGW9pt7ml1f01O3wRlrZ2GucjsdwiDkaB0V5ba99Z8cpfzTJ1sRpCIykWqdQ/OFSOSC0
         wDa20FUy6i2FFJVg+BfE1fVl7eUzYsBeIseBdadF566jSotHzvN6TIXS33UcdsFP/KUK
         Qr3c1yGJW7D54qs35k4QgFFDfOWy/j4tGEmJyYSeHgk9aADmSML1/ZM3lx8S3lLWNxp5
         dX0w==
X-Gm-Message-State: AOAM530Mjrqtj6EC9kwnv5InWInWRXOmVJ5+cYCpZhomHwblLGgfAWrf
        Jp94xyM8Y1dxmFV5NeopxiQgE6ghRvSvynpXhp44sw==
X-Google-Smtp-Source: ABdhPJxgOsj0srB2b+1E0q3IHD5GePgjGteGp3kTqGJntpt1fkvG1NwchkIcKKyEeaopwiwsXLl2ZlO1I60gsq3+hco=
X-Received: by 2002:ac2:59db:: with SMTP id x27mr17279297lfn.547.1627407600815;
 Tue, 27 Jul 2021 10:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com>
In-Reply-To: <YP+ql3QFYnefR/Cf@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Jul 2021 10:39:49 -0700
Message-ID: <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bill Wendling <morbo@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 26, 2021 at 11:15:52PM -0700, Bill Wendling wrote:
> > On Mon, Jul 26, 2021 at 10:27 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Mon, Jul 26, 2021 at 01:47:33PM -0700, Nathan Chancellor wrote:
> > > > + Greg and Rafael as the maintainer and reviewer of drivers/base/module.c
> > > > respectively, drop everyone else.
> > >
> > > Odd no one cc:ed us originally, I guess they didn't want the patch ever
> > > merged?  :(

Bill,
$ wget https://lore.kernel.org/lkml/20210726201924.3202278-2-morbo@google.com/raw
-O bill.patch
$ ./scripts/get_maintainer.pl bill.patch
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:DRIVER
CORE, KOBJECTS, DEBUGFS AND SYSFS)
"Rafael J. Wysocki" <rafael@kernel.org> (reviewer:DRIVER CORE,
KOBJECTS, DEBUGFS AND SYSFS)
Nathan Chancellor <nathan@kernel.org> (supporter:CLANG/LLVM BUILD SUPPORT)
Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD SUPPORT)
linux-kernel@vger.kernel.org (open list)
clang-built-linux@googlegroups.com (open list:CLANG/LLVM BUILD SUPPORT)

You can use something like this shell function for small patches:

$ which kpatch
kpatch () {
        patch=$1
        shift
        if [[ -d $patch ]]
        then
                echo "Directory given"
        else
                git send-email --cc-cmd="./scripts/get_maintainer.pl
--norolestats $patch" $@ $patch
        fi
}
$ kpatch bill.patch --to "Greg Kroah-Hartman
<gregkh@linuxfoundation.org>" --to "Rafael J. Wysocki
<rafael@kernel.org>"

(I recommend always putting the maintainers or people you'd expect to
pick up the patches in To:.)

> > >
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

What Greg is getting at is that the use of the volatile keyword in
variable declarations is slightly frowned on by the kernel community.
It's less flexible than making accesses volatile qualified via casts.
Then you have flexibility for some accesses to be volatile (ie. not
CSE'd), and some not (ie. CSE'd), if needed.

Though just because you assign to a variable doesn't mean that the
compiler generates an access, especially if the result is unused.
This warning is all about dead stores.  The cast to a volatile
qualified pointer then dereference is what guarantees the access.

https://godbolt.org/z/7K7369bGG

(To be explicit, IMO Greg's point about volatile stores is orthogonal
to discussions about dead stores.)

>
> > Otherwise, the variable itself is never used. A "variable that's
> > written to but not read from," in fact, is the whole reason for the
> > warning.
>
> But that is ok!  Sometimes you need to do this with hardware (like all
> PCI devices).  This is a legitimate code flow for many hardware types
> and if a C compiler thinks that this is not ok, then it is broken.
>
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

I think warn_unused_result should only really be used for functions
where the return value should be used 100% of the time.  If there are
cases where it's ok to not check the return value, consider not using
warn_unused_result on function declarations.

That said, we have a very similar issue throughout LLVM that Bill
should recognize. In LLVM, we have pretty aggressive usage of
assertions.  Rather than:

assert(someReallyLongExpression && "error message");

where that statement might wrap across multiple lines, instead it
might be clearer to write:

bool IsOk = someReallyLongExpression;
assert(IsOk && "error message");

which looks nicer but now produces -Wunused-but-set-variable on IsOk
for release builds where assertions are disabled.  The common fix in
LLVM is to write:

bool IsOk = someReallyLongExpression;
assert(IsOk && "error message");
(void)IsOk;

The cast to void is technically a use that doesn't result in a dead
store.  That pattern could be used in the kernel rather than

int no_warn;
no_warn = warn_unused_result_fn();

at least to avoid -Wunused-but-set-variable.  Oh, looks like a curious
difference between compilers:
https://godbolt.org/z/GvznMM6o1
Filed https://bugs.llvm.org/show_bug.cgi?id=51228.  So I guess we
can't use the cast-to-void to avoid -Wunused-but-set-variable, since
that triggers -Wunused-result, at least with GCC.  :( Nevermind...

Though I still think the use of warn_unused_result on
sysfs_create_link() is worth revisiting.

(Orthogonally, I wonder if C would have been more ergonomic or less to
have all functions implicitly warn_unused_result then have callers be
explicit when they didn't want a result, rather than what we have
today which is the opposite.  Maybe that's a terrible idea, but
sometimes you can't tell until some volume of code has been written in
such a language.  Maybe it makes hello world less pretty, but maybe it
avoids more bugs in real code.)

>
> > Would you rather the warning be turned off on some level?
>
> Which warning?
>
> The code here, as-is, is correct.  We already have 1 compiler warning
> work around in place, do you want to add another one?  How many can we
> stack on top of each other?

Isn't -Wunused-but-set-variable enabled only for W=1 builds?

>
> And again, why did you not cc: the maintainers of this code for this
> change?  That's not good...
>
> thanks,
>
> greg k-h



-- 
Thanks,
~Nick Desaulniers
