Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2FA33F8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhCQTMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:12:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39286 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhCQTLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:11:35 -0400
Received: from zn.tnic (p200300ec2f094a00b347ff8542af806f.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:4a00:b347:ff85:42af:806f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98A221EC0595;
        Wed, 17 Mar 2021 20:11:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616008294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IT+sbYUhPj57E3jyY3OyM34CWzd4arptbC0XaW/cWmw=;
        b=GEtmvyXPMkvnX4TkiBU+igaONJvSvyheptTH1PBaDK8ddLHMtnsSGb8tntO1HL8RYk8s0x
        XBO7g/lGyH1oYqNDnb66zFbqovpYoW4TEkXccRNWKJ+LqC7mKvH9Q1btdLweTd6uZYebVu
        TRYkb+rj79J9ZY4PVzNpDMzbguOzCtY=
Date:   Wed, 17 Mar 2021 20:11:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Peter Gonda <pgonda@google.com>
Subject: Re: [PATCH] x86/cpu/AMD: Adjust x86_phys_bits to account for reduced
 PA in SEV-* guests
Message-ID: <20210317191132.GD25069@zn.tnic>
References: <20210317183243.2904919-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210317183243.2904919-1-seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:32:43AM -0700, Sean Christopherson wrote:
> Always reduce x86_phys_bits per CPUID.0x8000001f[11:6] for SEV-* guests;
> the existing flow that queries X86_FEATURE_SEV may or may not trigger
> depending on what the VMM emulates, e.g. the VMM likely does not emulate
> MSR_K8_SYSCFG.
> 
> Print a somewhat scary message and override x86_phys_bits if the VMM
> doesn't omit the C-bit from MAXPHYADDR, which can be done either by
> enumerating a lower MAXPHYADDR or by enumerating a non-zero
> PhysAddrReduction.
> 
> Failure to adjust x86_phys_bits results in a false positive for
> phys_addr_valid() if the address sets the C-bit, and may also result in
> false positives for virt_addr_valid().  This is likely benign for a well-
> functioning kernel+drivers, but it's nearly impossible to confidently
> audit all users of the *_addr_valid() helpers, so who knows.
> 
> Opportunistically force clearing of SME, SEV, and SEV_ES in this case,
> as the kernel and KVM treat those feature flags as host capabilities, not
> guest capabilities.  This is likely a nop for most deployments, e.g. KVM
> doesn't emulate MSR_K8_SYSCFG.
> 
> Note, early kernel boot code for SEV-*, e.g. get_sev_encryption_bit(),
> _requires_ the SEV feature flag to be set in CPUID in order to identify
> SEV (this requirement comes from the SEV-ES GHCB standard).  But, that
> requirement does not mean the kernel must also "advertise" SEV in its own
> CPU features array.

Sure it does - /proc/cpuinfo contains feature bits of stuff which has
been enabled in the kernel. And when it comes to SEV, yeah, that was a
lot of enablement. :-)

> 
> Fixes: d8aa7eea78a1 ("x86/mm: Add Secure Encrypted Virtualization (SEV) support")
> Cc: stable@vger.kernel.org
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Peter Gonda <pgonda@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Regarding clearing SME, SEV, SEV_ES, etc..., it's obviously not required,
> but to avoid false postives, identifying "SEV guest" within the kernel
> must be done with sev_active().  And if we want to display support in
> /proc/cpuinfo, IMO it should be a separate synthetic feature so that
> userspace sees "sev_guest" instead of "sev".

I'm on the fence here, frankly. We issue capabilities in the guest dmesg
in print_mem_encrypt_feature_info(). However, if someone wants to query
SEV* status in the guest, then I don't have a good suggestion where to
put it. cpuinfo is probably ok-ish, a new /sys/devices/system/cpu/caps/
or so, should work too, considering the vuln stuff we stuck there so we
can extend that. We'll see.

> 
>  arch/x86/kernel/cpu/amd.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 2d11384dc9ab..0f7f8c905226 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -15,6 +15,7 @@
>  #include <asm/cpu.h>
>  #include <asm/spec-ctrl.h>
>  #include <asm/smp.h>
> +#include <asm/mem_encrypt.h>
>  #include <asm/numa.h>
>  #include <asm/pci-direct.h>
>  #include <asm/delay.h>
> @@ -575,10 +576,33 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
>  	resctrl_cpu_detect(c);
>  }
>  
> +#define SEV_CBIT_MSG "SEV: C-bit (bit %d), overlaps MAXPHYADDR (%d bits).  VMM is buggy or malicious, overriding MAXPHYADDR to %d.\n"

Not sure about that. This will make a lot of users run scared, not
knowing what's going on and open bugzillas.

> +
>  static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
>  {
>  	u64 msr;
>  
> +	/*
> +	 * When running as an SEV guest of any flavor, update the physical
> +	 * address width to account for the C-bit and clear all of the SME/SVE
> +	 * feature flags.  As far as the kernel is concerned, the SEV flags
> +	 * enumerate what features can be used by the kernel/KVM, not what
> +	 * features have been activated by the VMM.
> +	 */
> +	if (sev_active()) {
> +		int c_bit = ilog2(sme_me_mask);
> +
> +		BUG_ON(!sme_me_mask);
> +
> +		c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;

Well, if that leaf is intercepted, how do you wanna trust this at all?

IOW, you have c_bit so your valid address space is [0 .. c_bit-1] no?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
