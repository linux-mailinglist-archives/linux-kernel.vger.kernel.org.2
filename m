Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B369C3FAC4E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhH2Orq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 10:47:46 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:55463 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhH2Oro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 10:47:44 -0400
Date:   Sun, 29 Aug 2021 14:45:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630248350;
        bh=egrOQ3xpRZVhIt3GEQKBeg6M7dZBFdrtaZO951FwHac=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=CEh2i9lP5FOiNDIiidJgOLjpoqUebthIpivkxD2j1y0KtSRbqK/iPK2TSC9ZsgjOF
         ysV8+14/5d7WyihHPHsZsvJiymZDPqgxtov6p8VBzwTs8Fva5Ii+N6FHCRmldXkVub
         H2IPjC6k9ePB+h8AH+o9c63ogXig4Bc7tDDSOx/hmsQ1ynwt08ufF/+akx4P6FaNTT
         3zxTMqb0nwaaW6m00zh++QCqRlmwZBxnvWB3tSBQ46t/FY+jVlaG+d+qLiGMXGXiyJ
         xtRi9Y3yWymap+dSwgW/HXeni59DQgOQqttr4tvJyrChhOQaa9ED1hZp6s54u3Fc9P
         h7Xb6+qV76BGg==
To:     Krish Jain <krishjain02939@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
Message-ID: <20210829144531.c2syu4vv4s22dlg7@h510>
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

Hi Krish

On this day, August 29, 2021, thus sayeth Krish Jain:
> On Sun, Aug 29, 2021 at 8:17 AM Greg KH <gregkh@linuxfoundation.org> wrot=
e:
> >
> > On Sun, Aug 29, 2021 at 04:13:43AM +0200, Krish Jain wrote:
> > > On Sat, Aug 28, 2021 at 1:38 AM Bryan Brattlof <hello@bryanbrattlof.c=
om> wrote:
> > > > As for your patch, I built the driver using:
> > > >
> > > >   $ make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android
> > > >
> > > > Which produced the following error:
> > > >
> > > >
> > > > drivers/staging/android/ashmem.c: In function =E2=80=98ashmem_mmap=
=E2=80=99:
> > > > drivers/staging/android/ashmem.c:380:2: warning: =E2=80=98static=
=E2=80=99 is not at beginning of declaration [-Wold-style-declaration]
> > > >   380 |  const static struct file_operations vmfile_fops;
> > > >       |  ^~~~~
> > > > drivers/staging/android/ashmem.c:431:16: error: assignment of read-=
only variable =E2=80=98vmfile_fops=E2=80=99
> > > >   431 |    vmfile_fops =3D *vmfile->f_op;
> > > >       |                ^
> > > > drivers/staging/android/ashmem.c:432:21: error: assignment of membe=
r =E2=80=98mmap=E2=80=99 in read-only object
> > > >   432 |    vmfile_fops.mmap =3D ashmem_vmfile_mmap;
> > > >       |                     ^
> > > > drivers/staging/android/ashmem.c:433:34: error: assignment of membe=
r =E2=80=98get_unmapped_area=E2=80=99 in read-only object
> > > >   433 |    vmfile_fops.get_unmapped_area =3D
> > > >       |                                  ^
> > > > make[1]: *** [scripts/Makefile.build:271: drivers/staging/android/a=
shmem.o] Error 1
> > > > make: *** [Makefile:1851: drivers/staging/android] Error 2
> > > >
> > >
> > > Hi, this seems very useful and I tried this myself just now. I don't
> > > get any errors that you do though. When I hit enter I just get a new
> > > shell prompt. What am I doing wrong? Probably a silly mistake. I ran
> > > make CCFLAGS=3D-Werror M=3Ddrivers/staging/android/.
> >
> > Are you sure the file is being built at all?  You usually have to selec=
t
> > the proper configuration option to enable that driver as well.
>
>
> Hi, what option do you mean?  I already ran make allmodconfig and sudo
> make modules_install install and then make   "CCFLAGS=3D-Werror W=3D1
> M=3Ddrivers/staging/android/" and now I do get output but one line
> "WARNING: Symbol version dump "Module.symvers" is missing. Modules may
> not have dependencies or modversions. You may get many unresolved
> symbol warnings." . Then I tried "make CCFLAGS=3D-Werror V=3D1
> M=3Ddrivers/staging/android/" and that outputted the following:
>

