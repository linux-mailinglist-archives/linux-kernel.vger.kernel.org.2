Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43C741BAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 01:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbhI1X1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 19:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243188AbhI1X1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 19:27:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67176C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:25:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l6so200593plh.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VT5WbeKu0/eAkdwTtxtDa6N+vEQxewEmE2ILnAElu/s=;
        b=ISb4xKpQ3KFJ9GbIEUzIAHYtEC1cdwp731mKzzT6VysqyYqmCwkTPOTZ34fJVkr+B7
         G00rj6qWxaNJ6xsCsbSAoIHqAit18YfUxXtTDNlvdz2UnwweKrHGeew8GEa6BNnBjKfo
         sCnLF8Lbe7QGizn/2FpDqSfBjZ4bU8AJjHpXqdWJNiOOdpXQ2TivkNu8qqY+Iy0038DH
         Xbwqsj3y2+khTxMFFuSCbxXMRVytRm1gk2lIVC/7lBZV49pWT+OaBiP9noSdnEf17rpi
         +yWQuZ+Eh6zuEoYMuOrwIKfDkaY8lN+9xYAd37FtVRe72baLwrF7MsrStyOxdCBpv+1i
         FzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VT5WbeKu0/eAkdwTtxtDa6N+vEQxewEmE2ILnAElu/s=;
        b=QPmOp8TMI5t3MuJKr8MUoDym+K6Gwi6/x18aInqA8fJimiL2eNzGrpLgwLG1N3ELwM
         ikeLKaZhEjpYs2o0lQdD7jTT75PKnMb5ziCuwIpNGV7kG54Yt/kwgAj34YjgOH5bgXtO
         rOqtgBIy8/JSqT2ijc4CNHe2wYjlfkJNtzPMcw15OMkV2UIm7cVyNdC+ygip3oztSOJ/
         UWQLWhMJFbkEDN/JjCDNL0ij5VxJO6L6wUe2BUqxMsIylnNoT/ZO9v+VWALma8UCLwgU
         wsjI7qM3/ACIKuY/UFBUbE5Ub4usAjC86Eq7aMYCFCplOS4zsZQIiA02leCsqCA9Ckff
         5bvw==
X-Gm-Message-State: AOAM531X/1kRZ6pb4QDW02GJucP2Q3tP0x9EpikSdTTIbssly9l/Kq/l
        3Px2fUpn85g6sczVSwoqUmdRyA==
X-Google-Smtp-Source: ABdhPJwNeho1jCzibhnWsQTqtNbPKwXZ+faCPzaJLhWwp/0vXkH5MyIOCY0TtRjXlbOWrJCNv6YBhQ==
X-Received: by 2002:a17:902:6ac7:b0:13e:1fec:2bbc with SMTP id i7-20020a1709026ac700b0013e1fec2bbcmr7520714plt.82.1632871542538;
        Tue, 28 Sep 2021 16:25:42 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id p4sm237228pgc.15.2021.09.28.16.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:25:41 -0700 (PDT)
Date:   Tue, 28 Sep 2021 23:25:38 +0000
From:   David Matlack <dmatlack@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [PATCH v3 02/31] KVM: MMU: Introduce struct kvm_page_fault
Message-ID: <YVOkcn+PzZOpGRMA@google.com>
References: <20210924163152.289027-1-pbonzini@redhat.com>
 <20210924163152.289027-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924163152.289027-3-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 12:31:23PM -0400, Paolo Bonzini wrote:
> Create a single structure for arguments that are passed from
> kvm_mmu_do_page_fault to the page fault handlers.  Later
> the structure will grow to include various output parameters
> that are passed back to the next steps in the page fault
> handling.
> 
> Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu.h | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index e9688a9f7b57..0553ef92946e 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -114,17 +114,45 @@ static inline void kvm_mmu_load_pgd(struct kvm_vcpu *vcpu)
>  					  vcpu->arch.mmu->shadow_root_level);
>  }
>  
> +struct kvm_page_fault {
> +	/* arguments to kvm_mmu_do_page_fault.  */
> +	const gpa_t addr;
> +	const u32 error_code;
> +	const bool prefault;

This is somewhat tangential to your change but... I notice KVM uses
"prefetch" and "prefault" interchangably. If we changed prefault to
prefetch here and in kvm_mmu_do_page_fault then that would make the
naming consistent throughout KVM ("prefetch" for everything).

> +
> +	/* Derived from error_code.  */
> +	const bool exec;
> +	const bool write;
> +	const bool present;
> +	const bool rsvd;
> +	const bool user;
> +
> +	/* Derived from mmu.  */
> +	const bool is_tdp;
> +};
> +
>  int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>  		       bool prefault);
>  
>  static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  					u32 err, bool prefault)
>  {
> +	struct kvm_page_fault fault = {
> +		.addr = cr2_or_gpa,
> +		.error_code = err,
> +		.exec = err & PFERR_FETCH_MASK,
> +		.write = err & PFERR_WRITE_MASK,
> +		.present = err & PFERR_PRESENT_MASK,
> +		.rsvd = err & PFERR_RSVD_MASK,
> +		.user = err & PFERR_USER_MASK,
> +		.prefault = prefault,
> +		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
> +	};
>  #ifdef CONFIG_RETPOLINE
> -	if (likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault))
> -		return kvm_tdp_page_fault(vcpu, cr2_or_gpa, err, prefault);
> +	if (fault.is_tdp)
> +		return kvm_tdp_page_fault(vcpu, fault.addr, fault.error_code, fault.prefault);
>  #endif
> -	return vcpu->arch.mmu->page_fault(vcpu, cr2_or_gpa, err, prefault);
> +	return vcpu->arch.mmu->page_fault(vcpu, fault.addr, fault.error_code, fault.prefault);
>  }
>  
>  /*
> -- 
> 2.27.0
> 
> 
