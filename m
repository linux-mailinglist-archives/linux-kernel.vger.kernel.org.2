Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0CC3FAED7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhH2WM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbhH2WM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:12:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD86C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 15:11:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so5541398pjc.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lWn3Bwou+Kf1nMYgp9cDWjibnKU0wXoStsKIGvX9v/A=;
        b=ihNwTTQe/p5A9yQjNu2AQMoA0nnTtKLgI8nQQKu8iFOxRJ5iLjhF6hFCcJScWiTVy/
         emoVLcd4Secb02/M4tF0+CSrnGM1E0gDndtaqS31ZFHH+R17WGcOGsS9nceUuOKCGnGW
         fsiCjLk7TOckm37BEMcLFL+C0CW82qjwv5qBspo91HxJXOrY00lPxMneedIapI/vH9jt
         9vhkepf/LEPK2T5CZxCbyiviGMQa0gwff7gmEa65rBGLfX/cC6qy1cBOBzWDRJ7jBY+q
         GxYFcV+c5tjeBfnFj+jglzHDj0ZLfOEbj9JIdShXNLyti5XzKED6wmoZnYFRGihAWvOS
         hyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lWn3Bwou+Kf1nMYgp9cDWjibnKU0wXoStsKIGvX9v/A=;
        b=gVIfKfn9X8Z4X390rtvl79OUmuuXpuylXDsbw0Yb7pvgY8qFTOAGCy4VRPNyctj0RZ
         k25P4Cw0OztLq0+nyC6zZwxbh7jH0ST4qAIUyX0Iwp1EuJbP8SP+qjXR5j1/SYewd44K
         1Jin1a2cumjGg+r/lr1eZRng1iKQ/QUgYwLeVjdSKqICRlsvrICsqn9Jr3rTawTn0Et/
         bHe6nPGdu0CnQMXQ/lQatHuGS1cnVJzU/0fqBvhU0OHXNhhTybExbTb8nb92jQfdiL9Q
         khSaKnOALJcAd9F5+Y/MGnSSQuGK9maQtZXBn6DIvVYP1kmF503TncFJqneznB4b87vJ
         lZPw==
X-Gm-Message-State: AOAM530rUyH1XD1eeG1jUDOhfvQYU2bHWlVlTfiSLnTWGJNIu8x+x2E/
        DFDsWnPJR/jTSSuntc7/7oO7aUQ+UILXBhst4IFlnVh8o7qXo5J0
X-Google-Smtp-Source: ABdhPJxx/P4ra5QpWd5duArZLdcPIpwnYCzDJcQdTyLKMbGhl3SM+TwPUew0ZRRYUl+cSk9xgN4fZjN5aLaYIk6QhW8=
X-Received: by 2002:a17:902:930b:b029:12c:a7f4:afb2 with SMTP id
 bc11-20020a170902930bb029012ca7f4afb2mr18970184plb.24.1630275093687; Sun, 29
 Aug 2021 15:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+xTFBeH-x-=dsQK-K5KjZZ7JKmQggz2s26=p7g+71kZjA@mail.gmail.com>
 <20210829164921.u5ntqk5jz2v3hlgr@h510> <CAPGkw+ypKOVsJF_Guna+9+q-+cApYzdBGHMPKKr6MAzGQtqy2g@mail.gmail.com>
 <CAPGkw+wGn1oTAO7JXXApDMm4cFfxXam913hOGnnup1nSOpcVPA@mail.gmail.com>
 <CAPGkw+xroJmxa9i6X++un6tQFQ-3F5uMRCatzufWsdfw7cQ2LQ@mail.gmail.com> <20210829205953.63ebc32xlyudsqzg@h510>
In-Reply-To: <20210829205953.63ebc32xlyudsqzg@h510>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Mon, 30 Aug 2021 00:11:22 +0200
Message-ID: <CAPGkw+wtE0HMQmYsMkFEt_BPqqB2j_TQ6zwATp6zyXLyxxwTOA@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 11:00 PM Bryan Brattlof <hello@bryanbrattlof.com> w=
rote:
>
> On this day, August 29, 2021, thus sayeth Krish Jain:
> > Keeping you updated. Small win. The "Symbol version dump
> > "Module.symvers" is missing. " error disappeared. Now I still don't
> > know why
> >
>
> Whoop! Any win, no matter their size, always feel great. I ran around
> the house yesterday after cross compiling DOOM! for an armel chip. It's
> that "win" feeling you get that keeps me involved.
>
> It is important that you find out why though. What is the importance to
> having Module.symvers? and why is it a WARNING and not an ERROR?

 When a module is loaded/used, the values contained in the kernel are
compared with similar values in the module; if they are not equal, the
kernel refuses to load the module. I don't need it in my case.

