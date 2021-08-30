Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451D53FB6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhH3NCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 09:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhH3NCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 09:02:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BB1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 06:01:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w8so13369951pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DGaqXG6bmi3iDyt8AzR1s/ABOXV7ZXOmSecZ1y9/9wY=;
        b=csbAoxpCpxOJoE4m82GuH7cz1Mh3v8wmls/HWACe+CGA03gjcBZGObcIo/UODNm8rD
         0fL7MK0LDmSt8xtf8q8OjTL/Pps9wz//qmMy8oxTlwuHLUbK2U1frxGMLoeWITVLuRiv
         7NuWp6QWNrRBE5iikayQ08dJheunreYoFcYB2Oy7kuYmoQjYIVWKt0U+AW22jQxvDs3x
         v2g5uhxEWd5wLNBjabggwXNguUnyg+I8/NesnF41Ht6qjQZdtQ4IppE9zltxh+JRusXz
         ZuuIg9HYs8zi6cPEmuNBx+HC/ERmtOmbTQynEC56NkMVVToHP5eh+aNQFj+ThDSMHJ+3
         UKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DGaqXG6bmi3iDyt8AzR1s/ABOXV7ZXOmSecZ1y9/9wY=;
        b=Pf6k7OT0eWO92mxYXfqIVuC9p8yccOlqY2FBnCPNDurlKTLYGE9prF+d9KOh9WZ+x7
         OHNO9AEA1F8+6tPCeyitnHzy0dq8NbaRLjs6T3EqvS8Q00Ft+LBw3JoOqohPrEL7OTMl
         q1wepWHLOf7D3LD48IBOF9Ovo1EetrqQuRWsALpCVG6Gwm1Sa3+RaQi3HYW+fpaWmu8q
         FELoFVS3JY6p5lBebx+pkJoJV50e73GQyRhXrD+c8HsfozZaZsa4Q9qEMoo937Jn8mlB
         x9QXUYGRgYeR5eU6EjZVciak3DxY6Na6QH4dYxvI25d2F54v6W21zysXYIksElMhFJXR
         bekw==
X-Gm-Message-State: AOAM532ibIRwb/2przhdWIiCVnQQLxLhMf7GrZ5eCBmjIoiqT3q6/fQ3
        AU0fwi167v0NYyVOI/sAt4IGAH1f/VqINk1vT7o=
X-Google-Smtp-Source: ABdhPJz+WaPuEBqNyIA4EiSxTAhrZIgVEL2LfqLsWD1D7oOLA0T/oWYmNsOq31aeWVKvFJunt494YXvc1uJyN8cxtWw=
X-Received: by 2002:a62:1d94:0:b0:3eb:321d:671a with SMTP id
 d142-20020a621d94000000b003eb321d671amr22978720pfd.2.1630328488609; Mon, 30
 Aug 2021 06:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+xTFBeH-x-=dsQK-K5KjZZ7JKmQggz2s26=p7g+71kZjA@mail.gmail.com>
 <20210829164921.u5ntqk5jz2v3hlgr@h510> <CAPGkw+ypKOVsJF_Guna+9+q-+cApYzdBGHMPKKr6MAzGQtqy2g@mail.gmail.com>
 <CAPGkw+wGn1oTAO7JXXApDMm4cFfxXam913hOGnnup1nSOpcVPA@mail.gmail.com>
 <CAPGkw+xroJmxa9i6X++un6tQFQ-3F5uMRCatzufWsdfw7cQ2LQ@mail.gmail.com>
 <20210829205953.63ebc32xlyudsqzg@h510> <CAPGkw+wtE0HMQmYsMkFEt_BPqqB2j_TQ6zwATp6zyXLyxxwTOA@mail.gmail.com>
 <CAPGkw+w=A1ZBQrmSR2mCgXnfEvhG9tbuJjQ+q1-=Tedwb_XhOA@mail.gmail.com>
