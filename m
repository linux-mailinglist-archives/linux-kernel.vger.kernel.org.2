Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31DE3FB63C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhH3MlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhH3MlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:41:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4607DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:40:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j4-20020a17090a734400b0018f6dd1ec97so9882965pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ehJntOoC29/aDdVKocB/Ug4RX2L3GatBa1f/ygdqGyg=;
        b=ZYLCtNbCKbpAUQOaPc+p0j2LMZGyRRdYh7qF0bZp22vhHvZML+XwXqLPfHYtPoZLaC
         76KmNSwi3Ns5IvC4RmK2p5fKVsSRY2sbOxvOfyssL/I6EuBX6bDmtUnhXNFqvUKibOxA
         5ayJTuqLgJG+iij8TqEWWTXbD7xXBlexCKSxXLJrst80RzOv6l5XngBpmdInTB0nIIC/
         gyyBmV3Fb5Dtc7l08s0ddnXSb6I1Os4O7JCHm4Zv+fVmlujqT7P0O2VisU4A+oNzGNPh
         cEzU5aBQKG9ENT6ePIwwpfTx2sH1kiqWzhLpFxm7LMPH8FpmwX4J1UjE+cJXBYDPzgKI
         fqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ehJntOoC29/aDdVKocB/Ug4RX2L3GatBa1f/ygdqGyg=;
        b=MlxVI7tTDmfzTd42YNrtlkxH1aSu2BRpPqIMJw4UghYR11azDJvFwBHYYsmbGdrdD/
         hIq5eAfpmHZmdqARCovbiBVINjLt/sQ5/DiS41A881E8aIRoFkJS8OiyLEihVFlK8nEU
         5mpLgHx7BeSXgRY4ZR9h1Dl8wtiUJdzM9K/VvYXXC2DTAkiniK8Rwn2U0VZQoFUlchnc
         F7aWup410p7TXfwOgjWfPcyjPH/ciK64Kpy2cUyD0y4EBnlbiSGXq6M/4MVbzuFSz2UU
         2BUFFo/WOnir6sQKkf5SnQjO0PJ5gkHA6UGDvNYC+qPR7XK8Dz2rOctVaYxoIdkACL0b
         Ae1w==
X-Gm-Message-State: AOAM530vNpKW1TK0cwMclf0IwCHWuA/Whlt03YxUohJVhs/bZVuSHUWO
        NQpaGN7iDlQ67LBqny9iF2p/EIKJhhHoWdD3SCg=
X-Google-Smtp-Source: ABdhPJyfZeRUKmp0oSzKRpXfTfUvuwST6VnJdZjt7od5XKdJ8al7k7sATncio3/TZt/aNmh3h07YwmVcZMef8lW+42w=
X-Received: by 2002:a17:90a:ec0a:: with SMTP id l10mr4552540pjy.26.1630327211750;
 Mon, 30 Aug 2021 05:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+xTFBeH-x-=dsQK-K5KjZZ7JKmQggz2s26=p7g+71kZjA@mail.gmail.com>
 <20210829164921.u5ntqk5jz2v3hlgr@h510> <CAPGkw+ypKOVsJF_Guna+9+q-+cApYzdBGHMPKKr6MAzGQtqy2g@mail.gmail.com>
 <CAPGkw+wGn1oTAO7JXXApDMm4cFfxXam913hOGnnup1nSOpcVPA@mail.gmail.com>
 <CAPGkw+xroJmxa9i6X++un6tQFQ-3F5uMRCatzufWsdfw7cQ2LQ@mail.gmail.com>
 <20210829205953.63ebc32xlyudsqzg@h510> <CAPGkw+wtE0HMQmYsMkFEt_BPqqB2j_TQ6zwATp6zyXLyxxwTOA@mail.gmail.com>
In-Reply-To: <CAPGkw+wtE0HMQmYsMkFEt_BPqqB2j_TQ6zwATp6zyXLyxxwTOA@mail.gmail.com>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Mon, 30 Aug 2021 14:40:00 +0200
Message-ID: <CAPGkw+w=A1ZBQrmSR2mCgXnfEvhG9tbuJjQ+q1-=Tedwb_XhOA@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

https://pastebin.com/NuvqMUWu is the link to the .config file.
The error I get is https://imgur.com/gkwh7Sb .


Best Regards


On Mon, Aug 30, 2021 at 12:11 AM Krish Jain <krishjain02939@gmail.com> wrot=
e:
>
> On Sun, Aug 29, 2021 at 11:00 PM Bryan Brattlof <hello@bryanbrattlof.com>=
 wrote:
