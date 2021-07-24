Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9281A3D4781
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 13:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhGXLQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 07:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhGXLP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 07:15:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F98760ED7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 11:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627127791;
        bh=Or9WH1pvmZ4tR0pQ+qn4WAUGeesVrTpQna1KRhoMf9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GqiUR56gRh7BGaa5fFrU9Rxl8M2TrB00nMB8yg+92gB0euS8Aed0u+aaA8CISahNN
         ldX9XAFfH7P3QVljI3NsDjd4x12IxCk6nqoWDzkr4kbJeiC3zg65f4k4eaV4mv5E0V
         EyxiSqXXJ2scBbb2lUBTTqk5xs7btW2uq4Tnk7us8K9t+ZwBCPm2Jla+ibbFk/YEJY
         L4aq6GOaM93UE2knqwhdJzGn6cwlXQdgBf3aNdaYHncu9Le3egmawIOQBo1/y9rXLf
         +qYpUUY76vRC2vWNwEke7kgu9AQ//0V0DY8LLZ9hk97B1dMS+mpKeWPbRbL97Kc9cr
         aQGpVKBa/GK4Q==
Received: by mail-wm1-f46.google.com with SMTP id j34-20020a05600c1c22b029024e75084404so2226623wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 04:56:31 -0700 (PDT)
X-Gm-Message-State: AOAM530a5Xl7a7yg7WV6OrTRpLQNRoU46JwNNv3blCnHylJbMfKzKNDh
        TOKqk2IOcx7lIHGMAPjh2pEJEh9/aLB8p9Sg2sY=
X-Google-Smtp-Source: ABdhPJxRsxDvG5h/w15BRF87kyh1VVVKr9ninZcoTF/7r4hhnZwOsQ2QlykYbGshv3uR73Sb2/2ucgam2jgOI9/0WVI=
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr18402161wmk.84.1627127789904;
 Sat, 24 Jul 2021 04:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210723224617.3088886-1-kherbst@redhat.com> <CAK8P3a3u_jsxQW4dPXtsdKkw1mjKXL-h=qN1SGHytvUMPf3fPw@mail.gmail.com>
 <CACO55tuNWk6emjnnukgv9h-9jbpVP564Ogmi7TGbybc9n5v+ZQ@mail.gmail.com>
In-Reply-To: <CACO55tuNWk6emjnnukgv9h-9jbpVP564Ogmi7TGbybc9n5v+ZQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 24 Jul 2021 13:56:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1BceSaiqkTf+9Pr4Br-G3kgqD4ztwiaS7fxNiUg9t7Dg@mail.gmail.com>
Message-ID: <CAK8P3a1BceSaiqkTf+9Pr4Br-G3kgqD4ztwiaS7fxNiUg9t7Dg@mail.gmail.com>
Subject: Re: [PATCH] nouveau: make backlight support non optional
To:     Karol Herbst <kherbst@redhat.com>
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

On Sat, Jul 24, 2021 at 11:55 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Sat, Jul 24, 2021 at 8:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Sat, Jul 24, 2021 at 12:47 AM Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > In the past this only led to compilation issues. Also the small amount of
> > > extra .text shouldn't really matter compared to the entire nouveau driver
> > > anyway.
> > >
> >
> > >         select DRM_TTM_HELPER
> > > -       select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
> > > -       select ACPI_VIDEO if ACPI && X86 && BACKLIGHT_CLASS_DEVICE && INPUT
> > > +       select BACKLIGHT_CLASS_DEVICE
> > > +       select ACPI_VIDEO if ACPI && X86 && INPUT
> > >         select X86_PLATFORM_DEVICES if ACPI && X86
> > >         select ACPI_WMI if ACPI && X86
> >
> > I think the logic needs to be the reverse: instead of 'select
> > BACKLIGHT_CLASS_DEVICE',
> > this should be 'depends on BACKLIGHT_CLASS_DEVICE', and the same for ACPI_VIDEO.
> >
> > We may want to add 'default DRM || FB' to BACKLIGHT_CLASS_DEVICE in the
> > process so we don't lose it for users doing 'make oldconfig' or 'make defconfig'
> >
>
> I think the problem with
> "depends" is that the user needs to enable backlight support first
> before even seeing nouveau and I don't know if that makes sense. But
> maybe "default" is indeed helping here in this case.

In general, no driver should ever 'select' a subsystem. Otherwise you end up
with two problems:

- enabling this one driver suddenly makes all other drivers that have
a dependency
  on this visible, and some of those might have a 'default y', so you
end up with
  a ton of stuff in the kernel that would otherwise not be there.

- It becomes impossible to turn it off as long as some driver has that 'select'.
  This is the pretty much the same problem as the one you describe, just
   the other side of it.

- You run into dependency loops that prevent a successful build when some
   other driver has a 'depends on'. Preventing these loops was the main
   reason I said we should do this change.

In theory we could change the other 85 drivers that use 'depends on' today,
and make BACKLIGHT_CLASS_DEVICE a hidden symbol that only ever
selected by the drivers that need it. This would avoid the third problem but
not the other one.

      Arnd
