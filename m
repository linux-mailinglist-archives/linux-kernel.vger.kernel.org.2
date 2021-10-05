Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200424232BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhJEVSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235545AbhJEVSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633468577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTNivPlifppN7dLR240NN9xgDpFZ1XpURCcBZB0vwI8=;
        b=Yo2CQ4NghKwep4U9jTuaTbz5lKrQ5yJwnkxHxOH+1pIgUw08vmzHOovLlCMnh7leU1UnVw
        Qaeig5ZkJgO1FbyAo6x66K+LptBBDRbedPPz1oPycgiVtV014OL11ToG7dnTgYQW4tvIEf
        pwh/JJ/j2ach7mPjkh6ZP9K6PP8GSo0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-Wb_fu8g8Mimk6aEWmY2SkQ-1; Tue, 05 Oct 2021 17:16:16 -0400
X-MC-Unique: Wb_fu8g8Mimk6aEWmY2SkQ-1
Received: by mail-ot1-f72.google.com with SMTP id p7-20020a056830318700b0054749cce9bcso262916ots.18
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LTNivPlifppN7dLR240NN9xgDpFZ1XpURCcBZB0vwI8=;
        b=53RSW1YcOYPu2cFUM+ikCoG/G2yG5CnhONW4v/30yFMZOREpYoUlQCDSoqbgJGIG1X
         dMantHgGfZUAIYmkx/KeuGfVCzGkZRAgUCCaZSC0EhcCiarhne1JpoPspftrn2goBK40
         pzhOwG5TbxiO+l1UgBDajz+jrzZYRz00CZkBG3dceKubza5Cth6XQ33kEH8cSuabNA0x
         V1pXaaymePqXu562VcYPMB8E2/YkNsFXOT3bxrmUsRccU6wT+eGk56mRRfjAZ/7bXFUA
         VyZMS6/XXrxOJ4Rjy+dKVxORWJXjZ+gOrRqkyLV4ex5p7o4u6wKOXMAsOtSQy73xFHGJ
         rONg==
X-Gm-Message-State: AOAM5309pM7CxdVd/Me6GmgjRfZ2PMKbc52NjK4HRw/gO/CPpGVsZk4i
        2rHvJYH/y2QYr7sN0vBX92Z4r7atF7JZNTbLoThkNX5KzHCnED/Z6P80F6qyb+WF6OxRgfdKIoR
        WQfBTvvwondlobLpXRyQNSbLy
X-Received: by 2002:a4a:8789:: with SMTP id b9mr5679742ooi.9.1633468575515;
        Tue, 05 Oct 2021 14:16:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtb8LTfG/dRjz36MwYMT+NJj6lnh+qHKrO3g9J6YLdlRJ50NicY6382ueBCb6u7YJyaAIV0Q==
X-Received: by 2002:a4a:8789:: with SMTP id b9mr5679705ooi.9.1633468575245;
        Tue, 05 Oct 2021 14:16:15 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id j4sm3573872oia.56.2021.10.05.14.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 14:16:14 -0700 (PDT)
Date:   Tue, 5 Oct 2021 14:16:11 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
Subject: Re: [PATCH v8 04/11] x86/tdx: Add Intel ARCH support to
 cc_platform_has()
Message-ID: <20211005211611.ys42txybaed4ffpz@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:51:58PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +#if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_ARCH_HAS_CC_PLATFORM)
> +bool intel_cc_platform_has(enum cc_attr attr);
> +#else
> +static inline bool intel_cc_platform_has(enum cc_attr attr) { return false; }
> +#endif
> +

I assume this needs a rebase on -tip since cc_platform.c already has an
empty version of this function (and it's static so it doesn't need to be
declared in a header).

>  #endif	/* __ASSEMBLY__ */
>  
>  #endif	/* __X86_MEM_ENCRYPT_H__ */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 159fccfece65..8e5b49be65bd 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -28,6 +28,7 @@ KASAN_SANITIZE_dumpstack.o				:= n
>  KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
>  KASAN_SANITIZE_stacktrace.o				:= n
>  KASAN_SANITIZE_paravirt.o				:= n
> +KASAN_SANITIZE_cc_platform.o				:= n
>  KASAN_SANITIZE_sev.o					:= n
>  KASAN_SANITIZE_tdx.o					:= n

This change is already in -tip as well.

> +	/**
> +	 * @CC_ATTR_GUEST_TDX: Trusted Domain Extension Support
> +	 *
> +	 * The platform/OS is running as a TDX guest/virtual machine.
> +	 *
> +	 * Examples include Intel TDX.
> +	 */
> +	CC_ATTR_GUEST_TDX,

Examples of TDX include TDX? :-)

-- 
Josh

