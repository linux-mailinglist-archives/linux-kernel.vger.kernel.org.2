Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B20E3D47B3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhGXMLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 08:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230449AbhGXMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 08:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627131121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SqP8PeLUX+bkAijbG1F91uxgBzPDOmlyO/TzLjQPs+k=;
        b=b6BBdr+0vrCwFxFoQWA0j0U21Fn4f8HOsHUhzq11fqIvZdHMg5V0Y9iWBAOKUqh5XW49RQ
        OrkvfFSVf171SJeWdTKQW2M0Wz5IWBXvIKDKjk0oHIQDy/jm1HESbyiSRkc4zOF02haMkx
        v1rD7/bdOslLKLIS6ZchpgGg28kcJk0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63--UrE3wI_MNqHpi-Trm6IBw-1; Sat, 24 Jul 2021 08:52:00 -0400
X-MC-Unique: -UrE3wI_MNqHpi-Trm6IBw-1
Received: by mail-wm1-f70.google.com with SMTP id f25-20020a1c6a190000b029024fa863f6b0so144166wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 05:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqP8PeLUX+bkAijbG1F91uxgBzPDOmlyO/TzLjQPs+k=;
        b=f8rdI+wRxEPCvtXblJdtt04I43kaM7LoXB/sfLsUT8JGnQU0QJyHQqPiM19P8EKQUr
         12sm3iNG08n1yelIzUq6uH36qmHogh9O6Ufnf8F+zKVaQVrSyejB3PxVIwwMkjRZprTw
         b8FidlX5DxVa3cJCrc3OZRHhJ9+HqHMuzxwnG3skUz6Q5YZzeuS4LuP1mgns83XQRwXO
         KYuh5q8+uYG0YQX+YVrq0S224RqnlNApPIt6GKegeBFlW3FeuijfMEXEtfyZjIHmbRfP
         zqYFovif/462pZibZeJjr1OoVrB+/CWsnTObil602EV6CWi8hkzSHx5XjOxlrOsR+GlD
         jmLQ==
X-Gm-Message-State: AOAM531zCNg1v4KIB+fSv4pEUSzlp/FmjuGgRgM8n4gMKWsTmuJkiBWV
        86/JaC0qwu7PdbkIU4U5+UZRgip740kqOyo8DmS6TaxdtApDB7XmwiQSCihjrny8ZdSDL57ZPhm
        R8IFr2UWgVvX+u3DJX4SgJsQcHw3bnZ5JUjoN+tb+
X-Received: by 2002:a05:600c:354a:: with SMTP id i10mr1809638wmq.171.1627131118701;
        Sat, 24 Jul 2021 05:51:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkscYT672ybkBRK9AVIA/U5x33XrDVYao8PYSEV9N4uRmE4HwCi033ERdfHRxKag3E+wklUBG0a0zMSGLw8pg=
X-Received: by 2002:a05:600c:354a:: with SMTP id i10mr1809620wmq.171.1627131118511;
 Sat, 24 Jul 2021 05:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210723224617.3088886-1-kherbst@redhat.com> <CAK8P3a3u_jsxQW4dPXtsdKkw1mjKXL-h=qN1SGHytvUMPf3fPw@mail.gmail.com>
 <CACO55tuNWk6emjnnukgv9h-9jbpVP564Ogmi7TGbybc9n5v+ZQ@mail.gmail.com>
 <CAK8P3a1BceSaiqkTf+9Pr4Br-G3kgqD4ztwiaS7fxNiUg9t7Dg@mail.gmail.com> <CACO55tsoi2akTKvFdz3p48UHRjFXDW7dUnOM8qVePBFWet-3UQ@mail.gmail.com>
In-Reply-To: <CACO55tsoi2akTKvFdz3p48UHRjFXDW7dUnOM8qVePBFWet-3UQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 24 Jul 2021 14:51:47 +0200
Message-ID: <CACO55tuceMUz2pgOM23wvcmtaTqbo6S6rCB+mfLptqJRt=fMWA@mail.gmail.com>
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

On Sat, Jul 24, 2021 at 2:10 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Sat, Jul 24, 2021 at 1:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Sat, Jul 24, 2021 at 11:55 AM Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > On Sat, Jul 24, 2021 at 8:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > > >
> > > > On Sat, Jul 24, 2021 at 12:47 AM Karol Herbst <kherbst@redhat.com> wrote:
> > > > >
> > > > > In the past this only led to compilation issues. Also the small amount of
> > > > > extra .text shouldn't really matter compared to the entire nouveau driver
> > > > > anyway.
> > > > >
> > > >
> > > > >         select DRM_TTM_HELPER
> > > > > -       select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
> > > > > -       select ACPI_VIDEO if ACPI && X86 && BACKLIGHT_CLASS_DEVICE && INPUT
> > > > > +       select BACKLIGHT_CLASS_DEVICE
> > > > > +       select ACPI_VIDEO if ACPI && X86 && INPUT
> > > > >         select X86_PLATFORM_DEVICES if ACPI && X86
> > > > >         select ACPI_WMI if ACPI && X86
> > > >
> > > > I think the logic needs to be the reverse: instead of 'select
> > > > BACKLIGHT_CLASS_DEVICE',
> > > > this should be 'depends on BACKLIGHT_CLASS_DEVICE', and the same for ACPI_VIDEO.
> > > >
> > > > We may want to add 'default DRM || FB' to BACKLIGHT_CLASS_DEVICE in the
> > > > process so we don't lose it for users doing 'make oldconfig' or 'make defconfig'
> > > >
> > >
> > > I think the problem with
> > > "depends" is that the user needs to enable backlight support first
> > > before even seeing nouveau and I don't know if that makes sense. But
> > > maybe "default" is indeed helping here in this case.
> >
> > In general, no driver should ever 'select' a subsystem. Otherwise you end up
> > with two problems:
> >
> > - enabling this one driver suddenly makes all other drivers that have
> > a dependency
> >   on this visible, and some of those might have a 'default y', so you
> > end up with
> >   a ton of stuff in the kernel that would otherwise not be there.
> >
> > - It becomes impossible to turn it off as long as some driver has that 'select'.
> >   This is the pretty much the same problem as the one you describe, just
> >    the other side of it.
> >
> > - You run into dependency loops that prevent a successful build when some
> >    other driver has a 'depends on'. Preventing these loops was the main
> >    reason I said we should do this change.
> >
> > In theory we could change the other 85 drivers that use 'depends on' today,
> > and make BACKLIGHT_CLASS_DEVICE a hidden symbol that only ever
> > selected by the drivers that need it. This would avoid the third problem but
> > not the other one.
> >
> >       Arnd
> >
>
> I see. Yeah, I guess we can do it this way then. I just wasn't aware
> of the bigger picture here. Thanks for explaining.

yeah... that doesn't work. So the issue is, that X86_PLATFORM_DEVICES
is a little bit in the way. If I remove the select
X86_PLATFORM_DEVICES then I guess problems once ACPI is enabled, but
if I keep it, I get cyclic dep errors :/