In-Reply-To: <CAPGkw+w=A1ZBQrmSR2mCgXnfEvhG9tbuJjQ+q1-=Tedwb_XhOA@mail.gmail.com>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Mon, 30 Aug 2021 15:01:17 +0200
Message-ID: <CAPGkw+xzAZxEXBvsFuBLiCRfNvjBxwds7Q-CWeo8RM4Rxmabcw@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One sec this got even more confusing. I saw
https://stackoverflow.com/questions/23184181/error-while-running-make-insta=
ll-include-generated-autoconf-h-or-include-confi
and it says

-------
You are including the V=3D1 which causes Make to show the commands as
they're being run. From the looks of it, you're not actually seeing
the error itself, but you're seeing the test that it's running to
check if those files exist:

test -e include/generated/autoconf.h -a -e include/config/auto.conf ||
( \ ... echo error messages here ... \ )

That test is being run, and if it fails, it would echo those messages
to standard error, which it's not. If your module isn't building it's
probably due to some other issue.
------

So where is it going all wrong? Messing up the file ashmem.c does not
print the errors.


Best Regards

On Mon, Aug 30, 2021 at 2:40 PM Krish Jain <krishjain02939@gmail.com> wrote=
:
>
> Hi.
>
> https://pastebin.com/NuvqMUWu is the link to the .config file.
> The error I get is https://imgur.com/gkwh7Sb .
>
>
> Best Regards
>
>
> On Mon, Aug 30, 2021 at 12:11 AM Krish Jain <krishjain02939@gmail.com> wr=
ote:
> >
> > On Sun, Aug 29, 2021 at 11:00 PM Bryan Brattlof <hello@bryanbrattlof.co=
m> wrote:
> > >
> > > On this day, August 29, 2021, thus sayeth Krish Jain:
> > > > Keeping you updated. Small win. The "Symbol version dump
> > > > "Module.symvers" is missing. " error disappeared. Now I still don't
> > > > know why
> > > >
> > >
> > > Whoop! Any win, no matter their size, always feel great. I ran around
> > > the house yesterday after cross compiling DOOM! for an armel chip. It=
's
> > > that "win" feeling you get that keeps me involved.
> > >
> > > It is important that you find out why though. What is the importance =
to
> > > having Module.symvers? and why is it a WARNING and not an ERROR?
> >
> >  When a module is loaded/used, the values contained in the kernel are
> > compared with similar values in the module; if they are not equal, the
> > kernel refuses to load the module. I don't need it in my case.
> >
> > > What would happen if we didn't have the proper symbols when compiling=
 or
