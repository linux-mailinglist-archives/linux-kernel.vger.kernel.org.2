Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB4446A38
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhKEVCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKEVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:02:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354ACC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:59:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id iq11so3848191pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MXiC0S76dI2cPXsuxXI/B8AxYMIOQDDtelXVgC1U1K4=;
        b=cUzRVKMoPxS1py3Y/hYVdKwctH0kHTW3uj09eufdPHfuvdx4Az2XRhwRSFhuMhADwA
         JoOW92fGfBGfQSLl+XTRXFwn2BBRTUnOdEHB+ENThiRFaQG2wwMQ09xUC7A0SXLnmx+N
         WwTkXQwEI89uQzDpnC7MDUHgHW96R6zhFqP+i28g5u5A/Lps0/+/2DEnIUVpbkvhVLDr
         mqLz0BvLOMoqYihsfD6BIv9M1u+M6ISpPu3QYLVEKiM1mJmNuyU0rjakKKS7LcM17fyx
         I02gakwsGTudL57O4r68i+pBfoEA7oWrXJMFOR4B/ee6fgeoX6rLtIOL78EvKeDcnGIE
         Q0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXiC0S76dI2cPXsuxXI/B8AxYMIOQDDtelXVgC1U1K4=;
        b=HmmU30XAdAcatcAAidMzvmPyT/6h4NWHfdNRprxPzezUsp4NBChD4RBl7n2WxQ0idT
         2+yxz4pW6VfyEKU9k69P5SVjpZ7djJZMO0bRTgInsBvNU8X/1zo4ZgSgIGR5y+YeQ3fo
         4N5Ta6bQGXktgEp5wXBtDyRJe2cmT0pJ7Xja3D+O5my6cU3YxHogh4ag5gUQOdC7G5pc
         +24H6P0eiFlCc6FJbq1PTdRzG0vX0/62M81MzhQECv0/VrnYelxdiTIAqCJ6PQiso1f4
         jXfstE5KLaspXAO3eNXdKNg+HACwPNTwbCJUeg8HShHxfME+c4iumWzasGtFeVNG4yjY
         KD3g==
X-Gm-Message-State: AOAM532tboNtlxbwzJztisIoU6Ro43PmC2OeAo3PP6OwEexVtCi3iNOX
        2Ew0wuDifdTmoo1Oa1Rt6TcIew==
X-Google-Smtp-Source: ABdhPJyQgYAcCIZ9WIYAfeAgEMCBydb43M8muGPipBl5QRsCErYRTzJk8/0xt6cOKxEiKHVEMXRx4w==
X-Received: by 2002:a17:903:2055:b0:142:497c:a249 with SMTP id q21-20020a170903205500b00142497ca249mr6205316pla.35.1636145962459;
        Fri, 05 Nov 2021 13:59:22 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id ng9sm10631656pjb.4.2021.11.05.13.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:59:21 -0700 (PDT)
Date:   Fri, 5 Nov 2021 20:59:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/11] x86/tdx: Wire up KVM hypercalls
Message-ID: <YYWbJVTNr5QMTQGb@google.com>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-9-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-9-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021, Kuppuswamy Sathyanarayanan wrote:
> [Isaku Yamahata: proposed KVM VENDOR string]

...

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 458a564dd4c2..ebb97e082376 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -6,8 +6,9 @@
>  #include <linux/cpufeature.h>
>  #include <linux/types.h>
>  
> -#define TDX_CPUID_LEAF_ID	0x21
> -#define TDX_HYPERCALL_STANDARD  0
> +#define TDX_CPUID_LEAF_ID			0x21
> +#define TDX_HYPERCALL_STANDARD			0
> +#define TDX_HYPERCALL_VENDOR_KVM		0x4d564b2e584454 /* TDX.KVM */

...

> +#if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
> +static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
> +				     unsigned long p2, unsigned long p3,
> +				     unsigned long p4)
> +{
> +	struct tdx_hypercall_output out;
> +	u64 err;
> +
> +	err = __tdx_hypercall(TDX_HYPERCALL_VENDOR_KVM, nr, p1, p2,
> +			      p3, p4, &out);

Why use a magic string?  There are already mechanisms for the host to announce
itself to the guest, i.e. the guest shouldn't be attempting these hypercalls unless
it knows it's running on KVM (or something that implements KVM's ABI, whatever
that may be).

The only use case I can think of is to support multiple flavors of hypercalls in
the VMM, e.g. to let KVM support both KVM and Hyper-V hypercalls when KVM is
masquerading as Hyper-V, but this magic value alone isn't sufficient.

And if there is a future where KVM wants to support multiple sets of hypercalls,
using the entire 64-bit GPR for a magic value is unnecessary and wasteful, e.g.
it requires an overside MOV imm, reg.

Why not use a single high bit?  Actually, looking at KVM's set of hypercalls,
the guest can literally pass @nr as is.  The GHCI defines all non-zero values as
vendor owned, i.e. this needs to ensure only that @nr is non-zero.  For whatever
reason, perhaps to avoid false positives if the guest forgets to fill the value,
KVM's hypercalls start at '1'.

Regardless of what is stuffed into r10 for the TDVMCALL, if it's anything other
than KVM's raw hypercall number, it absolutely must go into
include/uapi/linux/kvm_para.h and it should be done as a standalone commit,
because what you're proposing here is effectively committing KVM to supporting
an ABI.  That is not remotely clear from the changelog.
