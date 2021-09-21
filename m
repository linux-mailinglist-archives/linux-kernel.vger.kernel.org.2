Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31474138C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhIURkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230444AbhIURkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632245950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dol89n1uM/B2bXTU97+WaVIJZe+JvJJV6we1CFEWq9M=;
        b=TAfF7RwIgJO1n+ER6jPPG49iERzdszQXZ5qIdEio9Ny/SdfRvVZIntcMlqNZFul1dl7AL7
        C/JxUwcfeWcDwa22Srw6SrWKtTCLn3s15YdfQMbN4G+MfvxJETm40DdhfLwJaJkXXo8Jn3
        RagEO0ZXNPIV0u+3P4V0IvzF3ln5lXM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-rcrUXlq7P-K8LZpdW1St5w-1; Tue, 21 Sep 2021 13:39:08 -0400
X-MC-Unique: rcrUXlq7P-K8LZpdW1St5w-1
Received: by mail-ed1-f71.google.com with SMTP id h24-20020a50cdd8000000b003d8005fe2f8so15701034edj.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dol89n1uM/B2bXTU97+WaVIJZe+JvJJV6we1CFEWq9M=;
        b=DdD9T9P0jt7h6q4yWNqT0brZyhN5Ml5rMF32gO2V+sv01ogkFRYyyyAVp825q/sThr
         2+jAyZULiCEwFO+2v0eMfK6AcdWJrkK0YoHNAtFGh8tYMw1Nd+lEXSewzDQfKiCUonXf
         UsOCLeZMoRoLeDT65pY/a3yMG0k7s/c+kIERUMq0ESmN9gCgYrwTn4W3Y/2u/NmYt+5D
         iUnUixBvdP3onrmvxfJaUEV6s10NkdihO4ZTuN+3M3CxHBgc8Onrf0/LGYXQy20WaVSA
         0C2EeLEpGisAoQ3AvR3tqUu3UYB7jf/0lcfrnmflBvNiCiT5+L06L1vm5wsHbVINSP8t
         XqBQ==
X-Gm-Message-State: AOAM532+CwPnfFOAYrGFQu+75MxZIOM+apT1r7GntFpSSoIHYFKYDbE9
        BhKpZO1Ehhs3XARZte5mEtenWtgHNPTKpKOpE1Vj5lNQNtuG/IoPS6z/J7DTW+k10lpN9ULM175
        3x3gdvlS94bFDnMP9/3rRlAFXLnk1l4gwZE4kNDAm2MgHNGVQ9R98iyU+aser8+sorQTgrYxPGs
        LT
X-Received: by 2002:a17:906:584:: with SMTP id 4mr35828314ejn.56.1632245947163;
        Tue, 21 Sep 2021 10:39:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydAYozLECbAB3FtNwlXLjXnMGQgLVpCGRhOjs5KMtaYsDdVgOsFWPzks3XYTFsXJ4IdZY5lQ==
X-Received: by 2002:a17:906:584:: with SMTP id 4mr35828279ejn.56.1632245946888;
        Tue, 21 Sep 2021 10:39:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w5sm7874823ejz.25.2021.09.21.10.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 10:39:06 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Remove defunct "nr_active_uret_msrs" field
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210908002401.1947049-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <712043a4-c4b4-0a94-3bf0-88c12397c49e@redhat.com>
Date:   Tue, 21 Sep 2021 19:39:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908002401.1947049-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/21 02:24, Sean Christopherson wrote:
> Remove vcpu_vmx.nr_active_uret_msrs and its associated comment, which are
> both defunct now that KVM keeps the list constant and instead explicitly
> tracks which entries need to be loaded into hardware.
> 
> No functional change intended.
> 
> Fixes: ee9d22e08d13 ("KVM: VMX: Use flag to indicate "active" uret MSRs instead of sorting list")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/vmx.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 4858c5fd95f2..02ab3468885f 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -248,12 +248,8 @@ struct vcpu_vmx {
>   	 * only loaded into hardware when necessary, e.g. SYSCALL #UDs outside
>   	 * of 64-bit mode or if EFER.SCE=1, thus the SYSCALL MSRs don't need to
>   	 * be loaded into hardware if those conditions aren't met.
> -	 * nr_active_uret_msrs tracks the number of MSRs that need to be loaded
> -	 * into hardware when running the guest.  guest_uret_msrs[] is resorted
> -	 * whenever the number of "active" uret MSRs is modified.
>   	 */
>   	struct vmx_uret_msr   guest_uret_msrs[MAX_NR_USER_RETURN_MSRS];
> -	int                   nr_active_uret_msrs;
>   	bool                  guest_uret_msrs_loaded;
>   #ifdef CONFIG_X86_64
>   	u64		      msr_host_kernel_gs_base;
> 

Queued, thanks.

Paolo

