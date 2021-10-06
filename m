Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDFA42462F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbhJFSmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239069AbhJFSmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633545639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fLMmfnaxcfN7/WOtGQ11g4LVY5mp5/ANoXiKGJMlpeo=;
        b=fbTpH9EwUq3q0X+eZcx0jNH1sYVFabPGtFxO+Xu0tk4MtUMSdnXh7Z+5ENi4C7gE1zo4ia
        naTGV86OI7UMduhn/T6hNIzTcERSv2iF6+c9O6xEC4p6wwyufuGPGwhbYWVGomT6pkD4r9
        L63E8RZW0WbrALFiPO55/JY0hJq1q88=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-PhXkUTkTO46YmOL6iIdStg-1; Wed, 06 Oct 2021 14:40:38 -0400
X-MC-Unique: PhXkUTkTO46YmOL6iIdStg-1
Received: by mail-ot1-f70.google.com with SMTP id k21-20020a9d7015000000b0054d5b451decso2063641otj.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 11:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fLMmfnaxcfN7/WOtGQ11g4LVY5mp5/ANoXiKGJMlpeo=;
        b=c50hj4eZGvdSOeeeJBcUQf8s15yCddNbqP2riafl4PON+tIeHN6LQqWyXdugg7ZMJD
         6Ip4jXqrQ+oLIij2NQ739cFyr1dkHo0T+VwCU+0hFFzRi6FBCqdNX39RXOB+hzA18arW
         bAYKn2joa0dJCn6R2XJrJERA+CeKAKi5w6YzJg+Cw71NNW5pd3xMUrmzt6/qK+md/kEW
         cN1MBWI2sZFXmM7RHlaNQJeBPQQ7yJULeVcGLZus1KLauq2Q3AYb5GwE4T2ra7b5/ijw
         qLd0u530k9IuGT5LlUZQpiZmezR6e3Gf2XnHlBeM3hHlli8yOMlpKqu3Dn6VvXcE6/cQ
         ougw==
X-Gm-Message-State: AOAM533rag/JLBgE/2nN+6DogrlxRUJUydPZ6AZG1e/xLVu3BseetJVb
        bCNV2Ube0Fx/XXYcUlBprxDs5bbGu7CFF5tZ+u/ab+a6emm96IdIH3W6Rw+LJDLw+GPm1+7F8Qz
        4++anrKagZ56nG5oT33/TZSua
X-Received: by 2002:aca:120f:: with SMTP id 15mr8165182ois.62.1633545637291;
        Wed, 06 Oct 2021 11:40:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYFZAAq7ADR8wr4SAI/tz7D0qV4V4jysDlQKQLQPnuk71cgHeTOTO4e1P/SelMhFxXfQnD/Q==
X-Received: by 2002:aca:120f:: with SMTP id 15mr8165159ois.62.1633545637013;
        Wed, 06 Oct 2021 11:40:37 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id k11sm89274oom.3.2021.10.06.11.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 11:40:36 -0700 (PDT)
Date:   Wed, 6 Oct 2021 11:40:33 -0700
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
Subject: Re: [PATCH v8 06/11] x86/traps: Add #VE support for TDX guest
Message-ID: <20211006184033.dcydf6ul7m2cv2pi@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:52:00PM -0700, Kuppuswamy Sathyanarayanan wrote:
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -68,6 +68,9 @@ static const __initconst struct idt_data early_idts[] = {
>  	 */
>  	INTG(X86_TRAP_PF,		asm_exc_page_fault),
>  #endif
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
> +#endif
>  };
>  
>  /*
> @@ -91,6 +94,9 @@ static const __initconst struct idt_data def_idts[] = {
>  	INTG(X86_TRAP_MF,		asm_exc_coprocessor_error),
>  	INTG(X86_TRAP_AC,		asm_exc_alignment_check),
>  	INTG(X86_TRAP_XF,		asm_exc_simd_coprocessor_error),
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
> +#endif

I don't think this 'def_idts' entry is necessary.  The #VE IDT gate is
already initialized due to the 'early_idts' entry.

>  
>  #ifdef CONFIG_X86_32
>  	TSKG(X86_TRAP_DF,		GDT_ENTRY_DOUBLEFAULT_TSS),
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index d5fc2904facf..f7885c777a09 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -6,6 +6,9 @@
>  
>  #include <asm/tdx.h>
>  
> +/* TDX Module call Leaf IDs */
> +#define TDGETVEINFO			3

This doesn't appear to be the canonical name anyway, can we at least
insert some underscores to make it more readable?

TDX_GET_VEINFO?

> @@ -1140,6 +1141,82 @@ DEFINE_IDTENTRY(exc_device_not_available)
>  	}
>  }
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +#define VEFSTR "VE fault"

Something more readable like VE_FAULT_STR?

-- 
Josh

