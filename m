Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F04415BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbhIWKEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:04:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51174 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240296AbhIWKEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:04:36 -0400
Received: from zn.tnic (p200300ec2f0d6800cf632848c722fe0b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:cf63:2848:c722:fe0b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6CEE1EC0455;
        Thu, 23 Sep 2021 12:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632391379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CO2tuPSUYVCB02aiwRrjOKveOoclk3z9uHMolvPhOCc=;
        b=Vspo+A4DCy2+2jFfDMfE9clhHW2gfP4y1XPjkpUd76EDiin2fW6OPU/Nk6IzvGFIPmy4VL
        aBqgHPOZNP/Wta3sGFN0kOuroEsEQi7majLTI4/l02neruDlsyqCakmi/kUbofccPy13fZ
        ZzJBnTUjHOYgtqG49ffj6WH2k2niZbo=
Date:   Thu, 23 Sep 2021 12:02:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/12] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YUxQzRdoH3dLJjL2@zn.tnic>
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210916183550.15349-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916183550.15349-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:35:42AM -0700, Kuppuswamy Sathyanarayanan wrote:
> @@ -495,6 +496,8 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>  
>  	copy_bootdata(__va(real_mode_data));
>  
> +	tdx_early_init();
> +

| Changes since v4:
|  * Moved tdx_early_init() below copy_bootdata() because of
|    cmdline and IDT dependencies.


What "cmdline and IDT dependencies"?

Without a comment explaining why that thing must be there in the boot
order, you're adding more to the already fragile house of cards.

Explain please.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
