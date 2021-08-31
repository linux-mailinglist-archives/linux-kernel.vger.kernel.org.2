Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911483FC017
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbhHaAny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhHaAnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:43:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB1DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:42:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n18so171475plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dydrTkuTP4UBLj9uXSmZMEGcaNGcaFtlgeTlkGhohW0=;
        b=altkSfrtET+OA79UAgdZFq+eZzw1i6/nhYbaMnfOiJcz8AqorGiE+iW3t2MF6v6FPT
         C+ZOekoAMbr2pnT+ZXP5g5DN5qgUIBUnsVGVJdsfKKSXVB8nrbOPhH1sT1RKR1kGExB+
         bVIDPLA06085SdOelJUmB9DRVF9CUxeS6SuuG1Um/s7IPnLUdLGy4RV9C/ZWlaMX89lS
         mIlPgoMOGLuKZQIuOD7wzU0OUIJo6Ms7RngLlvGoXM92viXGYs5HNLJHUl7bjPSyKL9l
         ZeFMQhkId3skcKLUXcq+heQEHTtSYZcr6MfDPsDFEewUhX1ORcGt0bc6BLrr8A2BIPRL
         95FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dydrTkuTP4UBLj9uXSmZMEGcaNGcaFtlgeTlkGhohW0=;
        b=GIVq1O2MevPNItkWZvkzwDsy3X4b0qderEAbuCZXM9tp/1wovyVglAc/KWkl58heOw
         PHnUlsP8A5M2gNvBq6UaLB011Hi1T2VK3N+OtCVsDzl0Pr3WevzKUW30acIBNIGbM491
         pmlMn66BCvTC+gJnSovzCJ5DvXqR27ofzCjEt2y8QD6Z1xYr8RmfmF/vK8wH4giHS/Mo
         OshE8U58dpGgFbuULH8St5nYgPlsntSViFHNhCmulXEfstOVd4pTQEANF6nMMp7xHHrR
         +tZB77ByVSgJW3FGZqPfS9MkchaRyFnr/8Z/TCOglqOQqDrgo2k37wgC//3D6sBIEhQE
         uHCg==
X-Gm-Message-State: AOAM5318FxUMX1eSSO034kQrt6+1mbnV34bbdWbU3USEGhUE11txr0vi
        OqbcgHGVtaxTRZq3CN3SlbO90Z7Tz887UaVV1ek=
X-Google-Smtp-Source: ABdhPJzaSSxv9aiXIWJbrUhwt2o44Sq41r751KI31/SlYC0gFfkCINGQhiY03esKXZHnEpRCrCwl/p3ED6OzLHWqJeE=
X-Received: by 2002:a17:90a:8801:: with SMTP id s1mr2029181pjn.166.1630370577974;
 Mon, 30 Aug 2021 17:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+xTFBeH-x-=dsQK-K5KjZZ7JKmQggz2s26=p7g+71kZjA@mail.gmail.com>
 <20210829164921.u5ntqk5jz2v3hlgr@h510> <CAPGkw+ypKOVsJF_Guna+9+q-+cApYzdBGHMPKKr6MAzGQtqy2g@mail.gmail.com>
 <CAPGkw+wGn1oTAO7JXXApDMm4cFfxXam913hOGnnup1nSOpcVPA@mail.gmail.com>
 <CAPGkw+xroJmxa9i6X++un6tQFQ-3F5uMRCatzufWsdfw7cQ2LQ@mail.gmail.com>
 <20210829205953.63ebc32xlyudsqzg@h510> <CAPGkw+wtE0HMQmYsMkFEt_BPqqB2j_TQ6zwATp6zyXLyxxwTOA@mail.gmail.com>
 <CAPGkw+w=A1ZBQrmSR2mCgXnfEvhG9tbuJjQ+q1-=Tedwb_XhOA@mail.gmail.com> <CAPGkw+xzAZxEXBvsFuBLiCRfNvjBxwds7Q-CWeo8RM4Rxmabcw@mail.gmail.com>
In-Reply-To: <CAPGkw+xzAZxEXBvsFuBLiCRfNvjBxwds7Q-CWeo8RM4Rxmabcw@mail.gmail.com>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Tue, 31 Aug 2021 02:42:46 +0200
Message-ID: <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, could someone help with this? Still stuck. Maybe someone else has
some insight into this issue too? Or Greg or Bryan.

