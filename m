Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A20373D86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhEEOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhEEOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:21:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E94C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 07:20:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n2so3130210ejy.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgBFW77w+tqXgd2qEhzNM+pBbVN0PtVs2ChlIQlnPok=;
        b=E0/0eSBIRoJ31aC+hu8b8fyOZgaiGRtak/6pzAv0VlIcRqBObMCPzEZaXsK/R085SU
         QNqZCv7io+8+UpPtOsLN9Gw4rXmi0D9EryZsIa2vA1H90I/J8J5ndJHnj0tDseLlGO6M
         O3b/XsVsGpaZUM6vXwEn/H7Tv2knupaQNUjSDhScaGZ1PsXZDRA0Tj/ytUmnqMSU1DKn
         l3ObaZV7lco5NHEOmSEZCUBEgEk0nWC/300ypBZFaZyfp10kT6K9l7563hSgWEBdYycE
         jezfZRst235bIHUGmfQyrgMJAUcbYZ5LLabv2eroQrm4eCZ9uDM/4RMX3n2kBNMVthZW
         iihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgBFW77w+tqXgd2qEhzNM+pBbVN0PtVs2ChlIQlnPok=;
        b=jppN3KZ+fwvuLZBCbZtBoneAYf+Lzxl9RMFP3UISgaiA4jFDlCotwrcNQs3Vl1y29S
         oBCgdCIDtgSJYcprRitY5fygjfeaPU5359FULP1JU7p0hRxOMzjKa8v98TGvN8B68PZa
         nfWiryMuBPf2yNFof2DFErGHZK3RX/irx8AjTculhGX+PejwPBTWgTajcZUv0Bm8nd2F
         xknc9ZW2bavlnrM57tOeCMS24t4hiW5wuE2yEvmJ58K/UMnz5E+YjOM/CkDQhwVtH2H2
         76WStxbgwypqIEbRT1rB6su7flDHpnApuq5X+kdcVM5Gep+Kp/IXSD8ANpYksc98ygrM
         oxxg==
X-Gm-Message-State: AOAM533Mf7qUevFJBawlNHsAyEGzKIqUBqezOdq6oV9voOUaVcoas9OR
        KnOLzgZ53o6yeChDuFKxS49i4sG1rLWhnbyNjlTPgw==
X-Google-Smtp-Source: ABdhPJyzLudiIQ/dpybDA57vC74JzVw449WHxrJNYfxwFjrKij9jEbD6z+ZLr4L2liSwFhoiYlSvyXGVP4cmweokm9k=
X-Received: by 2002:a17:907:78c4:: with SMTP id kv4mr27335251ejc.445.1620224402914;
 Wed, 05 May 2021 07:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210502193216.24872-1-brgl@bgdev.pl> <CAHk-=whSWp3exv8tZ2th5im_P7HF=c6iuOOVb9iSrNrd6405WA@mail.gmail.com>
 <YJBA1iYK7npit9vn@zeniv-ca.linux.org.uk> <YJCpnvKUNx+Tc+vg@zeniv-ca.linux.org.uk>
 <CAMRc=Mdh9LvUQCxcyt7ZBjitDB2noVnOptft_VORDhffxJaeCA@mail.gmail.com> <YJGFsrPBoQsKj+JZ@zeniv-ca.linux.org.uk>
In-Reply-To: <YJGFsrPBoQsKj+JZ@zeniv-ca.linux.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 5 May 2021 16:19:52 +0200
Message-ID: <CAMRc=Mf1N1iL4b5KvVFbPsvKDMy_geXkd8LjmCu5r=bih-N7_w@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: updates for v5.13
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 7:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, May 04, 2021 at 04:17:02PM +0200, Bartosz Golaszewski wrote:
> > >     Incidentally, if your code critically depends upon some field
> > > being first in such-and-such structure, you should either get rid of
> > > the dependency or at least bother to document that.
> > > That
> > > +               /*
> > > +                * Free memory allocated for the pending and live
> > > directories
> > > +                * of committable groups.
> > > +                */
> > > +               if (sd->s_type & (CONFIGFS_GROUP_PENDING |
> > > CONFIGFS_GROUP_LIVE))
> > > +                       kfree(sd->s_element);
> > > +
> > > is asking for trouble down the road.
> > >
> >
> > I'm not sure if this is a hard NAK for these changes or if you
> > consider this something that can be ironed out post v5.13-rc1?
>
> Rename implementation is simply bogus.  You are, for some reason, attaching
> stuff to *destination*, which won't be seen by anyone not currently using
> it.  It's the old_dentry that will be seen from that point on - you are
> moving it to new location by that d_move().  So I rather wonder how much
> had that thing been tested.  And I'm pretty much certain that you are
> mishandling the refcounts on configfs-internal objects, with everything
> that entails in terms of UAF and leaks.
>

The interface's stability in user-space has been tested a lot with the
test-suite for libgpiod[1] but I didn't look for leaks indeed.

> FWIW, I'm not happy about the userland API of that thing (what is supposed
> to happen if you create, move to live, then create another with the same
> name and try to move it to live or original back from live?), but
> Documentation/filesystems/configfs.rst is too sparse on such details.
> So I would like to see the specifics on that as well.  _Before_ signing
> up on anything, including "we can fix it up after merge".

Understood. I've sent out a new PR without these changes. I'll start
another thread asking for your help on the correct approach and maybe
some better ideas for the user interface.

Thanks,
Bartosz

[1] https://patchwork.ozlabs.org/project/linux-gpio/patch/20210429094734.9585-3-brgl@bgdev.pl/
