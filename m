Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EDC43CFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhJ0R0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhJ0R0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:26:42 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB53C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:24:16 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y207so4357475oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZTpDujXUs8AgiTYay7x9mo53A+jrUMMnqRa2UanwXXU=;
        b=H+nZpoyo+68UwBEBmhwaP3AV5LjR872sOY3DTnp0b5wIJrBk6dDgYepLfXn1cYXVuw
         5UXzjnSolau+QJdPwPsVNdDiCRnggiGvq3/V+UjEC5PDHz9xJQhDTQHJTGwcqobOi0MF
         mdc30+FN0+uQvSA32jjI6z4PrV28rBiPZO7+yk/BYRZd2QH8EJxGqFWfBJoGzBz5ARAV
         XHz+Qk9hTOwmRNklby2zl7hT+1l+oLoCMjO6eh+e0eSid7gGwZRR3K5Be9zXDVsWeRXU
         RqWqiROt20t7IfuPDX3AbKPvF0e9RIg8EyNv3mvoZygWFP16CZYS4OiDi2vE8lF48yAk
         unKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZTpDujXUs8AgiTYay7x9mo53A+jrUMMnqRa2UanwXXU=;
        b=kt9PcjzWNUUzSOuFmsL0e89mfoD7e7gJrcwUN65UW0L8tEO1iHNTPyxysVNTT3tKuh
         FKh4EOto2EAXZ3JQ5g7IWfu7+HNCZdEeQu2AEFM75onddCkBHdU9ublTWg+M4/9TkQsS
         qoV5KjjZmXAtpFGXc9yq5SyRhWKelIK4vkicr/8RiYhYsv8fy6htVQW1RCYwSDLNmSdw
         5JbFb5qCmXJbSILZzb2amoYN4G7M/31nv66ZRPSKPhnzfgN6BGRkyRNTaZBzUvq7LN7K
         ZFxYfFjNe0npeBVt1pStycrqY3ZvrXb+LzqtTuWS8AifImSwhFw3bedLEJU+zDDmA1gV
         gwDQ==
X-Gm-Message-State: AOAM532gOUgu5n7xC/5Duiocm4/10tBgatE2VdEGD+HCOKX5wajjumdB
        g0CUBg/qedsu7vOYwNUVXYbJxRjozAMrKDoEm0Q=
X-Google-Smtp-Source: ABdhPJzgy+PBIXCwu4lAyqaAU5LxAsB82sOF5UiHFh8XhLbSe4+mWz/uU24XI0PXBRhAXlO81/VD6jmqXW0JkcxrLg4=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr4569296oia.5.1635355455913;
 Wed, 27 Oct 2021 10:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com> <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
 <3c2de089-8f80-3644-7735-7df1c6151d70@molgen.mpg.de> <82fccb9d-43e8-4485-0ddb-7ff260f3ed32@arm.com>
In-Reply-To: <82fccb9d-43e8-4485-0ddb-7ff260f3ed32@arm.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 27 Oct 2021 13:24:04 -0400
Message-ID: <CADnq5_NiigOVnahNWrro+ur2aejcHLTLJMH5ndUyg3cO8E+NRw@mail.gmail.com>
Subject: Re: I got an IOMMU IO page fault. What to do now?
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, X86 ML <x86@kernel.org>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        it+linux-iommu@molgen.mpg.de, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 1:20 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 27/10/2021 5:45 pm, Paul Menzel wrote:
> > Dear Robin,
> >
> >
> > On 25.10.21 18:01, Robin Murphy wrote:
> >> On 2021-10-25 12:23, Christian K=C3=B6nig wrote:
> >
> >>> not sure how the IOMMU gives out addresses, but the printed ones look
> >>> suspicious to me. Something like we are using an invalid address like
> >>> -1 or similar.
> >>
> >> FWIW those look like believable DMA addresses to me, assuming that the
> >> DMA mapping APIs are being backed iommu_dma_ops and the device has a
> >> 40-bit DMA mask, since the IOVA allocator works top-down.
> >>
> >> Likely causes are either a race where the dma_unmap_*() call happens
> >> before the hardware has really stopped accessing the relevant
> >> addresses, or the device's DMA mask has been set larger than it should
> >> be, and thus the upper bits have been truncated in the round-trip
> >> through the hardware.
> >>
> >> Given the addresses involved, my suspicions would initially lean
> >> towards the latter case - the faults are in the very topmost pages
> >> which imply they're the first things mapped in that range. The other
> >> contributing factor being the trick that the IOVA allocator plays for
> >> PCI devices, where it tries to prefer 32-bit addresses. Thus you're
> >> only likely to see this happen once you already have ~3.5-4GB of live
> >> DMA-mapped memory to exhaust the 32-bit IOVA space (minus some
> >> reserved areas) and start allocating from the full DMA mask. You
> >> should be able to check that with a 5.13 or newer kernel by booting
> >> with "iommu.forcedac=3D1" and seeing if it breaks immediately
> >> (unfortunately with an older kernel you'd have to manually hack
> >> iommu_dma_alloc_iova() to the same effect).
> >
> > I booted Linux 5.15-rc7 with `iommu.forcedac=3D1` and the system booted=
,
> > and I could log in remotely over SSH. Please find the Linux kernel
> > messages attached. (The system logs say lightdm failed to start, but it
> > might be some other issue due to a change in the operating system.)
>
> OK, that looks like it's made the GPU blow up straight away, which is
> what I was hoping for (and also appears to reveal another bug where it's
> not handling probe failure very well - possibly trying to remove a
> non-existent audio device?). Lightdm presumably fails to start because
> it doesn't find any display devices, since amdgpu failed to probe.
>
> If you can boot the same kernel without "iommu.forcedac" and get a
> successful probe and working display, that will imply that it is
> managing to work OK with 32-bit DMA addresses, at which point I'd have
> to leave it to Christian and Alex to figure out exactly where DMA
> addresses are getting mangled. The only thing that stands out to me is
> the reference to "gfx_v6_0", which makes me wonder whether it's related
> to gmc_v6_0_sw_init() where a 44-bit DMA mask gets set. If so, that
> would suggest that either this particular model of GPU is more limited
> than expected, or that SoC only has 40 bits of address wired up between
> the PCI host bridge and the IOMMU.

That device only has a 40 bit DMA mask.  It looks like the code is wrong th=
ere.

Alex


>
> Cheers,
> Robin.
