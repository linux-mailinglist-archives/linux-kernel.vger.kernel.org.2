Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFFC3F618E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbhHXPZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhHXPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:25:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE933C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:24:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m26so18675712pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dOpXg+FJdBLWI5rzPlpee9Thq8Rl+rTtOGkPC38d/eM=;
        b=JeIic1euaNtoLKNq9Q2VWjbFLkdZFTk39npgl9ehainLBb57csCZPGQnFvb8pOYRlY
         SdtJJN6+MbbojDL4x0iduT7RFArHpVi6EPsEJ2JWQ9IdgmYPP+rCtQma07PZk6OpRoEw
         3LQSiQJlRijueWh/uB7/CSX/ousA0s9uTsqzOq6mEVlNw11OHU/xzZqTYgeN6bPc2SQv
         Tyh97N6Z3hy0YNpcckKClrX2zX7jMAEBtyujYVM0bf2Ylz528MqHKSbhdhY5R4K1KuD6
         mu6txVs2KD7trtXyKliX6MGsbP+TnGqMr+Or6YrnvKIyD6/oDBwJzgyzgSMAY71xe9Fi
         2LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dOpXg+FJdBLWI5rzPlpee9Thq8Rl+rTtOGkPC38d/eM=;
        b=bEy4Ld+epwiFHJp8MxVlhSHSVWHdH005PWNMx+IHHJCGUoCDNFWO6DGjA10A8LG7/t
         IsBZhW07aOpaU4S/z0VHJy6ClVdJFwBXILc/n9oEE9ZnW0GF01qsnbIWLWdxc1DOimkI
         y14MvqvkBaLXZrmQldngl+mV1KCWjqlKBqsbfyAfF8Y0OUFFU3ShPqReiMinyTYhfKyp
         qFlQ/N3yvyOjKkutet6c2b4V+kfzGBV66NVVWQ5Ht4Esqdvt6QR0IOQXaDqCeJJ253gv
         sTjrRnCO3xZ1bwgwkI8qFZe3QB6OcrbqA2NcQUPVvF0p54aY88JjJVrD2LxB+KELaz4D
         KNWQ==
X-Gm-Message-State: AOAM532drw1rlh0HAXDel0ek9yC7V7BlF++w7LBKqDqt2/WWvii4pDME
        PkD6VzyZkETI4hQtoPdV09sYRQ==
X-Google-Smtp-Source: ABdhPJzRLPy8KIFVr1u2JWlVmZFkhe9C3VHpJlsLA0fV++hreJjotD//9FSKzU53CDs5iITtPa44MA==
X-Received: by 2002:a63:480b:: with SMTP id v11mr37586366pga.413.1629818677254;
        Tue, 24 Aug 2021 08:24:37 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b7sm18844657pfl.195.2021.08.24.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:24:36 -0700 (PDT)
Date:   Tue, 24 Aug 2021 15:24:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] KVM: VMX: Use cached vmx->pt_desc.addr_range
Message-ID: <YSUPKmtP6Dcl1yio@google.com>
References: <20210824110743.531127-1-xiaoyao.li@intel.com>
 <20210824110743.531127-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824110743.531127-3-xiaoyao.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021, Xiaoyao Li wrote:
> The number of guest's valid PT ADDR MSRs is cached in

Can you do s/cached/precomputed in the shortlog and changelog?  Explanation below.

> vmx->pt_desc.addr_range. Use it instead of calculating it again.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e0a9460e4dab..7ed96c460661 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2202,8 +2202,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (!pt_can_write_msr(vmx))
>  			return 1;
>  		index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
> -		if (index >= 2 * intel_pt_validate_cap(vmx->pt_desc.caps,
> -						       PT_CAP_num_address_ranges))
> +		if (index >= 2 * vmx->pt_desc.addr_range)

Ugh, "validate" is a lie, a better name would be intel_pt_get_cap() or so.  There
is no validation, the helper is simply extracting the requested cap from the
passed in array of capabilities.

That matters in this case because the number of address ranges exposed to the
guest is not bounded by the number of address ranges present in hardware, i.e.
it's not "validated".  And that matters because KVM uses vmx->pt_desc.addr_range
to pass through the ADDRn_{A,B} MSRs when tracing enabled.  In other words,
userspace can expose MSRs to the guest that do not exist.

The bug shouldn't be a security issue, so long as Intel CPUs are bug free and
aren't doing silly things with MSR indexes.  The number of possible address ranges
is encoded in three bits, thus the theoretical max is 8 ranges.  So userspace can't
get access to arbitrary MSRs, just ADDR0_A -> ADDR7_B.

And since KVM would be modifying the "validated" value, it's more than just a
cache, hence the request to use "precomputed".

Finally, vmx_get_msr() should use the precomputed value as well.

P.S. If you want to introduce a bit of churn, s/addr_range/nr_addr_ranges would
     be a welcome change as well.

>  			return 1;
>  		if (is_noncanonical_address(data, vcpu))
>  			return 1;
> -- 
> 2.27.0
> 
