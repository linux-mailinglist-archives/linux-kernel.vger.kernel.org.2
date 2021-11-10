Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2106844C1F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhKJNQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhKJNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:16:04 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DDBC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:13:16 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id b3so4649368uam.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rvvr2RtA4N64UFGQXK0jopqcOfmPc4aLE1qDp/yCm4Q=;
        b=RzyFtbmtLFy/pM9mFZc38CpU11SdAryotxtOK/AWdRBqNoNgID8lPX+XDy/riYG+6H
         7QQqz5Ub14mcgi8x3GumK5Ujau+Y9vJaYsKE5yoHDlHXQBIZzntPL+Pdxeel8s7Z0mgp
         FMRuHfFB7oxmlyI33E9nIx9Nhl1zhzn8uBg9+58fyl41NF2xHyTMEPEmO4y2Tdx5nqhy
         KDRMr6/RzxpZRRceCtLg75avMkk/rywvtE8ZdwAPeZzcZr6s4dBnfdd7kKLlXitupBDO
         UfSw/PyodEFP6SV+8+3O5wdOQXcrBSSN0Jm32/Lfix8Kp71fw7lE/dfYFrqcPo/uMI2R
         84YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rvvr2RtA4N64UFGQXK0jopqcOfmPc4aLE1qDp/yCm4Q=;
        b=2A1wbXS1DYv1Elc8zRXXD2yfPo+lMZAZ46j6zQrHFuDk3l9RYP/hQWusxB9r+eXknQ
         V2gPBjUdTKfnVMOUmlgb8q+MYNwd4T2FIG7NoPMdXQvAfuBJrTHjPNH2Xba1UlUSjdiT
         Y6maXgFHb3NUjHUJeAhhBg+8dSRuodYvF6qnn8iJeUHVxZCwSZO0BPnk1CbRZjndAWMr
         1OKZBhjryVXaLBmZ6S5t0tGez1Uxly6rn4H59u7ODRYxB1rUNbOYjhdOcKUqjQPiekDG
         quPZ3h0WR3hiIUbOAFA4VEJ/cUT+8r+bYta+KqwMQz09Oe9HKmUkm0rKoj7vr4Ju4XvY
         PdRg==
X-Gm-Message-State: AOAM530K6qiEKcRk+AdIXV7h9khRfWE//vQsshxgmqMR7U3bYsnwR46e
        1pUUoPuAaQRvsmS0+EM48n66JX7pYgg79VENYwWFlQ==
X-Google-Smtp-Source: ABdhPJwH8wajx7BTO0aUFOl6fZQyQHZ6WnBQygNHEtDOZGsedxX+DRVxW7t7+Vhm7IcTswn+n2TA2WDNGb5a2uMHp60=
X-Received: by 2002:a67:f805:: with SMTP id l5mr44536272vso.17.1636549995973;
 Wed, 10 Nov 2021 05:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
 <YYpNOMtp7Kwf0fho@kroah.com> <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
 <YYpsq/umygfTb8mM@kroah.com> <CAHifhD6K5hbpHS-X+2L=pfUe+7OpyTbB7uyh8WGbdaeBMwoYPg@mail.gmail.com>
 <CAHp75VfbYsyC=7Ncnex1f_jiwrZhExDF7iy4oSGZgS1cHmsN0Q@mail.gmail.com>
 <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
 <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com> <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
In-Reply-To: <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Wed, 10 Nov 2021 10:13:04 -0300
Message-ID: <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Wed, Nov 10, 2021 at 7:00 AM Hans-Gert Dahmen
<hans-gert.dahmen@immu.ne> wrote:
>
> Am Mi., 10. Nov. 2021 um 10:25 Uhr schrieb Andy Shevchenko
> <andy.shevchenko@gmail.com>:
> >
> > On Wed, Nov 10, 2021 at 11:17 AM Hans-Gert Dahmen
> > <hans-gert.dahmen@immu.ne> wrote:
> > > Am Mi., 10. Nov. 2021 um 10:05 Uhr schrieb Andy Shevchenko
> > > <andy.shevchenko@gmail.com>:
> > > > On Wed, Nov 10, 2021 at 10:37 AM Hans-Gert Dahmen
> > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > Am Mi., 10. Nov. 2021 um 07:35 Uhr schrieb Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com>:
> > > > > > On Tuesday, November 9, 2021, Hans-Gert Dahmen <hans-gert.dahme=
n@immu.ne> wrote:
> > > > > >> Am Di., 9. Nov. 2021 um 13:42 Uhr schrieb Greg KH <gregkh@linu=
xfoundation.org>:
> > > >
> > > > > >> > Do you have a pointer to these complex and buggy drivers any=
where?
> > > > > >>
> > > > > >> I am talking about the linux-mtd intel-spi driver for example,=
 but I
