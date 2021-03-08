Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D483318B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhCHUgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhCHUgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:36:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7E8E65285
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 20:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615235770;
        bh=O+ReejtrMNWcuVeWBL3/zizI1ocIx5X8IPr5cVw5odU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cIumH+IM/8uCHmxVOG3y3cAoJ5WufchRisnap2UCgvsAipmBERLrQtUYAns5GJCP1
         83BaJuqWkv+GYUEd2MHgDVmcxWHwwFi/7qW3zU3gHEDodQF/3X6d8mf2wPTprzr4yf
         f1686lEyzKQUnWyf3PXeLNLSpsOdaP1E6wm7KDQPnegHvp0t6TTN+t4vLWzCj2KC4T
         J3KK0T19x8xcHNu9T2J4a4MupPpsy7r0t7aPKkn67w87g/dN+XdiQxU6xScVEqxTHh
         w34rSbnr08cHgt/SAiheNAqDjyC2CyBVADVkOO0P12N9e5W8JTo/XP8BJzjbd8twvs
         ITRswDXlm97aQ==
Received: by mail-ot1-f42.google.com with SMTP id t16so10563109ott.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 12:36:10 -0800 (PST)
X-Gm-Message-State: AOAM533CjjoJixcp5Z0fvtYDUWbUemafTW/aVfthVytSSObyesOweKU4
        Sw2ZC1BXmcM389JS14pZTZ1tkdkCRYXSIzT/t6c=
X-Google-Smtp-Source: ABdhPJwhe07CSGqsH4YO3B+zF8XwArdCOWpQFjHD+UZjHl0ykK/P8SF/czSLKjLwOHz1A80bokLqfLYncAJ+h+A0ctM=
X-Received: by 2002:a9d:6341:: with SMTP id y1mr6074155otk.210.1615235770221;
 Mon, 08 Mar 2021 12:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20210308153359.2513446-1-arnd@kernel.org> <176cae4d-33bc-1d51-a7d7-58eeeea5180e@amd.com>
 <CAK8P3a0nUKSJ2+knM6+REp8HXRFbz5-DmNRAusezkT+XzZQa7Q@mail.gmail.com>
 <92a6c999-c20a-2311-4e31-209a2d9229ed@amd.com> <CAK8P3a1SRubvaPzn2020Nc_SsL8xBW7ODGOGtF_4UYASGqTq-w@mail.gmail.com>
 <f2829f2e-6498-53d4-93fa-1613e988803f@amd.com> <71d1bd79-881c-062c-0b41-4be0cdf3c4d5@gmail.com>
In-Reply-To: <71d1bd79-881c-062c-0b41-4be0cdf3c4d5@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 8 Mar 2021 21:35:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2CB2CyNyZcDwB5BRiO-qDLrK2tjdM24K-pQhbH+0VZZA@mail.gmail.com>
Message-ID: <CAK8P3a2CB2CyNyZcDwB5BRiO-qDLrK2tjdM24K-pQhbH+0VZZA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix build error with missing AMD_IOMMU_V2
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <philip.yang@amd.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 9:12 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
> Am 08.03.21 um 21:02 schrieb Felix Kuehling:
> > Am 2021-03-08 um 2:33 p.m. schrieb Arnd Bergmann:

> > I don't want to create a hard dependency on AMD_IOMMU_V2 if I can avoid
> > it, because it is only really needed for a small number of AMD APUs, an=
d
> > even there it is now optional for more recent ones.
> >
> > Is there a better way to avoid build failures without creating a hard
> > dependency?
>
> What you need is the same trick we used for AGP on radeon/nouveau:
>
> depends on AMD_IOMMU_V2 || !AMD_IOMMU_V2
>
> This way when AMD_IOMMU_V2 is build as a module DRM_AMDGPU will be build
> as a module as well. When it is disabled completely we don't care.

Note that this trick only works if you put it into the DRM_AMDGPU Kconfig o=
ption
itself, since that decides if the driver is built-in or a loadable module. =
If
HSA_AMD is disabled, that dependency is not really necessary.

The version I suggested  -- adding "depends on AMD_IOMMU_V2=3Dy ||
DRM_AMDGPU=3Dm" to the HSA_AMD option -- might be slightly nicer
since it lets you still build a kernel with DRM_AMDGPU=3Dy and
AMD_IOMMU_V2=3Dm, but without the HSA_AMD.

I can send a patch with either of those two options to replace my
original patch.

> >    The documentation in
> > Documentation/kbuild/kconfig-language.rst suggests using if
> > (IS_REACHABLE(CONFIG_AMD_IOMMU_V2)) to guard those problematic function
> > calls. I think more generally, we could guard all of kfd_iommu.c with
> >
> >      #if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
> >
> > And use the same condition to define the stubs in kfd_iommu.h.

This would fix the compile-time error, but it's also the one I'd least
recommend out of all the options, because that causes the driver to
silently not work as expected. This seems even worse than failing
the build.

       Arnd
