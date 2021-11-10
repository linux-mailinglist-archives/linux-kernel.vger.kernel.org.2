Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF5244C60E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 18:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhKJRk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 12:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhKJRk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:40:56 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A579C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 09:38:08 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id o26so6408391uab.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 09:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L/5bKlWK2jqLZnw24OoIYgsu36ygJL4OBTluV5iAMi0=;
        b=YGOi9WtZg7v4L1eqM5JIFtSrbt1RI2/Hr72N1ovTr7pPl2A+FO82Y4kA9UkYmUgBJP
         k+IrImwIziIL/ike7i4nac9HX5Wcw+oAm/jNf2Uxm5SsfnkLKbQThzNORfqbdZ00aMwQ
         P1uflE+GcHEbgFHWd5aDeuVc80ZPpA/OZgWxHiUulHYYeftoGlI8hKvUMfLlmoFyFjeR
         te+8E5o8YC/qM/QvF0NYDvJtoLVqxvxpz0OuPnWh0noKtjjBgvr9BebDONx0uFcaRg/m
         BJ2xlYcUyU3JbI7g0ftD90kx6EZv4SIBQx3zDJhzqRtOEf0BYgb3MHj1KcCXOtfmTh4h
         XKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L/5bKlWK2jqLZnw24OoIYgsu36ygJL4OBTluV5iAMi0=;
        b=4n4zK0igs1piVtRLjPuRxAHgh/FlGeVIytVG0gWk8AW2Pg3wpuONqz8T7g5i80df+Q
         nnclz8ZlWA6QW1o2wpcmnDeBZSwHnD6ax00ppmK5zVrO3f2WSROnjqfS9zq6PmbmaDMo
         rwlLJf4c1LHCPLpiTKclNLkMxEmHsfIVWMjJT7N7Tl+IBvtEpZ7oR1T3/MUgACG8d7ub
         R6iNDPsKOld4bsKzib39ofwa5v0XeGa7b313/8+f1KHrRiJ6Vp+q0BgAY9HtaVeF6Ntn
         USMpFFoO3AlU0jrfs5WLNXa5rauYGgqXCC/IaDj3z3ULc/CdKeulGGuUF3mLEeCIELIR
         oHTQ==
X-Gm-Message-State: AOAM533eXtoHnOXIsvH06w6ttlwqvtrpncUawWmdok2eW3/4MkISB99C
        cwH/26Tbmnte5dwBbM7V8/pJcFlOz9sJ0biaOfflDQ==
X-Google-Smtp-Source: ABdhPJzFXZtG1BUJ8WT8SicIRYd+ZqU6KCwdhnMW0GJlgj13lB6xTaSmm8ZlzkFajzsRXLjYorI9Zqu+bdLv9WM35Uw=
X-Received: by 2002:a67:ba0c:: with SMTP id l12mr742416vsn.21.1636565887682;
 Wed, 10 Nov 2021 09:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
 <YYpNOMtp7Kwf0fho@kroah.com> <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
 <YYpsq/umygfTb8mM@kroah.com> <CAHifhD6K5hbpHS-X+2L=pfUe+7OpyTbB7uyh8WGbdaeBMwoYPg@mail.gmail.com>
 <CAHp75VfbYsyC=7Ncnex1f_jiwrZhExDF7iy4oSGZgS1cHmsN0Q@mail.gmail.com>
 <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
 <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com> <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
In-Reply-To: <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Wed, 10 Nov 2021 14:37:56 -0300
Message-ID: <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Richard Hughes <hughsient@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 1:32 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Nov 10, 2021 at 3:13 PM Mauro Lima <mauro.lima@eclypsium.com> wro=
te:
> >
> > On Wed, Nov 10, 2021 at 7:00 AM Hans-Gert Dahmen
> > <hans-gert.dahmen@immu.ne> wrote:
> > >
> > > Am Mi., 10. Nov. 2021 um 10:25 Uhr schrieb Andy Shevchenko
> > > <andy.shevchenko@gmail.com>:
> > > >
> > > > On Wed, Nov 10, 2021 at 11:17 AM Hans-Gert Dahmen
> > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > Am Mi., 10. Nov. 2021 um 10:05 Uhr schrieb Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com>:
> > > > > > On Wed, Nov 10, 2021 at 10:37 AM Hans-Gert Dahmen
> > > > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > > > Am Mi., 10. Nov. 2021 um 07:35 Uhr schrieb Andy Shevchenko
> > > > > > > <andy.shevchenko@gmail.com>:
> > > > > > > > On Tuesday, November 9, 2021, Hans-Gert Dahmen <hans-gert.d=
ahmen@immu.ne> wrote:
> > > > > > > >> Am Di., 9. Nov. 2021 um 13:42 Uhr schrieb Greg KH <gregkh@=
linuxfoundation.org>:
> > > > > >
> > > > > > > >> > Do you have a pointer to these complex and buggy drivers=
 anywhere?
> > > > > > > >>
> > > > > > > >> I am talking about the linux-mtd intel-spi driver for exam=
ple, but I
> > > > > > > >> feel that this gets the discussion in the wrong direction.
> > > > > > > >
> > > > > > > > This is the driver that covers all BIOSes on modern x86\64.=
 What=E2=80=99s wrong with it? Why do you need this?!
> > > > > > > >
> > > > > > > > If it=E2=80=99s buggy, where is the bug reports from you or=
 somebody else?
