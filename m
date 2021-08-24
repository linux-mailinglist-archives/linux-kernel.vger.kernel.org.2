Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BB03F6016
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhHXOVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhHXOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:21:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:20:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r2so19915155pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5T95M5lfE+srLIAkpG9PHutUq3ARWWsEvJ8TbETp7i0=;
        b=bbMFlT0KhjOcGWgTjRCQ+dd/LrVYiNuirkt7WHtNe44YENjMWcnaoOwIm6OUe6T6oo
         93jmPglRpIJcK+qFjqrNLburIffZs0+xbu84oGGwb/pAXw5yMgL881msZriA8Y2lp25y
         lOYNlK9foRn/XrQyP42Qdp2AK6seI35w94Dgp3WhrbaONPS6/LDweLbHO4Ew7WvaD7p8
         5u18q/UaXM1/NQX7qVD4/kK4e3WFAXaCyQfr891eHBKKaOLhIHECxDZrbyzwcJXOUTOx
         SZlvuXvkWWad2+C5JdxcSHTkpR/8o5PoNQGTBVIjtNmN6xbgY9W44llPIhpof38EzZSE
         HWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5T95M5lfE+srLIAkpG9PHutUq3ARWWsEvJ8TbETp7i0=;
        b=kSL7glVsosCWUEQloTCf34nXMlLaEQ0zYPEnHzBfVm3wJHSQaIC1gutiep264DFCno
         LgH/TQq45SJbEEwKYABgTavEHPN4KuDhRimMDIHWUq1gM3zIh7C0P0DZfynjhQBZW1fl
         oY4xbg5CLPe8Z7mVe4TjHJsiz5YP9w8IFj0sgEy8M7DbJJvnpOgIqmn1tji/yxwdEuRL
         vUzt61sfrM+KsqHLDzIzsyEC0Sr/RriNn/E26pUcjzuqOeZF4cXzkj19tgW9cyxYDjXu
         RzlcwF2VkSyr0in7IMrofrm3jqrj/PA/vHtkc4lRXt2HPc/YAEiEt3iZ6UbNrCrZATPo
         ltRg==
X-Gm-Message-State: AOAM531yYWeymxY/QBac0J9L9ZCpYRwg0DFzbT4qGjLlROBLaDzkYF9W
        HhXuZqVbu2Bv+lMD/0zeARF04Q==
X-Google-Smtp-Source: ABdhPJyDjUJtKVJaMfykvUPFlFwfXzWuU+K3Fk1o2sOxOg09hq0opgYgTbd+0rqZkJXrr+E6SMCAUA==
X-Received: by 2002:aa7:8f14:0:b0:3e1:3bdf:e4d3 with SMTP id x20-20020aa78f14000000b003e13bdfe4d3mr39140212pfr.39.1629814835939;
        Tue, 24 Aug 2021 07:20:35 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z4sm2790761pjl.53.2021.08.24.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:20:35 -0700 (PDT)
Date:   Tue, 24 Aug 2021 14:20:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] KVM: VMX: Disallow PT MSRs accessing if PT is not
 exposed to guest
Message-ID: <YSUALsBF8rKNPiaS@google.com>
References: <20210824110743.531127-1-xiaoyao.li@intel.com>
 <20210824110743.531127-5-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824110743.531127-5-xiaoyao.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021, Xiaoyao Li wrote:
> Per SDM, it triggers #GP for all the accessing of PT MSRs, if
> X86_FEATURE_INTEL_PT is not available.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4a70a6d2f442..1bbc4d84c623 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1010,9 +1010,16 @@ static unsigned long segment_base(u16 selector)
>  static inline bool pt_can_write_msr(struct vcpu_vmx *vmx)
>  {
>  	return vmx_pt_mode_is_host_guest() &&
> +	       guest_cpuid_has(&vmx->vcpu, X86_FEATURE_INTEL_PT) &&
>  	       !(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN);
>  }
>  
> +static inline bool pt_can_read_msr(struct kvm_vcpu *vcpu)
> +{
> +	return vmx_pt_mode_is_host_guest() &&
> +	       guest_cpuid_has(vcpu, X86_FEATURE_INTEL_PT);
> +}
> +
>  static inline bool pt_output_base_valid(struct kvm_vcpu *vcpu, u64 base)
>  {
>  	/* The base must be 128-byte aligned and a legal physical address. */
> @@ -1849,24 +1856,24 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  							&msr_info->data);
>  		break;
>  	case MSR_IA32_RTIT_CTL:
> -		if (!vmx_pt_mode_is_host_guest())
> +		if (!pt_can_read_msr(vcpu))

These all need to provide exemptions for accesses from the host.  KVM allows
access to MSRs that are not exposed to the guest so long as all the other checks
pass.  Same for the next patch.

Easiest thing is probably to pass in @msr_info to the helpers and do the check
there.

>  			return 1;
>  		msr_info->data = vmx->pt_desc.guest.ctl;
>  		break;
