Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB2942AE02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhJLUkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbhJLUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:40:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B871DC061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:38:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oa4so547567pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iQnV3pt8J3jb8XA6czy73gblHf036TthPcOfsFMgiAY=;
        b=VmKr4djT+eqIEmZtZWL/uW23lpthSKvp46povfujuU5koUN0k2iuu4zk8fTFWoyLek
         xpw22TK1jbHQL8sXVE0iUIVhrmJXLIOIbJJUuuiR8cb//6SfE3loeS+snUlzKo8i0C5H
         IyQ8c7mPWtWrvZexQJZrYG/+7szuXLBwrSBcc5dKOOSk4tFaHzrBU5p6nRxiqKt4YzzY
         WA/tWjRyZ/wTkg8ElxFt5drpv2naK6CTtp2EEHUkArCNVvzfyqHWzfu3HG8fAY6QFaYG
         IO9caj2gd1uNngxOa2QmiBaQ8Wske7hixXerdAZj+iv4tLnKqK0vy9fjkfMHzAV/Brly
         sRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iQnV3pt8J3jb8XA6czy73gblHf036TthPcOfsFMgiAY=;
        b=nrQRf1P9VaZDfxmrkjHgMvxXUjekcD3W/M3CROV17hBkVPOc6XF44SaWOTUWv4Ku5m
         pNpEC4IsKzaZq75VbzjR+9KHPHJkr29oA/7dcUjhrGvYu3yaVr/XMqYNh+FSOEQvrfhU
         CNZyqYMv1zBrhkK68yQjItsigDLQMJGCXdYMchahWK2zEB5P823sUhovSbdzDWhvGAqB
         ZrBrSTcKLmzQK7YZ50WgZs5TXxpJvMdeNtn92AJS7GtHLY4mxv9kr65fSHffTa4yhSB6
         dWHliPiphRF/WA3zZUO/f2jFo9pr05zpYKXyOclDW3hf2yIfLpWL7SLGwxmzbesjrVuY
         2TrQ==
X-Gm-Message-State: AOAM530wtxXU2/pH3z0ITMnwYAskHtNEuGigmavu61b/FmdaEXhXwqsH
        heXXU6QRwzODYSRFyhhtzvl0XA==
X-Google-Smtp-Source: ABdhPJwYuhpc+lnXyndFKFciOEGuFZvuJcxPeEVd9f4TxExIiDdwxtqOt5MEIvEjc6zXAi/TKh1zKw==
X-Received: by 2002:a17:90a:7d11:: with SMTP id g17mr8685244pjl.150.1634071108038;
        Tue, 12 Oct 2021 13:38:28 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id oj1sm3997435pjb.49.2021.10.12.13.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 13:38:27 -0700 (PDT)
Date:   Tue, 12 Oct 2021 20:38:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part2 v5 20/45] KVM: SVM: Provide the Hypervisor Feature
 support VMGEXIT
Message-ID: <YWXyP9E228aQSB5j@google.com>
References: <20210820155918.7518-1-brijesh.singh@amd.com>
 <20210820155918.7518-21-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820155918.7518-21-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021, Brijesh Singh wrote:
> Version 2 of the GHCB specification introduced advertisement of features
> that are supported by the Hypervisor.
> 
> Now that KVM supports version 2 of the GHCB specification, bump the
> maximum supported protocol version.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev-common.h |  2 ++
>  arch/x86/kvm/svm/sev.c            | 14 ++++++++++++++
>  arch/x86/kvm/svm/svm.h            |  3 ++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index d70a19000953..779c7e8f836c 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -97,6 +97,8 @@ enum psc_op {
>  /* GHCB Hypervisor Feature Request/Response */
>  #define GHCB_MSR_HV_FT_REQ		0x080
>  #define GHCB_MSR_HV_FT_RESP		0x081
> +#define GHCB_MSR_HV_FT_POS		12
> +#define GHCB_MSR_HV_FT_MASK		GENMASK_ULL(51, 0)
>  #define GHCB_MSR_HV_FT_RESP_VAL(v)			\
>  	/* GHCBData[63:12] */				\
>  	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0ca5b5b9aeef..1644da5fc93f 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2184,6 +2184,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
>  	case SVM_VMGEXIT_AP_HLT_LOOP:
>  	case SVM_VMGEXIT_AP_JUMP_TABLE:
>  	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
> +	case SVM_VMGEXIT_HV_FEATURES:
>  		break;
>  	default:
>  		goto vmgexit_err;
> @@ -2438,6 +2439,13 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>  				  GHCB_MSR_INFO_MASK,
>  				  GHCB_MSR_INFO_POS);
>  		break;
> +	case GHCB_MSR_HV_FT_REQ: {

Unnecessary braces.

> +		set_ghcb_msr_bits(svm, GHCB_HV_FT_SUPPORTED,
> +				  GHCB_MSR_HV_FT_MASK, GHCB_MSR_HV_FT_POS);
> +		set_ghcb_msr_bits(svm, GHCB_MSR_HV_FT_RESP,
> +				  GHCB_MSR_INFO_MASK, GHCB_MSR_INFO_POS);
> +		break;
> +	}
>  	case GHCB_MSR_TERM_REQ: {
>  		u64 reason_set, reason_code;
>  
> @@ -2553,6 +2561,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  		ret = 1;
>  		break;
>  	}
> +	case SVM_VMGEXIT_HV_FEATURES: {

Same here.

> +		ghcb_set_sw_exit_info_2(ghcb, GHCB_HV_FT_SUPPORTED);
> +
> +		ret = 1;
> +		break;
> +	}
>  	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
>  		vcpu_unimpl(vcpu,
>  			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
