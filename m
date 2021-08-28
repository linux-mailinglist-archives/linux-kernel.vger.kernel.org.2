Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94CD3FA4C9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhH1Ji4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhH1Jiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:38:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7F9C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 02:38:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v123so7896583pfb.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VlKqcGCYTB8qCl/7bAn2JOSlW1jbMj9qo0YUTPNwJFg=;
        b=fvI6aGb13Mh1TOwOiNGp+GkN6oI86FxZ4fMg6lAOVgLsQ6EaIeqoDTj44IIc+fUSyD
         wCiBE0PKdvSkntniNEDDx/ZzTpON4h+ipovTG6bPxhdxYe9i6b3b4yD2oJHUVUuLQWSh
         E/zmy388CCV1JLFSvCWaIEOIRtRGabrlzLUy+F8AVM1PuSG5pea4EuiEmVS5ZwnQ18HP
         zAJkrjXnjBihD34qF8yEb501DoK2f1bFwQqC8WTsBdQfz/2XShqBIXip54fRLITfwCf4
         JCoGWvoVbP5G9RFdCZMF8pcv+B4nNRSLFZy0zxPOsrjnlp2ArkWUe1iBVYyjIW41+uIJ
         5hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VlKqcGCYTB8qCl/7bAn2JOSlW1jbMj9qo0YUTPNwJFg=;
        b=KyHSnUjnSygd0vIDT6y0MgBmYe76pldWiO2s9kJKwd+aq/u55OdWBTyTVDG/xs0HAY
         RLsaw+Gjy69kjBPf8+HKeF0NTp8p3Km8ancJ/lepMhteCJ6Qv5HocvSlRKLI42ARK9iN
         poqmCMl76hCJIqbNlVxdCetazEerS7gXDx1gDQ+m6flnH8Kny7un/JwK+czhNcxyujUk
         Y/hIyGrr6ujkBHcDM96X+FPyx4KnPqN3rjR84mISS51AUFS4b1CZduuuu4JPUfnI28fN
         jwEjbkFZ/TzPU/pKanmx92MdfnElq/9oRk/Rn7I5I0G01lEk4QlPPhlEdpHZfQG/MN+N
         Fipg==
X-Gm-Message-State: AOAM5316kZbzpg7TNF0mbGjqxMbj22i8UV2VjgOp53iR+UXM/e1i6xHn
        35bzCvbQiruj5hRtc6rKiG7dJvS/bW3URJYeJLg=
X-Google-Smtp-Source: ABdhPJzg8ec89ducd5rROTI4aPCpYTrJNpLa0CzESkw7X2XlG8vF1qiZjpYZod0BzwgzPjkyVQkIQ1DJzkcWq2o2PXI=
X-Received: by 2002:aa7:9d02:0:b0:3f3:df3b:81ae with SMTP id
 k2-20020aa79d02000000b003f3df3b81aemr7096763pfp.19.1630143484584; Sat, 28 Aug
 2021 02:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGkw+x+B1731SL=afoSKiWwH-n-FA5YJ+WOwYdv8iyFhWk1zA@mail.gmail.com>
 <3634721.RBzQ2xsved@localhost.localdomain> <1742120.GgyQvu0Ciu@localhost.localdomain>
 <CAPGkw+yJ=V0OwFE+uqCeWWS8JbJD=YBE3+Uk-OKpmHRnvSTh+A@mail.gmail.com>
 <CAPGkw+w-y+iC3dMDLxi8DR3N+jf8roiJ2Vs_-uHxJ=i57eTiUA@mail.gmail.com>
 <CAPGkw+zyj4e-m19KdrHpAN_vHksNDy=k_cPPAftSN-hNoph0=w@mail.gmail.com> <20210827233835.px4az5hyqks2n4o5@h510>
In-Reply-To: <20210827233835.px4az5hyqks2n4o5@h510>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Sat, 28 Aug 2021 11:37:50 +0200
Message-ID: <CAPGkw+wq6LcVXSmuoDcTqOo=ULBBT_4DVXqXnpf7S5GW3Vzy2w@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Thanks for your response. Changing to  "const static" would fix
the first error but looking at the second error indicates that it
can't be a const, right? So checkpatch.pl was wrong?


