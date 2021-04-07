Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0514D356ABB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbhDGLBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbhDGLBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:01:31 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A67C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 04:01:22 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id j206so11021715ybj.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 04:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owbm4A4IMG4sqcQv2/3Uo7ClgudJx95v6vpnM66KkFU=;
        b=bUvE1/1N/l5voJA7Ui3fX+RNTz+y9x7ktpDuGl3OkWStJMPb/aONqmGwCO9LoIExwR
         mQXsVu6tgdRhG+/Pj4Bl8sgK1yB5on+G2XhJjEMfhbgRHC2+vbiArymUgLdlBg88z509
         7KA4JWCsgttHOFd5qvkTuwi2yUGggYrggfYNc8QBzPkTdVJZl3QWmzWt9D98oZU9KRfy
         AnColcNT49urXCRyRlTvU5UU0f0EM9VFqGMX3zv2UkNsGOGzKWUqilsTc+qdWoc5SWby
         HOCI3CO3/n4tnEPOCyYjKlTmFR8k+guADRXO4VTHFnJ6dL1zugW+hqhnjFqnE5fbTEsm
         +FzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owbm4A4IMG4sqcQv2/3Uo7ClgudJx95v6vpnM66KkFU=;
        b=V1tZ2PsScooOvxPuQ6ehxFiGZ/gGel0d8N4zoZPK1onUeApF0Fs4044aUEJUps3r1B
         S1K2Y8sUxq7Gp6cqTtHTAoIjvZEst7hDGENgSu33hM6LNO8KQ/hVN2fEOmLQd2j4NX9E
         FLmx9+nC9rQ6Wj3xCZHRLSZAxn17SvNZAZERohhtuE6q4H1rTfDg1Dbyzxx+TIxmL5N2
         22cMDTEFTPORFrsNyf79Q2LkP50WRuJVqatL0fo1xTmC1nosrmrVmhoytlzUbkPpvRdQ
         K71HqkBY6vdKfvHXqXv4SxHTQZ+nLLLI6j66aUWuMomm2HFYtPc1ui+gFCZ1kUjMKlKP
         L4Jw==
X-Gm-Message-State: AOAM530tASRYO6RgUamiDYQuS/EiW0DUAphjvi1X6mzvS7rdbfxUd28i
        XDwv6/yhYZNxF4Pm11grgwwmDM4w3pQY4Z8WUTOxWg==
X-Google-Smtp-Source: ABdhPJwHB1FrhvewWwbmCgUrRJH/CaeA5IOVNNHvijJ81c60pRrgw07MabyDyroA83YBMCs7NGUtqGgmaPfc49fUvH8=
X-Received: by 2002:a5b:34a:: with SMTP id q10mr3712454ybp.224.1617793281311;
 Wed, 07 Apr 2021 04:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210329195238.9455-1-acz@semihalf.com> <1c086b9e-d5c2-6e8d-1d81-748935b0dd64@intel.com>
 <20210330154957.GU2542@lahna.fi.intel.com>
In-Reply-To: <20210330154957.GU2542@lahna.fi.intel.com>
From:   Angela Czubak <acz@semihalf.com>
Date:   Wed, 7 Apr 2021 13:01:10 +0200
Message-ID: <CAB4aORU9N9684j4eqKPUx7s5NrfO_37=EmR3JoSPaA4RvY87OQ@mail.gmail.com>
Subject: Re: [PATCH] resource: Prevent irqresource_disabled() from erasing flags
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        akpm@linux-foundation.org, john.garry@huawei.com,
        linux-kernel@vger.kernel.org, upstream@semihalf.com,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-acpi <linux-acpi@intel.com>, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 5:50 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Tue, Mar 30, 2021 at 05:09:42PM +0200, Rafael J. Wysocki wrote:
> > On 3/29/2021 9:52 PM, Angela Czubak wrote:
> > > Do not overwrite flags as it leads to erasing triggering and polarity
> > > information which might be useful in case of hard-coded interrupts.
> > > This way the information can be read later on even though mapping to
> > > APIC domain failed.
> > >
> > > Signed-off-by: Angela Czubak <acz@semihalf.com>
> > > ---
> > > Some Chromebooks use hard-coded interrupts in their ACPI tables.
> > > This is an excerpt as dumped on Relm:
> > >
> > > ...
> > >              Name (_HID, "ELAN0001")  // _HID: Hardware ID
> > >              Name (_DDN, "Elan Touchscreen ")  // _DDN: DOS Device Name
> > >              Name (_UID, 0x05)  // _UID: Unique ID
> > >              Name (ISTP, Zero)
> > >              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> > >              {
> > >                  Name (BUF0, ResourceTemplate ()
> > >                  {
> > >                      I2cSerialBusV2 (0x0010, ControllerInitiated, 0x00061A80,
> > >                          AddressingMode7Bit, "\\_SB.I2C1",
> > >                          0x00, ResourceConsumer, , Exclusive,
> > >                          )
> > >                      Interrupt (ResourceConsumer, Edge, ActiveLow, Exclusive, ,, )
> > >                      {
> > >                          0x000000B8,
> > >                      }
> > >                  })
> > >                  Return (BUF0) /* \_SB_.I2C1.ETSA._CRS.BUF0 */
> > >              }
> > > ...
> > >
> > > This interrupt is hard-coded to 0xB8 = 184 which is too high to be mapped
> > > to IO-APIC, so no triggering information is propagated as acpi_register_gsi()
> > > fails and irqresource_disabled() is issued, which leads to erasing triggering
> > > and polarity information.
> > > If that function added its flags instead of overwriting them the correct IRQ
> > > type would be set even for the hard-coded interrupts, which allows device driver
> > > to retrieve it.
> > > Please, let me know if this kind of modification is acceptable.
> >
> > From the quick look it should not be problematic, but it needs to be checked
> > more carefully.
> >
> > Mika, what do you think?
>
> I think it makes sense. We still set IORESOURCE_DISABLED unconditionally
> so this should not cause issues. In theory at least :)
>
Is there anything else you would need me to do regarding the patch?
I suppose there are more platforms that could benefit from not erasing
the flags, so if this patch is fit for upstream, can we continue the
process?

> > >   include/linux/ioport.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > > index 55de385c839cf..647744d8514e0 100644
> > > --- a/include/linux/ioport.h
> > > +++ b/include/linux/ioport.h
> > > @@ -331,7 +331,7 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
> > >   {
> > >     res->start = irq;
> > >     res->end = irq;
> > > -   res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> > > +   res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> > >   }
> > >   extern struct address_space *iomem_get_mapping(void);
> >
