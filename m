Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AED30C81A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhBBRl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbhBBRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:39:14 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A07C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:38:33 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t29so14808565pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pVSquQSJrpYri28cE6XyoyehQWlIu8NKqtes58NqYnw=;
        b=iPjbSd3lMUVp+LL3SbLTaxLFPpifaaJDTb//4xQdc/L3ioPjSukPHVzjXBAe+udK0G
         hVFCtFYJyIgmEZLl4DjM92zZxYk5lLtod1CPtuoE8YL9NulxrHBpdrnoU0Ht3fPC5HIx
         F3o9wBimLyh+QvrM7zmD1Sc3us7fEjU16+ff0DX/VoKZ67zd4CF1+I9Jrh6yYJ9t0Y/w
         2savrwGja6E2cxd7zyhENRS6JJJ1GaopyvVV7gLCC+iM7YsR8WZcXlay7rbB2xGfDMba
         9Gw7TCEquEeYaNplRBBabw3aAswWwnqkeQ1tX8MM5It4QCVECGMDoU5v6S6QWxlmWfZX
         7VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pVSquQSJrpYri28cE6XyoyehQWlIu8NKqtes58NqYnw=;
        b=e1vXv5f2He/EPFi4tjQStELiKcBvKy2Ktxg2ZDrVVvaQsUvVCGfWfz2NNJHXw5DXaj
         hY7Fzztrdnlfn/Ge5Gaq+7GMLUrvrV+UubpvoXxg+6bUbv1lxj16QMOFjgFUuujq5o0k
         AaUSwGstYIIpzH4jOtKgEaUTtrEHcQQCNUmZYZ4dJyl/yYpPeQCz69Dbrrk1h98T0iC4
         NsTEFFXrU65U5+ocQGUkfZjYwtvIHwnm8DUQMuAt6u3USsQggVRMrscWWhFWkaleYHQP
         b1uC2gkgJZSFkbPToHkPHvAL9uCYguvxLrdNLLacCGEDbkpFf+jhtPvUX2qfMXJKMkJQ
         AJMg==
X-Gm-Message-State: AOAM532ShAQ2tfpJNWNFCj87Zhi37jXWA8uIYmhM0HlgjLzbsqJXXVvA
        9R+3QMdMuaXnITHDgVGQHI6wpoDkfoEQkw==
X-Google-Smtp-Source: ABdhPJyscSr9KAYJt2pwrGFtbF+cqkEDEm4VWe11h1YjFChuKOikDuV0f84w6vLAkYydzOIFhBWIIQ==
X-Received: by 2002:a62:ac06:0:b029:1cb:35bc:5e2c with SMTP id v6-20020a62ac060000b02901cb35bc5e2cmr16876009pfe.42.1612287513189;
        Tue, 02 Feb 2021 09:38:33 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e1bc:da69:2e4b:ce97])
        by smtp.gmail.com with ESMTPSA id i1sm23910312pfb.54.2021.02.02.09.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:38:32 -0800 (PST)
Date:   Tue, 2 Feb 2021 09:38:26 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/3] KVM: x86: move kvm_inject_gp up from
 kvm_handle_invpcid to callers
Message-ID: <YBmOEt6YezYWtTjQ@google.com>
References: <20210202165141.88275-1-pbonzini@redhat.com>
 <20210202165141.88275-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202165141.88275-3-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021, Paolo Bonzini wrote:
> Push the injection of #GP up to the callers, so that they can just use
> kvm_complete_insn_gp.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

...

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 08568c47337c..edbeb162012b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11375,7 +11375,6 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
>  		return kvm_handle_memory_failure(vcpu, r, &e);

This is broken.  kvm_handle_memory_failure() injects a #PF and returns 1, which
means an error here will trigger #PF->#GP->#DF.

>  
>  	if (operand.pcid >> 12 != 0) {
> -		kvm_inject_gp(vcpu, 0);
>  		return 1;
>  	}

Curly braces can be dropped.