> > > > > >> feel that this gets the discussion in the wrong direction.
> > > > > >
> > > > > > This is the driver that covers all BIOSes on modern x86\64. Wha=
t=E2=80=99s wrong with it? Why do you need this?!
> > > > > >
> > > > > > If it=E2=80=99s buggy, where is the bug reports from you or som=
ebody else?
> > > > >
> > > > > Please see Mauro's mail in this thread from yesterday below:
> > > >
> > > > I didn't get this. What's wrong with the response from the author o=
f
> > > > intel-spi (since we are speaking about it, let me add him to the
> > > > thread)?
> > > > What you are trying to do is to sneak around with ugly hack behind =
the
> > > > proper subsystem's back.
> > > >
> > > > NAK as I already said.
> > >
> > > There is nothing wrong with the response. Also we are not trying to
> > > sneak anything into the kernel. This just is no mtd or spi driver, it
> > > is not even a driver. What this does is it opens back up a portion of
> > > memory that can not be read anymore through /dev/mem on locked down
> > > systems with SecureBoot enabled. This portion of memory is actively
> > > being used by userspace programs. We, 9elements, Eclypsium, fwudp and
> > > immune are among those who rely upon this to improve the security of
> > > x86_64 linux devices.
> >
> > I appreciate this.
> >
> > x86_64 starting from long time ago has more or less standard hardware
> > interface for BIOS chip, i.e. SPI NOR. PCH usually has a separate host
> > controller and we have the driver in the kernel for that (coverage of
> > the systems may not be 100%, but close enough). Now you are trying to
> > repeat something that is _already_ provided by the kernel. Correct?
>
> Yes and no. We are not repeating the functionality of the SPI driver
> because we don't read nor write the flash specifically. What we do, is
> we make the boot vector readable by userspace when it is not
> accessible by /dev/mem. It happens to be a portion of the SPI flash
> but that doesn't have to be the case because the required view upon io
> memory here is CPU-centric and the rest of the system could be built
> in a way that backs that memory window differently. However, this is
> more or less hypothetical if you ignore some probably never-used bits
> that can be set in PCH registers. As I said, effectively we are trying
> to partially revert the lockdown on /dev/mem to be able to do a
> harmless read on an important memory range. From that point of view we
> are trying to keep functionality intact. The interface being used here
> has not changed a bit since 15 years and it probably will stay that
> way. In contrast to the intel-spi driver this will likely cover more
> future and past systems in different use-cases with fewer lines of
> code and next to no maintenance.
>
> >
> > > Now what happens is that more distros start to
> > > lock down their kernels and require signed modules. With the mtd
> > > driver not working on those machine to read the bios binary, you are
> > > effectively forcing users into less secure system configurations (i.e=
.
> > > opening up the whole /dev/mem and/or disabling SecureBoot) just to be
> > > able to run fwupd or other tools to assess firmware information. The
> > > issue of being able to assess and compare the bios binary to the one
> > > publicly available from the vendors is increasingly getting important
> > > in the wake of recent CVEs about supply-chain attacks where UEFI
> > > malware was pre-installed. So we are not even doing anything new here=
,
> > > you are just making life harder for everybody.
> >
> > Why me? As far as I got it from above the bottleneck is the distros
> > which do not enable the driver. So why not go and work with them?
> >
>
> Oh come on,  the distros have no choice here. Either not provide a
> more secure locked down system or allow a dangerous driver where
> patches to make it less dangerous are not welcome. And even if the
> latter could be solved, the history clearly is that it is in no way
> not even remotely as reliable as the memory region my patch is
> relaying to userspace.

As Hans already said, it is a no go to put drivers tagged as
_(DANGEROUS)_ within the kernel distro. In this thread [1] from the
latest changes to the intel-spi driver I asked if there is any reason
to keep the dangerous tag or if there is any work we can do to achieve
this. As long as this tag is in the driver, we can't use the driver.

[1] https://lore.kernel.org/all/CAArk9MPWh4f1E=3DecKBHy8PFzvU_y_ROgDyUU_O3Z=
Q0FuMhkj5Q@mail.gmail.com/

> Hans-Gert
