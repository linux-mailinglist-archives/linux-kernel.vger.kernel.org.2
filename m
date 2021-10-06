Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE642462C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbhJFSjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhJFSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:39:00 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D5AC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 11:37:07 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id u20-20020a9d7214000000b0054e170300adso4240646otj.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hugsBbFZUCDXNjsc+rGS4MvBKlrA0O8GjGIvI5uqac=;
        b=hHwBl24oGcmxhDDwfRwb/ze3Gxl536nKMitO2Ow9cOzjg6AWe7IFyhl++56ViyVrQm
         K8Lbfr0qim9BfXvS2RMqMc1GW/jI0nMFM/Owj06IfEtWGZG1QdoHarcCDYQFqHQk49km
         FnkSPQoB3UqIDiBP4cVgF6MY1FxQQq8MSaHi/NzC6iynU8IA2nqZUR5TYcJx7PQI2k1H
         UwZEbIk/F5n06P3YTODO+v9QVWVVoBt5/GRQlDyO8qJEOUWyyhBnZUGjIKq6OUD9g/GZ
         P0iCTfDmgUw5Jeg6fToV2goVvpH/aHD4VV7Npq0V6mGicpiebZ0Tp8PFapzOOeqPGewq
         5n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hugsBbFZUCDXNjsc+rGS4MvBKlrA0O8GjGIvI5uqac=;
        b=eYOXcTigI3Gdh4NGGdo/u0Dj7RoLEAr8Vizf1LIvlTLi95irmcVAGHaeRK2wHw5uyQ
         uB5zd+TcxwYBcnzza4LO79DWY/kWkR1s3d0vI0A16enI3+LICihs5BBu07NoVlXrAxSG
         INoMGS3qpg+nh6g2AOAuroBS/TY3sYX1aJmZqEX+MjObVRqToL8gDmcarUjh9s8Idb4R
         vw0wfcX/PhZPNYrtqquIBGBgAex6rsN2Qi1KfSvP2xJkkbn0bcB1JXrvoNzq6mEtaHXH
         s7REDuC4ZPSJDpgyruX1ARxCNuIJSTcRA8GybJG7QrcOqq7mrFt+rRo44sodpO5PgsKz
         7fGw==
X-Gm-Message-State: AOAM531XewIRzeMthbvVZUR6o+s0qx4nKzmoU2EzIA/4a5GCgRy8ugYe
        6tcx/3FeRlpCfgAXV2XRTOAChYJbMvDxAdP42/U=
X-Google-Smtp-Source: ABdhPJy2X8EP5QUKM+hJQOQmwlt/xE/zy6YaVqxKaTHl9MDg4dNk9Z8bjjvVtlXhHL7K3n14DqeXzTLdQ43HRTKk+b8=
X-Received: by 2002:a05:6830:1bc6:: with SMTP id v6mr212601ota.299.1633545427166;
 Wed, 06 Oct 2021 11:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic> <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com> <YV3pQCZ4GYbdpEm5@zn.tnic>
In-Reply-To: <YV3pQCZ4GYbdpEm5@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Oct 2021 14:36:56 -0400
Message-ID: <CADnq5_O8rTnWH5md1qWauW_3sDTO+qf=vNzPZC1E70NT7Wb99A@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 2:21 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 06, 2021 at 02:10:30PM -0400, Alex Deucher wrote:
> > This is not limited to Raven.
>
> That's what the innocuous "a.o." wanted to state. :)

Whoops, my eyes passed right over that.

>
> > All GPUs (and quite a few other
> > devices) have a limited DMA mask.  AMD GPUs have between 32 and 48
> > bits of DMA depending on what generation the hardware is.  So to
> > support SME, you either need swiotlb with bounce buffers or you need
> > IOMMU in remapping mode. The limitation with Raven is that if you want
> > to use it with the IOMMU enabled it requires the IOMMU to be set up in
> > passthrough mode to support IOMMUv2 functionality for compute support
> > and due to other hardware limitations on the display side. So for all
> > GPUs except raven, just having IOMMU enabled in remapping mode is
> > fine.  GPUs from other vendors would likely run into similar
> > limitations.  Raven just has further limitations.
>
> Hmm, and in passthrough mode it would use bounce buffers when SME is
> enabled. And when those 256K are not enough, it would fail there too,
> even with IOMMUv2. At least this is how it looks from here.
>
> Dunno, it feels like doing GPU compute and SME does not go hand-in-hand
> real smoothly currently but that probably doesn't matter all too much
> for both user camps. But that's just me with a hunch.

Well, this limitation only applies to Raven which is an integrated GPU
in client parts.  SME was initially productized on server parts so
there was not a lot of concern given to interactions with integrated
graphics at the time.  This has since been fixed in newer integrated
graphics.  dGPUs work fine as long as the IOMMU is in remapping mode
to handle the C bit.

>
> > Another option would be to enable SME by default on Epyc platforms,
> > but disabled by default on client APU platforms or even just raven.
>
> Thing is, we don't know at SME init time - very early during boot -
> whether we're Epyc or client. Can we find that out reliably from the hw?
>

From the x86 model and family info?  I think Raven has different
families from other Zen based CPUs.

> And even if we do, that's still not accurate enough - we wanna know
> whether the IOMMU works.

Right.

>
> So I guess we're all left to the user to decide. But I'm always open
> to suggestions for solving things in sw and not requiring any user
> interaction.

@Tom Lendacky Any ideas?

Alex

>
> > Other than these comments, looks fine to me.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
