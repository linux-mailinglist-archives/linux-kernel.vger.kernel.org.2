Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFF3E0A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhHDV7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHDV7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:59:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB57C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:59:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l19so5098141pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O8eJ77gUUAQPCTRG4aKmdZBbj0yzJFVRjQmVIPqu+nY=;
        b=Sy91xrJtaeMLLuVxL6+f1+uJtkDsKFSh3I/amCRlUJn9ma1utz8JNgRUWQVejG6IQJ
         2L0VeyIck1MTqpyMt18SY0ed9uvgF3epGv7JmGLq/eXOWyCLOIxJ9roXARNXXpD8ZtU2
         o0z65MEOkRoY3qVwgw2d5SIZM0iqn8cuYjhiTaWrWywJMVPkiHfhZqd4n18/5oRyP15k
         ZX9oFBaIq2O81VcqGHt/M43F4K33WrNCyD31cewYnN509EIEDuYEgH4m/ntwcE2PYiQ+
         EOCLv7XMMgOQU/9sroWhRFwsDjPHg+8NeftPEUbAvIptvNTlUEhZk0fuRSktSvfDJiVI
         6UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O8eJ77gUUAQPCTRG4aKmdZBbj0yzJFVRjQmVIPqu+nY=;
        b=ukueP3wx4rsrCS6ofhaobCuYiF/iwyUxrGQaMd8yluddIAT8YnjRpnXBr7r0FRX6Qd
         /leoiHx22zQVZ3Q6IYSq3ZIjcUzgYE2Kqt+6dphVpq1vfZGrTcs6EEGHy85rzaQLDSJj
         VegCXSDcph49279uwYwjdSHYVdpEAFtQJlpUXaez9COeCxI2dV4YRmKJQAMoL/4r+fXV
         ibhBCNfzdqipsaUKORRZB1noSq1222mc2xwSpkRNLuH3+U3HWbehNxyNpwRw9m6X1+Kz
         de0ZPsqqLnFVbbleH7Dn1UMN9PuFh12EdWnzJ+e+ngole3GbEoL71MnpDEEnqLOAvYsr
         dEsQ==
X-Gm-Message-State: AOAM531zoCmoNznq0QJmVYwvfZZeS8OLgTOApPIawcvtalNhQ36GWUGm
        hgcyccadFKiMIn+z8k0sz28CrQ==
X-Google-Smtp-Source: ABdhPJw2Ew3hDfI22U6qEBviQI4Q/MIZoAzm+AkbAdKfMwB1ZiPHwWQqmC0Xbjp3aB8fxVi6BYT+Ng==
X-Received: by 2002:aa7:96cd:0:b029:3b7:53e2:9e6b with SMTP id h13-20020aa796cd0000b02903b753e29e6bmr1670733pfq.19.1628114344599;
        Wed, 04 Aug 2021 14:59:04 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q16sm3948189pfk.153.2021.08.04.14.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 14:59:04 -0700 (PDT)
Date:   Wed, 4 Aug 2021 21:59:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/12] x86/tdx: Add protected guest support for TDX
 guest
Message-ID: <YQsNpG55v7dhFqIb@google.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021, Kuppuswamy Sathyanarayanan wrote:
> TDX architecture provides a way for VM guests to be highly secure and
> isolated (from untrusted VMM). To achieve this requirement, we can't
> completely trust any data coming from VMM. TDX guest fixes this issue
> by hardening the IO drivers against the attack from the VMM. Since we
> have a requirement to modify the generic drivers, we need to use the
> generic prot_guest_has() API to add TDX specific code in generic
> drivers.
> 
> So add TDX guest support in prot_guest_has() API.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---

...

> diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
> index b4a267dddf93..c67bf13c8ad3 100644
> --- a/arch/x86/include/asm/protected_guest.h
> +++ b/arch/x86/include/asm/protected_guest.h
> @@ -12,12 +12,17 @@
>  
>  #include <linux/mem_encrypt.h>
>  
> +#include <asm/processor.h>
> +#include <asm/tdx.h>
> +
>  #ifndef __ASSEMBLY__
>  
>  static inline bool prot_guest_has(unsigned int attr)
>  {
>  	if (sme_me_mask)
>  		return amd_prot_guest_has(attr);
> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)

Why not "boot_cpu_has(X86_FEATURE_TDX_GUEST)"?
