Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8FC44C50A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhKJQfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhKJQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:35:20 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03786C061764;
        Wed, 10 Nov 2021 08:32:32 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so12891793edz.2;
        Wed, 10 Nov 2021 08:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J7u+0TCDsdNfLQac9qkUaveXW0Na0gRFZCycurq9asE=;
        b=T+OeWq3L4QmQl03j+ds7z/WjXZv2yVLT+clzGNC0hLtw7MhxRvkmqgjEFDj2tWxeWo
         3qX5InByBlv6/v/UW4kajcBWpEr95PZtMoFJtx6MAZ4Z/ynsx5ZltU4u2MV+gDwlRpxR
         LhklfF80bT83CdIqsrwx8Y3TGMJ8co0RIvZCHe+dWE6tsblgvAUMfklygLjK/Xkq8pz7
         9TAwika7mIAQTXUE24fdiH4rveZQjvzMWmscgJ3ci5414xC9Kd3YES1ju86elZ4M3ckl
         Burydyvk1fetGxvY08bi47JdgTU5/JA7yK+s9IFTQ2bEVyn6PEtqil9nX8566eKHDh5K
         Rc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J7u+0TCDsdNfLQac9qkUaveXW0Na0gRFZCycurq9asE=;
        b=0w2UTl+i6BuG8Sh1I5OwguYuHuHLlBgumcXmjOPTkaMKPHotugNneYEhYAEZ+Yaqyh
         sg4ke/LNQO39chc6kwwUbnkdK/FoikB5v61nYP8yuyqhs/Xprs50TnM4R2ZLpqtkP23N
         y1YG6A9Yxo73afx7gNEou7+FlfBEAFXK9ahWFwlt4VdX3y33ej/PYMk//d/nrXiw9c0b
         ePYySkNdwHAVfEGQjLyDBU+JrudXbgMKtau4iU48JjKGX9YANrGzUIcVVAFoBqbgf3rM
         cn2zONQJSJ6WhettfgmRLixTqsiI7dHdnDIz6TGbb//bU3FknfoMxzx9KjIsil8Q5HGM
         aGrA==
X-Gm-Message-State: AOAM530ez9ElOjFvoZvQzUaZpWeNz3FsT+kqzevlxjMCUPWoxPvX1qbz
        OwKMgiCmS8gUowuUCtMqn/pLdM4ON+JblDpEyMM=
X-Google-Smtp-Source: ABdhPJyU6QU3nyyfXl5xVWDqIpMnKqu6jmLbKUKZw7VDuLnvxnTFsue7VewSBPvxMHKsIsdCdUQZTmCr3a5ox2UJL68=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr415238ejb.377.1636561950518;
 Wed, 10 Nov 2021 08:32:30 -0800 (PST)
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
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com> <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
In-Reply-To: <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 Nov 2021 18:31:45 +0200
Message-ID: <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Mauro Lima <mauro.lima@eclypsium.com>
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

On Wed, Nov 10, 2021 at 3:13 PM Mauro Lima <mauro.lima@eclypsium.com> wrote=
:
>
> On Wed, Nov 10, 2021 at 7:00 AM Hans-Gert Dahmen
> <hans-gert.dahmen@immu.ne> wrote:
> >
> > Am Mi., 10. Nov. 2021 um 10:25 Uhr schrieb Andy Shevchenko
> > <andy.shevchenko@gmail.com>:
> > >
> > > On Wed, Nov 10, 2021 at 11:17 AM Hans-Gert Dahmen
> > > <hans-gert.dahmen@immu.ne> wrote:
> > > > Am Mi., 10. Nov. 2021 um 10:05 Uhr schrieb Andy Shevchenko
> > > > <andy.shevchenko@gmail.com>:
> > > > > On Wed, Nov 10, 2021 at 10:37 AM Hans-Gert Dahmen
> > > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > > Am Mi., 10. Nov. 2021 um 07:35 Uhr schrieb Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com>:
> > > > > > > On Tuesday, November 9, 2021, Hans-Gert Dahmen <hans-gert.dah=
men@immu.ne> wrote:
> > > > > > >> Am Di., 9. Nov. 2021 um 13:42 Uhr schrieb Greg KH <gregkh@li=
nuxfoundation.org>:
> > > > >
> > > > > > >> > Do you have a pointer to these complex and buggy drivers a=
nywhere?
> > > > > > >>
> > > > > > >> I am talking about the linux-mtd intel-spi driver for exampl=
e, but I
> > > > > > >> feel that this gets the discussion in the wrong direction.
> > > > > > >
> > > > > > > This is the driver that covers all BIOSes on modern x86\64. W=
hat=E2=80=99s wrong with it? Why do you need this?!
> > > > > > >
> > > > > > > If it=E2=80=99s buggy, where is the bug reports from you or s=
omebody else?
> > > > > >
> > > > > > Please see Mauro's mail in this thread from yesterday below:
> > > > >
> > > > > I didn't get this. What's wrong with the response from the author=
 of
