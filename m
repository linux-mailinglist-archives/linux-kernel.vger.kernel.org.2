Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387D53FA835
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 04:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhH2CRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 22:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhH2CRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 22:17:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FA9C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 19:16:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y23so9805039pgi.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 19:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f9IIPedBoddZPb1L8A5yGgQYZa4Tn0bJxJHmZki7lF8=;
        b=JXlhH0/Idz1rKZtD3UnVeLuKZSAEtUSbrRL2HzPie7vqr981mOQt/jfYyua2skG7mc
         y3cX3TNwEVDMUUJEjXapZZAViZ0dqv2egyIduHY1erEZLdWO9NU16O84S/vfT2S/r+UR
         cQceRkXzrobO4xtubW5L6bJV0/VFFbr2cgNqTlLU+IVXJmzMeJTVPqJsFg8RbtOajpe6
         VNNnXzTF4Tq7RzmikrWtX613cZACwfFpQlrEr+G0GHMcb3qLVftMP5kD6XjK13ixip8q
         YKSbnURBhL5TR1JUIZiDbYPWS6aP4NX9QanrKM+/W/b0wVwxPFWCRH0/FpNOUJrXxOmD
         BhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f9IIPedBoddZPb1L8A5yGgQYZa4Tn0bJxJHmZki7lF8=;
        b=cU9HIzGaWalJ56HOdOu3SzpA15sAeTbTRszuExOqSyBQr1rW5jwdljhMtIdIL5YyBF
         qy+susj/20NHI2f1vTAuS9/z0244CnWJyThYa7rthVnJapNxXNk2scWrZNheKE4UOyit
         krky6bFx/D24MQ2GezrtqIkhW3KiL4tSqaBRVTAoc2aoAnvyc7++MvPavNi5NYQrhQaU
         hEsOtU4oKsIhRMOX+HAi8yUYR5uTr71Jl4KgSJ+M/Cp2wNCD2SMuzTgbEiFN9onUq1XM
         AOJ6r6fKGbDIKM3uahP+Kfsy7KkCdUAtSN1NXHF7UrJMrULW8kblSJ3Kd6W4tk22/Ut/
         3eBQ==
X-Gm-Message-State: AOAM531aFQBJU0ARGTYOoDUUjIw6/QeTNHwVjKpvwFW7wj/0ow1oVBBg
        Cn83gggHeY/ib+MMpjyFTD8m6zNhkk2o7HrJFgP5u9PjkZ2cPg==
X-Google-Smtp-Source: ABdhPJynDG0YcWK/cctFt2DrnC29NiuL+mFXOjzsnlAulCrmBpeSfFKvGMdJVeeDEDj49dSLLo3PJWRFd2xsMBKtfjo=
X-Received: by 2002:a63:c045:: with SMTP id z5mr6936583pgi.374.1630203384198;
 Sat, 28 Aug 2021 19:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGkw+x+B1731SL=afoSKiWwH-n-FA5YJ+WOwYdv8iyFhWk1zA@mail.gmail.com>
 <3634721.RBzQ2xsved@localhost.localdomain> <1742120.GgyQvu0Ciu@localhost.localdomain>
 <CAPGkw+yJ=V0OwFE+uqCeWWS8JbJD=YBE3+Uk-OKpmHRnvSTh+A@mail.gmail.com>
 <CAPGkw+w-y+iC3dMDLxi8DR3N+jf8roiJ2Vs_-uHxJ=i57eTiUA@mail.gmail.com>
 <CAPGkw+zyj4e-m19KdrHpAN_vHksNDy=k_cPPAftSN-hNoph0=w@mail.gmail.com>
 <20210827233835.px4az5hyqks2n4o5@h510> <CAPGkw+x7sXUtrZYv6tm+Apbjk5CYwd1j1BvvL6uCPWsot3zKSg@mail.gmail.com>
In-Reply-To: <CAPGkw+x7sXUtrZYv6tm+Apbjk5CYwd1j1BvvL6uCPWsot3zKSg@mail.gmail.com>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Sun, 29 Aug 2021 04:16:13 +0200
Message-ID: <CAPGkw+xQCwRU8Bw97-x5Qf1v2Bncq7tC9ksXznezefYZQSxCGg@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I meant I ran "make CCFLAGS=3D-Werror W=3D1
M=3Ddrivers/staging/android"  and I get no error.

