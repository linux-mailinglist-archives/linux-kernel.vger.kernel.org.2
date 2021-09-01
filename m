Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6FA3FE58A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbhIAWmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhIAWmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:42:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F3C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 15:41:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 2so87307pfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3NRYGbQG6UX30AqNmUtI7t7dPAOy9Ipa6jbNHk92/oY=;
        b=kl7crTyanbSy2UXfXA3Wou6TvpU8o2k7DIs/hsyl4HUy2mMMnRlxAItMfrzVYFyhs6
         ypHxuUVf8YzjKIc8uCQj2mkC6lWfeKjPTjKL9YKItWyuKSL8sERYS1LzL95jkcNPJJhv
         5OV8TyO8m4uzWDC7lC3WGY607fIYH9LuHgi4CRJR+wqZLqnG7VQPn+0aH3TtXJl0Aymh
         /srhoPyJvch+nksJBUWGtUVWcPNSwKKwQeXD1e0SNE2wDxP0K73Gupa1wxjFzX92t1a9
         zTfjbsn9rFgbSLw9Vk4iRiAwYXd705col894ZTXBBWFFVjUiQ1XzVYcSuJ1X7esBJBYa
         WlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NRYGbQG6UX30AqNmUtI7t7dPAOy9Ipa6jbNHk92/oY=;
        b=cYPCtHL3br4xplNt/orGE2l1XeDQOn2YhCR3Z5/OqYNQTYcCdaHyW3Y9td1Khk9YsB
         WaiYDaXopHS/Ai1xr3uYvMA/O2QMN07n6zwb9fX0VX8YAdIEIt19MiM8gnMSJqI+2+mg
         abv/PyqrKXCMGXcO4R3qH9w0DquJWSviY6gIU2qZx6msOClOkayo08LJHM3Jn6cymTeC
         mazN9+y40nhu3UE/j9fKAUjOibDz+kurGmjy9XDHFDltbL+ukUd2IqwB5uNunjyv9DQ4
         8gOrCy1m0HPtiYxkKQsQPlD7kLt3zwrVk/YCkXR5/u3AMjyvX+EmKScztb9qhJ3BrY0V
         fLMw==
X-Gm-Message-State: AOAM531i6QWKkoQpKULkmz/M8FP5bO9JijLXq+JEIYC8TUWEi8uHfE80
        O8Xd8DDkq0L7CeDJQTaLMAJAUA==
X-Google-Smtp-Source: ABdhPJxBfJJQdPBhA8L8/oHzvypAYhFXCZBTr7W2qH2Su2I2/jYavct8zDw+qdTg98pZl5YPPP2AeA==
X-Received: by 2002:a63:6e02:: with SMTP id j2mr3697pgc.157.1630536104537;
        Wed, 01 Sep 2021 15:41:44 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r22sm15239pjp.7.2021.09.01.15.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 15:41:44 -0700 (PDT)
Date:   Wed, 1 Sep 2021 22:41:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2.1 3/4] KVM: SVM: Add support for Hypervisor Feature
 support MSR protocol
Message-ID: <YTABpNDxSkO84VAf@google.com>
References: <20210722115245.16084-1-joro@8bytes.org>
 <20210722115245.16084-4-joro@8bytes.org>
 <YPleNFvmsEi3kBZk@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPleNFvmsEi3kBZk@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021, Joerg Roedel wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> Version 2 of the GHCB specification introduced advertisement of
> supported Hypervisor SEV features. This request is required to support
> a the GHCB version 2 protocol.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/uapi/asm/svm.h |  1 +
>  arch/x86/kvm/svm/sev.c          | 21 +++++++++++++++++++++
>  arch/x86/kvm/svm/svm.h          |  1 +
>  3 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index efa969325ede..fbb6f8d27a80 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -108,6 +108,7 @@
>  #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
>  #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
>  #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
> +#define SVM_VMGEXIT_HV_FT			0x8000fffd

For this KVM-only (for all intents and purposes) name, please use the verbose
SVM_VMGEXIT_HYPERVISOR_FEATURES.

https://lkml.kernel.org/r/b73ad44e-7719-cde7-d543-df34e5acf9a5@amd.com

>  #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
>  
>  /* Exit code reserved for hypervisor/software use */
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index a32ef011025f..4565c360d87d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2180,6 +2180,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
>  	case SVM_VMGEXIT_AP_HLT_LOOP:
>  	case SVM_VMGEXIT_AP_JUMP_TABLE:
>  	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
> +	case SVM_VMGEXIT_HV_FT:
>  		break;
>  	default:
>  		goto vmgexit_err;
> @@ -2361,6 +2362,16 @@ static void set_ghcb_msr_ap_rst_resp(struct vcpu_svm *svm, u64 value)
>  	svm->vmcb->control.ghcb_gpa = GHCB_MSR_AP_RESET_HOLD_RESP | (value << GHCB_DATA_LOW);
>  }
>  
> +static void set_ghcb_msr_hv_feat_resp(struct vcpu_svm *svm, u64 value)
> +{
> +	u64 msr;
> +
> +	msr  = GHCB_MSR_HV_FT_RESP;
> +	msr |= (value << GHCB_DATA_LOW);
> +
> +	svm->vmcb->control.ghcb_gpa = msr;
> +}
> +
>  static void set_ghcb_msr(struct vcpu_svm *svm, u64 value)
>  {
>  	svm->vmcb->control.ghcb_gpa = value;
> @@ -2425,6 +2436,10 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>  
>  		break;
>  	}
> +	case GHCB_MSR_HV_FT_REQ: {
> +		set_ghcb_msr_hv_feat_resp(svm, GHCB_HV_FT_SUPPORTED);

I definitely think there are too many small wrappers that bury the write to
svm->vmcb->control.ghcb_gpa.  E.g. with a rename, this

		control->ghcb_msr = GHCB_MSR_HV_FT_RESP |
				    (GHCB_HV_FT_SUPPORTED << GHCB_DATA_LOW);

or maybe add a generic helper for simple data responses?  E.g. GHCB_MSR_AP_RESET_HOLD_REQ
can share a macro.

		control->ghcb_msr = GHCB_MSR_RESP_WITH_DATA(GHCB_MSR_HV_FT_RESP,
							    GHCB_HV_FT_SUPPORTED);

> +		break;
> +	}

Unnecessary braces.

>  	case GHCB_MSR_TERM_REQ: {
>  		u64 reason_set, reason_code;
>  
> @@ -2537,6 +2552,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  		ret = 1;
>  		break;
>  	}
> +	case SVM_VMGEXIT_HV_FT: {
> +		ghcb_set_sw_exit_info_2(ghcb, GHCB_HV_FT_SUPPORTED);
> +
> +		ret = 1;
> +		break;
> +	}

Unnecessary braces.

>  	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
>  		vcpu_unimpl(vcpu,
>  			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 7e2090752d8f..9cafeba3340e 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -550,6 +550,7 @@ void svm_vcpu_unblocking(struct kvm_vcpu *vcpu);
>  #define GHCB_VERSION_MAX	1ULL
>  #define GHCB_VERSION_MIN	1ULL
>  
> +#define GHCB_HV_FT_SUPPORTED	0
>  
>  extern unsigned int max_sev_asid;
>  
> -- 
> 2.31.1
> 