> > > > > intel-spi (since we are speaking about it, let me add him to the
> > > > > thread)?
> > > > > What you are trying to do is to sneak around with ugly hack behin=
d the
> > > > > proper subsystem's back.
> > > > >
> > > > > NAK as I already said.
> > > >
> > > > There is nothing wrong with the response. Also we are not trying to
> > > > sneak anything into the kernel. This just is no mtd or spi driver, =
it
> > > > is not even a driver. What this does is it opens back up a portion =
of
> > > > memory that can not be read anymore through /dev/mem on locked down
> > > > systems with SecureBoot enabled. This portion of memory is actively
> > > > being used by userspace programs. We, 9elements, Eclypsium, fwudp a=
nd
> > > > immune are among those who rely upon this to improve the security o=
f
> > > > x86_64 linux devices.
> > >
> > > I appreciate this.
> > >
> > > x86_64 starting from long time ago has more or less standard hardware
> > > interface for BIOS chip, i.e. SPI NOR. PCH usually has a separate hos=
t
> > > controller and we have the driver in the kernel for that (coverage of
> > > the systems may not be 100%, but close enough). Now you are trying to
> > > repeat something that is _already_ provided by the kernel. Correct?
> >
> > Yes and no. We are not repeating the functionality of the SPI driver
> > because we don't read nor write the flash specifically. What we do, is
> > we make the boot vector readable by userspace when it is not
> > accessible by /dev/mem. It happens to be a portion of the SPI flash
> > but that doesn't have to be the case because the required view upon io
> > memory here is CPU-centric and the rest of the system could be built
> > in a way that backs that memory window differently. However, this is
> > more or less hypothetical if you ignore some probably never-used bits
> > that can be set in PCH registers. As I said, effectively we are trying
> > to partially revert the lockdown on /dev/mem to be able to do a
> > harmless read on an important memory range. From that point of view we
> > are trying to keep functionality intact. The interface being used here
> > has not changed a bit since 15 years and it probably will stay that
> > way. In contrast to the intel-spi driver this will likely cover more
> > future and past systems in different use-cases with fewer lines of
> > code and next to no maintenance.
> >
> > >
> > > > Now what happens is that more distros start to
> > > > lock down their kernels and require signed modules. With the mtd
> > > > driver not working on those machine to read the bios binary, you ar=
e
> > > > effectively forcing users into less secure system configurations (i=
.e.
> > > > opening up the whole /dev/mem and/or disabling SecureBoot) just to =
be
> > > > able to run fwupd or other tools to assess firmware information. Th=
e
> > > > issue of being able to assess and compare the bios binary to the on=
e
> > > > publicly available from the vendors is increasingly getting importa=
nt
> > > > in the wake of recent CVEs about supply-chain attacks where UEFI
> > > > malware was pre-installed. So we are not even doing anything new he=
re,
> > > > you are just making life harder for everybody.
> > >
> > > Why me? As far as I got it from above the bottleneck is the distros
> > > which do not enable the driver. So why not go and work with them?
> > >
> >
> > Oh come on,  the distros have no choice here. Either not provide a
> > more secure locked down system or allow a dangerous driver where
> > patches to make it less dangerous are not welcome. And even if the
> > latter could be solved, the history clearly is that it is in no way
> > not even remotely as reliable as the memory region my patch is
> > relaying to userspace.
>
> As Hans already said, it is a no go to put drivers tagged as
> _(DANGEROUS)_ within the kernel distro. In this thread [1] from the
> latest changes to the intel-spi driver I asked if there is any reason
> to keep the dangerous tag or if there is any work we can do to achieve
> this. As long as this tag is in the driver, we can't use the driver.
>
> [1] https://lore.kernel.org/all/CAArk9MPWh4f1E=3DecKBHy8PFzvU_y_ROgDyUU_O=
3ZQ0FuMhkj5Q@mail.gmail.com/

From [1]:
  "> IMHO we can make certain parts of the driver, that are known not to
  > cause any issues available without the DANGEROUS. I mean the controller
  > exposes some information that I think you are intersted in and that doe=
s
  > not cause anything to be sent to the flash chip itself.
  This will work for me."

And?.. Where is your proposal to modify the driver the way maintainer
and you will be happy? Why do we see this instead? Try again to
collaborate with Intel SPI driver author(s) / maintainer(s) by sending
the proposal that may work.

--=20
With Best Regards,
Andy Shevchenko