Thanks

On Mon, Aug 30, 2021 at 3:01 PM Krish Jain <krishjain02939@gmail.com> wrote=
:
>
> One sec this got even more confusing. I saw
> https://stackoverflow.com/questions/23184181/error-while-running-make-ins=
tall-include-generated-autoconf-h-or-include-confi
> and it says
>
> -------
> You are including the V=3D1 which causes Make to show the commands as
> they're being run. From the looks of it, you're not actually seeing
> the error itself, but you're seeing the test that it's running to
> check if those files exist:
>
> test -e include/generated/autoconf.h -a -e include/config/auto.conf ||
> ( \ ... echo error messages here ... \ )
>
> That test is being run, and if it fails, it would echo those messages
> to standard error, which it's not. If your module isn't building it's
> probably due to some other issue.
> ------
>
> So where is it going all wrong? Messing up the file ashmem.c does not
> print the errors.
>
>
> Best Regards
>
> On Mon, Aug 30, 2021 at 2:40 PM Krish Jain <krishjain02939@gmail.com> wro=
te:
> >
> > Hi.
> >
> > https://pastebin.com/NuvqMUWu is the link to the .config file.
> > The error I get is https://imgur.com/gkwh7Sb .
> >
> >
> > Best Regards
> >
> >
> > On Mon, Aug 30, 2021 at 12:11 AM Krish Jain <krishjain02939@gmail.com> =
wrote:
> > >
> > > On Sun, Aug 29, 2021 at 11:00 PM Bryan Brattlof <hello@bryanbrattlof.=
com> wrote:
> > > >
> > > > On this day, August 29, 2021, thus sayeth Krish Jain:
> > > > > Keeping you updated. Small win. The "Symbol version dump
> > > > > "Module.symvers" is missing. " error disappeared. Now I still don=
't
> > > > > know why
> > > > >
> > > >
> > > > Whoop! Any win, no matter their size, always feel great. I ran arou=
nd
> > > > the house yesterday after cross compiling DOOM! for an armel chip. =
It's
> > > > that "win" feeling you get that keeps me involved.
> > > >
> > > > It is important that you find out why though. What is the importanc=
e to
> > > > having Module.symvers? and why is it a WARNING and not an ERROR?
> > >
> > >  When a module is loaded/used, the values contained in the kernel are
> > > compared with similar values in the module; if they are not equal, th=
e
> > > kernel refuses to load the module. I don't need it in my case.
> > >
> > > > What would happen if we didn't have the proper symbols when compili=
ng or
> > > > installing this driver?
> > > > How and what generates the Module.symvers file when we *do* need it=
?
> > >
> > > The kernel would refuse to load the module.
> > >
> > >
> > >
> > >
> > >
> > > > How can we turn this warning off when we don't need it?
> > > >
> > > > This is covered in chapter "6. Module Versioning"
> > > >
> > > >   https://www.kernel.org/doc/html/latest/kbuild/modules.html
> > > >
> > > > >
> > > > > ERROR: Kernel configuration is invalid."; \
> > > > > echo >&2 "         include/generated/autoconf.h or
> > > > > include/config/auto.conf are missing.";\
> > > > > echo >&2 "         Run 'make oldconfig && make prepare' on kernel=
 src
> > > > > to fix it."; \
> > > > >
> > > > >
> > > > > is still present.
> > > > >
> > > > > How can I fix this?
> > > > >
> > > >
> > > > Are there any other 'make *config' options we could try?
> > >
> > > Yes, like main menuconfig. I tried it but it still doesn't work.
> > >
> > > > What does 'make prepare' even do?
> > >
> > >
> > > Prepares for different architectures etc.
> > >
> > >
> > > > Why do we even need a configuration file?
> > > >
> > > >   https://www.kernel.org/doc/html/latest/kbuild/kconfig.html
> > > >
> > > > >
> > > > > Best Regards
> > > > >
> > > > > On Sun, Aug 29, 2021 at 8:28 PM Krish Jain <krishjain02939@gmail.=
com> wrote:
> > > > > >
> > > > > > Basically it says "you must have a prebuilt kernel available th=
at
> > > > > > contains the configuration and header files used in the build."=
 Since
