Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359053FC856
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbhHaNg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:36:57 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:59376 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbhHaNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:54 -0400
Date:   Tue, 31 Aug 2021 13:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630416956;
        bh=cn0U6GzVIDMIdqLgNMFeLkrCj6U5UatyC2ElQujHs0E=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Y87cmOTYcxcgUu34+GA65wKU15gu8Arj4V+SdJwK09N13rLy3klz9bKIO2PK8SH3j
         DVIoAA6nS50MbshfD1rIKr8m9yLYW+7144ZxxH42Uw4pPktJ2URwmSfGOzh16d1znS
         amPZB+yvwSfaoGrGWRg6bTeyYjCK0OBeTvLT9V6Lr77vrCXUjxvQYu5RKKTmsBNxVh
         fpL9oNUM8sw4nWJRnfw/8Ene9d42ljTWfnE78z2JUmCKdOzSJRYIxXDFbUf1jMYqqa
         fsMPnMTnQBoAuWOfBDKoFmVQliHxS7fcOomVKFxHbWIMJ7a/P4DGek1WA22KB9Z0mw
         pKFG4656rezPA==
To:     Krish Jain <krishjain02939@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
Message-ID: <20210831133533.6aayzjghdakrhy56@h510>
In-Reply-To: <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com>
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+ypKOVsJF_Guna+9+q-+cApYzdBGHMPKKr6MAzGQtqy2g@mail.gmail.com> <CAPGkw+wGn1oTAO7JXXApDMm4cFfxXam913hOGnnup1nSOpcVPA@mail.gmail.com> <CAPGkw+xroJmxa9i6X++un6tQFQ-3F5uMRCatzufWsdfw7cQ2LQ@mail.gmail.com> <20210829205953.63ebc32xlyudsqzg@h510> <CAPGkw+wtE0HMQmYsMkFEt_BPqqB2j_TQ6zwATp6zyXLyxxwTOA@mail.gmail.com> <CAPGkw+w=A1ZBQrmSR2mCgXnfEvhG9tbuJjQ+q1-=Tedwb_XhOA@mail.gmail.com> <CAPGkw+xzAZxEXBvsFuBLiCRfNvjBxwds7Q-CWeo8RM4Rxmabcw@mail.gmail.com> <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com>
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

On this day, August 31, 2021, thus sayeth Krish Jain:
> Hi, could someone help with this? Still stuck. Maybe someone else has
> some insight into this issue too? Or Greg or Bryan.
>
> Thanks
>

Just another friendly reminder about top posting. I liked Greg's link to
John Gruber's opinion. TLDR: It's poor form.

  http://daringfireball.net/2007/07/on_top

Ignoring these bits of advice send signals to the community that you
don't value the time we donate to you.

>
> On Mon, Aug 30, 2021 at 3:01 PM Krish Jain <krishjain02939@gmail.com> wro=
te:
> >
> > One sec this got even more confusing. I saw
> > https://stackoverflow.com/questions/23184181/error-while-running-make-i=
nstall-include-generated-autoconf-h-or-include-confi
> > and it says
> >
> > -------
> > You are including the V=3D1 which causes Make to show the commands as
> > they're being run. From the looks of it, you're not actually seeing
> > the error itself, but you're seeing the test that it's running to
> > check if those files exist:
> >
> > test -e include/generated/autoconf.h -a -e include/config/auto.conf ||
> > ( \ ... echo error messages here ... \ )
> >
> > That test is being run, and if it fails, it would echo those messages
> > to standard error, which it's not. If your module isn't building it's
> > probably due to some other issue.
> > ------
> >
> > So where is it going all wrong? Messing up the file ashmem.c does not
> > print the errors.
> >

I have no clue where you got V=3D1 from. Are you sure you need it?

As for "So where is it going all wrong?"

Like Greg said a few emails ago:

  "Are you sure the file is being built at all? You usually have to
  select the proper configuration option to enable that driver as well."

