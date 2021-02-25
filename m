Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ABD3252B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 16:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhBYPsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 10:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhBYPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 10:47:41 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:47:00 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id o3so6466922oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p1FuJXZMatJHyJTGkObaxlo1fAYr8nIDoteIQbCQluQ=;
        b=CySFpdI+Jsei8FbEThQbhvVfeq0NF3DKnmK4tWuxHtE64J8KA7qxG9/Kcz83gyVyY6
         M0MP2JJCTD6SIdr0nI4j0bHUdPee8x/pGJJ+Ubsa2uPskvU7x7FxNbIjImla1Z2A5D6z
         Eix+yQWlA+5DvZVobTnKFrWjuwKxUJJWY5m34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p1FuJXZMatJHyJTGkObaxlo1fAYr8nIDoteIQbCQluQ=;
        b=g7cwI4J7YZ5honCsGxpClw2fgrvGtf8w36Bj7Jmwo/ssTMlkKXad49fNCNVoO2rgW4
         KRgPHCfJk7BgoYG0BTF+53oYx1A2+ZjCSDVz4PCAO8SEkkrg39L998rKOvywfaKu4mGv
         edLVdVsN/P7iKxrOvVSbPkzASkOM1jwXaD/HxExqleB/MigFdI3yCw/MB7qn8rN/LYOX
         oWRHpn41Q8YY39cgZzhcyB52sjqGfHYtjcI9Nliy91hBpPfbHASaPoVWn5TobM7ri1Vz
         ac8d6cmsJqjTZZWV9qkyOHOaR8ybcBqJ3Gtcg0Krah+zFuIlgpjJC87t7vIDfCYA9YNv
         bAmw==
X-Gm-Message-State: AOAM533cxg2HBS8hCiVfEWQAfYkm+D7BciCvtVB8Heut5nbFNFPBC3pF
        UulvbVF0+0XPPbdVoQcUVX28gmUba0kF8NUb0UYhuQ==
X-Google-Smtp-Source: ABdhPJxspYsQHTFQg7SDpkytyC8G0vPt+TIbNebEDGa69KvpuOK83CJolun8M8yhLHfATBMQZZYY7R75AJ28FRK4W7Q=
X-Received: by 2002:a05:6808:4c9:: with SMTP id a9mr2303337oie.101.1614268019504;
 Thu, 25 Feb 2021 07:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20210225125301.1723047-1-arnd@kernel.org> <7c41b175-6da2-6801-43c2-c4038c08b228@amd.com>
