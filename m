Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF01424775
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhJFTvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229810AbhJFTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633549758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UEWV04P6aOqAyOh95Ju38pNlOcSyEyaLX9ZsILND1Lk=;
        b=Rw072eIkrVR2FhSIeJdjd+IADKUJl8uQmcplNcGaGXxHgO6IKTSk4AaYyzRDUiIIZwxS4e
        8XFl+B48lNSXwn+nkQl6/KCRDF99lkSSWM5lbC15uMTd2ndZQK9Vh7TSy69U7L70/eEQq6
        k0SFZDDfvrJfQbqxsDKNb2WwJLnptHo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-Mo4TzK5WPKSa6bw14yK7dQ-1; Wed, 06 Oct 2021 15:49:16 -0400
X-MC-Unique: Mo4TzK5WPKSa6bw14yK7dQ-1
Received: by mail-oo1-f72.google.com with SMTP id o8-20020a4aabc8000000b002b601d1fb33so2293766oon.23
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UEWV04P6aOqAyOh95Ju38pNlOcSyEyaLX9ZsILND1Lk=;
        b=qSxEECbKsrqxCo0XwOHTIHDdqPFIBr401TcEfSMW72dKKOSRe7QH1sBR1y6B6Kg8MU
         30NveZG50/wfle7s8j+C0iB6AomXk1DofgoLOgPCJGNmThIDBSp52zaJD9G4K4NJT5fF
         /20OytvXS12AN5suCXEyDkD8TcmgVdnVXyjivC90f4qhWCIC21nli9w6ZsBpXn0jzVKL
         k22NnOKTkqQLdNp6Mm2GdaaT7XZRoOUgm4tjeQXyptSA0HeTo9oDKT3HbwQHUBH1G78h
         LcjOWvujDMLDKW5+AHKNw6HviCVqKTDhsJVvmirh9pXXGNZLbNSaJS82iTxydweTcMPO
         u38w==
X-Gm-Message-State: AOAM5319ZuCFsx5dVlWPMXQOfT0Z8I+VxKhROIGgwpu87eKPQIdb2jgx
        kaRW7kJlp86MFWH6oYFwPz9AfO3tZ4ryrhJWckqwR36WRGHdvci6wDX9PJZNiq5zKoKwlRnM/gb
        wq181gb9DMb/NRAHqLAaXWgk3
X-Received: by 2002:a05:6808:f88:: with SMTP id o8mr8997305oiw.49.1633549754771;
        Wed, 06 Oct 2021 12:49:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfNz5WBJcjrJfm7QTgK5rBymR0hCYFTsvPv/cfMETDGcNXtb+LsvQ+VMscL1xPNpPGQH1wKg==
X-Received: by 2002:a05:6808:f88:: with SMTP id o8mr8997284oiw.49.1633549754533;
        Wed, 06 Oct 2021 12:49:14 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id bd24sm4478512oib.52.2021.10.06.12.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:49:14 -0700 (PDT)
Date:   Wed, 6 Oct 2021 12:49:10 -0700
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
Subject: Re: [PATCH v8 09/11] x86/tdx: Add MSR support for TDX guest
Message-ID: <20211006194910.cdbqzn5enpueg7iw@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-10-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-10-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:52:03PM -0700, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 3d0416515506..062ac4720434 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -110,6 +110,41 @@ static __cpuidle void tdx_safe_halt(void)
>  	_tdx_halt(irq_disabled, do_sti);
>  }
>  
> +static u64 tdx_read_msr_safe(unsigned int msr, int *err)

Here the kernel convention would probably be to return the error and
make 'val' an argument:

static int tdx_read_msr_safe(unsigned int msr, u64 *val)


> +{
> +	struct tdx_hypercall_output out = {0};
> +	u64 ret;
> +
> +	/*
> +	 * Emulate the MSR read via hypercall. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), sec titled "TDG.VP.VMCALL<Instruction.RDMSR>".
> +	 */
> +	ret = _tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out);
> +
> +	*err = ret ? -EIO : 0;
> +
> +	return out.r11;
> +}
> +
> +static int tdx_write_msr_safe(unsigned int msr, unsigned int low,
> +			      unsigned int high)
> +{
> +	u64 ret;
> +
> +	WARN_ON_ONCE(tdx_is_context_switched_msr(msr));

This fails to build, tdx_is_context_switched_msr() is missing.

> @@ -136,19 +171,33 @@ unsigned long tdx_get_ve_info(struct ve_info *ve)
>  int tdx_handle_virtualization_exception(struct pt_regs *regs,
>  					struct ve_info *ve)
>  {
> +	unsigned long val;
> +	int ret = 0;
> +
>  	switch (ve->exit_reason) {
>  	case EXIT_REASON_HLT:
>  		tdx_halt();
>  		break;
> +	case EXIT_REASON_MSR_READ:
> +		val = tdx_read_msr_safe(regs->cx, (unsigned int *)&ret);

Why the 'unsigned int *' cast?

Also, 'val' should have the same type as the one returned by
tdx_read_msr_safe().  (Though it technically doesn't matter here.)

-- 
Josh

