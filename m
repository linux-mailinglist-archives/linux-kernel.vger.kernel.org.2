Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C6416386
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhIWQq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhIWQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632415495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b3cKL1JgUfD96S3aQcdHQmja5cYQo5swp49YUwIJl7I=;
        b=P0e0hcUImhmEaiQD61K0lpNvKhijBRr9cA14C8TsOeks/ygGirfQPVYQAeVMdoWS+19ivb
        llQybEUrE4ac3xLGr2bX5WYuSNKGDBB4PuXDtfxfR8t90UPeryJZ1KiXP9qPJQqoXJkH+j
        FmCw7JoprVSu02EeNhcJH5DfwiOzsZU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-GsOO0WniNgShfK8MeOOc2A-1; Thu, 23 Sep 2021 12:44:53 -0400
X-MC-Unique: GsOO0WniNgShfK8MeOOc2A-1
Received: by mail-ej1-f71.google.com with SMTP id k23-20020a170906055700b005e8a5cb6925so116705eja.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b3cKL1JgUfD96S3aQcdHQmja5cYQo5swp49YUwIJl7I=;
        b=YWDI50rmZgzO+bMydICNoiiVmZ7JjLcwRfACAOlDCmPz4qt+45jd/RMtawkfZeAK6x
         nodUDoA8oauQ514UKWvaCq2Qk70vEOlfISM/BO9UOXzmjqsBrgLJwPDHA+2ytfx2NdJK
         W6AgZ1+Pi6EnZBP/lIoa7KIJyFD63QoLmmRWumtm4XyVbKxDSRLSgLuQmPuv/cEklid+
         Ii4gRD9vUlmjYkRL6LxzEkjDXdyGd9Cp9ykcCizqCvx7RzEfFbX1malLC2Fb7ElQajiw
         sAkAv/imOs3AvpoB89+vuiNIoxgmCic+BALf/yQPBbIjusvoJsEnUbW+cjIwOUP47Jcw
         oWdw==
X-Gm-Message-State: AOAM531RjkNBdVmApbdVFDxT45PZRCI3cnBPgegAxcAo1h8U6pbydx/W
        JaGjr+T4DOyxGToXCzK0MLuFdKnStawVhwAincXnU5Q03FHmuh2o10w/TSKMQcS4s4ZRY7l9Iwj
        /ycV1awDnedwIERHJ8ffog61l
X-Received: by 2002:a05:6402:1352:: with SMTP id y18mr6644382edw.122.1632415492645;
        Thu, 23 Sep 2021 09:44:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb0pdd2zsBYxzBKuRqu8tLTqE1ME1zAUyb78G1o0tA1cydtDx/eqtKTicaBwcf1AOWQhgWOg==
X-Received: by 2002:a05:6402:1352:: with SMTP id y18mr6644353edw.122.1632415492426;
        Thu, 23 Sep 2021 09:44:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g9sm3414971ejo.60.2021.09.23.09.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:44:51 -0700 (PDT)
Subject: Re: [PATCH 07/14] KVM: x86: SVM: add warning for CVE-2021-3656
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
 <20210914154825.104886-8-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0c0e659-23a8-59ab-edf8-5b380d723493@redhat.com>
Date:   Thu, 23 Sep 2021 18:44:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914154825.104886-8-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/21 17:48, Maxim Levitsky wrote:
> Just in case, add a warning ensuring that on guest entry,
> either both VMLOAD and VMSAVE intercept is enabled or
> vVMLOAD/VMSAVE is enabled.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/svm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 861ac9f74331..deeebd05f682 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3784,6 +3784,12 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>   
>   	WARN_ON_ONCE(kvm_apicv_activated(vcpu->kvm) != kvm_vcpu_apicv_active(vcpu));
>   
> +	/* Check that CVE-2021-3656 can't happen again */
> +	if (!svm_is_intercept(svm, INTERCEPT_VMSAVE) ||
> +	    !svm_is_intercept(svm, INTERCEPT_VMSAVE))
> +		WARN_ON(!(svm->vmcb->control.virt_ext &
> +			  VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK));
> +
>   	sync_lapic_to_cr8(vcpu);
>   
>   	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
> 

While it's nice to be "proactive", this does adds some extra work. 
Maybe it should be under CONFIG_DEBUG_KERNEL.  It could be useful to 
make it into its own function so we can add similar intercept invariants 
in the same place.

Paolo

