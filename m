Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DF7423F70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbhJFNiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238577AbhJFNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633527371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aV5/M3LfS5R3mNSscT7B+Fc+NyevBjVnAj1L+poz5Kg=;
        b=aLbag6K5XXj4DiWdZsRaT5iGDIrCQwcy0Vlk7UdpBBtxmRx5GDDJYF+ywWgGgUEUWQLc7P
        1AFJVvxihXCl0qsl9avalab+tKMwNx3XZrav1lTEeqc8bBuTHzDDA/n3LxGcMx+lLYhp7+
        s9LyiRMEOsccGbwgxY9+9IJbeh+OsTQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-FUQqPpm2OV2W_PQGuI14jQ-1; Wed, 06 Oct 2021 09:36:10 -0400
X-MC-Unique: FUQqPpm2OV2W_PQGuI14jQ-1
Received: by mail-ed1-f70.google.com with SMTP id p20-20020a50cd94000000b003db23619472so2637926edi.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 06:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aV5/M3LfS5R3mNSscT7B+Fc+NyevBjVnAj1L+poz5Kg=;
        b=gPrcLTbtGtZFmX7M4vozSVzLC2HuVZT20Uo1IQLGNFcPejKDpNkJxEb5Gs041I3Y8N
         nS8RZR+q0XX+vSYfamcs/vlaMfmx4l4UNAsMUPra/pup1EG7Edm/HB5KL1Ythamiy8XM
         NBOvx66MfNHFlgUP2AAN3nq6l7w/aY/XHi2no5hxkHQQS137QMk05GSfG9z6QY410YFd
         NvHgZokccScO+B0v+mA6pNi13kjDYAiGemYE7HroRz8yTrI0vTNvgOTj4/Hwi1CtwbXg
         vqMd5sZkxHy8ed764xlEDiY+/NVs6AnThn6S1g2XEuvM81Wdcu0OrGGzfEsYHnX84Atv
         oeNw==
X-Gm-Message-State: AOAM532vp+vXrt84zLmzpoqS9XdhU1Vh37gbFfZQdCphphsKOmKHCfBb
        qgUuD+1M1swHGqXsCZgV2YpgyY+mXkkC3O3KTQO7ZjcGMbngjtWg+J2JGnYHVFXqX3M0G9EP734
        3BpjKp5Y2s/Fo3X5xWqyo2UMN
X-Received: by 2002:a05:6402:16d8:: with SMTP id r24mr33636248edx.47.1633527369591;
        Wed, 06 Oct 2021 06:36:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVXfuOd+xQWGsYnhOhtgE1uQwa79FmNxhWDKJNzrRuUzwCuHLFmVX/uuMgR+qwPriOvBf3WQ==
X-Received: by 2002:a05:6402:16d8:: with SMTP id r24mr33636219edx.47.1633527369392;
        Wed, 06 Oct 2021 06:36:09 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id g2sm10075960edp.74.2021.10.06.06.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 06:36:08 -0700 (PDT)
Message-ID: <a37798f3-708a-049d-34dc-0d0d23bc499a@redhat.com>
Date:   Wed, 6 Oct 2021 15:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.14 6/9] KVM: x86: nVMX: don't fail nested VM
 entry on invalid guest state if !from_vmentry
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, kvm@vger.kernel.org
References: <20211006133021.271905-1-sashal@kernel.org>
 <20211006133021.271905-6-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211006133021.271905-6-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/21 15:30, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit c8607e4a086fae05efe5bffb47c5199c65e7216e ]
> 
> It is possible that when non root mode is entered via special entry
> (!from_vmentry), that is from SMM or from loading the nested state,
> the L2 state could be invalid in regard to non unrestricted guest mode,
> but later it can become valid.
> 
> (for example when RSM emulation restores segment registers from SMRAM)
> 
> Thus delay the check to VM entry, where we will check this and fail.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Message-Id: <20210913140954.165665-7-mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/vmx/nested.c | 7 ++++++-
>   arch/x86/kvm/vmx/vmx.c    | 5 ++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index ac1803dac435..2e8a46f9f552 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2576,8 +2576,13 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>   	 * Guest state is invalid and unrestricted guest is disabled,
>   	 * which means L1 attempted VMEntry to L2 with invalid state.
>   	 * Fail the VMEntry.
> +	 *
> +	 * However when force loading the guest state (SMM exit or
> +	 * loading nested state after migration, it is possible to
> +	 * have invalid guest state now, which will be later fixed by
> +	 * restoring L2 register state
>   	 */
> -	if (CC(!vmx_guest_state_valid(vcpu))) {
> +	if (CC(from_vmentry && !vmx_guest_state_valid(vcpu))) {
>   		*entry_failure_code = ENTRY_FAIL_DEFAULT;
>   		return -EINVAL;
>   	}
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 339116ff236f..974029917713 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6613,7 +6613,10 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>   	 * consistency check VM-Exit due to invalid guest state and bail.
>   	 */
>   	if (unlikely(vmx->emulation_required)) {
> -		vmx->fail = 0;
> +
> +		/* We don't emulate invalid state of a nested guest */
> +		vmx->fail = is_guest_mode(vcpu);
> +
>   		vmx->exit_reason.full = EXIT_REASON_INVALID_STATE;
>   		vmx->exit_reason.failed_vmentry = 1;
>   		kvm_register_mark_available(vcpu, VCPU_EXREG_EXIT_INFO_1);
> 

NACK (depends on patch 5)