After a response from Greg like that, I would ask myself: How do I
select the proper configuration options? and How do I know if the proper
one is set?

Having had the same issue as you when I first started, I will try to
save you some time. Read the documentation, it is faster than you think
and will give you more information than I can give you over email:

  https://www.kernel.org/doc/html/latest/kbuild/makefiles.html

> > >
> > > https://pastebin.com/NuvqMUWu is the link to the .config file.
> > > The error I get is https://imgur.com/gkwh7Sb .
> > >

Your .config will be different to everyone else. I have different
hardware to you, Greg or Fabio. And I will need different modules and
options enabled.  I have no idea if your .config file is correct.

This error seems to indicate you're missing your Module.symvers file,
not your .config file. It's hard to tell with the V=3D1 option set.

> > > >
> > > >  When a module is loaded/used, the values contained in the kernel a=
re
> > > > compared with similar values in the module; if they are not equal, =
the
> > > > kernel refuses to load the module. I don't need it in my case.
> > > >
> > > > > What would happen if we didn't have the proper symbols when compi=
ling or
> > > > > installing this driver?
> > > > > How and what generates the Module.symvers file when we *do* need =
it?
> > > >
> > > > The kernel would refuse to load the module.
> > > >

Excellent! This has nothing to do with test building our shared memory
system. We can either turn the warning off, find a way to generate the
file, or fake that we've generated the file.

Though it's important you know the impact of your decision.

> > > > > >
> > > > > > ERROR: Kernel configuration is invalid."; \
> > > > > > echo >&2 "         include/generated/autoconf.h or
> > > > > > include/config/auto.conf are missing.";\
> > > > > > echo >&2 "         Run 'make oldconfig && make prepare' on kern=
el src
> > > > > > to fix it."; \
> > > > > >
> > > > > >
> > > > > > is still present.
> > > > > >
> > > > > > How can I fix this?
> > > > > >

After everything above, (See what we mean about top posting?) Are you
sure you're getting this ERROR?

> > > > >
> > > > > Are there any other 'make *config' options we could try?
> > > >
> > > > Yes, like main menuconfig. I tried it but it still doesn't work.
> > > >

There are more (faster) options. Though 'menuconfig' would be a great
option to select specific modules you would like to build.

> > > > >
> > > > > Do we really need CONFIG_INFINIBAND turned on if we're working in=
 the
> > > > > drivers/staging tree of the kernel?
> > > >
> > > > No, we don't. I removed it.
> > > >

"removed it" makes me think your editing your .config file by hand.
It's not wrong to do so, just be sure you know what you're doing.

> > > >
> > > > > What would we gain from having a compiled kernel if we want to te=
st a
> > > > > single staging driver?
> > > >
> > > > No need to compile the entire kernel I guess for my use case. But
> > > > after all this reading :( I still don't get why " sudo make
> > > > CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android/  V=3D1" worked=
 for you
> > > > but not for me. I still get the following errors
> > > >
> > > >
> > > > test -e include/generated/autoconf.h -a -e include/config/auto.conf=
 || ( \
> > > > echo >&2; \
> > > > echo >&2 "  ERROR: Kernel configuration is invalid."; \
> > > > echo >&2 "         include/generated/autoconf.h or
> > > > include/config/auto.conf are missing.";\
> > > > echo >&2 "         Run 'make oldconfig && make prepare' on kernel s=
rc
> > > > to fix it."; \
> > > > echo >&2 ; \
> > > > /bin/false)
> > > > .....
> > > >
> > > >
> > > > How can I fix this?
> > > >

My advice would be to familiarize yourself with how modules are built
with "Linux Kernel Makefiles" section in the documentation.

  https://www.kernel.org/doc/html/latest/kbuild/makefiles.html

It describes everything in greater detail than I could ever give here.

If anyone else wants to jump in here, feel free.
~Bryan

