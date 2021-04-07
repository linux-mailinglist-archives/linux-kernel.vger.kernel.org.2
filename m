Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B772B356CB4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352488AbhDGMxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:53:32 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:45965 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhDGMxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:53:31 -0400
Received: by mail-oo1-f49.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so4504562oop.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 05:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKDgU1yLjGyHNHcGNUpZAwk4xvj+aA7x3EWVsTIYXaM=;
        b=ktky2oa7SjHOUUGHPZL3v0zK+ph6KbRsXMb/vOSeKFlYJQkpIaqJAoOIWJCYurYiIK
         7Ln9hotcOjAAwXz8Xa1f+Nelao31sEfyVNfIQHWh19myuktnOJ7h/dqc9r7AnpjThaDi
         l83VYHgWrHyscaXit+2Xy6UMIdN5EwCg3dliS4Hb35PvX560VodnvuAvyNZznAQx6YDn
         I7CEIM8kXKh3ZarRfgrMwOGIYyiQCO83pOADZdOB60wbBkf7pOCuRTiSRDMhUtao0S1d
         2Cs/c39f6jvnJ9NxyCYKHy4LMeZ3tk4Z+WjtRk4JwJfZEYv+jPaegsJW9F9GgUmi7htZ
         F6pA==
X-Gm-Message-State: AOAM530TMOZZE57SWJ2daVzYZsM3hLaptFf9wNLDFPDg0/Q3dRxRYp2p
        A60MA5xyoO4A0pwqEH1HFjfb4fWEGBlDEsG/85Q=
X-Google-Smtp-Source: ABdhPJz8mb1hCS4cIl6U4FHNeJ5uOpyx6a996s7hvJbkQgdnUhn3XTyKvGZy11XSsWh1QMAUgHtEQOPmev/ojEVETtk=
X-Received: by 2002:a4a:41cb:: with SMTP id x194mr2961645ooa.1.1617800000246;
 Wed, 07 Apr 2021 05:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210329195238.9455-1-acz@semihalf.com> <1c086b9e-d5c2-6e8d-1d81-748935b0dd64@intel.com>
 <20210330154957.GU2542@lahna.fi.intel.com> <CAB4aORU9N9684j4eqKPUx7s5NrfO_37=EmR3JoSPaA4RvY87OQ@mail.gmail.com>
In-Reply-To: <CAB4aORU9N9684j4eqKPUx7s5NrfO_37=EmR3JoSPaA4RvY87OQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Apr 2021 14:53:09 +0200
Message-ID: <CAJZ5v0hzbJmTy=X8R60FYqKkmhLama7C_ADWLPQ2k0SuJ4UGeg@mail.gmail.com>
Subject: Re: [PATCH] resource: Prevent irqresource_disabled() from erasing flags
To:     Angela Czubak <acz@semihalf.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        upstream@semihalf.com, Dmitry Torokhov <dtor@chromium.org>,
        linux-acpi <linux-acpi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 1:01 PM Angela Czubak <acz@semihalf.com> wrote:
>
> On Tue, Mar 30, 2021 at 5:50 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Tue, Mar 30, 2021 at 05:09:42PM +0200, Rafael J. Wysocki wrote:
> > > On 3/29/2021 9:52 PM, Angela Czubak wrote:
> > > > Do not overwrite flags as it leads to erasing triggering and polarity
> > > > information which might be useful in case of hard-coded interrupts.
> > > > This way the information can be read later on even though mapping to
> > > > APIC domain failed.
> > > >
> > > > Signed-off-by: Angela Czubak <acz@semihalf.com>
> > > > ---
> > > > Some Chromebooks use hard-coded interrupts in their ACPI tables.
> > > > This is an excerpt as dumped on Relm:
> > > >
> > > > ...
> > > >              Name (_HID, "ELAN0001")  // _HID: Hardware ID
> > > >              Name (_DDN, "Elan Touchscreen ")  // _DDN: DOS Device Name
> > > >              Name (_UID, 0x05)  // _UID: Unique ID
> > > >              Name (ISTP, Zero)
> > > >              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> > > >              {
> > > >                  Name (BUF0, ResourceTemplate ()
> > > >                  {
> > > >                      I2cSerialBusV2 (0x0010, ControllerInitiated, 0x00061A80,
> > > >                          AddressingMode7Bit, "\\_SB.I2C1",
> > > >                          0x00, ResourceConsumer, , Exclusive,
> > > >                          )
> > > >                      Interrupt (ResourceConsumer, Edge, ActiveLow, Exclusive, ,, )
> > > >                      {
> > > >                          0x000000B8,
> > > >                      }
> > > >                  })
> > > >                  Return (BUF0) /* \_SB_.I2C1.ETSA._CRS.BUF0 */
> > > >              }
> > > > ...
> > > >
> > > > This interrupt is hard-coded to 0xB8 = 184 which is too high to be mapped
> > > > to IO-APIC, so no triggering information is propagated as acpi_register_gsi()
> > > > fails and irqresource_disabled() is issued, which leads to erasing triggering
> > > > and polarity information.
> > > > If that function added its flags instead of overwriting them the correct IRQ
> > > > type would be set even for the hard-coded interrupts, which allows device driver
> > > > to retrieve it.
> > > > Please, let me know if this kind of modification is acceptable.
> > >
> > > From the quick look it should not be problematic, but it needs to be checked
> > > more carefully.
> > >
> > > Mika, what do you think?
> >
> > I think it makes sense. We still set IORESOURCE_DISABLED unconditionally
> > so this should not cause issues. In theory at least :)
> >
> Is there anything else you would need me to do regarding the patch?

Yes, please resend it with a CC to linux-acpi@vger.kernel.org for more
visibility.

> I suppose there are more platforms that could benefit from not erasing
> the flags, so if this patch is fit for upstream, can we continue the
> process?
>
> > > >   include/linux/ioport.h | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > > > index 55de385c839cf..647744d8514e0 100644
> > > > --- a/include/linux/ioport.h
> > > > +++ b/include/linux/ioport.h
> > > > @@ -331,7 +331,7 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
> > > >   {
> > > >     res->start = irq;
> > > >     res->end = irq;
> > > > -   res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> > > > +   res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> > > >   }
> > > >   extern struct address_space *iomem_get_mapping(void);
> > >