> >
> > On this day, August 29, 2021, thus sayeth Krish Jain:
> > > Keeping you updated. Small win. The "Symbol version dump
> > > "Module.symvers" is missing. " error disappeared. Now I still don't
> > > know why
> > >
> >
> > Whoop! Any win, no matter their size, always feel great. I ran around
> > the house yesterday after cross compiling DOOM! for an armel chip. It's
> > that "win" feeling you get that keeps me involved.
> >
> > It is important that you find out why though. What is the importance to
> > having Module.symvers? and why is it a WARNING and not an ERROR?
>
>  When a module is loaded/used, the values contained in the kernel are
> compared with similar values in the module; if they are not equal, the
> kernel refuses to load the module. I don't need it in my case.
>
> > What would happen if we didn't have the proper symbols when compiling o=
r
> > installing this driver?
> > How and what generates the Module.symvers file when we *do* need it?
>
> The kernel would refuse to load the module.
>
>
>
>
>
> > How can we turn this warning off when we don't need it?
> >
> > This is covered in chapter "6. Module Versioning"
> >
> >   https://www.kernel.org/doc/html/latest/kbuild/modules.html
> >
> > >
> > > ERROR: Kernel configuration is invalid."; \
> > > echo >&2 "         include/generated/autoconf.h or
> > > include/config/auto.conf are missing.";\
> > > echo >&2 "         Run 'make oldconfig && make prepare' on kernel src
> > > to fix it."; \
> > >
> > >
> > > is still present.
> > >
> > > How can I fix this?
> > >
> >
> > Are there any other 'make *config' options we could try?
>
> Yes, like main menuconfig. I tried it but it still doesn't work.
>
> > What does 'make prepare' even do?
>
>
> Prepares for different architectures etc.
>
>
> > Why do we even need a configuration file?
> >
> >   https://www.kernel.org/doc/html/latest/kbuild/kconfig.html
> >
> > >
> > > Best Regards
> > >
> > > On Sun, Aug 29, 2021 at 8:28 PM Krish Jain <krishjain02939@gmail.com>=
 wrote:
> > > >
> > > > Basically it says "you must have a prebuilt kernel available that
> > > > contains the configuration and header files used in the build." Sin=
ce
> > > > for the staging kernel  "make oldconfig" asked me for  more
> > > > configurations apart from my old configuration file (as it reads th=
e
> > > > existing .config file that was used for an old kernel and prompts t=
he
> > > > user for options in the current kernel source that are not found in
> > > > the file) . So I *don't* currently have a prebuilt kernel that
> > > > contains all the configuration in my staging kernel's .config file.=
 So
> > > > do I have to build the kernel once before I can just build the modu=
le
> > > > with "make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android" ?
> > > >
> >
> > What do all these other configuration settings turn on and off anyway?
> >
> > Do we really need CONFIG_INFINIBAND turned on if we're working in the
> > drivers/staging tree of the kernel?
>
>
> No, we don't. I removed it.
>
> > What would we gain from having a compiled kernel if we want to test a
> > single staging driver?
>
> No need to compile the entire kernel I guess for my use case. But
> after all this reading :( I still don't get why " sudo make
> CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android/  V=3D1" worked for y=
ou
> but not for me. I still get the following errors
>
>
> test -e include/generated/autoconf.h -a -e include/config/auto.conf || ( =
\
> echo >&2; \
> echo >&2 "  ERROR: Kernel configuration is invalid."; \
> echo >&2 "         include/generated/autoconf.h or
> include/config/auto.conf are missing.";\
> echo >&2 "         Run 'make oldconfig && make prepare' on kernel src
> to fix it."; \
> echo >&2 ; \
> /bin/false)
> .....
>
>
> How can I fix this?
>
>
>
>
> > If you found what Module.symvers does, you should know this.
> >
> > > > > >
> > > > > > Again, do not allow others to rob you of learning how to solve =
these
> > > > > > issues yourself. I *strongly* encourage you to familiarize your=
self with
> > > > > > the Kernel Build System in the Documentation.
> > > > > >
> > > > > >   https://www.kernel.org/doc/html/latest/kbuild/modules.html
> > > > > >
> > > > > > Specifically the first paragraph of "2. How to Build External M=
odules"
> > > > > >
> > > > > > It may seem like a lot for such a simple issue but it *is* wort=
h it.
> > > > > > ~Bryan
> > > > > >
> > > > >
> > > > > That section says
> > > > >
> > > > >
> > > > > "To build external modules, *you must have a prebuilt kernel
> > > > > available* that contains the configuration and header files used =
in
> > > > > the build. Also, the kernel must have been built with modules ena=
bled.
> > > > > If you are using a distribution kernel, there will be a package f=
or
> > > > > the kernel you are running provided by your distribution.
> > > > >
> > > > > An alternative is to use the =E2=80=9Cmake=E2=80=9D target =E2=80=
=9Cmodules_prepare.=E2=80=9D This
> > > > > will make sure the kernel contains the information required. The
> > > > > target exists solely as a simple way to prepare a kernel source t=
ree
> > > > > for building external modules.
> > > > >
> > > > > NOTE: =E2=80=9Cmodules_prepare=E2=80=9D will not build Module.sym=
vers even if
> > > > > CONFIG_MODVERSIONS is set; therefore, *a full kernel build needs =
to be
> > > > > executed to make module versioning work.*"
> > > > >
> > > > > So I am just trying to confirm with you whether I have to first b=
uild
> > > > > the kernel with like "make" or not? As you can imagine my hardwar=
e
> > > > > takes *very* long to build a kernel as I did in my last attempt s=
o I
> > > > > am asking whether it is needed. Hope you understand.
> > > > >
> >
> > I understand. Though I still don't wish to rob you of this opportunity.
> >
> > Your ability to come up with these questions and answer them yourself i=
s
> > what will make you a better programmer and developer.
> >
> > Don't get me wrong. Greg knows all too well the garbage I can shovel hi=
s
> > way. It's not about knowing the answer. It about knowing how to find th=
e
> > answer yourself.
> >
> > ~Bryan
> >
