Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115993BD7C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhGFN2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 09:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231889AbhGFN2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625577939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EVK6tufpC1aTZkrqSwpxANTfYm84v4lUfym5iBb/fMw=;
        b=RoDqtDUsAFlfRHH70mEDMhpBcyln2HY2DZuvrV/ZLC/H6z4aMsjqCeN8kofVYYURi/tHnH
        sQstRp/QKH1csQYsfZBAokdTxZAmjy6yAvdQT3bSQlq+mNJTQ2Bu8tdYIZI/CRXlQ5IWlS
        iKm+uqw7IRTLFm/DH9csjihrOJ9TqJc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-U2wTqp6WOEuYITw2giy-zA-1; Tue, 06 Jul 2021 09:25:38 -0400
X-MC-Unique: U2wTqp6WOEuYITw2giy-zA-1
Received: by mail-ed1-f72.google.com with SMTP id m10-20020aa7c2ca0000b0290399df423df0so2590575edp.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 06:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EVK6tufpC1aTZkrqSwpxANTfYm84v4lUfym5iBb/fMw=;
        b=pJUNUvrEFCaHzzLDjFGvq6++/BQ5qLeVjXeq8HdNCfS0VRgSm4ym2KNqVs1WEyB8Lh
         ardSNc2Cu4e4eV80JlgKAWSqrSEkcq4mDsM7O/u0Ce/KdZi4xzny2Jl1R/Br1FT0HgCI
         BAVdhZPH0Cd8zUr01OOljf2vJN/9aF/BjG9s/5h8lcJeTxz5+6TnJXuDxFb5w8J9a/jp
         TYp8yzmwsT+i9Pa4nGj5cJZ0U+3mZcizw+V4My6d1ySrkxA3IMhIv2/dsjgi0LByKxU6
         3Zv4Uqe4pZZhoySe0mXrjaAoBt8sRUFApremu+442+HzMEhfBGBh3un8KdjaRC1Em09I
         QMAg==
X-Gm-Message-State: AOAM5322gbJW+nea3LUjWd+JztOBZ15kcM6KmsGGeSBixjWFDxAtGPJg
        aspmei5nK72Yc+LL5/MbxDVuk9lrbSiLRpziyu78DeWdNml1989OrC7UiJ36fe0H2nd4e9VVdp/
        PvQr97vYztuES4Gmo49dJ9m6Q
X-Received: by 2002:a17:906:3c14:: with SMTP id h20mr633140ejg.176.1625577937170;
        Tue, 06 Jul 2021 06:25:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPG0tum4lqOXr+lcTi2g7NFPKoTxJVD8akcm/y6czNIOJaEAqNzWzeK07BJ1MAEto6m53zpQ==
X-Received: by 2002:a17:906:3c14:: with SMTP id h20mr633126ejg.176.1625577937027;
        Tue, 06 Jul 2021 06:25:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id lu21sm5675703ejb.31.2021.07.06.06.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:25:36 -0700 (PDT)
Subject: Re: [RFC PATCH v2 10/69] KVM: TDX: Print the name of SEAMCALL status
 code
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <69fb3df4debc96f3d3e95d731ee5eab8042767fb.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e587261-6c77-f3d2-6258-32fac15fabb7@redhat.com>
Date:   Tue, 6 Jul 2021 15:25:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <69fb3df4debc96f3d3e95d731ee5eab8042767fb.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> SEAMCALL error code is not intuitive to tell what's wrong in the
> SEAMCALL, print the error code name along with it.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/kvm/boot/seam/tdx_common.c | 21 +++++++++++++++++++++
>   arch/x86/kvm/vmx/seamcall.h         |  7 +++++--
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/boot/seam/tdx_common.c b/arch/x86/kvm/boot/seam/tdx_common.c
> index d803dbd11693..4fe352fb8586 100644
> --- a/arch/x86/kvm/boot/seam/tdx_common.c
> +++ b/arch/x86/kvm/boot/seam/tdx_common.c
> @@ -9,6 +9,7 @@
>   #include <asm/kvm_boot.h>
>   
>   #include "vmx/tdx_arch.h"
> +#include "vmx/tdx_errno.h"
>   
>   /*
>    * TDX system information returned by TDSYSINFO.
> @@ -165,3 +166,23 @@ void tdx_keyid_free(int keyid)
>   	ida_free(&tdx_keyid_pool, keyid);
>   }
>   EXPORT_SYMBOL_GPL(tdx_keyid_free);
> +
> +static struct tdx_seamcall_status {
> +	u64 err_code;
> +	const char *err_name;
> +} tdx_seamcall_status_codes[] = {TDX_SEAMCALL_STATUS_CODES};
> +
> +const char *tdx_seamcall_error_name(u64 error_code)
> +{
> +	struct tdx_seamcall_status status;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tdx_seamcall_status_codes); i++) {
> +		status = tdx_seamcall_status_codes[i];
> +		if ((error_code & TDX_SEAMCALL_STATUS_MASK) == status.err_code)
> +			return status.err_name;
> +	}
> +
> +	return "Unknown SEAMCALL status code";
> +}
> +EXPORT_SYMBOL_GPL(tdx_seamcall_error_name);
> diff --git a/arch/x86/kvm/vmx/seamcall.h b/arch/x86/kvm/vmx/seamcall.h
> index 2c83ab46eeac..fbb18aea1720 100644
> --- a/arch/x86/kvm/vmx/seamcall.h
> +++ b/arch/x86/kvm/vmx/seamcall.h
> @@ -37,11 +37,14 @@ static inline u64 _seamcall(u64 op, u64 rcx, u64 rdx, u64 r8, u64 r9, u64 r10,
>   	_seamcall(SEAMCALL_##op, (rcx), (rdx), (r8), (r9), (r10), (ex))
>   #endif
>   
> +const char *tdx_seamcall_error_name(u64 error_code);
> +
>   static inline void __pr_seamcall_error(u64 op, const char *op_str,
>   				       u64 err, struct tdx_ex_ret *ex)
>   {
> -	pr_err_ratelimited("SEAMCALL[%s] failed on cpu %d: 0x%llx\n",
> -			   op_str, smp_processor_id(), (err));
> +	pr_err_ratelimited("SEAMCALL[%s] failed on cpu %d: %s (0x%llx)\n",
> +			   op_str, smp_processor_id(),
> +			   tdx_seamcall_error_name(err), err);
>   	if (ex)
>   		pr_err_ratelimited(
>   			"RCX 0x%llx, RDX 0x%llx, R8 0x%llx, R9 0x%llx, R10 0x%llx, R11 0x%llx\n",
> 

You can squash it in the earlier patch that introduced __pr_seamcall_error.

Paolo

