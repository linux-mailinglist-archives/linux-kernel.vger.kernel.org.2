Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97D93FE12C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhIARfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:35:13 -0400
Received: from mail-4317.protonmail.ch ([185.70.43.17]:53820 "EHLO
        mail-4317.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhIARfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:35:12 -0400
Date:   Wed, 01 Sep 2021 17:34:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630517653;
        bh=4DZXoSZg/x86Vl6h/q4bF5QMWXnNiM9y1sUOzfxcIMI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=i8STOvz0t8mkjlVrtjuWxWXd6gJ4Fg8bHGsl/o8YYiDiA8+zKrunBnWkRSzzMB1X/
         XUcRCW+XUE60EaeqDxLaH8qi/x0q+RNBKWoRX63qWAzrQpsHw7NYiNSjq70P1AQHgw
         MIxUSoTyKu0JjEe2X+u8fQQZM9Z6vUceJ/3og4WyaxpLXwVDk50T4r8tJe8ylESp9S
         XhmnDwBBf0zATpL2lJ5cAFKd2nb+Vt4AVjUjpDwE8BL7oF351sa3frB4aK2Pfb/BA9
         YZKnYmOezpKEnk1wqD3vtGR4WtiYdz8DB7UM0+AW+p/+eutbrdSWo0eF4moL5PbVlm
         niQprq1j9KRLA==
To:     Krish Jain <krishjain02939@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
Message-ID: <20210901173357.2dfvw5xgpzjndesc@h510>
In-Reply-To: <YS+vfVTV0fls6KuN@kroah.com>
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com> <20210831133533.6aayzjghdakrhy56@h510> <13366651.n50aozgL3V@localhost.localdomain> <20210831230014.cp46vho2hnndacjp@h510> <CAPGkw+zpYsovnXL_4GfjsQ60fqre+xyiwvwKuDj_fHPTKEfzeQ@mail.gmail.com> <YS+cexhuqldPaACs@kroah.com> <CAPGkw+z+uepM0hiNh48xjjD7=2rpgr+RSLzMcHbw2iE=8y+xqQ@mail.gmail.com> <YS+vfVTV0fls6KuN@kroah.com>
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

On this day, September  1, 2021, thus sayeth Greg KH:
> On Wed, Sep 01, 2021 at 05:34:36PM +0200, Krish Jain wrote:
> >
> > Can you tell me why this is the case?
>
> Again, it depends on your kernel configuration file as to what will, or
> will not, be built.
>
> If you have some things set as modules, they can be built as a module,
> but the ashmem code can not be built as a module, so you would never
> build it if you did the above line.
>
> Here, look at this sequence, starting with a tree that does nothing if I
> do a simple 'make' in it, as the whole kernel is already built, and
> ashmem is enabled in the kernel configuration
>
> $ grep ASHMEM .config
> CONFIG_ASHMEM=3Dy
> $ make
> $
>
> So, let's change the time stamp on the ashmem.c file and see what gets
> built if you use the M=3D option:
>
> $ touch drivers/staging/android/ashmem.c
> $ make M=3Ddrivers/staging/android
>   MODPOST drivers/staging/android/Module.symvers
> $
>
> Nothing gets built as ashmem is NOT a module, and M=3D only builds any
> modules in the directory you specified.
>
> But, if you tell make to just build the whole subdirectory, no matter
> what the setting is, it will be built:
>
> $ make drivers/staging/android/
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND objtool
>   CC      drivers/staging/android/ashmem.o
>   AR      drivers/staging/android/built-in.a
> $
>
> So that's the difference, "M=3D" builds modules in that directory, but if
> you tell it to build the subdir, everything in there that needs to be
> built, will be built.
>
> Be careful about your kernel configuration, that is the key for what
> will, and will not, be built.
>

Ouch...

I want to *really* apologize to you Krish for introducing so much
confusion while you, and apparently I, am still learning. And for your
persistence with seeking the correct answer here Krish.

I did not notice that this could only be build as a built-in object.
Thank you Greg for pointing out my mistake, and I apologize for dragging
this out longer than it had to and the frustration this caused.

It seems I will be reading the documentation again, along with Greg's
book recommendation, "Linux Kernel in a Nutshell" over this merge
window.

Thank you again Krish and Greg
~Bryan

