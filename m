Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE73BD9EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhGFPTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232124AbhGFPTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625584582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71X87AHnd420IiBmxRAPwo5IaTjIGnXDVEPdKZi7cp0=;
        b=ABp7Yhq2CMnAb5X9pobrW9+XYt4JGTHWouPLJOodn7qop3P2+Hra6OURX3LUNIeEvtZT9G
        iYuSDHiCWKLLqTC2mdgDl4Gtzpkw+fY20wA0xBjusTeUBDgWAhIyF+97b7KSiLdRHDsXIx
        tKFhGvHPFIBT0MGCROuo660C/bFvE28=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-hGMztoRqNJGkziWrZ70pxQ-1; Tue, 06 Jul 2021 11:16:19 -0400
X-MC-Unique: hGMztoRqNJGkziWrZ70pxQ-1
Received: by mail-wr1-f72.google.com with SMTP id t12-20020adff04c0000b029013253c3389dso2863235wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 08:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=71X87AHnd420IiBmxRAPwo5IaTjIGnXDVEPdKZi7cp0=;
        b=nO/NHFjp28MjHkkTdxjQbnu5kFpmsyOqi4FfrSVGdJSAuRJIzWJBjAh7LuyVHR+911
         2ePzmmspL/CQG3HI1DvDP/mjHj1hQxWA8n1OWa/wVzEaGDnLLNy6JDufLApHfpLb/xH+
         31MdUj7ktifMqMkWI7EXBZsWYASXA6NNED9sWBzcx417Gsc4bjh50OQ5s8s2l6/inApT
         fZmaBwIIJV27KCcs/WGzJy0CEd/j+2F6yq1POWUjAN35MqJnspOwkNT5IAwoP7qPXNt0
         ikBbh4Q5kd3t/3YN0nAPlvg/keLK6EYqO5xlE5i4XY+4p1UidIlbsM7lT/y7Rc80+WDH
         w6Dw==
X-Gm-Message-State: AOAM531f3UTlpFZ3ILZXn1v/i7Uj7UmICwNU833AwdELtvEleTa4oybG
        4bKZmfPCRt+SngL2pFX/IRYU2+eywPGs3m33KInKms9xwTuNu48kp+yIwh7L3n7vgp1Lmn7Tj24
        rtiXgTuCS3aIIPB3+JkjocsEanYCEDoQ3TQ+5TtyUHweaxZ2Q3ygh0BF/IIiL/lMWM+RneZW6
X-Received: by 2002:a5d:6d8d:: with SMTP id l13mr22173425wrs.358.1625584578413;
        Tue, 06 Jul 2021 08:16:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP2q9obcq0LO4UQaDXIQuHFm/CNB5B6GxvBQJVGiqU3pFDNi1cYBEl3Oz37XJl1vWGiG3waA==
X-Received: by 2002:a5d:6d8d:: with SMTP id l13mr22173399wrs.358.1625584578220;
        Tue, 06 Jul 2021 08:16:18 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id k6sm15971138wrx.41.2021.07.06.08.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 08:16:17 -0700 (PDT)
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
 <be78ce5d-92e4-36bd-aa28-e32db0342a44@redhat.com>
 <45690e80-5c7c-1e11-99d5-c0d1482755ad@de.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c7d61761-3426-6e44-99a8-7aa9e1cad5b6@redhat.com>
Date:   Tue, 6 Jul 2021 17:16:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <45690e80-5c7c-1e11-99d5-c0d1482755ad@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.21 14:02, Christian Borntraeger wrote:
> 
> 
> On 06.07.21 13:59, David Hildenbrand wrote:
>> On 06.07.21 13:56, Christian Borntraeger wrote:
>>>
>>>
>>> On 06.07.21 13:52, Cornelia Huck wrote:
>>>> On Tue, Jul 06 2021, Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:
>>>>
>>>>> When this feature is enabled the hardware is free to interpret
>>>>> specification exceptions generated by the guest, instead of causing
>>>>> program interruption interceptions.
>>>>>
>>>>> This benefits (test) programs that generate a lot of specification
>>>>> exceptions (roughly 4x increase in exceptions/sec).
>>>>>
>>>>> Interceptions will occur as before if ICTL_PINT is set,
>>>>> i.e. if guest debug is enabled.
>>>>>
>>>>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>>>>> ---
>>>>> I'll additionally send kvm-unit-tests for testing this feature.
>>>>>
>>>>>     arch/s390/include/asm/kvm_host.h | 1 +
>>>>>     arch/s390/kvm/kvm-s390.c         | 2 ++
>>>>>     arch/s390/kvm/vsie.c             | 2 ++
>>>>>     3 files changed, 5 insertions(+)
>>>>
>>>> (...)
>>>>
>>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>>> index b655a7d82bf0..aadd589a3755 100644
>>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>>> @@ -3200,6 +3200,8 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
>>>>>             vcpu->arch.sie_block->ecb |= ECB_SRSI;
>>>>>         if (test_kvm_facility(vcpu->kvm, 73))
>>>>>             vcpu->arch.sie_block->ecb |= ECB_TE;
>>>>> +    if (!kvm_is_ucontrol(vcpu->kvm))
>>>>> +        vcpu->arch.sie_block->ecb |= ECB_SPECI;
>>>>
>>>> Does this exist for any hardware version (i.e. not guarded by a cpu
>>>> feature?)
>>>
>>> Not for all hardware versions, but also no indication. The architecture
>>> says that the HW is free to do this or not. (which makes the vsie code
>>> simpler).
>>
>> I remember the architecture said at some point to never set undefined bits - and this bit is undefined on older HW generations. I might be wrong, though.
> 
> I can confirm that this bit will be ignored on older machines. The notion of
> never setting undefined bits comes from "you never know what this bit will
> change in future machines". Now we know :-)

Well, okay then :)

So the plan for vSIE is to always keep it disabled? IIUC, one could 
similarly always forward the bit of set.


-- 
Thanks,

David / dhildenb

