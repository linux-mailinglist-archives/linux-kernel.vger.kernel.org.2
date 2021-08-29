Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1503FAE9B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 23:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhH2VBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 17:01:03 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:37847 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhH2VBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 17:01:02 -0400
Date:   Sun, 29 Aug 2021 21:00:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630270807;
        bh=wz6zZHmKi+d39glEis2kDxC7Ii0oe40CPrCIf0zI8ys=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Mr8eciYDm5K8u30m1SFYMb8KMW7+EuCZ1SzC2oY4FM9OFqAVwNodL3mZHbiNAtMZF
         VUFQ7wH/A5anJBvBt5XPhC1Lz+fBsr4JTFDTiH51s5+gA/NOwB/T6TqpKSF1hNE1Ov
         wzxyzH1QHfKK47pQKolt6WtGewRPZ2S9Itk1oLMSOZAIoL7flPry2H+Z06Qaqx+twX
         9U4ILdTEj7/zPOC7DsAn8Qk2W2cHzZKosAK5qBA7HDm2pK5R4He+uTS/BhEZmrhstQ
         2FsSOB8H0al1xClZb4kN2NXt1pjpuJ2eLDo19Rw2yEHZm2Sb/eSQ/+5FYYCsl4O5Lx
         m0OYcc6LmQbSw==
To:     Krish Jain <krishjain02939@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
Message-ID: <20210829205953.63ebc32xlyudsqzg@h510>
In-Reply-To: <CAPGkw+xroJmxa9i6X++un6tQFQ-3F5uMRCatzufWsdfw7cQ2LQ@mail.gmail.com>
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+xTFBeH-x-=dsQK-K5KjZZ7JKmQggz2s26=p7g+71kZjA@mail.gmail.com> <20210829164921.u5ntqk5jz2v3hlgr@h510> <CAPGkw+ypKOVsJF_Guna+9+q-+cApYzdBGHMPKKr6MAzGQtqy2g@mail.gmail.com> <CAPGkw+wGn1oTAO7JXXApDMm4cFfxXam913hOGnnup1nSOpcVPA@mail.gmail.com> <CAPGkw+xroJmxa9i6X++un6tQFQ-3F5uMRCatzufWsdfw7cQ2LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this day, August 29, 2021, thus sayeth Krish Jain:
> Keeping you updated. Small win. The "Symbol version dump
> "Module.symvers" is missing. " error disappeared. Now I still don't
> know why
>

Whoop! Any win, no matter their size, always feel great. I ran around
the house yesterday after cross compiling DOOM! for an armel chip. It's
that "win" feeling you get that keeps me involved.

It is important that you find out why though. What is the importance to
having Module.symvers? and why is it a WARNING and not an ERROR?

What would happen if we didn't have the proper symbols when compiling or
installing this driver?

How and what generates the Module.symvers file when we *do* need it?

How can we turn this warning off when we don't need it?

This is covered in chapter "6. Module Versioning"

  https://www.kernel.org/doc/html/latest/kbuild/modules.html

>
> ERROR: Kernel configuration is invalid."; \
> echo >&2 "         include/generated/autoconf.h or
> include/config/auto.conf are missing.";\
> echo >&2 "         Run 'make oldconfig && make prepare' on kernel src
> to fix it."; \
>
>
> is still present.
>
> How can I fix this?
>

Are there any other 'make *config' options we could try?

What does 'make prepare' even do?

Why do we even need a configuration file?

  https://www.kernel.org/doc/html/latest/kbuild/kconfig.html

>
> Best Regards
>
> On Sun, Aug 29, 2021 at 8:28 PM Krish Jain <krishjain02939@gmail.com> wro=
te:
> >
> > Basically it says "you must have a prebuilt kernel available that
> > contains the configuration and header files used in the build." Since
> > for the staging kernel  "make oldconfig" asked me for  more
> > configurations apart from my old configuration file (as it reads the
> > existing .config file that was used for an old kernel and prompts the
> > user for options in the current kernel source that are not found in
> > the file) . So I *don't* currently have a prebuilt kernel that
> > contains all the configuration in my staging kernel's .config file. So
> > do I have to build the kernel once before I can just build the module
> > with "make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android" ?
> >

What do all these other configuration settings turn on and off anyway?

Do we really need CONFIG_INFINIBAND turned on if we're working in the
drivers/staging tree of the kernel?

What would we gain from having a compiled kernel if we want to test a
single staging driver?

If you found what Module.symvers does, you should know this.

> > > >
> > > > Again, do not allow others to rob you of learning how to solve thes=
e
> > > > issues yourself. I *strongly* encourage you to familiarize yourself=
 with
> > > > the Kernel Build System in the Documentation.
> > > >
> > > >   https://www.kernel.org/doc/html/latest/kbuild/modules.html
> > > >
> > > > Specifically the first paragraph of "2. How to Build External Modul=
es"
> > > >
> > > > It may seem like a lot for such a simple issue but it *is* worth it=
.
> > > > ~Bryan
> > > >
> > >
> > > That section says
> > >
> > >
> > > "To build external modules, *you must have a prebuilt kernel
> > > available* that contains the configuration and header files used in
> > > the build. Also, the kernel must have been built with modules enabled=
.
> > > If you are using a distribution kernel, there will be a package for
> > > the kernel you are running provided by your distribution.
> > >
> > > An alternative is to use the =E2=80=9Cmake=E2=80=9D target =E2=80=
=9Cmodules_prepare.=E2=80=9D This
> > > will make sure the kernel contains the information required. The
> > > target exists solely as a simple way to prepare a kernel source tree
> > > for building external modules.
> > >
> > > NOTE: =E2=80=9Cmodules_prepare=E2=80=9D will not build Module.symvers=
 even if
> > > CONFIG_MODVERSIONS is set; therefore, *a full kernel build needs to b=
e
> > > executed to make module versioning work.*"
> > >
> > > So I am just trying to confirm with you whether I have to first build
> > > the kernel with like "make" or not? As you can imagine my hardware
> > > takes *very* long to build a kernel as I did in my last attempt so I
> > > am asking whether it is needed. Hope you understand.
> > >

I understand. Though I still don't wish to rob you of this opportunity.

Your ability to come up with these questions and answer them yourself is
what will make you a better programmer and developer.

Don't get me wrong. Greg knows all too well the garbage I can shovel his
way. It's not about knowing the answer. It about knowing how to find the
answer yourself.

~Bryan

