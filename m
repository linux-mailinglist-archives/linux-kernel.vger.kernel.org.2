Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E433B3D46FC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 11:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhGXJOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 05:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234993AbhGXJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 05:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627120483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4c+xqVW7MfBsa5VDqyOX8qekDnp6U6DnRr3TNr1ss8g=;
        b=UkkJC2dGm+uinTs8wJbqeGDvfj4+mWQBwFhbgb/IsUESZRbLogvY/GiTGrRhUAsv/J9axO
        4XnNHbYOEmE5v2oBysRkUwAgoCPRdAW0Vy9qhRyxFJvmMSHYEOoFpBrHbYpcS0ei6izPky
        6S2jKAPxT3b3+XFk8iAVEbwRnsIpJCI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-B49MbFDJPNiM_yRxqCBsbg-1; Sat, 24 Jul 2021 05:54:42 -0400
X-MC-Unique: B49MbFDJPNiM_yRxqCBsbg-1
Received: by mail-wm1-f70.google.com with SMTP id 132-20020a1c018a0000b029025005348905so146562wmb.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 02:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4c+xqVW7MfBsa5VDqyOX8qekDnp6U6DnRr3TNr1ss8g=;
        b=lUhRoB1gsSya5vbk32oIPySkzgr1Hu+ri6UstacqhtbbIckANYFv5B637YmbPPNHv0
         Nc09uHFS7AEi2Jxh6/SiUsZ4L62mmo9Mn561a7GojTcT6/ZaAeqB7roq/RK/9USzFf2V
         4erlCRASgNEqWiqs/QSYKaG/g9GAhwLTodCtjqurN+yqBNn8TpdiKOzKGCcppquMEPe4
         CWjkZ74MM9yAM2HIFGaQmFiuUVrcdH45SDXp6WnxErPhMZFqjU4H+98PEqfqMajb78c6
         Rbm5aUQ03IGlDcWppREP4FLHXCT4s9aUOsuP0AOVhhyR9ypAOyblHQUuZcdc4uo4Im69
         rCHQ==
X-Gm-Message-State: AOAM5337NY7QQLOrzpEfJfe0QsLsqs2UlXI2f07HismQyhuQeWvl0LtB
        x7uy79dB9jFR5KOKxPjVsvky4FZGaRRlYHmHprhtTjX+XOUmgmZG+T1D0A9OBHXYV/2me/+/Sk4
        fboxjNgl0l8JsFU1TEZV2+u8Rwi/ZZLQAjKgjB9f7
X-Received: by 2002:adf:a148:: with SMTP id r8mr8978528wrr.415.1627120481322;
        Sat, 24 Jul 2021 02:54:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwwMalzdNDmZeupmmuzGaDQDj9isYPnXIp/RVrPJIn29iuFfmxbG0uKGKcUX72MK2H2D25PbjolghFSWdAD9M=
X-Received: by 2002:adf:a148:: with SMTP id r8mr8978515wrr.415.1627120481145;
 Sat, 24 Jul 2021 02:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210723224617.3088886-1-kherbst@redhat.com> <CAK8P3a3u_jsxQW4dPXtsdKkw1mjKXL-h=qN1SGHytvUMPf3fPw@mail.gmail.com>
In-Reply-To: <CAK8P3a3u_jsxQW4dPXtsdKkw1mjKXL-h=qN1SGHytvUMPf3fPw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 24 Jul 2021 11:54:30 +0200
Message-ID: <CACO55tuNWk6emjnnukgv9h-9jbpVP564Ogmi7TGbybc9n5v+ZQ@mail.gmail.com>
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

On Sat, Jul 24, 2021 at 8:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sat, Jul 24, 2021 at 12:47 AM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > In the past this only led to compilation issues. Also the small amount of
> > extra .text shouldn't really matter compared to the entire nouveau driver
> > anyway.
> >
>
> >         select DRM_TTM_HELPER
> > -       select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
> > -       select ACPI_VIDEO if ACPI && X86 && BACKLIGHT_CLASS_DEVICE && INPUT
> > +       select BACKLIGHT_CLASS_DEVICE
> > +       select ACPI_VIDEO if ACPI && X86 && INPUT
> >         select X86_PLATFORM_DEVICES if ACPI && X86
> >         select ACPI_WMI if ACPI && X86
>
> I think the logic needs to be the reverse: instead of 'select
> BACKLIGHT_CLASS_DEVICE',
> this should be 'depends on BACKLIGHT_CLASS_DEVICE', and the same for ACPI_VIDEO.
>
> We may want to add 'default DRM || FB' to BACKLIGHT_CLASS_DEVICE in the
> process so we don't lose it for users doing 'make oldconfig' or 'make defconfig'
>

yeah.. not sure. I tested it locally (config without backlight
enabled) and olddefconfig just worked. I think the problem with
"depends" is that the user needs to enable backlight support first
before even seeing nouveau and I don't know if that makes sense. But
maybe "default" is indeed helping here in this case.

> The rest of the patch looks good to me.
>
>        Arnd
>

