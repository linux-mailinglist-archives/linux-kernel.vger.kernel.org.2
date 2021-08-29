Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A473FAD1E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 18:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhH2QVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhH2QVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 12:21:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2B2C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 09:20:42 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id n18so11005618pgm.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IzFSzITg1sx5FSecfgVemfPISS0vS3rTJxQTZWD5w0w=;
        b=T+En5cCNMv587eOd774LjBnFwh87efMuXPdJ8LBFPOofzAG3HMt87iCv9GZyb7kd9f
         I8Vq1B7+b+tkrYzP9bk+mIFKCVkpeQaDC/1Vpjy3StP3ACy4eZ0VWuv4L7ERImT1xH0L
         Ma/i5zQBBRSFHJDCzmHj8inoGJTGS9rOf0ncIoACLtiP3YPE/xwBdFkJcpM/xSECFU1g
         DuzhRupQwCqIvtgqMe+hmKcYjumCRAYAn9hdOdQtLgwbZZe3A/VUyCHDdzFVMqCG33Ls
         k0oojpnlnUypGl2zi6UBmpGGHD5g2aLDmBmCsM6QO9GzcbVDKUwHBlYmBehkDcV2TDEn
         WDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IzFSzITg1sx5FSecfgVemfPISS0vS3rTJxQTZWD5w0w=;
        b=hJF+tRNjNWsv0/+BEuOrGcWuHV4aBAm7cJYdvQJ/b4UFPUcbxc55L+r3LDSWiBvbpn
         OYpI/B+PlxDNQ8xf5V58QdVCL4iuL50P2sa3j6gIORSPcmm6ZC0EYinKE2VQOPGqfRHR
         dPiKhoN06W07jJq8aRSS6nMHAzASKdLmxc5em9cSyO0rVWl8G8yu1HZw+VdGNoxMcw2w
         FbdLZzR+IV4LAUciXfooGwWa9LebK/YOYlepUHHCN+mZrv8X9KbcEXBZH2UASSWIgEh5
         wi9Qpq2tmbaqP0bV/w+mbkyNBnQ60Xf3MLvaiX1fF1uObFOBWRwwWMYJS0FlyMeL3rh3
         tevg==
X-Gm-Message-State: AOAM530QCHWp98XHxMZQdVF/fGEd1F/eY00IZNzh5U4y38NXzzmE3D7V
        SjYzpgnqImKPph5yZv/UUBtNr70xdZfzxyDgeaI=
X-Google-Smtp-Source: ABdhPJwVFbT5JMa94Z8duP5qdnQEWzWdaM35QOnZFg2IQRr6vkVzjZ4HzzxpU3TY8hbTULE+7nTGS7cGd5yzKQHnpSc=
X-Received: by 2002:a63:fd12:: with SMTP id d18mr17725396pgh.129.1630254041838;
 Sun, 29 Aug 2021 09:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210829144531.c2syu4vv4s22dlg7@h510>
In-Reply-To: <20210829144531.c2syu4vv4s22dlg7@h510>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Sun, 29 Aug 2021 18:20:30 +0200
Message-ID: <CAPGkw+xTFBeH-x-=dsQK-K5KjZZ7JKmQggz2s26=p7g+71kZjA@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 4:45 PM Bryan Brattlof <hello@bryanbrattlof.com> wr=
ote:
>
> Hi Krish
>
> On this day, August 29, 2021, thus sayeth Krish Jain:
> > On Sun, Aug 29, 2021 at 8:17 AM Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> > >
> > > On Sun, Aug 29, 2021 at 04:13:43AM +0200, Krish Jain wrote:
> > > > On Sat, Aug 28, 2021 at 1:38 AM Bryan Brattlof <hello@bryanbrattlof=
.com> wrote:
> > > > > As for your patch, I built the driver using:
> > > > >
> > > > >   $ make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android
> > > > >
> > > > > Which produced the following error:
> > > > >
> > > > >
> > > > > drivers/staging/android/ashmem.c: In function =E2=80=98ashmem_mma=
p=E2=80=99:
> > > > > drivers/staging/android/ashmem.c:380:2: warning: =E2=80=98static=
=E2=80=99 is not at beginning of declaration [-Wold-style-declaration]
> > > > >   380 |  const static struct file_operations vmfile_fops;
> > > > >       |  ^~~~~
> > > > > drivers/staging/android/ashmem.c:431:16: error: assignment of rea=
d-only variable =E2=80=98vmfile_fops=E2=80=99
> > > > >   431 |    vmfile_fops =3D *vmfile->f_op;
> > > > >       |                ^
> > > > > drivers/staging/android/ashmem.c:432:21: error: assignment of mem=
ber =E2=80=98mmap=E2=80=99 in read-only object
> > > > >   432 |    vmfile_fops.mmap =3D ashmem_vmfile_mmap;
> > > > >       |                     ^
> > > > > drivers/staging/android/ashmem.c:433:34: error: assignment of mem=
ber =E2=80=98get_unmapped_area=E2=80=99 in read-only object
> > > > >   433 |    vmfile_fops.get_unmapped_area =3D
> > > > >       |                                  ^
> > > > > make[1]: *** [scripts/Makefile.build:271: drivers/staging/android=
/ashmem.o] Error 1
> > > > > make: *** [Makefile:1851: drivers/staging/android] Error 2
> > > > >
> > > >
> > > > Hi, this seems very useful and I tried this myself just now. I don'=
t
> > > > get any errors that you do though. When I hit enter I just get a ne=
w
> > > > shell prompt. What am I doing wrong? Probably a silly mistake. I ra=
n
> > > > make CCFLAGS=3D-Werror M=3Ddrivers/staging/android/.
> > >
> > > Are you sure the file is being built at all?  You usually have to sel=
ect
> > > the proper configuration option to enable that driver as well.
> >
> >
> > Hi, what option do you mean?  I already ran make allmodconfig and sudo
> > make modules_install install and then make   "CCFLAGS=3D-Werror W=3D1
> > M=3Ddrivers/staging/android/" and now I do get output but one line
> > "WARNING: Symbol version dump "Module.symvers" is missing. Modules may
> > not have dependencies or modversions. You may get many unresolved
> > symbol warnings." . Then I tried "make CCFLAGS=3D-Werror V=3D1
> > M=3Ddrivers/staging/android/" and that outputted the following:
> >
>
> Most of the answers you're asking for are going to get vague responses
> (if any) on the mailing lists. The idea being (and I agree with) that
> giving out the answers will steal your opportunity to explore and learn
> the material yourself.
>
> Yes, it would be faster if we told you the answer, but ultimately, we
> would be doing a disservice to you.
>
> Besides, more times than not we (me especially) don't have the answer.
>
> With that said, I will give a (generous) hint. :)
>