Best Regards

On Sat, Aug 28, 2021 at 1:38 AM Bryan Brattlof <hello@bryanbrattlof.com> wr=
ote:
>
> Hi Krish!
>
> I'm sure someone has said something by now, however "top posting", where
> you reply to emails by writing on the top can make things hard to read
> on the mailing lists. The conversation is upside down when reading.
>
>    https://en.wikipedia.org/wiki/Posting_style#Top-posting
>
> Next time try writing underneath the text your referring to like this:
> Don't worry we're all learning here :)
>
> On this day, August 27, 2021 thus sayeth Krish Jain:
> > I unfortunately forgot to add Greg to this thread. Doing so now. I
> > apologize for the confusion, if any. This patch was regarding the
> > staging tree's file android/ashmem.c and declaring the file_operations
> > struct as const as done elsewhere in the kernel, because there are no
> > modifications to its fields.
> >
> > Warm Regards
> >
>
> Things can be a little deceiving in the kernel. That's why testing your
> changes before you submit them can be helpful.
>
> But don't worry too much if you break something, there are countless
> bots trying to break the kernel every day. It usually means you're
> learning when you break something.
>
> >
> > On Fri, Aug 27, 2021 at 8:38 PM Krish Jain <krishjain02939@gmail.com> w=
rote:
> > >
> > > So what do you think I can do?
> > >
> > > Best Regards
> > >
>
> That's a tough one as it really depends on your situation. When I first
> started programming I had a *really* old (even for that time) laptop
> that couldn't do much.  It wasn't ideal but I found I could connect
> through ssh to a virtual machine my university lent me to "learn to
> code".
>
> I have no idea what your situation is like. Though having a second
> computer to compile code while I wrote worked for me.
>
> > >
> > > On Fri, Aug 27, 2021 at 10:50 AM Krish Jain <krishjain02939@gmail.com=
> wrote:
> > > >
> > > > Hi, yes, this is my first time programming at this low level. And y=
es,
> > > > I read both docs now. Furthermore the issue is that my current
> > > > hardware can't handle building the kernel, it barely managed to
> > > > survive the first build after 2 hours so I don't know how I can. If=
 I
> > > > change it to static const would it fix the issue and build
> > > > successfully?  If not what would be the error message, then I can
> > > > debug. Thanks
> > > >
>
> As for your patch, I built the driver using:
>
>   $ make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android
>
> Which produced the following error:
>
>
> drivers/staging/android/ashmem.c: In function =E2=80=98ashmem_mmap=E2=80=
=99:
> drivers/staging/android/ashmem.c:380:2: warning: =E2=80=98static=E2=80=99=
 is not at beginning of declaration [-Wold-style-declaration]
>   380 |  const static struct file_operations vmfile_fops;
>       |  ^~~~~
> drivers/staging/android/ashmem.c:431:16: error: assignment of read-only v=
ariable =E2=80=98vmfile_fops=E2=80=99
>   431 |    vmfile_fops =3D *vmfile->f_op;
>       |                ^
> drivers/staging/android/ashmem.c:432:21: error: assignment of member =E2=
=80=98mmap=E2=80=99 in read-only object
>   432 |    vmfile_fops.mmap =3D ashmem_vmfile_mmap;
>       |                     ^
> drivers/staging/android/ashmem.c:433:34: error: assignment of member =E2=
=80=98get_unmapped_area=E2=80=99 in read-only object
>   433 |    vmfile_fops.get_unmapped_area =3D
>       |                                  ^
> make[1]: *** [scripts/Makefile.build:271: drivers/staging/android/ashmem.=
o] Error 1
> make: *** [Makefile:1851: drivers/staging/android] Error 2
>
>
> You shouldn't need to compile the entire kernel. That may be why your
> computer is having a hard time?
>
> Hope this helps :) and it was nice to meet you Krish
> ~Bryan
>