In-Reply-To: <7c41b175-6da2-6801-43c2-c4038c08b228@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 25 Feb 2021 16:46:48 +0100
Message-ID: <CAKMK7uEqztQYkqwuduAwvz_87tq_SBwjSYZF7x5b-aWb-kHVsw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/pci: rework AGP dependency
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 1:59 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 25.02.21 um 13:52 schrieb Arnd Bergmann:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > I noticed a warning from 'nm' when CONFIG_TRIM_UNUSED_KSYMS is set
> > and IS_REACHABLE(CONFIG_AGP) is false:
> >
> > drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.o: no symbols
> >
> > I later found this is completely harmless and we should find a way
> > to suppress the warning, but at that point I had already done a
> > cleanup patch to address this instance.
> >
> > It turns out this code could be improved anyway, as the current version
> > behaves unexpectedly when AGP is a loadable module but nouveau is built=
-in
> > itself, in which case it silently omits agp support.
> >
> > A better way to handle this is with a Kconfig dependency that requires
> > AGP either to be disabled, or forces nouveau to be a module for AGP=3Dm=
.
> > With this change, the compile-time hack can be removed and lld no
> > longer warns.
> >
> > Fixes: 340b0e7c500a ("drm/nouveau/pci: merge agp handling from nouveau =
drm")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >   drivers/gpu/drm/nouveau/Kbuild                 | 1 +
> >   drivers/gpu/drm/nouveau/Kconfig                | 1 +
> >   drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild | 2 +-
> >   drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c  | 2 --
> >   drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h  | 9 +++++----
> >   5 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/K=
build
> > index 60586fb8275e..173b8d9d85e3 100644
> > --- a/drivers/gpu/drm/nouveau/Kbuild
> > +++ b/drivers/gpu/drm/nouveau/Kbuild
> > @@ -15,6 +15,7 @@ nouveau-y :=3D $(nvif-y)
> >   #- code also used by various userspace tools/tests
> >   include $(src)/nvkm/Kbuild
> >   nouveau-y +=3D $(nvkm-y)
> > +nouveau-m +=3D $(nvkm-m)
> >
> >   # DRM - general
> >   ifdef CONFIG_X86
> > diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/=
Kconfig
> > index 278e048235a9..90276a557a70 100644
> > --- a/drivers/gpu/drm/nouveau/Kconfig
> > +++ b/drivers/gpu/drm/nouveau/Kconfig
> > @@ -2,6 +2,7 @@
> >   config DRM_NOUVEAU
> >       tristate "Nouveau (NVIDIA) cards"
> >       depends on DRM && PCI && MMU
> > +     depends on AGP || !AGP
>
> My first thought was WTF? But then I realized that this totally makes sen=
se.

depends on SYM || !SYM

is essentially

optional depends on SYM

when SYM is a tri-state. I think there was even patches to kconfig to
add something like that since it's such a common pattern. Might be
neat to resurrect that for more clarity.
-Daniel

> We should probably have the same for radeon as well.
>
> Apart from that the patch is Acked-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>
>
> >       select IOMMU_API
> >       select FW_LOADER
> >       select DRM_KMS_HELPER
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild b/drivers/g=
pu/drm/nouveau/nvkm/subdev/pci/Kbuild
> > index 174bdf995271..a400c680cf65 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
> > @@ -1,5 +1,5 @@
> >   # SPDX-License-Identifier: MIT
> > -nvkm-y +=3D nvkm/subdev/pci/agp.o
> > +nvkm-$(CONFIG_AGP) +=3D nvkm/subdev/pci/agp.o
> >   nvkm-y +=3D nvkm/subdev/pci/base.o
> >   nvkm-y +=3D nvkm/subdev/pci/pcie.o
> >   nvkm-y +=3D nvkm/subdev/pci/nv04.o
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/pci/agp.c
> > index 385a90f91ed6..86c9e1d658af 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c
> > @@ -20,7 +20,6 @@
> >    * OTHER DEALINGS IN THE SOFTWARE.
> >    */
> >   #include "agp.h"
> > -#ifdef __NVKM_PCI_AGP_H__
> >   #include <core/option.h>
> >
> >   struct nvkm_device_agp_quirk {
> > @@ -172,4 +171,3 @@ nvkm_agp_ctor(struct nvkm_pci *pci)
> >
> >       pci->agp.mtrr =3D arch_phys_wc_add(pci->agp.base, pci->agp.size);
> >   }
> > -#endif
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h b/drivers/gp=
u/drm/nouveau/nvkm/subdev/pci/agp.h
> > index ad4d3621d02b..041fe1fbf093 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h
> > @@ -1,15 +1,14 @@
> > -/* SPDX-License-Identifier: MIT */
> > -#include "priv.h"
> > -#if defined(CONFIG_AGP) || (defined(CONFIG_AGP_MODULE) && defined(MODU=
LE))
> >   #ifndef __NVKM_PCI_AGP_H__
> >   #define __NVKM_PCI_AGP_H__
> >
> > +/* SPDX-License-Identifier: MIT */
> > +#include "priv.h"
> > +#if IS_ENABLED(CONFIG_AGP)
> >   void nvkm_agp_ctor(struct nvkm_pci *);
> >   void nvkm_agp_dtor(struct nvkm_pci *);
> >   void nvkm_agp_preinit(struct nvkm_pci *);
> >   int nvkm_agp_init(struct nvkm_pci *);
> >   void nvkm_agp_fini(struct nvkm_pci *);
> > -#endif
> >   #else
> >   static inline void nvkm_agp_ctor(struct nvkm_pci *pci) {}
> >   static inline void nvkm_agp_dtor(struct nvkm_pci *pci) {}
> > @@ -17,3 +16,5 @@ static inline void nvkm_agp_preinit(struct nvkm_pci *=
pci) {}
> >   static inline int nvkm_agp_init(struct nvkm_pci *pci) { return -ENOSY=
S; }
> >   static inline void nvkm_agp_fini(struct nvkm_pci *pci) {}
> >   #endif
> > +
> > +#endif
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
