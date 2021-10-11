Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D264429422
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhJKQHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhJKQHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:07:41 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6833C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 09:05:41 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id o83so17830539oif.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSee7KtM9X8rG8D4MwSrt8EM6ucCH+R9nFgw8OJr1AU=;
        b=Xbw13qTZgagmtSPY2rkIeitbwLTrOeLJsy7CPRw/8pWejPwsZ6evtyIxbGdmIGYidZ
         h2uaMAsH50bOz0WiGwRy8N1VNIveB9R2u0QjgJD6wjP4gpcAkY8sRkol6sv3zMFa8Nf8
         bKWL3HyDDMFFhg2qYUrpvnV7P4LKEqLcnWowWFNRnckoMWbEUpqdJkcn6Vpritb8d9Uj
         +HyufEA8QSjWT/MxFNp+d8Do3ERe9t26x7JiQG4nJInQ/sxLWkkCYo9C9wHz3dSvFjmd
         H8eMNg0GEtOEfGLsZ0gJHjoVVJ3gBwlv+4wB8iSNBv+fxtUTpF57TMna90RZGxK2lqOq
         sy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSee7KtM9X8rG8D4MwSrt8EM6ucCH+R9nFgw8OJr1AU=;
        b=S7dhXWCdlHsJ3y44ZnKVZrHGiCjrx8ivaWolYIatuiNEjbddyDpUMvVDZ0DgarwNcW
         K87Z9ROjgRwhosMqkw0Oa+E4bPqmwwsOhtrK53VqwjaNuUDp3MXRQtE3aeYvex2RYQHu
         5UFcEz/3cUp/6GZcElYLLldO8g/H+5QgEzW6kwH3E14CdIkzBmMgvUK2o36OLm5seQ8N
         Jv1VZ1AVEXo+mv8tF1DeXC1tfMbt8vh9qdIMIMA/sqALSfwmN0d2YvG79Z4OrFasaDJK
         oLBAsicuG9fo8uKwt0knzd36/Y1hYwmUO7xy6bRJtzjYgZXE/07EzL7b046Ug2zVeoZJ
         DNcw==
X-Gm-Message-State: AOAM5301kqdQE4FguNUJLRkLmeybGXcXplX3jEZlloexNrBkUht8XwAH
        rcDopOMJiQhMI4wyxyA/50MYWB0+w/1WnYVUSh8=
X-Google-Smtp-Source: ABdhPJw2XouqEqIRocixtR0bpAG0gAlXUGFHRFTt4Dmg4x0Q7IOfR3tDAxZZYMHgAdFeCICbirtK9QIj4YjudSzLW0U=
X-Received: by 2002:a05:6808:1141:: with SMTP id u1mr18793414oiu.123.1633968340570;
 Mon, 11 Oct 2021 09:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de> <YWQ3963xcO3xbFo5@zn.tnic>
 <87d93314-ba3e-464f-d051-84a8de674b06@amd.com> <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
 <be2b3cca-9822-4bb7-12b4-4c5c89318625@amd.com> <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
 <CADnq5_OLaFFuK-LaEw+aXdbJcXa0pEUEBJaCbaeuOxVbEat_oA@mail.gmail.com> <YWRgN63FOrQGO8jS@zn.tnic>
In-Reply-To: <YWRgN63FOrQGO8jS@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Oct 2021 12:05:29 -0400
Message-ID: <CADnq5_PtpbRrpkK2KQ=UOJughGRymOcO7J4KU+SnbiiD8Z+8Ag@mail.gmail.com>
Subject: Re: [PATCH -v2] x86/Kconfig: Do not enable AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 automatically
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

On Mon, Oct 11, 2021 at 12:03 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok,
>
> here's v2, I've added "however" number 3 below which should summarize
> Christian's note about coherent and concurrent use of memory by the GPU
> and CPU, which obviously cannot work with bounce buffers.
>
> I'll send it to Linus next week if there are no more complaints.
>
> Thx.
>
> ---
> From: Borislav Petkov <bp@suse.de>
>
> This Kconfig option was added initially so that memory encryption is
> enabled by default on machines which support it.
>
> However, devices which have DMA masks that are less than the bit
> position of the encryption bit, aka C-bit, require the use of an IOMMU
> or the use of SWIOTLB.
>
> If the IOMMU is disabled or in passthrough mode, the kernel would switch
> to SWIOTLB bounce-buffering for those transfers.
>
> In order to avoid that,
>
>   2cc13bb4f59f ("iommu: Disable passthrough mode when SME is active")
>
> disables the default IOMMU passthrough mode so that devices for which the
> default 256K DMA is insufficient, can use the IOMMU instead.
>
> However 2, there are cases where the IOMMU is disabled in the BIOS, etc.
> (think the usual hardware folk "oops, I dropped the ball there" cases) or a
> driver doesn't properly use the DMA APIs or a device has a firmware or
> hardware bug, e.g.:
>
>   ea68573d408f ("drm/amdgpu: Fail to load on RAVEN if SME is active")
>
> However 3, in the above GPU use case, there are APIs like Vulkan and
> some OpenGL/OpenCL extensions which are under the assumption that
> user-allocated memory can be passed in to the kernel driver and both the
> GPU and CPU can do coherent and concurrent access to the same memory.
> That cannot work with SWIOTLB bounce buffers, of course.
>
> So, in order for those devices to function, drop the "default y" for the
> SME by default active option so that users who want to have SME enabled,
> will need to either enable it in their config or use "mem_encrypt=on" on
> the kernel command line.
>
>  [ tlendacky: Generalize commit message. ]
>
> Fixes: 7744ccdbc16f ("x86/mm: Add Secure Memory Encryption (SME) support")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <stable@vger.kernel.org>
> Link: https://lkml.kernel.org/r/8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  arch/x86/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index bd70e8a39fbf..d9830e7e1060 100644
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
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