> @@ -11385,15 +11384,13 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
>  	case INVPCID_TYPE_INDIV_ADDR:
>  		if ((!pcid_enabled && (operand.pcid != 0)) ||
>  		    is_noncanonical_address(operand.gla, vcpu)) {
> -			kvm_inject_gp(vcpu, 0);
>  			return 1;
>  		}
>  		kvm_mmu_invpcid_gva(vcpu, operand.gla, operand.pcid);
> -		return kvm_skip_emulated_instruction(vcpu);
> +		return 0;
>  
>  	case INVPCID_TYPE_SINGLE_CTXT:
>  		if (!pcid_enabled && (operand.pcid != 0)) {
> -			kvm_inject_gp(vcpu, 0);
>  			return 1;
>  		}

Same here.

>  
> @@ -11414,7 +11411,7 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
>  		 * resync will happen anyway before switching to any other CR3.
>  		 */
>  
> -		return kvm_skip_emulated_instruction(vcpu);
> +		return 0;
>  
>  	case INVPCID_TYPE_ALL_NON_GLOBAL:
>  		/*
> @@ -11427,7 +11424,7 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
>  		fallthrough;
>  	case INVPCID_TYPE_ALL_INCL_GLOBAL:
>  		kvm_mmu_unload(vcpu);
> -		return kvm_skip_emulated_instruction(vcpu);
> +		return 0;
>  
>  	default:
>  		BUG(); /* We have already checked above that type <= 3 */
> -- 
> 2.26.2

IMO, this isn't an improvement.  For flows that can't easily be consolidated to
x86.c, e.g. CRs (and DRs?), I agree it makes sense to use kvm_complete_insn_gp(),
but this feels forced.

What about a pure refactoring of kvm_handle_invpcid() to get a similar effect?

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ef630f8d8bd2..b9f57f9f2422 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11363,28 +11363,23 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
        if (r != X86EMUL_CONTINUE)
                return kvm_handle_memory_failure(vcpu, r, &e);
 
-       if (operand.pcid >> 12 != 0) {
-               kvm_inject_gp(vcpu, 0);
-               return 1;
-       }
+       if (operand.pcid >> 12 != 0)
+               goto inject_gp;
 
        pcid_enabled = kvm_read_cr4_bits(vcpu, X86_CR4_PCIDE);
 
        switch (type) {
        case INVPCID_TYPE_INDIV_ADDR:
                if ((!pcid_enabled && (operand.pcid != 0)) ||
-                   is_noncanonical_address(operand.gla, vcpu)) {
-                       kvm_inject_gp(vcpu, 0);
-                       return 1;
-               }
+                   is_noncanonical_address(operand.gla, vcpu))
+                       goto inject_gp;
+
                kvm_mmu_invpcid_gva(vcpu, operand.gla, operand.pcid);
-               return kvm_skip_emulated_instruction(vcpu);
+               break;
 
        case INVPCID_TYPE_SINGLE_CTXT:
-               if (!pcid_enabled && (operand.pcid != 0)) {
-                       kvm_inject_gp(vcpu, 0);
-                       return 1;
-               }
+               if (!pcid_enabled && (operand.pcid != 0))
+                       goto inject_gp;
 
                if (kvm_get_active_pcid(vcpu) == operand.pcid) {
                        kvm_mmu_sync_roots(vcpu);
@@ -11402,8 +11397,7 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
                 * given PCID, then nothing needs to be done here because a
                 * resync will happen anyway before switching to any other CR3.
                 */
-
-               return kvm_skip_emulated_instruction(vcpu);
+               break;
 
        case INVPCID_TYPE_ALL_NON_GLOBAL:
                /*
@@ -11416,11 +11410,17 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
                fallthrough;
        case INVPCID_TYPE_ALL_INCL_GLOBAL:
                kvm_mmu_unload(vcpu);
-               return kvm_skip_emulated_instruction(vcpu);
+               break;
 
        default:
                BUG(); /* We have already checked above that type <= 3 */
        }
+
+       return kvm_skip_emulated_instruction(vcpu);
+
+inject_gp:
+       kvm_inject_gp(vcpu, 0);
+       return 1;
 }
 EXPORT_SYMBOL_GPL(kvm_handle_invpcid);
 

