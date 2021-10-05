Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D004232A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhJEVGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231322AbhJEVGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633467869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qSi/EGCkMZaOb1CBlFluZpZE3DLb0hdQi2z1tMhFOGA=;
        b=OT8y6nHI8pLFxfRXJMzPrA89IDdLJe665sTwmAO9N0BCn5yzXSyGOB30+vEzY+LqF68hfy
        XHxMY97V1nRIGHv4hNbhtQ1AWBShb+AcWeOvU+5RVAj4wgeTjyyRl7g/M8gAILy/QAO/7r
        j0m/cSM9rPaMq+QPAr37sFBBjmXp2P8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-Z8ws3IoWOhmxrGuuEfbXAA-1; Tue, 05 Oct 2021 17:04:28 -0400
X-MC-Unique: Z8ws3IoWOhmxrGuuEfbXAA-1
Received: by mail-qk1-f200.google.com with SMTP id s18-20020a05620a255200b00433885d4fa7so301541qko.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qSi/EGCkMZaOb1CBlFluZpZE3DLb0hdQi2z1tMhFOGA=;
        b=P70vAKq3/zirvUI6Z6+WkOVzKo04KIJZyhe6ju9uFQ0jHOszXG+HLxjSYwaz02Y2a5
         8dIKniirq24Sk0XDAwIJQp91hQmHVfI0he8stcAEAmTqJaIXkoPVtDHl4RFKq2nTLnOX
         aTMuck7X/jnYM49aVOyOa4ZYSeMyPcIUR4CzIJuDxDhxcGPDDJRJYs93uBkC1N4T1Du7
         85OaSVb812MMbKC81Fp0RinqDUyy5QqBTs2qqBAtM8VoRpOyODrXESDVFidRsjknrp+T
         VXbATAVpcFTEmsgCweHqGhAkPs2uf0tFcu+EBmDL7zJ5d+Hr0I1J1GDW+6GIb+nVXkXE
         J3kQ==
X-Gm-Message-State: AOAM532qRvVuTKmnNLCEhSB1yfBva+5/n1RWcfZsTb586ooLq6nWXOpr
        rZttptTJNfpiVijbQgi1RYBAgY1Riv1aaC5MtE4ey3xKCq72EpAv3iJ1VJ5xs5K2Ree2gg0Qi1L
        1L+9Ih8kd8bxNn3sjOpXVdCjH
X-Received: by 2002:a37:63c2:: with SMTP id x185mr3094643qkb.223.1633467867955;
        Tue, 05 Oct 2021 14:04:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAGWMJQVnLo8VOb4yTsbj6mflor9520VMElto1oO/+aMP8NcZyoct3Z1g9RmWc0rc62irhBA==
X-Received: by 2002:a37:63c2:: with SMTP id x185mr3094615qkb.223.1633467867684;
        Tue, 05 Oct 2021 14:04:27 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id h5sm10360324qke.1.2021.10.05.14.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 14:04:27 -0700 (PDT)
Date:   Tue, 5 Oct 2021 14:04:23 -0700
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
Subject: Re: [PATCH v8 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <20211005210423.yfftpxxmj3cjprtv@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:51:57PM -0700, Kuppuswamy Sathyanarayanan wrote:
> @@ -495,6 +496,13 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>  
>  	copy_bootdata(__va(real_mode_data));
>  
> +	/*
> +	 * tdx_early_init() has dependency on command line parameters.
> +	 * So the order of calling it should be after copy_bootdata()
> +	 * (in which command line parameter is initialized).
> +	 */
> +	tdx_early_init();

Which cmdline parameters are those?

> +/*
> + * Allocate it in the data region to avoid zeroing it during
> + * BSS initialization. It is mainly used in cc_platform_has()
> + * call during early boot call.
> + */
> +u64 __section(".data") is_tdx_guest = 0;

Or you could just give it a -1 value here to avoid the section
annotation.  Not sure why it needs 64 bits, any reason it can't just be
bool?

> +
> +static void __init is_tdx_guest_init(void)
> +{
> +	u32 eax, sig[3];
> +
> +	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID) {
> +		is_tdx_guest = 0;
> +		return;
> +	}
> +
> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);
> +
> +	is_tdx_guest = !memcmp("IntelTDX    ", sig, 12);
> +}
> +
> +void __init tdx_early_init(void)
> +{
> +	is_tdx_guest_init();
> +
> +	if (!is_tdx_guest)
> +		return;
> +
> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> +
> +	pr_info("Guest initialized\n");
> +}

What's the point of having both 'is_tdx_guest' and
X86_FEATURE_TDX_GUEST?  Are they not redundant?

-- 
Josh

