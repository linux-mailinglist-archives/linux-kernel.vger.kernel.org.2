Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE013D34E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 08:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhGWGSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234053AbhGWGSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627023518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HnC1b6TYPKR0qc8BZCeS9n9yti0/AcEzG2nRNrYmKqg=;
        b=NI3xVJLPPUR1tJtwy7h+rt9/GojGYd5No7aCjWFmfl3ZSQ8WQys7t3xIViXKUALuQAFHym
        Ig4FEWcMUmS5YE7PWtL5fXuapmju9+8vhnR7cHIxvbcYJUYrTdBX6M3BdpPpNnaNi7YUVz
        oQyqxUsbepKujgsnJ9aQQ43NHRIP2gg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-p1p_O5nBM4eq_ENd_K_lSg-1; Fri, 23 Jul 2021 02:58:36 -0400
X-MC-Unique: p1p_O5nBM4eq_ENd_K_lSg-1
Received: by mail-wr1-f72.google.com with SMTP id r1-20020a5d69410000b02901304c660e75so589819wrw.19
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 23:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HnC1b6TYPKR0qc8BZCeS9n9yti0/AcEzG2nRNrYmKqg=;
        b=HGuL1XZS5asT5OiR4ntQIOcwv7dlIsEHUu7Nb9GM6siAehYCKONKqrBsecSTd28fFy
         Ar183P0fdlU/Xa9gDZP2qjyfesKR5YTofy07ADskaxBEGX3OQzeDGhAKQseaiK/LTkcS
         bzlSoGgPsrPY+AGhwTneIAOOkqkipXyNGsMC5A2RPCOMyEvEdWQRpYZ7GhBE4wbJ6M4K
         ZADGsQgj3WmT5UUhuExAnw213PMwRhz5NCBwGukBECQR+0Ie/2QWLK05zk6ihfd1wMep
         vqbCRi2AKbX/ktR9k1aym6a/YPhnHp+X4xSdKJBKNUpJfZa/ONg6ehcCTNB+YnJrRW7P
         ojLA==
X-Gm-Message-State: AOAM533hjmJQ/gRbacLhLDylOMhUAYqOUKMca5u2NzyFMi2JRjK/f+sf
        aKHGt0nL5hmaAWl9WCKY26eKTi2r6SChAt+vuuqRmEqfMVwKaA4Rhf1UnDne8IhWQUKek6Ve0qw
        Mhp35ivmDfkhpscp7/1rGOWxgKh3ZYxW1e0D+7GwMzGApGsTTjQ7zlCSHY86Qq3pSqwYwwH8bpm
        2C
X-Received: by 2002:a05:600c:1c0d:: with SMTP id j13mr3009521wms.34.1627023515170;
        Thu, 22 Jul 2021 23:58:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUpiKl0DzQ+iQ26fJyr+DpAUhUYZqt3I+7NwnHorU0HeWW1m8fYG0k6AXj5SQ3niD7L5lKJQ==
X-Received: by 2002:a05:600c:1c0d:: with SMTP id j13mr3009507wms.34.1627023514964;
        Thu, 22 Jul 2021 23:58:34 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v21sm4296580wml.5.2021.07.22.23.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 23:58:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Check the right feature bit for
 MSR_KVM_ASYNC_PF_ACK access
In-Reply-To: <YPmopoGY4hwuVHAp@google.com>
References: <20210722123018.260035-1-vkuznets@redhat.com>
 <YPmopoGY4hwuVHAp@google.com>
Date:   Fri, 23 Jul 2021 08:58:33 +0200
Message-ID: <87lf5x7bza.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jul 22, 2021, Vitaly Kuznetsov wrote:
>> MSR_KVM_ASYNC_PF_ACK MSR is part of interrupt based asynchronous page fault
>> interface and not the original (deprecated) KVM_FEATURE_ASYNC_PF. This is
>> stated in Documentation/virt/kvm/msr.rst.
>> 
>> Fixes: 66570e966dd9 ("kvm: x86: only provide PV features if enabled in guest's CPUID")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/x86.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index d715ae9f9108..88ff7a1af198 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -3406,7 +3406,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  			return 1;
>>  		break;
>>  	case MSR_KVM_ASYNC_PF_ACK:
>> -		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
>> +		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
>
> Do we want to require both, or do we want to let userspace be stupid?
>

It's OK to be stupid :-)

Thinking more about it, I'd suggest we go the other way around: allow
access to MSR_KVM_ASYNC_PF_EN when either KVM_FEATURE_ASYNC_PF or
KVM_FEATURE_ASYNC_PF_INT are present. This will allow to eventually
deprecate KVM_FEATURE_ASYNC_PF completely and switch to
KVM_FEATURE_ASYNC_PF_INT exclusively.

>>  			return 1;
>>  		if (data & 0x1) {
>>  			vcpu->arch.apf.pageready_pending = false;
>> @@ -3745,7 +3745,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  		msr_info->data = vcpu->arch.apf.msr_int_val;
>>  		break;
>>  	case MSR_KVM_ASYNC_PF_ACK:
>> -		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
>> +		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
>>  			return 1;
>>  
>>  		msr_info->data = 0;
>> -- 
>> 2.31.1
>> 
>

-- 
Vitaly

