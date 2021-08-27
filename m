Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61CD3FA1E2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 01:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhH0Xjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 19:39:40 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:50123 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhH0Xjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 19:39:39 -0400
Date:   Fri, 27 Aug 2021 23:38:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630107528;
        bh=eEP9pOnPTRmzzXEkOuuw3aASMkcnu6gECOHCp9wM/sY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=rMp5gJUNs5kfgbMZrxvU0I88dfdyx2A9mzwg1axgDhsUQrSLMcRC+bVHlvcv2zfRp
         QLSQT3y1Y6Q74RlT+lQh1VcMU6Ti1oMpeFxvgE1UlJtjvunYpvzhA9+jSDzbZKjdfg
         gVc2+iS6wNfLv472wPQAjAe++N38BLwF3huuqMFI9IR1R3ijoa5LYKSEKtMBOZT2Bb
         NsjKQdC6wM9Czuc/CCVrX0dj482LW9Ji+zbJ9cJM0OjcNOat2M/uZSae2OCo92nS3C
         pOOnH/rFyf/mDi8xCjG0QePV2M8z/hEg5nwCWCU/Nl+i80XkVH8vyAR6GnOWKIZw+h
         yRCzSBrT/APxA==
To:     Krish Jain <krishjain02939@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
Message-ID: <20210827233835.px4az5hyqks2n4o5@h510>
In-Reply-To: <CAPGkw+zyj4e-m19KdrHpAN_vHksNDy=k_cPPAftSN-hNoph0=w@mail.gmail.com>
References: <CAPGkw+x+B1731SL=afoSKiWwH-n-FA5YJ+WOwYdv8iyFhWk1zA@mail.gmail.com> <3634721.RBzQ2xsved@localhost.localdomain> <1742120.GgyQvu0Ciu@localhost.localdomain> <CAPGkw+yJ=V0OwFE+uqCeWWS8JbJD=YBE3+Uk-OKpmHRnvSTh+A@mail.gmail.com> <CAPGkw+w-y+iC3dMDLxi8DR3N+jf8roiJ2Vs_-uHxJ=i57eTiUA@mail.gmail.com> <CAPGkw+zyj4e-m19KdrHpAN_vHksNDy=k_cPPAftSN-hNoph0=w@mail.gmail.com>
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

Hi Krish!

I'm sure someone has said something by now, however "top posting", where
you reply to emails by writing on the top can make things hard to read
on the mailing lists. The conversation is upside down when reading.

   https://en.wikipedia.org/wiki/Posting_style#Top-posting

Next time try writing underneath the text your referring to like this:
Don't worry we're all learning here :)

On this day, August 27, 2021 thus sayeth Krish Jain:
> I unfortunately forgot to add Greg to this thread. Doing so now. I
> apologize for the confusion, if any. This patch was regarding the
> staging tree's file android/ashmem.c and declaring the file_operations
> struct as const as done elsewhere in the kernel, because there are no
> modifications to its fields.
>
> Warm Regards
>

Things can be a little deceiving in the kernel. That's why testing your
changes before you submit them can be helpful.

But don't worry too much if you break something, there are countless
bots trying to break the kernel every day. It usually means you're
learning when you break something.

>
> On Fri, Aug 27, 2021 at 8:38 PM Krish Jain <krishjain02939@gmail.com> wro=
te:
> >
> > So what do you think I can do?
> >
> > Best Regards
> >

That's a tough one as it really depends on your situation. When I first
started programming I had a *really* old (even for that time) laptop
that couldn't do much.  It wasn't ideal but I found I could connect
through ssh to a virtual machine my university lent me to "learn to
code".

I have no idea what your situation is like. Though having a second
computer to compile code while I wrote worked for me.

> >
> > On Fri, Aug 27, 2021 at 10:50 AM Krish Jain <krishjain02939@gmail.com> =
wrote:
> > >
> > > Hi, yes, this is my first time programming at this low level. And yes=
,
> > > I read both docs now. Furthermore the issue is that my current
> > > hardware can't handle building the kernel, it barely managed to
> > > survive the first build after 2 hours so I don't know how I can. If I
> > > change it to static const would it fix the issue and build
> > > successfully?  If not what would be the error message, then I can
> > > debug. Thanks
> > >

As for your patch, I built the driver using:

  $ make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android

Which produced the following error:


drivers/staging/android/ashmem.c: In function =E2=80=98ashmem_mmap=E2=80=
=99:
drivers/staging/android/ashmem.c:380:2: warning: =E2=80=98static=E2=80=
=99 is not at beginning of declaration [-Wold-style-declaration]
  380 |  const static struct file_operations vmfile_fops;
      |  ^~~~~
drivers/staging/android/ashmem.c:431:16: error: assignment of read-only var=
iable =E2=80=98vmfile_fops=E2=80=99
  431 |    vmfile_fops =3D *vmfile->f_op;
      |                ^
drivers/staging/android/ashmem.c:432:21: error: assignment of member =
=E2=80=98mmap=E2=80=99 in read-only object
  432 |    vmfile_fops.mmap =3D ashmem_vmfile_mmap;
      |                     ^
drivers/staging/android/ashmem.c:433:34: error: assignment of member =
=E2=80=98get_unmapped_area=E2=80=99 in read-only object
  433 |    vmfile_fops.get_unmapped_area =3D
      |                                  ^
make[1]: *** [scripts/Makefile.build:271: drivers/staging/android/ashmem.o]=
 Error 1
make: *** [Makefile:1851: drivers/staging/android] Error 2


You shouldn't need to compile the entire kernel. That may be why your
computer is having a hard time?

Hope this helps :) and it was nice to meet you Krish
~Bryan

