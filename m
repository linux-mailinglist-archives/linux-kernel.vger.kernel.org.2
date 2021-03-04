Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4532D02E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhCDJxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:53:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238062AbhCDJxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614851528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NBlfUZ5qlNcwMNLTSOObyKp2FpqfhaUG207qjodcr48=;
        b=PfpX4MvD7jdOmymlD3aNQwDAUvjA8sGZf2wzHqhOnv8LQ33zzxuHvCzxBK/lEaGtqyjpxV
        9Nx6IYmrmRaX9HWI/zvNuOkV8EuPf8rBjjxmzopvD7NrWmj3u/8wI7vecmk5RwQ4EZkP7K
        thBMLVih2oYNPF8Avl8OyvZ1QJ6mU3U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-i5QejKhYOs6sdaDWjpT6LQ-1; Thu, 04 Mar 2021 04:52:07 -0500
X-MC-Unique: i5QejKhYOs6sdaDWjpT6LQ-1
Received: by mail-ed1-f69.google.com with SMTP id i4so13844319edt.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NBlfUZ5qlNcwMNLTSOObyKp2FpqfhaUG207qjodcr48=;
        b=qJFkGvcbwIz4/GIU6wjs7N7s7yl4BfiHZnIMf/Zvob/O64ot+3FM1lu/8dLgHRiU/C
         fDmVI2HGvuUno7X/qeAW+7XWTE5jPnCMG8zV3uzZ1qqi6nEVlWFBee49J5zayt8iuqpw
         EzXpgmz9odnAPBSOQh/QDJ8vPduVxUdACeLgr2igh/qrOOtXkqg7VTOEkcGmmwjsdpnM
         d3pRdS2r+r+QwnapRJNTw21PL++QOHCOfSI25roR4Np2u9WhopMIhjzCcN1ehKSGpyby
         JRQdCP9cI+d4aL76PHy3EeWpc86Y9Id9kzaVs00i+rqqIr8QMvTmlw50LPAWz4iOXD9b
         iWBg==
X-Gm-Message-State: AOAM533PVj49vXTp06j+l/kHy52dGHnPEfhXk+rE4JVAeT4NYFeaeEIp
        +aMfqy9eDtUt+uqFjUxbjnHe/w7SGCFmPpVbPWKqdLfs4ogzX0iy+2PhVm70k42TGsS02L9TKiy
        dhkW++Ufy1LMiBHNOYJc50TPCcvvKaw3Ckw1PPewvLTq3fuoeN7nWLnYi6hVocQCE9VWHdWvBh2
        H1
X-Received: by 2002:a17:906:a016:: with SMTP id p22mr3267354ejy.456.1614851525981;
        Thu, 04 Mar 2021 01:52:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlo5eA6ixzk4HcXv/OUomMVtpzFZiKvWSMBnmf8YrnTG8jpRbWpN8vf4hpbLg26sZCmMjhug==
X-Received: by 2002:a17:906:a016:: with SMTP id p22mr3267339ejy.456.1614851525798;
        Thu, 04 Mar 2021 01:52:05 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e18sm22793498eji.111.2021.03.04.01.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:52:05 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        seanjc@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] KVM: nVMX: Add CET entry/exit load bits to evmcs
 unsupported list
In-Reply-To: <20210304060740.11339-4-weijiang.yang@intel.com>
References: <20210304060740.11339-1-weijiang.yang@intel.com>
 <20210304060740.11339-4-weijiang.yang@intel.com>
Date:   Thu, 04 Mar 2021 10:52:04 +0100
Message-ID: <87h7lrckl7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Weijiang <weijiang.yang@intel.com> writes:

> Nested guest doesn't support CET when KVM is running as an intermediate
> layer between two Hyper-Vs for now, so mask out related CET entry/exit
> load bits. Relevant enabling patches will be posted as a separate patch
> series.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/evmcs.c | 4 ++--
>  arch/x86/kvm/vmx/evmcs.h | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
> index 41f24661af04..9f81db51fd8b 100644
> --- a/arch/x86/kvm/vmx/evmcs.c
> +++ b/arch/x86/kvm/vmx/evmcs.c
> @@ -351,11 +351,11 @@ void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata)
>  	switch (msr_index) {
>  	case MSR_IA32_VMX_EXIT_CTLS:
>  	case MSR_IA32_VMX_TRUE_EXIT_CTLS:
> -		ctl_high &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> +		ctl_high &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
>  		break;
>  	case MSR_IA32_VMX_ENTRY_CTLS:
>  	case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
> -		ctl_high &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> +		ctl_high &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
>  		break;
>  	case MSR_IA32_VMX_PROCBASED_CTLS2:
>  		ctl_high &= ~SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
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

Thanks, this should be enough for both KVM on Hyper-V and Hyper-V on KVM
using eVMCS.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

