Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB63393602
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhE0TNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhE0TNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:13:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB4BC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:11:41 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 27so675954pgy.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RE1qcP7vRIDhMC+4p2UKC8eKad09zvQ8yhQM/ragHj8=;
        b=qLKb8JgiNEKyopizIPmcyaNgma9muoqIc9lRad1LH0VqqoQ5mjTChUbotc4AbndIvg
         mX5GqBuqdwLcm5G9Ni6/RmGDxvhj3EbZzwFDCx2Xbik4+QoU+RVj+Nk3PD9CjvgJ5r8i
         sKsldL31c5wfm2dJM+R/vkzG3qdkkL+56LSwt0mbAKGYVpJgVco8hn7Dnv4emuwvvnLX
         7GDOceUUV1ZMZAzgINptnSRgrQ7oSoOk2obk1mOmkorFerFPSK3S4FO5v+qYygM/EOEO
         9Ma4SS2/KRZ0A299gNY4XensWaQyHVUlMvL2ttjCQS89DS6ngIVgchzPpjKnRmGb9giG
         RHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RE1qcP7vRIDhMC+4p2UKC8eKad09zvQ8yhQM/ragHj8=;
        b=Npux/nfaDtvCNXaVwdwR6vL3x9p2j/j8JErJampMOzYffklFTlQ3z6jE0ER8BSE8SS
         jCXUuGqSxuIRL+Lha+89Vz1JFy/KfNLzEWz9uJ7OcU4txsC6atEC/Fkfh4UfoPca4FMp
         o4hAhmYYIg9KZ7EgE4in1IwUKXyufSVtyk0DeOcfB385dFbNvrCXBmJqj+imAm/Tgq/o
         +6yW/rWooPREh+R80NhD05uZp6WxmU3LKZZu1ZtOwitwinFnZeYVpmVmKUW7iiJNYqlp
         RDSh1GHiy5CFGlgdoLPNCPMvwXrgVuMu4H6Kn6u5CPdxltjPwgTATy6MAfeLdIhCM51c
         5aOQ==
X-Gm-Message-State: AOAM5309ZlhZh8T7nx0Y2BAMOAX+QNnc1ubCYekASi/gxFVN3ujecv7W
        HXmbawU1nL26ZZwvi+FoiODaDQ==
X-Google-Smtp-Source: ABdhPJzTYCsAJgciUstnbjttdGVE4ouT7ErBqkdg+J2DgWFJEwSPTJW5HTkOSa30TY6ufM8ArnBbaQ==
X-Received: by 2002:a63:1b0b:: with SMTP id b11mr5135456pgb.410.1622142701157;
        Thu, 27 May 2021 12:11:41 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id f18sm2423360pjh.55.2021.05.27.12.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:11:40 -0700 (PDT)
Date:   Thu, 27 May 2021 19:11:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 43/43] KVM: x86: Drop pointless @reset_roots from
 kvm_init_mmu()
Message-ID: <YK/u6N18S9gG7Fua@google.com>
References: <20210424004645.3950558-1-seanjc@google.com>
 <20210424004645.3950558-44-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424004645.3950558-44-seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021, Sean Christopherson wrote:
> Remove the @reset_roots param from kvm_init_mmu(), the one user,
> kvm_mmu_reset_context() has already unloaded the MMU and thus freed and
> invalidated all roots.  This also happens to be why the reset_roots=true
> paths doesn't leak roots; they're already invalid.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu.h        |  2 +-
>  arch/x86/kvm/mmu/mmu.c    | 13 ++-----------
>  arch/x86/kvm/svm/nested.c |  2 +-
>  arch/x86/kvm/vmx/nested.c |  2 +-
>  4 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 88d0ed5225a4..63b49725fb24 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -65,7 +65,7 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only);
>  void
>  reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context);
>  
> -void kvm_init_mmu(struct kvm_vcpu *vcpu, bool reset_roots);
> +void kvm_init_mmu(struct kvm_vcpu *vcpu);
>  void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer,
>  			     gpa_t nested_cr3);
>  void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 930ac8a7e7c9..ff3e200b32dd 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4793,17 +4793,8 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
>  	update_last_nonleaf_level(vcpu, g_context);
>  }
>  
> -void kvm_init_mmu(struct kvm_vcpu *vcpu, bool reset_roots)
> +void kvm_init_mmu(struct kvm_vcpu *vcpu)
>  {
> -	if (reset_roots) {
> -		uint i;
> -
> -		vcpu->arch.mmu->root_hpa = INVALID_PAGE;
> -
> -		for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
> -			vcpu->arch.mmu->prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;

Egad!  This is wrong.  mmu->root_hpa is guaranteed to be INVALID_PAGE, but the
prev_roots are not!  I'll drop this patch and do cleanup of this code in a
separate series.

> -	}
> -
>  	if (mmu_is_nested(vcpu))
>  		init_kvm_nested_mmu(vcpu);
>  	else if (tdp_enabled)
