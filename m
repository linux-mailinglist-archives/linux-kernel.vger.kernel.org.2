Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606F8445D1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 01:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhKEAy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 20:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhKEAy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 20:54:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB64AC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 17:52:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k4so10052640plx.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uCH8t91lFcjRnDOcwcN0CwWqkbbPkrn0hhYpSIb82zA=;
        b=sShQdCLccwDTVD7/q0z6iiCGczwOGvYtn62xONjWmRoX3hdmqa7pWhwkYkTzzDwyap
         f3oftkJVC1wmV6Uf4T5C0neABifO6XS3FOGF4NShFpCz/xx6ZIS5xDUv3k0vUtrV+Eyl
         CmcOzSkhqCOqtuzaQ7slCeMR+Jt7ZmtCzb+FiSPzKIHJpbcCYaoWLuGTOy7yNVPMKwJf
         GAmK3AepxvfCl03MkAQsWFBsvuTa7J7IeunyyI5elnECuXPXQq2HhBBlC/MYubetH2rv
         zNTanOSJbueofxyorefgQ4Br7WEdTS9FF8nRYxfpXoO6byCf8B2LXgWcuId/w/mgcMj0
         NK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uCH8t91lFcjRnDOcwcN0CwWqkbbPkrn0hhYpSIb82zA=;
        b=Hrt1/xIEoOwBqUPBA7XTSlaWIMvsrOyBXqa4an9enQgjqZu4pAfJYQd4H3Sl4E8pH4
         vNVJAaJkMCEdo6AWwMhy4Wo8qC8Oky2ICRMbwNhu9LQKBiflE6VouO5mHvJSHpPUxghy
         gJ08EoEdv1M4y7L6S0eX0NYEnQOSuQAhzFLJq535Lj1yp7HCdX9WtKrWmIPJugDZ5Bt9
         0NW7jD+oEqI9j+4Sy8LNtocp4W+8EGrKpMt6J6Ubc8xSgb1N6i0iuGc1efnzCDt6jbGY
         MxINdO+4Vmzg5GtGMIXXFz48MilBIzyj8y7QQDpK6MhgjuhtgEpYPBgmLERMKNQazPKe
         4HgA==
X-Gm-Message-State: AOAM532fIl3DS55gamqXgw9XkeEsaoBjmC4VVLVmEQ9rJwAjCQwUo6W9
        EtqUOyR5lzSTLaS9xlXRfgWfUg==
X-Google-Smtp-Source: ABdhPJyckkmkJ2vXm4o42wBECVNwchkOxHObIjzHdPLNT6jPQYr8FAavO3PW84g/hXRjV4HSaLEsRQ==
X-Received: by 2002:a17:90a:fd96:: with SMTP id cx22mr26586829pjb.151.1636073538326;
        Thu, 04 Nov 2021 17:52:18 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t66sm2046078pfd.150.2021.11.04.17.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 17:52:17 -0700 (PDT)
Date:   Fri, 5 Nov 2021 00:52:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] KVM: nVMX: Don't use Enlightened MSR Bitmap for L3
Message-ID: <YYSAPotqLVIScunK@google.com>
References: <20211013142258.1738415-1-vkuznets@redhat.com>
 <20211013142258.1738415-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013142258.1738415-2-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021, Vitaly Kuznetsov wrote:
> 3-level nesting is also not a very common setup nowadays.

Says who? :-D

> Don't enable 'Enlightened MSR Bitmap' feature for KVM's L2s (real L3s) for
> now.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1c8b2b6e7ed9..e82cdde58119 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2655,15 +2655,6 @@ int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
>  		if (!loaded_vmcs->msr_bitmap)
>  			goto out_vmcs;
>  		memset(loaded_vmcs->msr_bitmap, 0xff, PAGE_SIZE);
> -
> -		if (IS_ENABLED(CONFIG_HYPERV) &&
> -		    static_branch_unlikely(&enable_evmcs) &&
> -		    (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {
> -			struct hv_enlightened_vmcs *evmcs =
> -				(struct hv_enlightened_vmcs *)loaded_vmcs->vmcs;
> -
> -			evmcs->hv_enlightenments_control.msr_bitmap = 1;
> -		}
>  	}
>  
>  	memset(&loaded_vmcs->host_state, 0, sizeof(struct vmcs_host_state));
> @@ -6903,6 +6894,18 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>  
>  	vmx->loaded_vmcs = &vmx->vmcs01;
>  
> +	/*
> +	 * Use Hyper-V 'Enlightened MSR Bitmap' feature when KVM runs as a
> +	 * nested (L1) hypervisor and Hyper-V in L0 supports it.

And maybe call out specifically that KVM intentionally uses this only for vmcs02?

> +	 */
> +	if (IS_ENABLED(CONFIG_HYPERV) && static_branch_unlikely(&enable_evmcs)
> +	    && (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {

&& on the previous line, I think we'll survive the 82 char line :-)

> +		struct hv_enlightened_vmcs *evmcs =
> +			(struct hv_enlightened_vmcs *)vmx->loaded_vmcs->vmcs;

Hmm, what about landing this right after vmcs01's VMCS is allocated?  It's kinda
weird, but it makes it more obvious that ->vmcs is not NULL.  And if the cast is
simply via a "void *" it all fits on one line.

	err = alloc_loaded_vmcs(&vmx->vmcs01);
	if (err < 0)
		goto free_pml;

	/*
	 * Use Hyper-V 'Enlightened MSR Bitmap' feature when KVM runs as a
	 * nested (L1) hypervisor and Hyper-V in L0 supports it.  Enable an
	 * enlightened bitmap only for vmcs01, KVM currently isn't equipped to
	 * realize any performance benefits from enabling it for vmcs02.
	 */ 
	if (IS_ENABLED(CONFIG_HYPERV) && static_branch_unlikely(&enable_evmcs) &&
	    (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {
		struct hv_enlightened_vmcs *evmcs = (void *)vmx->vmcs01.vmcs;

		evmcs->hv_enlightenments_control.msr_bitmap = 1;
	}

> +
> +		evmcs->hv_enlightenments_control.msr_bitmap = 1;
> +	}
> +
>  	if (cpu_need_virtualize_apic_accesses(vcpu)) {
>  		err = alloc_apic_access_page(vcpu->kvm);
>  		if (err)
> -- 
> 2.31.1
> 