> > > > > > for the staging kernel  "make oldconfig" asked me for  more
> > > > > > configurations apart from my old configuration file (as it read=
s the
> > > > > > existing .config file that was used for an old kernel and promp=
ts the
> > > > > > user for options in the current kernel source that are not foun=
d in
> > > > > > the file) . So I *don't* currently have a prebuilt kernel that
> > > > > > contains all the configuration in my staging kernel's .config f=
ile. So
> > > > > > do I have to build the kernel once before I can just build the =
module
> > > > > > with "make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android"=
 ?
> > > > > >
> > > >
> > > > What do all these other configuration settings turn on and off anyw=
ay?
> > > >
> > > > Do we really need CONFIG_INFINIBAND turned on if we're working in t=
he
> > > > drivers/staging tree of the kernel?
> > >
> > >
> > > No, we don't. I removed it.
> > >
> > > > What would we gain from having a compiled kernel if we want to test=
 a
> > > > single staging driver?
> > >
> > > No need to compile the entire kernel I guess for my use case. But
> > > after all this reading :( I still don't get why " sudo make
> > > CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android/  V=3D1" worked f=
or you
> > > but not for me. I still get the following errors
> > >
> > >
> > > test -e include/generated/autoconf.h -a -e include/config/auto.conf |=
| ( \
> > > echo >&2; \
> > > echo >&2 "  ERROR: Kernel configuration is invalid."; \
> > > echo >&2 "         include/generated/autoconf.h or
> > > include/config/auto.conf are missing.";\
> > > echo >&2 "         Run 'make oldconfig && make prepare' on kernel src
> > > to fix it."; \
> > > echo >&2 ; \
> > > /bin/false)
> > > .....
> > >
> > >
> > > How can I fix this?
> > >
> > >
> > >
> > >
> > > > If you found what Module.symvers does, you should know this.
> > > >
> > > > > > > >
> > > > > > > > Again, do not allow others to rob you of learning how to so=
lve these
> > > > > > > > issues yourself. I *strongly* encourage you to familiarize =
yourself with
> > > > > > > > the Kernel Build System in the Documentation.
> > > > > > > >
> > > > > > > >   https://www.kernel.org/doc/html/latest/kbuild/modules.htm=
l
> > > > > > > >
> > > > > > > > Specifically the first paragraph of "2. How to Build Extern=
al Modules"
> > > > > > > >
> > > > > > > > It may seem like a lot for such a simple issue but it *is* =
worth it.
> > > > > > > > ~Bryan
> > > > > > > >
> > > > > > >
> > > > > > > That section says
> > > > > > >
> > > > > > >
> > > > > > > "To build external modules, *you must have a prebuilt kernel
> > > > > > > available* that contains the configuration and header files u=
sed in
> > > > > > > the build. Also, the kernel must have been built with modules=
 enabled.
> > > > > > > If you are using a distribution kernel, there will be a packa=
ge for
> > > > > > > the kernel you are running provided by your distribution.
> > > > > > >
> > > > > > > An alternative is to use the =E2=80=9Cmake=E2=80=9D target =
=E2=80=9Cmodules_prepare.=E2=80=9D This
> > > > > > > will make sure the kernel contains the information required. =
The
> > > > > > > target exists solely as a simple way to prepare a kernel sour=
ce tree
> > > > > > > for building external modules.
> > > > > > >
> > > > > > > NOTE: =E2=80=9Cmodules_prepare=E2=80=9D will not build Module=
.symvers even if
> > > > > > > CONFIG_MODVERSIONS is set; therefore, *a full kernel build ne=
eds to be
> > > > > > > executed to make module versioning work.*"
> > > > > > >
> > > > > > > So I am just trying to confirm with you whether I have to fir=
st build
> > > > > > > the kernel with like "make" or not? As you can imagine my har=
dware
> > > > > > > takes *very* long to build a kernel as I did in my last attem=
pt so I
> > > > > > > am asking whether it is needed. Hope you understand.
> > > > > > >
> > > >
> > > > I understand. Though I still don't wish to rob you of this opportun=
ity.
> > > >
> > > > Your ability to come up with these questions and answer them yourse=
lf is
> > > > what will make you a better programmer and developer.
> > > >
> > > > Don't get me wrong. Greg knows all too well the garbage I can shove=
l his
> > > > way. It's not about knowing the answer. It about knowing how to fin=
d the
> > > > answer yourself.
> > > >
> > > > ~Bryan
> > > >
