Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2497042400B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbhJFO2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238734AbhJFO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633530366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xudSKXu0tUIHo/Kh4GTH3SABFsAoVJ2WLnJX5dK8z9c=;
        b=aHfcCt6lbL+hueLNN1eLHsHwcUW1GdxBw23ffUxJHMgo69eyfScDn552gowRV9cEoPrzav
        sgQw/Yu4qF1PlHfsbkBUXZ1avTZmaRq9cvaqN2CFjjNZXfyumqce9QuC8HfQaux8yyJZCH
        wXy0zE0yCDC7PaBgUpB8UYteBM3+Hfo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-UGsdWgKZOhu8clvCjDnk1g-1; Wed, 06 Oct 2021 10:26:04 -0400
X-MC-Unique: UGsdWgKZOhu8clvCjDnk1g-1
Received: by mail-oi1-f199.google.com with SMTP id n136-20020acad68e000000b00275ee0e97b5so1666906oig.16
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xudSKXu0tUIHo/Kh4GTH3SABFsAoVJ2WLnJX5dK8z9c=;
        b=x8QfAZ6/sKqlsTLiSwYWOnbTfLKZHAZFrATf27pjjw5widuOhzm+zT5WPrvckxE+Qq
         Hq9CyUnHiAV28BlVa0b3J98fFY/NsLaJMH2t7FtEd8+q5wW+9p4G0VCut1B2WlQGV3qO
         FtG1BkRmvjIt8DHbR8AFhl/5VANieLpCe5hXTxaSyaWjZg37L1xjuGytsjf7QNuW6oOV
         bfoAsCEOlhHZIW9t+quPxL0TZFUPmtTSliXq1aHm6Nu6ODBjY/xQG8hsnW2xhCW8WIJw
         bzvtcPNY4mE9bMj3lLfn/vK0ZC6KRtTV5wY8Lna9SJgzlOOQGBkIYTnXZAKdc5KUVqNW
         9Z3w==
X-Gm-Message-State: AOAM530HUcsS20OdASz040AYsSuzodDG+6l/296v7hiW5fPu92U4ZaNu
        mWY2cQFwLntZcdf4an6TLPbalLOGp7XXHLot9CxlF0zY9HuF0HJRyvo/2jchNx6S5KSiefutP8J
        OT8c0kAApNVyiF8029JZUN/m2
X-Received: by 2002:a05:6808:616:: with SMTP id y22mr5763892oih.159.1633530363287;
        Wed, 06 Oct 2021 07:26:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvdmedb044vxICUu4U+RdWcjiZJ9tVmMOkEL8mItjVOG7Lbo2mUzL/zd0mXXm69RAAUh0nrg==
X-Received: by 2002:a05:6808:616:: with SMTP id y22mr5763860oih.159.1633530363069;
        Wed, 06 Oct 2021 07:26:03 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id c17sm4246027oiw.10.2021.10.06.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:26:02 -0700 (PDT)
Date:   Wed, 6 Oct 2021 07:25:59 -0700
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
Message-ID: <20211006142559.4s7exdrzhgpk6awl@treble>
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
> +/*
> + * Allocate it in the data region to avoid zeroing it during
> + * BSS initialization. It is mainly used in cc_platform_has()
> + * call during early boot call.
> + */
> +u64 __section(".data") is_tdx_guest = 0;

Actually this should be __ro_after_init, since it never changes after
it's initialized.  As a bonus you won't have to worry about it getting
placed in BSS and the comment and initializer can go away.

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

setup_force_cpu_cap() sets a bit in 'cpu_caps_set' which is in BSS,
which gets cleared later right?  So this presumably doesn't fully work
as expected.  Maybe it can be set in init_intel(), based on
'is_tdx_guest'.

-- 
Josh