Most of the answers you're asking for are going to get vague responses
(if any) on the mailing lists. The idea being (and I agree with) that
giving out the answers will steal your opportunity to explore and learn
the material yourself.

Yes, it would be faster if we told you the answer, but ultimately, we
would be doing a disservice to you.

Besides, more times than not we (me especially) don't have the answer.

With that said, I will give a (generous) hint. :)

***

It looks like your having trouble with Kconfig. Have a look at:

   https://www.kernel.org/doc/html/latest/kbuild/makefiles.html

and:

   https://www.kernel.org/doc/html/latest/kbuild/modules.html

Also, you shouldn't need to install anything if you're just testing
whether a module builds. Especially when 'sudo' and 'install' are
involved.

>
> test -e include/generated/autoconf.h -a -e include/config/auto.conf || ( =
\
> echo >&2; \
> echo >&2 "  ERROR: Kernel configuration is invalid."; \
> echo >&2 "         include/generated/autoconf.h or
> include/config/auto.conf are missing.";\
> echo >&2 "         Run 'make oldconfig && make prepare' on kernel src
> to fix it."; \
>

If I were you I would be asking:

"What is a Kernel configuration file? and how did I corrupt mine?"

   https://www.kernel.org/doc/html/latest/kbuild/kconfig.html

>
> echo >&2 ; \
> /bin/false)
> make -f ./scripts/Makefile.build obj=3Ddrivers/staging/android \
> single-build=3D \
> need-builtin=3D1 need-modorder=3D1
> sh ./scripts/modules-check.sh drivers/staging/android/modules.order
> make -f ./scripts/Makefile.modpost
> WARNING: Symbol version dump "Module.symvers" is missing.
>          Modules may not have dependencies or modversions.
>          You may get many unresolved symbol warnings.
> make -f ./scripts/Makefile.modfinal
>

"What is Module.symvers?"

  If you're reading the links I gave, you should know this by now. :)
  Check out chapter 6 in "Building External Modules"

>
> I followed this and ran make oldconfig && make prepare but all that is
> outputted is again  "WARNING: Symbol version dump "Module.symvers" is
> missing. Modules may not have dependencies or modversions. You may get
> many unresolved symbol warnings." Then I just tried sudo make
> modules_install install   again and what was outputted was:
>

  Again, Be *VERY* careful running commands you do not understand.
  Especially when the words 'sudo' and 'install' are in the same
  command.

>
> sed: can't read modules.order: No such file or directory
> make[1]: *** [Makefile:1494: __modinst_pre] Error 2
> make: *** [Makefile:351: __build_one_by_one] Error 2
>

"What does modules.order do?"

  https://www.kernel.org/doc/html/latest/kbuild/kbuild.html

>
> Any ideas?  I've been stuck on debugging for hours to no avail. Please
> enlighten me on where I am messing up.
>

All I can say is the kernels' documentation is the greatest thing to
have when joining the community. The search bar is *fantastic*.

  https://www.kernel.org/doc/html/latest/index.html

Together with the collective history of ~30 years of developer's
conversations on Linux Kernel Mailing List (LMKL).

  https://lore.kernel.org/lkml/

Along with our ability to see the full commit history at any time by:

  $ git grep <regexp>

In the end, all of the questions you have are in the documentation. I
can't stress enough how appreciative we should be of contributers to
Documentation/ and people like Jonathan Corbet who take the time to
document how all of this stuff works in such a straight forward way.

Withholding simple answers like this may seem unfair, but the juice is
absolutely worth the squeeze the next time you run into another issue.

And trust me when I say you *will* run into another issue. We wouldn't
be here if there weren't constant issues to solve.

We've all been where you're at. Even Greg, he may deny this, but I'm
sure he has been.

I'm excited to see what you learn.
~Bryan

***

Just as an aside, for any other lurkers out there: This was the email
that gave me confidence that I could join this community and that
sending a patch, no matter how small, is welcome.

  https://lore.kernel.org/lkml/Pine.LNX.4.58.0412201646220.4112@ppc970.osdl=
.org/

The old "grey-beards" here don't bite, no matter how much they and
everyone else say they do.

