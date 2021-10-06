Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07CA423659
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 05:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhJFDoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 23:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230306AbhJFDoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 23:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633491746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cq9QM7oxz7zu5iEfX1jX73fU6cps/HcqH2m3KFDbUC8=;
        b=d/9I5JW/veR8en2Df4HC+ojaomvcdDiytircOwOEO9glW3KzFxO5yVRwFuplv3opq0dAEZ
        4Ahf/ii0BaL5EjECRl+FlZ2tLaJXalQUCm1orAUTP8HS4UBUegIXMQkpC2LJOLQsTpzC+u
        K0sk/45LkkbBZwzt4Rf2kW+3Hdt+uBQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-wsk3K_6MMGWIJNLskLh7AQ-1; Tue, 05 Oct 2021 23:42:23 -0400
X-MC-Unique: wsk3K_6MMGWIJNLskLh7AQ-1
Received: by mail-qt1-f199.google.com with SMTP id z10-20020ac83e0a000000b002a732692afaso1281978qtf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 20:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cq9QM7oxz7zu5iEfX1jX73fU6cps/HcqH2m3KFDbUC8=;
        b=HBhOkpbazlAc1JUwMewwSDb6z/EQcBAzVsTtz0nVHDxA85ZYWeQ3LiKxtowi8PIqkx
         k6ZNrkaqGbhgl26FxWiHipIL9LsDxDrjHKhXvvU1DSJ8NGZ5cyTr+2q2npzqKoWrty7k
         /0hF5O0vVl0AN1HKdBfCn6P1F5l315+NJHZ9V/gXyKZ6056zCL6Vb/IC6bcUjasK2+nh
         kFnZPogLMlso66oztETs0M01dDsxohY2XFnFcuF42oGKVWECSySj90DrBgovdhhsvxIG
         wPNzQLi7HzQ8PKdUvt9+xHx4r+8h4gxkf+KTOE4q46L1RypmtBpgtuPgwTXKSueOXUVz
         nbFg==
X-Gm-Message-State: AOAM533yNRFlL92seAbg8Avz+QsaazfOp/pJrXUXVsEGHUVFj1crtLhp
        M+1LCiIOrFTXtyuzTZjdFoGQgm7Brwu2n/0P0fcJN08goyfWm1ayRhxbn6aDly8oIQ9yGIZ0eTM
        v0uMs+Z2aJVS1HyfgO1cyRTuP
X-Received: by 2002:a05:622a:1993:: with SMTP id u19mr24285728qtc.168.1633491743037;
        Tue, 05 Oct 2021 20:42:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX4vTl6+93PbbJhyDWOCHG7YWi9pEui6z+8do8CfNVqy7n9v6qVW/taAGIZGgnc8JKGbEiEQ==
X-Received: by 2002:a05:622a:1993:: with SMTP id u19mr24285713qtc.168.1633491742832;
        Tue, 05 Oct 2021 20:42:22 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c139sm10834026qkg.2.2021.10.05.20.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:42:22 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:42:18 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kuppuswamy, Sathyanarayanan" 
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
Message-ID: <20211006034218.ynamwigsvpgad7sr@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005210423.yfftpxxmj3cjprtv@treble>
 <15a07997-2659-6be1-b8a3-da57e72562b5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15a07997-2659-6be1-b8a3-da57e72562b5@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 02:41:35PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 10/5/21 2:04 PM, Josh Poimboeuf wrote:
> > On Mon, Oct 04, 2021 at 07:51:57PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > @@ -495,6 +496,13 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
> > >   	copy_bootdata(__va(real_mode_data));
> > > +	/*
> > > +	 * tdx_early_init() has dependency on command line parameters.
> > > +	 * So the order of calling it should be after copy_bootdata()
> > > +	 * (in which command line parameter is initialized).
> > > +	 */
> > > +	tdx_early_init();
> > 
> > Which cmdline parameters are those?
> 
> We have few debug command line options like tdx_forced (force TDX
> initialization) and tdx_disable_filter (Disables TDX device filter
> support). Support for these options have not been posted out (waiting
> to merge the initial support patches first). Since we need to access
> command line options, we want to follow the above calling order.

But until if/when those cmdline options are added, the comment is plain
wrong.  At the very least, it should state the present state of things,
i.e. that a future dependency on cmdline parameters is expected.

> > > +/*
> > > + * Allocate it in the data region to avoid zeroing it during
> > > + * BSS initialization. It is mainly used in cc_platform_has()
> > > + * call during early boot call.
> > > + */
> > > +u64 __section(".data") is_tdx_guest = 0;
> > 
> > Or you could just give it a -1 value here to avoid the section
> > annotation.  Not sure why it needs 64 bits, any reason it can't just be
> > bool?
> 
> It can be bool. I can fix this in next version.

Ok.  maybe something like

  bool is_tdx_guest = true;

along with the comment clarifying why the nonzero initializer is needed.

> > > +static void __init is_tdx_guest_init(void)
> > > +{
> > > +	u32 eax, sig[3];
> > > +
> > > +	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID) {
> > > +		is_tdx_guest = 0;
> > > +		return;
> > > +	}
> > > +
> > > +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);
> > > +
> > > +	is_tdx_guest = !memcmp("IntelTDX    ", sig, 12);
> > > +}
> > > +
> > > +void __init tdx_early_init(void)
> > > +{
> > > +	is_tdx_guest_init();
> > > +
> > > +	if (!is_tdx_guest)
> > > +		return;
> > > +
> > > +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> > > +
> > > +	pr_info("Guest initialized\n");
> > > +}
> > 
> > What's the point of having both 'is_tdx_guest' and
> > X86_FEATURE_TDX_GUEST?  Are they not redundant?
> 
> is_tdx_guest was mainly introduced to support cc_platform_has()
> API in early boot calls (similar to sme_me_mask in AMD code).
> Regarding FEATURE flag it will be useful for userspace tools to
> check the TDX feature support.

FEATURE flags can also be checked in the kernel, with boot_cpu_has().
Or am I missing something?

-- 
Josh

