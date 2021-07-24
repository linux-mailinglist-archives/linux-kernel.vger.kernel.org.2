Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870923D4788
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 14:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhGXLai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 07:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231511AbhGXLag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 07:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627128667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6AcUZFHd8G5i76Vd2O5qx5HOAivGVNtt24z6TdHQF1o=;
        b=epNu0UjSa2Naa7AER7Zbs1JPjnA77O/hYw5Lf1a0C22rm/SOvU+fW9HVdjm7MfmS4a9FTJ
        zNGvewInVYrtc/M8ZpMSI8FOEbvlFuMYzDCHRbAqSAP3zwVkLhudCzSBEfe6RNWLOtHQS7
        b94DBLfx7hig+5M9VJiHMYyWwrVyhBM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-dNw8lvy3OVK0F4gs-7lfdg-1; Sat, 24 Jul 2021 08:11:06 -0400
X-MC-Unique: dNw8lvy3OVK0F4gs-7lfdg-1
Received: by mail-wr1-f72.google.com with SMTP id p2-20020a5d48c20000b0290150e4a5e7e0so2025756wrs.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 05:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6AcUZFHd8G5i76Vd2O5qx5HOAivGVNtt24z6TdHQF1o=;
        b=Ro6V+J2qt3s7CP4sihFvDxvsUaHlMViRHuCnzDjDKp1DbK01Nz5cduRFDYhvrId6pU
         dXeDBY9VgA79+56qycxAVPYWM2QmgJcTEPuLzpzZKR6GSfU2ZQioM5ji2HYEOkHjDxKf
         QtxbxA1JMDk+fwc6T95k9lKDwYzgIKMIZEqxkLnndDX0ToBD/41EttAgPZkGq1iN+axA
         V/dSpvAEOcoCfCghtZXzrK5mynnDKbW7L1SDieDR02qLBx9xEpc+otAIhyuCFtBIkV74
         OVl5JdsbYeXTieONRgNeyEZPgQnSQjvrzDjMqEUcC7zf1j6vUP8OleF/Ih/ljk+7XLgi
         scqg==
X-Gm-Message-State: AOAM532bK/qhsU6ENOn67r9ZLvGiEUW2qfK7PeKtrJBtlymEvherHBMI
        7wMw14AIrp5P+RLIFn2oVVPD35J15wKIQCKBxUgalnvAbzV6TflQ5f15c7KWTZ2GYnV/XCM2tO2
        /4yOsLoEj31a+OOPAykJqbWcZP/Nl//KjcBt6snec
X-Received: by 2002:a5d:6644:: with SMTP id f4mr9516228wrw.177.1627128665077;
        Sat, 24 Jul 2021 05:11:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1U/Pv5yVb884gxpjWlzIwo4rESJ/20Yl1+UEyfV86RbeZzOoyylb1wUn4yvDX+I0fEFDwDPAH06HqLqn5dkc=
X-Received: by 2002:a5d:6644:: with SMTP id f4mr9516213wrw.177.1627128664906;
 Sat, 24 Jul 2021 05:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210723224617.3088886-1-kherbst@redhat.com> <CAK8P3a3u_jsxQW4dPXtsdKkw1mjKXL-h=qN1SGHytvUMPf3fPw@mail.gmail.com>
 <CACO55tuNWk6emjnnukgv9h-9jbpVP564Ogmi7TGbybc9n5v+ZQ@mail.gmail.com> <CAK8P3a1BceSaiqkTf+9Pr4Br-G3kgqD4ztwiaS7fxNiUg9t7Dg@mail.gmail.com>
In-Reply-To: <CAK8P3a1BceSaiqkTf+9Pr4Br-G3kgqD4ztwiaS7fxNiUg9t7Dg@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 24 Jul 2021 14:10:53 +0200
Message-ID: <CACO55tsoi2akTKvFdz3p48UHRjFXDW7dUnOM8qVePBFWet-3UQ@mail.gmail.com>
Subject: Re: [PATCH] nouveau: make backlight support non optional
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 1:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sat, Jul 24, 2021 at 11:55 AM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Sat, Jul 24, 2021 at 8:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > On Sat, Jul 24, 2021 at 12:47 AM Karol Herbst <kherbst@redhat.com> wrote:
> > > >
> > > > In the past this only led to compilation issues. Also the small amount of
> > > > extra .text shouldn't really matter compared to the entire nouveau driver
> > > > anyway.
> > > >
> > >
> > > >         select DRM_TTM_HELPER
> > > > -       select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
> > > > -       select ACPI_VIDEO if ACPI && X86 && BACKLIGHT_CLASS_DEVICE && INPUT
> > > > +       select BACKLIGHT_CLASS_DEVICE
> > > > +       select ACPI_VIDEO if ACPI && X86 && INPUT
> > > >         select X86_PLATFORM_DEVICES if ACPI && X86
> > > >         select ACPI_WMI if ACPI && X86
> > >
> > > I think the logic needs to be the reverse: instead of 'select
> > > BACKLIGHT_CLASS_DEVICE',
> > > this should be 'depends on BACKLIGHT_CLASS_DEVICE', and the same for ACPI_VIDEO.
> > >
> > > We may want to add 'default DRM || FB' to BACKLIGHT_CLASS_DEVICE in the
> > > process so we don't lose it for users doing 'make oldconfig' or 'make defconfig'
> > >
> >
> > I think the problem with
> > "depends" is that the user needs to enable backlight support first
> > before even seeing nouveau and I don't know if that makes sense. But
> > maybe "default" is indeed helping here in this case.
>
> In general, no driver should ever 'select' a subsystem. Otherwise you end up
> with two problems:
>
> - enabling this one driver suddenly makes all other drivers that have
> a dependency
>   on this visible, and some of those might have a 'default y', so you
> end up with
>   a ton of stuff in the kernel that would otherwise not be there.
>
> - It becomes impossible to turn it off as long as some driver has that 'select'.
>   This is the pretty much the same problem as the one you describe, just
>    the other side of it.
>
> - You run into dependency loops that prevent a successful build when some
>    other driver has a 'depends on'. Preventing these loops was the main
>    reason I said we should do this change.
>
> In theory we could change the other 85 drivers that use 'depends on' today,
> and make BACKLIGHT_CLASS_DEVICE a hidden symbol that only ever
> selected by the drivers that need it. This would avoid the third problem but
> not the other one.
>
>       Arnd
>

I see. Yeah, I guess we can do it this way then. I just wasn't aware
of the bigger picture here. Thanks for explaining.