> > > installing this driver?
> > > How and what generates the Module.symvers file when we *do* need it?
> >
> > The kernel would refuse to load the module.
> >
> >
> >
> >
> >
> > > How can we turn this warning off when we don't need it?
> > >
> > > This is covered in chapter "6. Module Versioning"
> > >
> > >   https://www.kernel.org/doc/html/latest/kbuild/modules.html
> > >
> > > >
> > > > ERROR: Kernel configuration is invalid."; \
> > > > echo >&2 "         include/generated/autoconf.h or
> > > > include/config/auto.conf are missing.";\
> > > > echo >&2 "         Run 'make oldconfig && make prepare' on kernel s=
rc
> > > > to fix it."; \
> > > >
> > > >
> > > > is still present.
> > > >
> > > > How can I fix this?
> > > >
> > >
> > > Are there any other 'make *config' options we could try?
> >
> > Yes, like main menuconfig. I tried it but it still doesn't work.
> >
> > > What does 'make prepare' even do?
> >
> >
> > Prepares for different architectures etc.
> >
> >
> > > Why do we even need a configuration file?
> > >
> > >   https://www.kernel.org/doc/html/latest/kbuild/kconfig.html
> > >
> > > >
> > > > Best Regards
> > > >
> > > > On Sun, Aug 29, 2021 at 8:28 PM Krish Jain <krishjain02939@gmail.co=
m> wrote:
> > > > >
> > > > > Basically it says "you must have a prebuilt kernel available that
> > > > > contains the configuration and header files used in the build." S=
ince
> > > > > for the staging kernel  "make oldconfig" asked me for  more
> > > > > configurations apart from my old configuration file (as it reads =
the
> > > > > existing .config file that was used for an old kernel and prompts=
 the
> > > > > user for options in the current kernel source that are not found =
in
> > > > > the file) . So I *don't* currently have a prebuilt kernel that
> > > > > contains all the configuration in my staging kernel's .config fil=
e. So
> > > > > do I have to build the kernel once before I can just build the mo=
dule
> > > > > with "make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android" ?
> > > > >
> > >
> > > What do all these other configuration settings turn on and off anyway=
?
> > >
> > > Do we really need CONFIG_INFINIBAND turned on if we're working in the
> > > drivers/staging tree of the kernel?
> >
> >
> > No, we don't. I removed it.
> >
> > > What would we gain from having a compiled kernel if we want to test a
> > > single staging driver?
> >
> > No need to compile the entire kernel I guess for my use case. But
> > after all this reading :( I still don't get why " sudo make
> > CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android/  V=3D1" worked for=
 you
> > but not for me. I still get the following errors
> >
> >
> > test -e include/generated/autoconf.h -a -e include/config/auto.conf || =
( \
> > echo >&2; \
> > echo >&2 "  ERROR: Kernel configuration is invalid."; \
> > echo >&2 "         include/generated/autoconf.h or
> > include/config/auto.conf are missing.";\
> > echo >&2 "         Run 'make oldconfig && make prepare' on kernel src
> > to fix it."; \
> > echo >&2 ; \
> > /bin/false)
> > .....
> >
> >
> > How can I fix this?
> >
> >
> >
> >
> > > If you found what Module.symvers does, you should know this.
> > >
> > > > > > >
> > > > > > > Again, do not allow others to rob you of learning how to solv=
e these
> > > > > > > issues yourself. I *strongly* encourage you to familiarize yo=
urself with
> > > > > > > the Kernel Build System in the Documentation.
> > > > > > >
> > > > > > >   https://www.kernel.org/doc/html/latest/kbuild/modules.html
> > > > > > >
> > > > > > > Specifically the first paragraph of "2. How to Build External=
 Modules"
> > > > > > >
> > > > > > > It may seem like a lot for such a simple issue but it *is* wo=
rth it.
> > > > > > > ~Bryan
> > > > > > >
> > > > > >
> > > > > > That section says
> > > > > >
> > > > > >
> > > > > > "To build external modules, *you must have a prebuilt kernel
> > > > > > available* that contains the configuration and header files use=
d in
> > > > > > the build. Also, the kernel must have been built with modules e=
nabled.
> > > > > > If you are using a distribution kernel, there will be a package=
 for
> > > > > > the kernel you are running provided by your distribution.
> > > > > >
> > > > > > An alternative is to use the =E2=80=9Cmake=E2=80=9D target =E2=
=80=9Cmodules_prepare.=E2=80=9D This
> > > > > > will make sure the kernel contains the information required. Th=
e
> > > > > > target exists solely as a simple way to prepare a kernel source=
 tree
> > > > > > for building external modules.
> > > > > >
> > > > > > NOTE: =E2=80=9Cmodules_prepare=E2=80=9D will not build Module.s=
ymvers even if
> > > > > > CONFIG_MODVERSIONS is set; therefore, *a full kernel build need=
s to be
> > > > > > executed to make module versioning work.*"
> > > > > >
> > > > > > So I am just trying to confirm with you whether I have to first=
 build
> > > > > > the kernel with like "make" or not? As you can imagine my hardw=
are
> > > > > > takes *very* long to build a kernel as I did in my last attempt=
 so I
> > > > > > am asking whether it is needed. Hope you understand.
> > > > > >
> > >
> > > I understand. Though I still don't wish to rob you of this opportunit=
y.
> > >
> > > Your ability to come up with these questions and answer them yourself=
 is
> > > what will make you a better programmer and developer.
> > >
> > > Don't get me wrong. Greg knows all too well the garbage I can shovel =
his
> > > way. It's not about knowing the answer. It about knowing how to find =
the
> > > answer yourself.
> > >
> > > ~Bryan
> > >
