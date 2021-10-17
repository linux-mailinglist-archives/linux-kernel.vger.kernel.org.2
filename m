Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46C430BB7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbhJQTZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:25:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33852 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhJQTZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:25:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634498616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bS8eHN/rHSzUrokdi0mEHrTigThokrL8A9mvGaDhNak=;
        b=1HpFXb8dFdPw+4UBK2/aIAb1MK3ODgtMFajEYVjNnF2M4OEwGzmOinr21dPpZ5jJ5EN9ru
        2hy4+01DqdlL1DfFxdP0huThY9QVHY5ikMXOjrcniJizkrDmglBD8LrLcvC9jn2LATOkSV
        Z12WfKhZIMQpm4/Mrv9k8+kx5Bc/hKKLIgZdOAEqvkmRcL83xN8xDku8UIG4uzaMUyJhTj
        kn1z+uYV5cfvk2E1L7rVLMV122pySoqV8yBZTU1lQ8K5hzVz9vhTjysj/uFauOaHxEv81L
        IHlurAZliYI1g3tIpKQ2T0eMOTtQYu8Uth+rAaaRAyL5qkd6LLQ0oy5ouDmTQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634498616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bS8eHN/rHSzUrokdi0mEHrTigThokrL8A9mvGaDhNak=;
        b=muj8Z2KDBFC3l+jUyBIXgyIhjip5nsSi0vhmW6PRn1cLBaFnPNYFvsM84PNvxswnDyoSfI
        VX6hV/1yATNbKPBw==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] x86/topology: Disable CPU online/offline control
 for TDX guest
In-Reply-To: <20211005230550.1819406-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005230550.1819406-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Sun, 17 Oct 2021 21:23:31 +0200
Message-ID: <877deb4frg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05 2021 at 16:05, Kuppuswamy Sathyanarayanan wrote:
>  
> +static int tdx_cpu_offline_prepare(unsigned int cpu)
> +{
> +	/*
> +	 * Per Intel TDX Virtual Firmware Design Guide,
> +	 * sec 4.3.5 and sec 9.4, Hotplug is not supported
> +	 * in TDX platforms. So don't support CPU
> +	 * offline feature once it is turned on.
> +	 */
> +	return -EOPNOTSUPP;
> +}
> +
>  unsigned long tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out = {0};
> @@ -451,5 +464,8 @@ void __init tdx_early_init(void)
>  	pv_ops.irq.safe_halt = tdx_safe_halt;
>  	pv_ops.irq.halt = tdx_halt;
>  
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdx:cpu_hotplug",
> +			  NULL, tdx_cpu_offline_prepare);

Seriously? This lets the unplug start, which starts to kick off tasks
from the CPU just to make it fail a few steps later?

The obvious place to prevent this is the CPU hotplug code itself, right?

Thanks,

        tglx
---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 192e43a87407..c544eb6c79d3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1178,6 +1178,8 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 
 static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 {
+	if (cc_platform_has(CC_HOTPLUG_DISABLED))
+		return -ENOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
 	return _cpu_down(cpu, 0, target);


        
