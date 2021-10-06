Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665F54245BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhJFSMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhJFSMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:12:34 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D72C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 11:10:41 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id u20-20020a9d7214000000b0054e170300adso4145710otj.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDJG33beoekgnoibdIUsfRXOx9O3G1/t6zYh/kfqMkc=;
        b=H0DIO9Ii0mRx0UpHPomb5+nZMKQtVZfVVIuojCoaiHoX7ia16/vO/R2921fQgLVlV2
         IfGGE1RQRE+IhWgnasPSfVtu8gFWjCrLJqTH2+7xc4hcklCtNks4WaBMmb5TeARfr5ho
         Vd5aT4WZnTwAOpeOcVCqUKqLFZem/dhMK1aYLq9uSkcCzZkYP/3A4j6HJf1T4uvsxAh3
         HyhYPsdg1+9y++eiynSoiIkEa2KpeS6HbKlJDXZaXVj1Nw6zW8JDsWCWOmg/yUYwDger
         TRqqTcD5PNuXYZiheR6fdhaIKEzv+HezvqhduSaUKIb41xYkD1dJkCxT8I3PVoTVpX9T
         6zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDJG33beoekgnoibdIUsfRXOx9O3G1/t6zYh/kfqMkc=;
        b=dZre64vayt5Cf90Pfi9vd+B/HKkS3aum41dMDNAzk9d48b9M6+zpr3lZShCgmBFlFx
         h3xDcpodx4j2Ryya7rzkhe67nAV5edPb5yf77adQI5WfOxyhBdB5xvsM1o5RqeFPHk2A
         h7mm9hUUfCP2FnGN/2fWHA/jTQAUwvkSWRRztOzjNmYtE47PEXbmHzbhW2AJOF11ijbk
         u5F3nvZNAIrXqx5EnwjFQUj5OGpXrPSxF0igIUqRhFyzjHWqDJCp+ogfL4hCFtjMoxNw
         B0JL5S8nTnNme7XBc48YM7czr0EK73Wygj15jB5aFUp5nAQo9Y64ZTPttTtksbXWArjl
         rkpA==
X-Gm-Message-State: AOAM530G/b6dO3gdVMZrGOmSOtG+Sr1fm6Jwv6nPovRqhrR5sIpZZ7hb
        pCfaEbRr8u/Ijta8X8zk0KuGQ51qADGm7smX8EY=
X-Google-Smtp-Source: ABdhPJykj0/VkYXXLu+qLjHrqNh2F/gadqD3VfJNaPGpd4zaqwOar9O4qZCsU5MO3xosaeHAbnx/JLnnBP56Uy0Z8mY=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr148129otd.200.1633543841270;
 Wed, 06 Oct 2021 11:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic> <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
In-Reply-To: <YV3hbK/uhChK5Pse@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Oct 2021 14:10:30 -0400
Message-ID: <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
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

On Wed, Oct 6, 2021 at 1:48 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok,
>
> so I sat down and wrote something and tried to capture all the stuff we
> so talked about that it is clear in the future why we did it.
>
> Thoughts?
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 6 Oct 2021 19:34:55 +0200
> Subject: [PATCH] x86/Kconfig: Do not enable AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
>  automatically
>
> This Kconfig option was added initially so that memory encryption is
> enabled by default on machines which support it.
>
> However, Raven-class GPUs, a.o., cannot handle DMA masks which are
> shorter than the bit position of the encryption, aka C-bit. For that,
> those devices need to have the IOMMU present.

This is not limited to Raven.  All GPUs (and quite a few other
devices) have a limited DMA mask.  AMD GPUs have between 32 and 48
bits of DMA depending on what generation the hardware is.  So to
support SME, you either need swiotlb with bounce buffers or you need
IOMMU in remapping mode. The limitation with Raven is that if you want
to use it with the IOMMU enabled it requires the IOMMU to be set up in
passthrough mode to support IOMMUv2 functionality for compute support
and due to other hardware limitations on the display side. So for all
GPUs except raven, just having IOMMU enabled in remapping mode is
fine.  GPUs from other vendors would likely run into similar
limitations.  Raven just has further limitations.


>
> If the IOMMU is disabled or in passthrough mode, though, the kernel
> would switch to SWIOTLB bounce-buffering for those transfers.
>
> In order to avoid that,
>
>    2cc13bb4f59f ("iommu: Disable passthrough mode when SME is active")
>
> disables the default IOMMU passthrough mode so that devices for which
> the default 256K DMA is insufficient, can use the IOMMU instead.
>
> However 2, there are cases where the IOMMU is disabled in the BIOS, etc,
> think the usual hardware folk "oops, I dropped the ball there" cases.
>
> Which means, it can happen that there are systems out there with devices
> which need the IOMMU to function properly with SME enabled but the IOMMU
> won't necessarily be enabled.
>
> So in order for those devices to function, drop the "default y" for
> the SME by default on option so that users who want to have SME, will
> need to either enable it in their config or use "mem_encrypt=on" on the
> kernel command line.

Another option would be to enable SME by default on Epyc platforms,
but disabled by default on client APU platforms or even just raven.

Other than these comments, looks fine to me.

Alex

>
> Fixes: 7744ccdbc16f ("x86/mm: Add Secure Memory Encryption (SME) support")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <stable@vger.kernel.org>
> Link: https://lkml.kernel.org/r/8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de
> ---
>  arch/x86/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8055da49f1c0..6a336b1f3f28 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1525,7 +1525,6 @@ config AMD_MEM_ENCRYPT
>
>  config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
>         bool "Activate AMD Secure Memory Encryption (SME) by default"
> -       default y
>         depends on AMD_MEM_ENCRYPT
>         help
>           Say yes to have system memory encrypted by default if running on
> --
> 2.29.2
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