On Sun, Aug 29, 2021 at 4:13 AM Krish Jain <krishjain02939@gmail.com> wrote=
:
>
> On Sat, Aug 28, 2021 at 1:38 AM Bryan Brattlof <hello@bryanbrattlof.com> =
wrote:
> >
> > Hi Krish!
> >
> > I'm sure someone has said something by now, however "top posting", wher=
e
> > you reply to emails by writing on the top can make things hard to read
> > on the mailing lists. The conversation is upside down when reading.
> >
> >    https://en.wikipedia.org/wiki/Posting_style#Top-posting
> >
> > Next time try writing underneath the text your referring to like this:
> > Don't worry we're all learning here :)
> >
> > On this day, August 27, 2021 thus sayeth Krish Jain:
> > > I unfortunately forgot to add Greg to this thread. Doing so now. I
> > > apologize for the confusion, if any. This patch was regarding the
> > > staging tree's file android/ashmem.c and declaring the file_operation=
s
> > > struct as const as done elsewhere in the kernel, because there are no
> > > modifications to its fields.
> > >
> > > Warm Regards
> > >
> >
> > Things can be a little deceiving in the kernel. That's why testing your
> > changes before you submit them can be helpful.
> >
> > But don't worry too much if you break something, there are countless
> > bots trying to break the kernel every day. It usually means you're
> > learning when you break something.
> >
> > >
> > > On Fri, Aug 27, 2021 at 8:38 PM Krish Jain <krishjain02939@gmail.com>=
 wrote:
> > > >
> > > > So what do you think I can do?
> > > >
> > > > Best Regards
> > > >
> >
> > That's a tough one as it really depends on your situation. When I first
> > started programming I had a *really* old (even for that time) laptop
> > that couldn't do much.  It wasn't ideal but I found I could connect
> > through ssh to a virtual machine my university lent me to "learn to
> > code".
> >
> > I have no idea what your situation is like. Though having a second
> > computer to compile code while I wrote worked for me.
> >
> > > >
> > > > On Fri, Aug 27, 2021 at 10:50 AM Krish Jain <krishjain02939@gmail.c=
om> wrote:
> > > > >
> > > > > Hi, yes, this is my first time programming at this low level. And=
 yes,
> > > > > I read both docs now. Furthermore the issue is that my current
> > > > > hardware can't handle building the kernel, it barely managed to
> > > > > survive the first build after 2 hours so I don't know how I can. =
If I
> > > > > change it to static const would it fix the issue and build
> > > > > successfully?  If not what would be the error message, then I can
> > > > > debug. Thanks
> > > > >
> >
> > As for your patch, I built the driver using:
> >
> >   $ make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android
> >
> > Which produced the following error:
> >
> >
> > drivers/staging/android/ashmem.c: In function =E2=80=98ashmem_mmap=E2=
=80=99:
> > drivers/staging/android/ashmem.c:380:2: warning: =E2=80=98static=E2=80=
=99 is not at beginning of declaration [-Wold-style-declaration]
> >   380 |  const static struct file_operations vmfile_fops;
> >       |  ^~~~~
> > drivers/staging/android/ashmem.c:431:16: error: assignment of read-only=
 variable =E2=80=98vmfile_fops=E2=80=99
> >   431 |    vmfile_fops =3D *vmfile->f_op;
> >       |                ^
> > drivers/staging/android/ashmem.c:432:21: error: assignment of member =
=E2=80=98mmap=E2=80=99 in read-only object
> >   432 |    vmfile_fops.mmap =3D ashmem_vmfile_mmap;
> >       |                     ^
> > drivers/staging/android/ashmem.c:433:34: error: assignment of member =
=E2=80=98get_unmapped_area=E2=80=99 in read-only object
> >   433 |    vmfile_fops.get_unmapped_area =3D
> >       |                                  ^
> > make[1]: *** [scripts/Makefile.build:271: drivers/staging/android/ashme=
m.o] Error 1
> > make: *** [Makefile:1851: drivers/staging/android] Error 2
> >
>
> Hi, this seems very useful and I tried this myself just now. I don't
> get any errors that you do though. When I hit enter I just get a new
> shell prompt. What am I doing wrong? Probably a silly mistake. I ran
> make CCFLAGS=3D-Werror M=3Ddrivers/staging/android/.
>
>
> - Krish
>
> > You shouldn't need to compile the entire kernel. That may be why your
> > computer is having a hard time?
> >
> > Hope this helps :) and it was nice to meet you Krish
> > ~Bryan
> >
