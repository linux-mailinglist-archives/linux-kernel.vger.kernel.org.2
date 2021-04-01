Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1435174E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhDARlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234122AbhDARgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617298579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gDC7i2lcnIpwprv2MM7sCVCIYProJ2chwug+EO7t94=;
        b=DHBh22mD4nl2huS+f6tTdqDv4QKfDCu5jFg/hT8XjbuclBQiP8rq1bhKdJxTmAc/AJiWvz
        PWJscbaTVV6ampfQDC1+IAXkX66kzTdR36wLOgRWz0NhAeDv7I59Q1+hEKseQeITwI8AOV
        HZgFy+G44XaU58QYDmTofpcWGRa30ts=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-gauNf7jINFau6sPTYRwdWQ-1; Thu, 01 Apr 2021 13:05:41 -0400
X-MC-Unique: gauNf7jINFau6sPTYRwdWQ-1
Received: by mail-wr1-f69.google.com with SMTP id e9so3056851wrg.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 10:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+gDC7i2lcnIpwprv2MM7sCVCIYProJ2chwug+EO7t94=;
        b=Ul7kbnJA4jBBMUXlpaOsKNHlc0hYpwPWdc6OnRb1+Il+xFDrDbd0nbxkllVapqswhR
         1Q4+lUqlUTDrJJ3w+yNPd8oMyOE24GK0VSDU/Z9uCzUL9y4wIJtSs7uTx0MNspTYGzSl
         x5RcU2KA/QUsQwFwY87rqSEn4edS4nT/QV8FNdmMbeyB+mDRRaF8rzAnHPWmelZQbLTp
         SLQky4PW45JKVPOdG7F2Pc16/VpcK46YCFJIagn9Ot2x5u15X45R099nQ1FVXjyI4GFf
         h2lW8AEte1dxaUj+MLralDfDpmf373A/ksmPqofHdzV+ciRzFQJtb9GAe/Irkty84Y+Z
         Pwiw==
X-Gm-Message-State: AOAM532L0h8Pc6jg/mGorUpOSuVyffKqhFbylD6k89ZVybJGygqt3Db8
        m2+hdLHKDuoFNI2jcyfhJVKCmczoHnjd4Mj792ZrphsmiVnn4vUzHrIuaTr98HC+iSU2ZK7iLwS
        Z+ISBa2CB+cvmS2qVPBTKfhj4
X-Received: by 2002:adf:9bca:: with SMTP id e10mr10978481wrc.364.1617296739819;
        Thu, 01 Apr 2021 10:05:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6bRxgGaxi7gnz4A0LwmjIJAReTDTvc/N5Vp/zCZDK8+BU80MaKkHtU7SekOftZhg+CIIg6w==
X-Received: by 2002:adf:9bca:: with SMTP id e10mr10978455wrc.364.1617296739580;
        Thu, 01 Apr 2021 10:05:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f4sm11056839wrz.4.2021.04.01.10.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 10:05:38 -0700 (PDT)
Subject: Re: [PATCH 1/4] KVM: x86: pending exceptions must not be blocked by
 an injected event
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Sean Christopherson <seanjc@google.com>
References: <20210401143817.1030695-1-mlevitsk@redhat.com>
 <20210401143817.1030695-2-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f6a321a-bc44-fe2f-37f5-6b22bc7fae1c@redhat.com>
Date:   Thu, 1 Apr 2021 19:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401143817.1030695-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/21 16:38, Maxim Levitsky wrote:
> Injected interrupts/nmi should not block a pending exception,
> but rather be either lost if nested hypervisor doesn't
> intercept the pending exception (as in stock x86), or be delivered
> in exitintinfo/IDT_VECTORING_INFO field, as a part of a VMexit
> that corresponds to the pending exception.
> 
> The only reason for an exception to be blocked is when nested run
> is pending (and that can't really happen currently
> but still worth checking for).
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

This patch would be an almost separate bugfix, right?  I am going to 
queue this, but a confirmation would be helpful.

Paolo

> ---
>   arch/x86/kvm/svm/nested.c |  8 +++++++-
>   arch/x86/kvm/vmx/nested.c | 10 ++++++++--
>   2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 8523f60adb92..34a37b2bd486 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1062,7 +1062,13 @@ static int svm_check_nested_events(struct kvm_vcpu *vcpu)
>   	}
>   
>   	if (vcpu->arch.exception.pending) {
> -		if (block_nested_events)
> +		/*
> +		 * Only a pending nested run can block a pending exception.
> +		 * Otherwise an injected NMI/interrupt should either be
> +		 * lost or delivered to the nested hypervisor in the EXITINTINFO
> +		 * vmcb field, while delivering the pending exception.
> +		 */
> +		if (svm->nested.nested_run_pending)
>                           return -EBUSY;
>   		if (!nested_exit_on_exception(svm))
>   			return 0;
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index fd334e4aa6db..c3ba842fc07f 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3806,9 +3806,15 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
>   
>   	/*
>   	 * Process any exceptions that are not debug traps before MTF.
> +	 *
> +	 * Note that only a pending nested run can block a pending exception.
> +	 * Otherwise an injected NMI/interrupt should either be
> +	 * lost or delivered to the nested hypervisor in the IDT_VECTORING_INFO,
> +	 * while delivering the pending exception.
>   	 */
> +
>   	if (vcpu->arch.exception.pending && !vmx_pending_dbg_trap(vcpu)) {
> -		if (block_nested_events)
> +		if (vmx->nested.nested_run_pending)
>   			return -EBUSY;
>   		if (!nested_vmx_check_exception(vcpu, &exit_qual))
>   			goto no_vmexit;
> @@ -3825,7 +3831,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
>   	}
>   
>   	if (vcpu->arch.exception.pending) {
> -		if (block_nested_events)
> +		if (vmx->nested.nested_run_pending)
>   			return -EBUSY;
>   		if (!nested_vmx_check_exception(vcpu, &exit_qual))
>   			goto no_vmexit;
> 

