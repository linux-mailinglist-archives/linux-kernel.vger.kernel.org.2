Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1BF32BD85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCCQJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:09:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234095AbhCCLmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614771622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/j20RVofkj/hPK0Wo3xRPO9YBuymSE3SUYDVG+qh8o=;
        b=LZ7zBmqmD3uCrih3m5/N7teNpl1B0EfKewFFn3Bl7j0BqzG7QzzlN/jqhP8rNe7cqNOcbX
        7z+x3zBI4xwcWUpUCsBhq6v1PHSZ/VLO9XdoNGe2galTL7vF+3/5Du6PfZ+24D3filCG7c
        LEpb+lXxMRP3lhIIUAbQLTKdghVdEdk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-WwWlgG9fNr-dXzyKAmSTrw-1; Wed, 03 Mar 2021 04:36:43 -0500
X-MC-Unique: WwWlgG9fNr-dXzyKAmSTrw-1
Received: by mail-ed1-f70.google.com with SMTP id i19so9443274edy.18
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=r/j20RVofkj/hPK0Wo3xRPO9YBuymSE3SUYDVG+qh8o=;
        b=JENExQCsYluzoIbuewvuYilQL0Jomcec5mAksXfp9RvCydkq8O2mzEGExK0YLcMmZN
         vBhf573VUd2sH2qrtH0ndiQmFGpG+n/4xWs4bjiXvM7VSds7l0Zy/bgYve69JDJ41Z5r
         INceVCh9bzm9qExngVgOUdx9vTb7ECFOgX9BGBikH6LJBixkkCOBV6d1QI4eQVSn9UMY
         sW/x0io8+qzMtNK1G/KLJOIvKFTqHXoRe09saUrMxVqzZdkG7Yt5NG++R8CJHkpSVXIw
         rkHW4hWcLDReqKlocdIKyllyq9LZmVise7lg4VU0/CnBpjmlgYJ/+L250jhqMOIjxpQb
         Y63g==
X-Gm-Message-State: AOAM530byXSDCZErsceembvXZ9WBwH6Y0WWAXb7Gpq7UGArl0rl+fTnE
        roazQuFaX6uiP+sGTqdLYq42ZdpteFvFtQX8Of0+E+8+pq61K/VRDMGpfV93qUdLQ2/0HHcvSuE
        TAX5x56yfAxA9GWqZ9WZF/GRMctMR/75jcfttmOh9Zvcl6/cuyO2buPG+N+m7Ub3hLN0WxQhlt7
        yR
X-Received: by 2002:a17:906:33d9:: with SMTP id w25mr24858494eja.413.1614764202036;
        Wed, 03 Mar 2021 01:36:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9srdPqz0s4q1Xe5kvp25flWERjZA9N812PYdPFVO6+9MmFpJ6/Ozf7O8+uFN1+d2OxMxUQw==
X-Received: by 2002:a17:906:33d9:: with SMTP id w25mr24858472eja.413.1614764201828;
        Wed, 03 Mar 2021 01:36:41 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o6sm2602785edw.24.2021.03.03.01.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 01:36:41 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Add CET entry/exit load bits to evmcs
 unsupported list
In-Reply-To: <20210303060435.8158-1-weijiang.yang@intel.com>
References: <20210303060435.8158-1-weijiang.yang@intel.com>
Date:   Wed, 03 Mar 2021 10:36:40 +0100
Message-ID: <87h7lsefyv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Weijiang <weijiang.yang@intel.com> writes:

> CET in nested guest over Hyper-V is not supported for now. Relevant
> enabling patches will be posted as a separate patch series.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/evmcs.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
> index bd41d9462355..25588694eb04 100644
> --- a/arch/x86/kvm/vmx/evmcs.h
> +++ b/arch/x86/kvm/vmx/evmcs.h
> @@ -59,8 +59,10 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
>  	 SECONDARY_EXEC_SHADOW_VMCS |					\
>  	 SECONDARY_EXEC_TSC_SCALING |					\
>  	 SECONDARY_EXEC_PAUSE_LOOP_EXITING)
> -#define EVMCS1_UNSUPPORTED_VMEXIT_CTRL (VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)
> -#define EVMCS1_UNSUPPORTED_VMENTRY_CTRL (VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL)
> +#define EVMCS1_UNSUPPORTED_VMEXIT_CTRL (VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | \
> +					VM_EXIT_LOAD_CET_STATE)
> +#define EVMCS1_UNSUPPORTED_VMENTRY_CTRL (VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | \
> +					 VM_ENTRY_LOAD_CET_STATE)
>  #define EVMCS1_UNSUPPORTED_VMFUNC (VMX_VMFUNC_EPTP_SWITCHING)
>  
>  #if IS_ENABLED(CONFIG_HYPERV)

This should be enough when we run KVM on Hyper-V using eVMCS, however,
it may not suffice when we run Hyper-V on KVM using eVMCS: there's still
no corresponding eVMCS fields so CET can't be used. In case Hyper-V is
smart enough it won't use the feature, however, it was proven to be 'not
very smart' in the past, see nested_evmcs_filter_control_msr(). I'm
wondering if we should also do

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 41f24661af04..9f81db51fd8b 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -351,11 +351,11 @@ void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata)
        switch (msr_index) {
        case MSR_IA32_VMX_EXIT_CTLS:
        case MSR_IA32_VMX_TRUE_EXIT_CTLS:
-               ctl_high &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
+               ctl_high &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
                break;
        case MSR_IA32_VMX_ENTRY_CTLS:
        case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
-               ctl_high &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
+               ctl_high &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
                break;
        case MSR_IA32_VMX_PROCBASED_CTLS2:
                ctl_high &= ~SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;

to be on the safe side.

-- 
Vitaly

