Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF3639FC89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhFHQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhFHQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623169657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KwKEefJtvG5O4GXlLD+oJ84/ugnabyJFojY0GxM0/KQ=;
        b=Zj+j4vNPPS+qRJ/KUSXwiQkgTxkHkqDp+uq3H2d+tL6yyywpSUSvmek9SU71FFBvgfusKP
        tmeAcq3GjTa2h5CNFT5k6uCVEfB+lp/Zpx/l6ZCMIef+/OokJbfRwDFHXWLgbHqmvx2ln8
        wz/N6hhUGGrprcs94p9bYoTWMocx+Nc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-PVGBJa5sMomHIkwVMrHxAg-1; Tue, 08 Jun 2021 12:27:18 -0400
X-MC-Unique: PVGBJa5sMomHIkwVMrHxAg-1
Received: by mail-wr1-f69.google.com with SMTP id l13-20020adfe9cd0000b0290119a0645c8fso6683276wrn.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KwKEefJtvG5O4GXlLD+oJ84/ugnabyJFojY0GxM0/KQ=;
        b=p0wWniohBjB9LGpVezN2iXkWO53NVW4U5RYPBK26Bc8VZWi0nIgNpx5/9Cy50zsmEC
         eIkGoGjdUkjtZXsHfuFymlCObZTENhatfbYusxlPOon07EJGRTFMVc1TK/VfOH6JvHDC
         B2OwrpYJe2DwRC4PfNIxE67fsUJyqkLNJesC5+o258O3YctkqA1EY643DRn2XbUhIyeY
         1iWrEsAXS7sdqhGHuuPBm0PGhn0DzxwPjNFE7+Djosz+9BB7TNh9qpNGMznMuEQez/zc
         HL3GP9AWRtFqvWRX1nGiRk5YErvXD2yFQ7EL1q3Vv6yyG+7AVYui09DPpjZ2zIHQ/JGs
         1+tw==
X-Gm-Message-State: AOAM531QhuTymTupqsNrOaoFtf+QQixCFqjlgcxcDtd9gOa5z7bdoUE0
        KKfGoIrS+UcGe8jr/EqZPOLKSO6z1jMU49579vtV5HgJn0JmipXR/oXDEhYVw0Q30Ib4zgl8BLA
        z70TGJYv2Y4/AFcbq2m8P2slB
X-Received: by 2002:a5d:64ec:: with SMTP id g12mr23643275wri.137.1623169637581;
        Tue, 08 Jun 2021 09:27:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhJ105w3KL5Uw0wAiuzK1NcADpvygfyGVRcUm7KixEdHqO9SnoC9xoj454XiibhdRSik/tPw==
X-Received: by 2002:a5d:64ec:: with SMTP id g12mr23643262wri.137.1623169637429;
        Tue, 08 Jun 2021 09:27:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 62sm22634353wrm.1.2021.06.08.09.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 09:27:16 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] KVM: LAPIC: Reset TMCCT during vCPU reset
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1623050385-100988-1-git-send-email-wanpengli@tencent.com>
 <1623050385-100988-2-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0584d79d-9f2c-52dd-5dcc-beffd18f265b@redhat.com>
Date:   Tue, 8 Jun 2021 18:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623050385-100988-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/21 09:19, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> The value of the current counter register after reset is 0 for both
> Intel and AMD, let's do it in kvm, though, the TMCCT is always computed
> on-demand and never directly readable.

It's useless though since it's never read except by KVM_SET_LAPIC. 
Perhaps instead set TMCCT to 0 in kvm_apic_set_state, instead of keeping 
the value that was filled in by KVM_GET_LAPIC?

Paolo

> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>   * update patch description
> 
>   arch/x86/kvm/lapic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 6d72d8f..cbfdecd 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2352,6 +2352,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
>   	kvm_lapic_set_reg(apic, APIC_ICR2, 0);
>   	kvm_lapic_set_reg(apic, APIC_TDCR, 0);
>   	kvm_lapic_set_reg(apic, APIC_TMICT, 0);
> +	kvm_lapic_set_reg(apic, APIC_TMCCT, 0);
>   	for (i = 0; i < 8; i++) {
>   		kvm_lapic_set_reg(apic, APIC_IRR + 0x10 * i, 0);
>   		kvm_lapic_set_reg(apic, APIC_ISR + 0x10 * i, 0);
> 

