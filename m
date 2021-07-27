Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3253D79A7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhG0PZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232642AbhG0PXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627399413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K9vnN9wL7bbivI7Hwt9tBs1nCKBEhS3YAOrtS2yFzAo=;
        b=LFev05ijJeQz4As0rMtduLuwQ94jfcTx2On64DdVaDIPxtPGuItcTTtKxQMBdH85jxaDix
        Bh1Nc44c4B3eOcQ/pk/YIHpVAG4KLs5rT1C66YVzCIjzKd8WNwEuDE/tVev+3Z37hnKZX+
        +olfLgp9Ml+7589wMfavV0+6hztZpaY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-k3CfWqRVNiGUIwPaMcI_6A-1; Tue, 27 Jul 2021 11:23:32 -0400
X-MC-Unique: k3CfWqRVNiGUIwPaMcI_6A-1
Received: by mail-ed1-f71.google.com with SMTP id de5-20020a0564023085b02903bb92fd182eso3443829edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 08:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=K9vnN9wL7bbivI7Hwt9tBs1nCKBEhS3YAOrtS2yFzAo=;
        b=OfPz0VSq2X4btSAjUlExnmbj06SKgTisxq1En3znCzxKuSpxsr485mkaSXoNe6TEF5
         I6T+CKmQhSt5f/6ZbIr+v4ncgVZVT1FFzMty6wUt1cVyrsLrlIr0cV97PB8RIFo6WPlV
         C/r6G62l2nU+UtC56yhDoiOB6sCUoTgLEPdeOicwQCb1/OzRq9EqKrr+06gA17Y32E7C
         pbSPReoVGccMxAfjSVce9Nfq1KYKIcBtSH2KiZVOTzDMeN1sQLrjBvk54gRmpeCIXRNq
         Ozf6BR6EQHnUsPDftrK0dULD7JYrA5Fki79XK5sL6UrRUbk4CMNWdSUwt9SaHzJyGgqB
         rpEw==
X-Gm-Message-State: AOAM531PqwmRWEyo6kctTUthchC4uyVZqP39n6HtFfY4LcTJnEqHeCBs
        gg7nihlO51wTWasOmvpza+RsnMG0M6mbp8/IYX9UnNFtzpQv0K0IyyZR4VtPZmf/EIxBQ7CFu4j
        VQwnkIAcZvcqBFbx53pfHMk5V
X-Received: by 2002:aa7:c956:: with SMTP id h22mr27834807edt.378.1627399411348;
        Tue, 27 Jul 2021 08:23:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziLlMRBKgJ1MU+hRRcFdLOJqyAASXy4lbQBYorQQKdWpyIS4+ytKilfOPL91Ubb5c5gfus2A==
X-Received: by 2002:aa7:c956:: with SMTP id h22mr27834785edt.378.1627399411116;
        Tue, 27 Jul 2021 08:23:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l17sm1391591edt.52.2021.07.27.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 08:23:30 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: delay svm_vcpu_init_msrpm after svm->vmcb is
 initialized
In-Reply-To: <20210726165843.1441132-1-pbonzini@redhat.com>
References: <20210726165843.1441132-1-pbonzini@redhat.com>
Date:   Tue, 27 Jul 2021 17:23:29 +0200
Message-ID: <87zgu76ary.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Right now, svm_hv_vmcb_dirty_nested_enlightenments has an incorrect
> dereference of vmcb->control.reserved_sw before the vmcb is checked
> for being non-NULL.  The compiler is usually sinking the dereference
> after the check; instead of doing this ourselves in the source,
> ensure that svm_hv_vmcb_dirty_nested_enlightenments is only called
> with a non-NULL VMCB.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Vineeth Pillai <viremana@linux.microsoft.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [Untested for now due to issues with my AMD machine. - Paolo]

At least this doesn't seem to break kvm-amd on bare metal, so

Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> ---
>  arch/x86/kvm/svm/svm.c          | 4 ++--
>  arch/x86/kvm/svm/svm_onhyperv.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 9a6987549e1b..4bcb95bb8ed7 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1406,8 +1406,6 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>  		goto error_free_vmsa_page;
>  	}
>  
> -	svm_vcpu_init_msrpm(vcpu, svm->msrpm);
> -
>  	svm->vmcb01.ptr = page_address(vmcb01_page);
>  	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
>  
> @@ -1419,6 +1417,8 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>  	svm_switch_vmcb(svm, &svm->vmcb01);
>  	init_vmcb(vcpu);
>  
> +	svm_vcpu_init_msrpm(vcpu, svm->msrpm);
> +
>  	svm_init_osvw(vcpu);
>  	vcpu->arch.microcode_version = 0x01000065;
>  
> diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
> index 9b9a55abc29f..c53b8bf8d013 100644
> --- a/arch/x86/kvm/svm/svm_onhyperv.h
> +++ b/arch/x86/kvm/svm/svm_onhyperv.h
> @@ -89,7 +89,7 @@ static inline void svm_hv_vmcb_dirty_nested_enlightenments(
>  	 * as we mark it dirty unconditionally towards end of vcpu
>  	 * init phase.
>  	 */
> -	if (vmcb && vmcb_is_clean(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS) &&
> +	if (vmcb_is_clean(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS) &&
>  	    hve->hv_enlightenments_control.msr_bitmap)
>  		vmcb_mark_dirty(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS);
>  }

-- 
Vitaly

