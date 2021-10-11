Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF4428D85
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhJKNHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:07:37 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52211 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235418AbhJKNHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:07:36 -0400
Received: from [192.168.0.7] (ip5f5aef5a.dynamic.kabel-deutschland.de [95.90.239.90])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1C82A61E5FE33;
        Mon, 11 Oct 2021 15:05:34 +0200 (CEST)
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
Date:   Mon, 11 Oct 2021 15:05:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YV3hbK/uhChK5Pse@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Borislav,


Am 06.10.21 um 19:48 schrieb Borislav Petkov:
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
> Subject: [PATCH] x86/Kconfig: Do not enable AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT automatically
> 
> This Kconfig option was added initially so that memory encryption is
> enabled by default on machines which support it.
> 
> However, Raven-class GPUs, a.o., cannot handle DMA masks which are
> shorter than the bit position of the encryption, aka C-bit. For that,
> those devices need to have the IOMMU present.
> 
> If the IOMMU is disabled or in passthrough mode, though, the kernel
> would switch to SWIOTLB bounce-buffering for those transfers.
> 
> In order to avoid that,
> 
>     2cc13bb4f59f ("iommu: Disable passthrough mode when SME is active")
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
> 
> Fixes: 7744ccdbc16f ("x86/mm: Add Secure Memory Encryption (SME) support")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <stable@vger.kernel.org>
> Link: https://lkml.kernel.org/r/8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de
> ---
>   arch/x86/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8055da49f1c0..6a336b1f3f28 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1525,7 +1525,6 @@ config AMD_MEM_ENCRYPT
>   
>   config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
>   	bool "Activate AMD Secure Memory Encryption (SME) by default"
> -	default y
>   	depends on AMD_MEM_ENCRYPT
>   	help
>   	  Say yes to have system memory encrypted by default if running on
> 

I think, the IOMMU is enabled on the MSI B350M MORTAR, but otherwise, 
yes this looks fine. The help text could also be updated to mention 
problems with AMD Raven devices.


Kind regards,

Paul
