Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE36E3BD576
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbhGFMWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242402AbhGFMCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625572795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uW+E9jScNZ5agh1jL2MsJyyJ0npRr318JrpawlDgYKM=;
        b=GF1mC7uCBZnNzh96WqufvL/F+t/2rhzn82Y2RIz0hLnxzaSO7lFYSnkL7YMziy6EWJ5PVT
        Y7AFqTP0ZmXGs0rxbo1ayMccKaBOjcRy39/a+eqX4PyxVo/HJG6eCpwGrR8IbeVTY8hSir
        FNsQB59tlOvtu7kvQ+yChFkUf8H709o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-wDdpgtkON2STTvkG7kr7BA-1; Tue, 06 Jul 2021 07:59:54 -0400
X-MC-Unique: wDdpgtkON2STTvkG7kr7BA-1
Received: by mail-wm1-f69.google.com with SMTP id t12-20020a7bc3cc0000b02901f290c9c44eso824789wmj.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 04:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uW+E9jScNZ5agh1jL2MsJyyJ0npRr318JrpawlDgYKM=;
        b=etL/BJ8JLUbvidmV4Mn1tZpz+1maEMsSa8s539pZRO7rO/I0ZQLLA2t5eE3f7cqUXd
         bQDUNqIn0/65TKGaXq4Jm+oGT+60bmYw6cJL54SkXA8eVS7KUKCjE3NvprQ5Pn6c6Gsp
         z9v0bZh64sq9+L/ri2zuXDfLkUaNJcqLc/S8x7bw605T+0MAkwDmSwAX7oPM9eRJP1uQ
         TzsCZ5HA0ChmggdFIWkEv/sklbEo1vLOMBokNrwTflc8ZlBhdb1rr7eOM+W3EtBtS/7Q
         GXxHwaV2H0yNYJWde2hlgyS59Ee+iaExRfXMquTonKdDedCzko2oJpNUEN78vMnv7bBx
         BvRQ==
X-Gm-Message-State: AOAM530lDuh52Zq9TrBzq8TADdRoKPGdm1xSDRa/k+T2pFRjby1eS+5L
        0n5RLx7rotYdH1128F/0WwZdVOkJxUt+8uPlSqL02ZPk0zAi8c/FqOQ+xh6qowV13UVjYlkVjHq
        jDc6laNh9h3Xmidv6SjEVfeMl7CPUJW9My2/wROmCfcf+WM+4jFg0puZIDoc6CGDqO9Aq7VUI
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr21255009wrw.155.1625572793166;
        Tue, 06 Jul 2021 04:59:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2u4QcVp8Z//R1GNAmE7RUOVZhrVIPxFfJvCNi9/yctbFPEoASdoc9aUnMXgr/0BSKnUccmw==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr21254984wrw.155.1625572792939;
        Tue, 06 Jul 2021 04:59:52 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id h13sm5700227wrs.68.2021.07.06.04.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 04:59:52 -0700 (PDT)
Subject: Re: [PATCH] KVM: s390: Enable specification exception interpretation
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "open list:KERNEL VIRTUAL MACHINE for s390 (KVM/s390)" 
        <kvm@vger.kernel.org>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210706114714.3936825-1-scgl@linux.ibm.com>
 <87k0m3hd7h.fsf@redhat.com> <194128c1-8886-5b8b-2249-5ec58b8e7adb@de.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <be78ce5d-92e4-36bd-aa28-e32db0342a44@redhat.com>
Date:   Tue, 6 Jul 2021 13:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <194128c1-8886-5b8b-2249-5ec58b8e7adb@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.21 13:56, Christian Borntraeger wrote:
> 
> 
> On 06.07.21 13:52, Cornelia Huck wrote:
>> On Tue, Jul 06 2021, Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:
>>
>>> When this feature is enabled the hardware is free to interpret
>>> specification exceptions generated by the guest, instead of causing
>>> program interruption interceptions.
>>>
>>> This benefits (test) programs that generate a lot of specification
>>> exceptions (roughly 4x increase in exceptions/sec).
>>>
>>> Interceptions will occur as before if ICTL_PINT is set,
>>> i.e. if guest debug is enabled.
>>>
>>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>>> ---
>>> I'll additionally send kvm-unit-tests for testing this feature.
>>>
>>>    arch/s390/include/asm/kvm_host.h | 1 +
>>>    arch/s390/kvm/kvm-s390.c         | 2 ++
>>>    arch/s390/kvm/vsie.c             | 2 ++
>>>    3 files changed, 5 insertions(+)
>>
>> (...)
>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index b655a7d82bf0..aadd589a3755 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -3200,6 +3200,8 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
>>>    		vcpu->arch.sie_block->ecb |= ECB_SRSI;
>>>    	if (test_kvm_facility(vcpu->kvm, 73))
>>>    		vcpu->arch.sie_block->ecb |= ECB_TE;
>>> +	if (!kvm_is_ucontrol(vcpu->kvm))
>>> +		vcpu->arch.sie_block->ecb |= ECB_SPECI;
>>
>> Does this exist for any hardware version (i.e. not guarded by a cpu
>> feature?)
> 
> Not for all hardware versions, but also no indication. The architecture
> says that the HW is free to do this or not. (which makes the vsie code
> simpler).

I remember the architecture said at some point to never set undefined 
bits - and this bit is undefined on older HW generations. I might be 
wrong, though.

(I though HW learned the lesson to always use proper feature indications 
along with new features)


-- 
Thanks,

David / dhildenb

