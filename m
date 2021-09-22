Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2DD4142D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhIVHmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233230AbhIVHmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632296476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FwUnLWRxBbFGXqrWK0WVzYlF4ZD1jUKaBikzITPlQE=;
        b=EQSDpL485IsR3Dxnaws4/jmcwRjuAJEhx8y8UdEuNPchSIVe4Se5bqmspgUkwup3G183GQ
        20wUPRccJzTM4SvqiOPFYdto06JYhfyrAMYmP5VfiS7QqUPiTfXhYo1mnBvXovTFYymNsT
        8MaWLi4yP5/rtQcQg6n3rKqrkyUV9SE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-zu8FYZzINlGasHnmf74PMg-1; Wed, 22 Sep 2021 03:41:15 -0400
X-MC-Unique: zu8FYZzINlGasHnmf74PMg-1
Received: by mail-ed1-f69.google.com with SMTP id e7-20020a50d4c7000000b003d871ecccd8so1986446edj.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 00:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4FwUnLWRxBbFGXqrWK0WVzYlF4ZD1jUKaBikzITPlQE=;
        b=2JLahiZcGvyhNRz83hX7z0L5CmXszmgLbjJG+j/tBKwBUbCdSHv99XDPiWvInMxPip
         qGLMSCcTsPuO42Q3J8tUabYDDa5vUpKZbVlpJBbC4Tl4f+G520sssbzUnwmFJy65uyaB
         VZHSNnCWUv0edMOaFCD0cfCx8w+pYrakktNfsEV/EfIUhs7D9C7i8lVgmm7wcnM7bxXu
         /ytZrIq1tjrTiZfsEh2amsI2VhnP4ychEFfK7+YVNyhtOJFxG/gLuOLF2FOMRA+ofWMl
         Hr12LyWveNuAcrNo70tU2nSKtKRSg1Yusz7YHjl+EKz15uyplL7lEpdE1QGFZonFkRpM
         1Fgw==
X-Gm-Message-State: AOAM530XfUCX365q6sEdJUAOJCFH3fF8OyWc0/Ap1jFd5ZoHnHkjXgQg
        ZhFUGv0hguaBDUIGOB7Mprrfs8GX9ztrq/O83Txl//2r1ZvsnCayAJk/DnwYSxW7GtAuCuViJXj
        lDVT6wBbyvKgy4G7elJrdWLpFzofGj8w+3+EdFCDSPQ2e9DakXAMLpt8xby1L+3al0VNGiDH4Hc
        9B
X-Received: by 2002:a05:6402:319a:: with SMTP id di26mr40876780edb.84.1632296474155;
        Wed, 22 Sep 2021 00:41:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyDEBgD+rpfIilbzK6lXOJWrkiDbxO9FAIi9c8hMpfth1/eCUhnpGKo4zS/VIS9j2MT2qk3Q==
X-Received: by 2002:a05:6402:319a:: with SMTP id di26mr40876756edb.84.1632296473936;
        Wed, 22 Sep 2021 00:41:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o15sm640446ejj.10.2021.09.22.00.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 00:41:13 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86: Identify vCPU0 by its vcpu_idx instead of
 walking vCPUs array
To:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210910183220.2397812-1-seanjc@google.com>
 <20210910183220.2397812-3-seanjc@google.com>
 <87czpd2bsi.fsf@vitty.brq.redhat.com> <YUihS9CcTh9m53J6@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c12a4ef0-5b20-a81a-26bd-7d29c59ece8d@redhat.com>
Date:   Wed, 22 Sep 2021 09:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUihS9CcTh9m53J6@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/21 16:57, Sean Christopherson wrote:
> On Mon, Sep 13, 2021, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>>> Use vcpu_idx to identify vCPU0 when updating HyperV's TSC page, which is
>>> shared by all vCPUs and "owned" by vCPU0 (because vCPU0 is the only vCPU
>>> that's guaranteed to exist).  Using kvm_get_vcpu() to find vCPU works,
>>> but it's a rather odd and suboptimal method to check the index of a given
>>> vCPU.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> ---
>>>   arch/x86/kvm/x86.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 86539c1686fa..6ab851df08d1 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -2969,7 +2969,7 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
>>>   				       offsetof(struct compat_vcpu_info, time));
>>>   	if (vcpu->xen.vcpu_time_info_set)
>>>   		kvm_setup_pvclock_page(v, &vcpu->xen.vcpu_time_info_cache, 0);
>>> -	if (v == kvm_get_vcpu(v->kvm, 0))
>>> +	if (!v->vcpu_idx)
>>>   		kvm_hv_setup_tsc_page(v->kvm, &vcpu->hv_clock);
>>>   	return 0;
>>>   }
>>
>> " ... instead of walking vCPUs array" in the Subject line is a bit
>> confusing because kvm_get_vcpu() doesn't actually walk anything, it just
>> returns 'kvm->vcpus[i]' after checking that we actually have that many
>> vCPUs. The patch itself is OK, so
> 
> Argh, yes, I have a feeling I wrote the changelog after digging into the history
> of kvm_get_vcpu().
> 
> Paolo, can you tweak the shortlog to:
> 
>    KVM: x86: Identify vCPU0 by its vcpu_idx instead of its vCPUs array entry
> 

Done and queued.  Patch 1 required some further s390 changes.

Paolo