> What would happen if we didn't have the proper symbols when compiling or
> installing this driver?
> How and what generates the Module.symvers file when we *do* need it?

The kernel would refuse to load the module.





> How can we turn this warning off when we don't need it?
>
> This is covered in chapter "6. Module Versioning"
>
>   https://www.kernel.org/doc/html/latest/kbuild/modules.html
>
> >
> > ERROR: Kernel configuration is invalid."; \
> > echo >&2 "         include/generated/autoconf.h or
> > include/config/auto.conf are missing.";\
> > echo >&2 "         Run 'make oldconfig && make prepare' on kernel src
> > to fix it."; \
> >
> >
> > is still present.
> >
> > How can I fix this?
> >
>
> Are there any other 'make *config' options we could try?

Yes, like main menuconfig. I tried it but it still doesn't work.

> What does 'make prepare' even do?


Prepares for different architectures etc.


> Why do we even need a configuration file?
>
>   https://www.kernel.org/doc/html/latest/kbuild/kconfig.html
>
> >
> > Best Regards
> >
> > On Sun, Aug 29, 2021 at 8:28 PM Krish Jain <krishjain02939@gmail.com> w=
rote:
> > >
> > > Basically it says "you must have a prebuilt kernel available that
> > > contains the configuration and header files used in the build." Since
> > > for the staging kernel  "make oldconfig" asked me for  more
> > > configurations apart from my old configuration file (as it reads the
> > > existing .config file that was used for an old kernel and prompts the
> > > user for options in the current kernel source that are not found in
> > > the file) . So I *don't* currently have a prebuilt kernel that
> > > contains all the configuration in my staging kernel's .config file. S=
o
> > > do I have to build the kernel once before I can just build the module
> > > with "make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android" ?
> > >
>
> What do all these other configuration settings turn on and off anyway?
>
> Do we really need CONFIG_INFINIBAND turned on if we're working in the
> drivers/staging tree of the kernel?


No, we don't. I removed it.

> What would we gain from having a compiled kernel if we want to test a
> single staging driver?

No need to compile the entire kernel I guess for my use case. But
after all this reading :( I still don't get why " sudo make
CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android/  V=3D1" worked for you
but not for me. I still get the following errors


test -e include/generated/autoconf.h -a -e include/config/auto.conf || ( \
echo >&2; \
echo >&2 "  ERROR: Kernel configuration is invalid."; \
echo >&2 "         include/generated/autoconf.h or
include/config/auto.conf are missing.";\
echo >&2 "         Run 'make oldconfig && make prepare' on kernel src
to fix it."; \
echo >&2 ; \
/bin/false)
.....


How can I fix this?




> If you found what Module.symvers does, you should know this.
>
> > > > >
> > > > > Again, do not allow others to rob you of learning how to solve th=
ese
> > > > > issues yourself. I *strongly* encourage you to familiarize yourse=
lf with
> > > > > the Kernel Build System in the Documentation.
> > > > >
> > > > >   https://www.kernel.org/doc/html/latest/kbuild/modules.html
> > > > >
> > > > > Specifically the first paragraph of "2. How to Build External Mod=
ules"
> > > > >
> > > > > It may seem like a lot for such a simple issue but it *is* worth =
it.
> > > > > ~Bryan
> > > > >
> > > >
> > > > That section says
> > > >
> > > >
> > > > "To build external modules, *you must have a prebuilt kernel
> > > > available* that contains the configuration and header files used in
> > > > the build. Also, the kernel must have been built with modules enabl=
ed.
> > > > If you are using a distribution kernel, there will be a package for
> > > > the kernel you are running provided by your distribution.
> > > >
> > > > An alternative is to use the =E2=80=9Cmake=E2=80=9D target =E2=80=
=9Cmodules_prepare.=E2=80=9D This
> > > > will make sure the kernel contains the information required. The
> > > > target exists solely as a simple way to prepare a kernel source tre=
e
> > > > for building external modules.
> > > >
> > > > NOTE: =E2=80=9Cmodules_prepare=E2=80=9D will not build Module.symve=
rs even if
> > > > CONFIG_MODVERSIONS is set; therefore, *a full kernel build needs to=
 be
> > > > executed to make module versioning work.*"
> > > >
> > > > So I am just trying to confirm with you whether I have to first bui=
ld
> > > > the kernel with like "make" or not? As you can imagine my hardware
> > > > takes *very* long to build a kernel as I did in my last attempt so =
I
> > > > am asking whether it is needed. Hope you understand.
> > > >
>
> I understand. Though I still don't wish to rob you of this opportunity.
>
> Your ability to come up with these questions and answer them yourself is
> what will make you a better programmer and developer.
>
> Don't get me wrong. Greg knows all too well the garbage I can shovel his
> way. It's not about knowing the answer. It about knowing how to find the
> answer yourself.
>
> ~Bryan
>