> > > > > > >
> > > > > > > Please see Mauro's mail in this thread from yesterday below:
> > > > > >
> > > > > > I didn't get this. What's wrong with the response from the auth=
or of
> > > > > > intel-spi (since we are speaking about it, let me add him to th=
e
> > > > > > thread)?
> > > > > > What you are trying to do is to sneak around with ugly hack beh=
ind the
> > > > > > proper subsystem's back.
> > > > > >
> > > > > > NAK as I already said.
> > > > >
> > > > > There is nothing wrong with the response. Also we are not trying =
to
> > > > > sneak anything into the kernel. This just is no mtd or spi driver=
, it
> > > > > is not even a driver. What this does is it opens back up a portio=
n of
> > > > > memory that can not be read anymore through /dev/mem on locked do=
wn
> > > > > systems with SecureBoot enabled. This portion of memory is active=
ly
> > > > > being used by userspace programs. We, 9elements, Eclypsium, fwudp=
 and
> > > > > immune are among those who rely upon this to improve the security=
 of
> > > > > x86_64 linux devices.
> > > >
> > > > I appreciate this.
> > > >
> > > > x86_64 starting from long time ago has more or less standard hardwa=
re
> > > > interface for BIOS chip, i.e. SPI NOR. PCH usually has a separate h=
ost
> > > > controller and we have the driver in the kernel for that (coverage =
of
> > > > the systems may not be 100%, but close enough). Now you are trying =
to
> > > > repeat something that is _already_ provided by the kernel. Correct?
> > >
> > > Yes and no. We are not repeating the functionality of the SPI driver
> > > because we don't read nor write the flash specifically. What we do, i=
s
> > > we make the boot vector readable by userspace when it is not
> > > accessible by /dev/mem. It happens to be a portion of the SPI flash
> > > but that doesn't have to be the case because the required view upon i=
o
> > > memory here is CPU-centric and the rest of the system could be built
> > > in a way that backs that memory window differently. However, this is
> > > more or less hypothetical if you ignore some probably never-used bits
> > > that can be set in PCH registers. As I said, effectively we are tryin=
g
> > > to partially revert the lockdown on /dev/mem to be able to do a
> > > harmless read on an important memory range. From that point of view w=
e
> > > are trying to keep functionality intact. The interface being used her=
e
> > > has not changed a bit since 15 years and it probably will stay that
> > > way. In contrast to the intel-spi driver this will likely cover more
> > > future and past systems in different use-cases with fewer lines of
> > > code and next to no maintenance.
> > >
> > > >
> > > > > Now what happens is that more distros start to
> > > > > lock down their kernels and require signed modules. With the mtd
> > > > > driver not working on those machine to read the bios binary, you =
are
> > > > > effectively forcing users into less secure system configurations =
(i.e.
> > > > > opening up the whole /dev/mem and/or disabling SecureBoot) just t=
o be
> > > > > able to run fwupd or other tools to assess firmware information. =
The
> > > > > issue of being able to assess and compare the bios binary to the =
one
> > > > > publicly available from the vendors is increasingly getting impor=
tant
> > > > > in the wake of recent CVEs about supply-chain attacks where UEFI
> > > > > malware was pre-installed. So we are not even doing anything new =
here,
> > > > > you are just making life harder for everybody.
> > > >
> > > > Why me? As far as I got it from above the bottleneck is the distros
> > > > which do not enable the driver. So why not go and work with them?
> > > >
> > >
> > > Oh come on,  the distros have no choice here. Either not provide a
> > > more secure locked down system or allow a dangerous driver where
> > > patches to make it less dangerous are not welcome. And even if the
> > > latter could be solved, the history clearly is that it is in no way
> > > not even remotely as reliable as the memory region my patch is
> > > relaying to userspace.
> >
> > As Hans already said, it is a no go to put drivers tagged as
> > _(DANGEROUS)_ within the kernel distro. In this thread [1] from the
> > latest changes to the intel-spi driver I asked if there is any reason
> > to keep the dangerous tag or if there is any work we can do to achieve
> > this. As long as this tag is in the driver, we can't use the driver.
> >
> > [1] https://lore.kernel.org/all/CAArk9MPWh4f1E=3DecKBHy8PFzvU_y_ROgDyUU=
_O3ZQ0FuMhkj5Q@mail.gmail.com/
>
> From [1]:
>   "> IMHO we can make certain parts of the driver, that are known not to
>   > cause any issues available without the DANGEROUS. I mean the controll=
er
>   > exposes some information that I think you are intersted in and that d=
oes
>   > not cause anything to be sent to the flash chip itself.
>   This will work for me."
>
> And?.. Where is your proposal to modify the driver the way maintainer
> and you will be happy? Why do we see this instead? Try again to
> collaborate with Intel SPI driver author(s) / maintainer(s) by sending
> the proposal that may work.

I talked with Mika and now I'm working on a way to read BIOSWE, BIOSLE
and FLOCKDN values from the chip through pci (not using intel-spi
driver), you will see it in near future. Unfortunately this is only to
see if the vendor did the homework and set the flags correctly before
the spi leaves the factory. This is still useful to see if the write
protection mechanism it's in place.
We are still interested in a way to get the BIOS, for this the first
way you think of is reading it using the spi but after this (also from
[1] )
> I don't think we want to remove that. This driver is not for regular
> users, at least in its current form.
It seems that is not an option to use it.

> Why do we see this instead?

This is not my patch.

> Try again to collaborate with Intel SPI driver author(s) / maintainer(s) =
by sending
> the proposal that may work.

The proposal I sent makes the driver work only with read ops, but that
was not the issue with this driver. The issue was something related to
a status register and this was fixed. So if there is no issue with
write/erase ops, the bug was fixed and there is no intention to remove
the tag. What kind of proposal are we talking about?

> --
> With Best Regards,
> Andy Shevchenko

Thanks, Mauro.