Hi. Do I have to build the kernel once before this works? Or can I
just build a module directly?



Best Regards


>
> It looks like your having trouble with Kconfig. Have a look at:
>
>    https://www.kernel.org/doc/html/latest/kbuild/makefiles.html
>
> and:
>
>    https://www.kernel.org/doc/html/latest/kbuild/modules.html
>
> Also, you shouldn't need to install anything if you're just testing
> whether a module builds. Especially when 'sudo' and 'install' are
> involved.
>
> >
> > test -e include/generated/autoconf.h -a -e include/config/auto.conf || =
( \
> > echo >&2; \
> > echo >&2 "  ERROR: Kernel configuration is invalid."; \
> > echo >&2 "         include/generated/autoconf.h or
> > include/config/auto.conf are missing.";\
> > echo >&2 "         Run 'make oldconfig && make prepare' on kernel src
> > to fix it."; \
> >
>
> If I were you I would be asking:
>
> "What is a Kernel configuration file? and how did I corrupt mine?"
>
>    https://www.kernel.org/doc/html/latest/kbuild/kconfig.html
>
> >
> > echo >&2 ; \
> > /bin/false)
> > make -f ./scripts/Makefile.build obj=3Ddrivers/staging/android \
> > single-build=3D \
> > need-builtin=3D1 need-modorder=3D1
> > sh ./scripts/modules-check.sh drivers/staging/android/modules.order
> > make -f ./scripts/Makefile.modpost
> > WARNING: Symbol version dump "Module.symvers" is missing.
> >          Modules may not have dependencies or modversions.
> >          You may get many unresolved symbol warnings.
> > make -f ./scripts/Makefile.modfinal
> >
>
> "What is Module.symvers?"
>
>   If you're reading the links I gave, you should know this by now. :)
>   Check out chapter 6 in "Building External Modules"
>
> >
> > I followed this and ran make oldconfig && make prepare but all that is
> > outputted is again  "WARNING: Symbol version dump "Module.symvers" is
> > missing. Modules may not have dependencies or modversions. You may get
> > many unresolved symbol warnings." Then I just tried sudo make
> > modules_install install   again and what was outputted was:
> >
>
>   Again, Be *VERY* careful running commands you do not understand.
>   Especially when the words 'sudo' and 'install' are in the same
>   command.
>
> >
> > sed: can't read modules.order: No such file or directory
> > make[1]: *** [Makefile:1494: __modinst_pre] Error 2
> > make: *** [Makefile:351: __build_one_by_one] Error 2
> >
>
> "What does modules.order do?"
>
>   https://www.kernel.org/doc/html/latest/kbuild/kbuild.html
>
> >
> > Any ideas?  I've been stuck on debugging for hours to no avail. Please
> > enlighten me on where I am messing up.
> >
>
> All I can say is the kernels' documentation is the greatest thing to
> have when joining the community. The search bar is *fantastic*.
>
>   https://www.kernel.org/doc/html/latest/index.html
>
> Together with the collective history of ~30 years of developer's
> conversations on Linux Kernel Mailing List (LMKL).
>
>   https://lore.kernel.org/lkml/
>
> Along with our ability to see the full commit history at any time by:
>
>   $ git grep <regexp>
>
> In the end, all of the questions you have are in the documentation. I
> can't stress enough how appreciative we should be of contributers to
> Documentation/ and people like Jonathan Corbet who take the time to
> document how all of this stuff works in such a straight forward way.
>
> Withholding simple answers like this may seem unfair, but the juice is
> absolutely worth the squeeze the next time you run into another issue.
>
> And trust me when I say you *will* run into another issue. We wouldn't
> be here if there weren't constant issues to solve.
>
> We've all been where you're at. Even Greg, he may deny this, but I'm
> sure he has been.
>
> I'm excited to see what you learn.
> ~Bryan
>
> ***
>
> Just as an aside, for any other lurkers out there: This was the email
> that gave me confidence that I could join this community and that
> sending a patch, no matter how small, is welcome.
>
>   https://lore.kernel.org/lkml/Pine.LNX.4.58.0412201646220.4112@ppc970.os=
dl.org/
>
> The old "grey-beards" here don't bite, no matter how much they and
> everyone else say they do.
>
