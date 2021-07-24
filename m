Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8833D480A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhGXNYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 09:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhGXNY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 09:24:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6836B6069E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627135501;
        bh=2O1ur3A24Hv4gqCkdm20xC6QD3E7j9yg0tu1vwjXVsw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bkRatRZpHOtR+aE3DhgBHrrhv1VXncOzBGwj3UsYTh+Co0fiWI8iZq7dYQIdRjI/k
         qHoeHwDdhMS+11XN1H2hCIjraTG9bMwivtXTg5L6iyAPZq9y7c9bm8fbiVE00yKJbT
         YwB7A/mNM9+9H8jBpojDeRWhnc/EnUFU1li7FhCdU/dx8dnm+wOCbP2p4RNIoBxKrV
         I4Dpwidq96afczxPMjUblawZHlbMZ43SAo5x55oJsiN97aX8c9M/xjR0m4cr59lKul
         wgqX+309KeSzv18jStZYat6uIMtUt9SAkLq9wrsBiL4vwWizEVBnN/LITyBuDUI9zl
         Od4LdFYTyYuww==
Received: by mail-wr1-f41.google.com with SMTP id e2so5390358wrq.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 07:05:01 -0700 (PDT)
X-Gm-Message-State: AOAM53197fHl9nqX+MEtYk+B+vWj8paQi++k/pCOZsLV2BTijBYRbFiZ
        zt7BwvDkPNsZkGq6whasg+D6DYvCs/XiPZ3YXGg=
X-Google-Smtp-Source: ABdhPJyKC4hlIYKQZNSTphY0smp/aRHoZeyrOis8ju5E0a4bjJB5Up9oudDm99dXbMvpGnDd4mDyBtueOrC8gp/BxgI=
X-Received: by 2002:adf:b318:: with SMTP id j24mr10476011wrd.361.1627135499960;
 Sat, 24 Jul 2021 07:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210723224617.3088886-1-kherbst@redhat.com> <CAK8P3a3u_jsxQW4dPXtsdKkw1mjKXL-h=qN1SGHytvUMPf3fPw@mail.gmail.com>
 <CACO55tuNWk6emjnnukgv9h-9jbpVP564Ogmi7TGbybc9n5v+ZQ@mail.gmail.com>
 <CAK8P3a1BceSaiqkTf+9Pr4Br-G3kgqD4ztwiaS7fxNiUg9t7Dg@mail.gmail.com>
 <CACO55tsoi2akTKvFdz3p48UHRjFXDW7dUnOM8qVePBFWet-3UQ@mail.gmail.com> <CACO55tuceMUz2pgOM23wvcmtaTqbo6S6rCB+mfLptqJRt=fMWA@mail.gmail.com>
In-Reply-To: <CACO55tuceMUz2pgOM23wvcmtaTqbo6S6rCB+mfLptqJRt=fMWA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 24 Jul 2021 16:04:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3+AD02-8nbULMdae2Hc=hJ+-Zb_CL+bHF-9oGieYiZWQ@mail.gmail.com>
Message-ID: <CAK8P3a3+AD02-8nbULMdae2Hc=hJ+-Zb_CL+bHF-9oGieYiZWQ@mail.gmail.com>
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

On Sat, Jul 24, 2021 at 2:52 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Sat, Jul 24, 2021 at 2:10 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Sat, Jul 24, 2021 at 1:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > On Sat, Jul 24, 2021 at 11:55 AM Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > - You run into dependency loops that prevent a successful build when some
> > >    other driver has a 'depends on'. Preventing these loops was the main
> > >    reason I said we should do this change.
> > >
> > > In theory we could change the other 85 drivers that use 'depends on' today,
> > > and make BACKLIGHT_CLASS_DEVICE a hidden symbol that only ever
> > > selected by the drivers that need it. This would avoid the third problem but
> > > not the other one.
> > >
> > I see. Yeah, I guess we can do it this way then. I just wasn't aware
> > of the bigger picture here. Thanks for explaining.
>
> yeah... that doesn't work. So the issue is, that X86_PLATFORM_DEVICES
> is a little bit in the way. If I remove the select
> X86_PLATFORM_DEVICES then I guess problems once ACPI is enabled, but
> if I keep it, I get cyclic dep errors :/

Right, this is the exact problem I explained: since all other drivers use
'depends on X86_PLATFORM_DEVICES' instead of 'select', you get a
loop again. Prior to changing the BACKLIGHT_CLASS_DEVICE dependency,
nouveau was pretty much on top of everything else in the hierarchy,
changing part of it can result in a loop.

I see that there are about ten more 'select' statements that look like
they should not be there, and almost all of them were added in order
to be able to 'select MXM_WMI'.

I think we can go as far as the patch below, which I've put in my
randconfig build machine, on top of your patch. I'm not entirely
sure how strong the dependency on MXM_WMI is: does it cause
a build failure when that is not enabled, or was this select just
added for convenience so users don't get surprised when it's missing?

       Arnd

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 9c2108b48524..f2585416507e 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -3,21 +3,14 @@ config DRM_NOUVEAU
        tristate "Nouveau (NVIDIA) cards"
        depends on DRM && PCI && MMU
        depends on AGP || !AGP
+       depends on ACPI_VIDEO || !ACPI
+       depends on BACKLIGHT_CLASS_DEVICE
+       depends on MXM_WMI || !X86 || !ACPI
        select IOMMU_API
        select FW_LOADER
        select DRM_KMS_HELPER
        select DRM_TTM
        select DRM_TTM_HELPER
-       select BACKLIGHT_CLASS_DEVICE
-       select ACPI_VIDEO if ACPI && X86 && INPUT
-       select X86_PLATFORM_DEVICES if ACPI && X86
-       select ACPI_WMI if ACPI && X86
-       select MXM_WMI if ACPI && X86
-       select POWER_SUPPLY
-       # Similar to i915, we need to select ACPI_VIDEO and it's dependencies
-       select INPUT if ACPI && X86
-       select THERMAL if ACPI && X86
-       select ACPI_VIDEO if ACPI && X86
        select SND_HDA_COMPONENT if SND_HDA_CORE
        help
          Choose this option for open-source NVIDIA support.
