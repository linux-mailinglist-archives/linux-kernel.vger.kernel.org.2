Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210F14040DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 00:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhIHWFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 18:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbhIHWFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:05:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C26CC061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 15:04:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n18so4036495pgm.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=18AnhRW3dAr1PCrBHBFLJrZqcArBzwF29cM5sws1nbM=;
        b=pcYTw/bILO7ZwMau96S/hoLCEOgSW2MGGBOcOeyVd40FR08UqFRdJW9hcPqffjtZL4
         lECLA8XzdSVQqmMHDRVHcEnCeGiI1vQggyDOyxdcqIx5UX/2LvhC1J17X/SOpjJ1g9Ar
         TnwbfCqMx796Z5AiOmpNhVAUr7G5FgnTqlsMSDbQOn84ZGmvoydek+oZyy9wI1QRj9x7
         5Hlk1hbBtQaFszXJ7nhIKFCdwfSsrqipaVREpLulejXBW/iOjbP4aJyc02xyDftHVCDA
         zR4SXOl2OSMk8DZ8M7FDAoAwYRptBzlbo8eEzBl6qOkwsZRKAU9EAfSDehVVzHnaViyu
         4H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=18AnhRW3dAr1PCrBHBFLJrZqcArBzwF29cM5sws1nbM=;
        b=Y3UK+gAz5KIxh2RY74fFBYuXdCUwgm4tQdcDtbNdnV6ygstQ3h6Kru8hwdT7U/YbVp
         936X78rjlDJ/E4tLfXAYJZvYYYj1jXIvTi1S3Vukou74x5MfTEcnvGl2QIWHsELTSquv
         xJdrdScxIMAXJIVGHXWTgmK6Pot0Vq+cwIhsyJfHyN9hnC9f8wOWnoziLUQYKgqm/NsF
         v6e9YeHLgCHy63XbAMGC9DWWdzQXG8XKYNBtoF4p0qU6X2DucPJiw1UThVTuc0kwa/OC
         Dzoj6idzqptZv/v4th3G6A6v+fIq03hPnLDYohvIEnrK9cdGGJDGg8bISSz94vOeLTiF
         +bQQ==
X-Gm-Message-State: AOAM533YiEgg44Cx72hfOzXdHd3wirmO8hf3pgQtnZQwghBNxANEFDG3
        dY5jPMVl5EVL3XS3VRWbusJKMA==
X-Google-Smtp-Source: ABdhPJx5fIPRC67AmFdbbYTgLi2/+o0m5jcTglZATET/J7A2JBEcgkqwPdocELkWasdEEjPBnb82hQ==
X-Received: by 2002:aa7:8088:0:b029:3c1:1672:2f25 with SMTP id v8-20020aa780880000b02903c116722f25mr309095pff.22.1631138645508;
        Wed, 08 Sep 2021 15:04:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m13sm3112247pjv.20.2021.09.08.15.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 15:04:04 -0700 (PDT)
Date:   Wed, 8 Sep 2021 22:04:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpengli@tencent.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: nSVM: restore the L1 host state prior to
 resuming a nested guest on SMM exit
Message-ID: <YTkzUaFD664+9WB+@google.com>
References: <20210823114618.1184209-1-mlevitsk@redhat.com>
 <20210823114618.1184209-2-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823114618.1184209-2-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021, Maxim Levitsky wrote:
> If the guest is entered prior to restoring the host save area,
> the guest entry code might see incorrect L1 state (e.g paging state).
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/svm/svm.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 1a70e11f0487..ea7a4dacd42f 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4347,27 +4347,30 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
>  					 gpa_to_gfn(vmcb12_gpa), &map) == -EINVAL)
>  				return 1;
>  
> -			if (svm_allocate_nested(svm))
> +			if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.hsave_msr),
> +					 &map_save) == -EINVAL)
>  				return 1;

Returning here will neglect to unmap "map".

>  
> -			vmcb12 = map.hva;
> -
> -			nested_load_control_from_vmcb12(svm, &vmcb12->control);
> -
> -			ret = enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12);
> -			kvm_vcpu_unmap(vcpu, &map, true);
> +			if (svm_allocate_nested(svm))
> +				return 1;

Ditto here for both "map" and "map_save", though it looks like there's a
pre-existing bug if svm_allocate_nested() fails.  If you add a prep cleanup patch
to remove the statement nesting (between the bug fix and this patch), it will make
handling this a lot easier, e.g.

static int svm_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
{
	struct vcpu_svm *svm = to_svm(vcpu);
	struct kvm_host_map map, map_save;
	u64 saved_efer, vmcb12_gpa;
	struct vmcb *vmcb12;
	int ret;

	if (!guest_cpuid_has(vcpu, X86_FEATURE_LM))
		return 0;

	/* Non-zero if SMI arrived while vCPU was in guest mode. */
	if (!GET_SMSTATE(u64, smstate, 0x7ed8))
		return 0;

	if (!guest_cpuid_has(vcpu, X86_FEATURE_SVM))
		return 1;

	saved_efer = GET_SMSTATE(u64, smstate, 0x7ed0);
	if (!(saved_efer & EFER_SVME))
		return 1;

	vmcb12_gpa = GET_SMSTATE(u64, smstate, 0x7ee0);
	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map) == -EINVAL)
		return 1;

	ret = 1;
	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.hsave_msr), &map_save) == -EINVAL)
		goto unmap_map;

	if (svm_allocate_nested(svm))
		goto unmap_save;

	/*
	 * Restore L1 host state from L1 HSAVE area as VMCB01 was
	 * used during SMM (see svm_enter_smm())
	 */

	svm_copy_vmrun_state(&svm->vmcb01.ptr->save,
				map_save.hva + 0x400);

	/*
	 * Restore L2 state
	 */

	vmcb12 = map.hva;
	nested_load_control_from_vmcb12(svm, &vmcb12->control);
	ret = enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12);

unmap_save;
	kvm_vcpu_unmap(vcpu, &map_save, true);
unmap_map:
	kvm_vcpu_unmap(vcpu, &map, true);
	return 1;
}
