Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC7446CD2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 08:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhKFHIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 03:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhKFHIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636182356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tawnQd7hGO+sXkmPuHdSPGpynjDobLtFMgT5gC3pUgY=;
        b=SoWwntmIDvVvgJXzTiPObbDTax1qkelGDGent/0rXRkhMrG12vYmOBmd4F7mt+RNF4+amk
        UivKmaU9U+pij/Ev0LxFu001eRncmU8nVbgvuvwBSwuXYrqBrTRm+O4uPFjDqx2xrLgaFu
        aD7CsYosRjIeCM4Nd+Es3hZLE5fryow=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-mQN1Td4TOIeDSzqT9cyXPQ-1; Sat, 06 Nov 2021 03:05:55 -0400
X-MC-Unique: mQN1Td4TOIeDSzqT9cyXPQ-1
Received: by mail-ed1-f72.google.com with SMTP id i22-20020a05640242d600b003e28aecc0afso10827129edc.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 00:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tawnQd7hGO+sXkmPuHdSPGpynjDobLtFMgT5gC3pUgY=;
        b=UwHpK9K14fni0p5rMFesDoWef2NQHEeccnv8dTSMiQ53ridUqD2BeAdRjp4/H1y+Ai
         tk2CNL2xObVLZDXjqMrxG1ZM8TUkuNLLFPZpV8LUVvb5qzW/o9ZmVxqG7/2f7GETelZs
         bXrrZx11Yujau3c0kYlj02gWZVv8nrw0H2wVzW02t2nCHP9CrT6iqe82F5tBbJKPdgOU
         Q/tngUN6j+irlf2oEdJ3vQwuup8VyOB2O7TQkjalRTTWtu/vVGeVEOYbJAatNjPNEegb
         3dEOhWtUrYdEZfB3060u6DKPBUgBR6EWldbN/O++n8AySmkCuxZ4nJr/DNh/QigxTsMo
         l5xw==
X-Gm-Message-State: AOAM532lUwBawZMHtL2qgQPNF15eH1dKybCb45kJcSMXPfOXkHznHlW0
        pINWGjc8Rw/UTth07JUjQ5IZK7txNHZ/WGESlYGEmgGpPIDKotLp9ptxfn7VFwMjeLj3N+F0eUH
        TTC1j7KJg8MQMIj+JykrChfX3
X-Received: by 2002:a17:907:7f1a:: with SMTP id qf26mr44760015ejc.543.1636182354462;
        Sat, 06 Nov 2021 00:05:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA7CCj4Odi9YiQyC/GczYWfSZ1JqyomFA2/Bds6lu3qUktvYsUH4VUQzJxL9gOr2hwPWxH3A==
X-Received: by 2002:a17:907:7f1a:: with SMTP id qf26mr44759986ejc.543.1636182354226;
        Sat, 06 Nov 2021 00:05:54 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id nd36sm5097092ejc.17.2021.11.06.00.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 00:05:53 -0700 (PDT)
Message-ID: <18358428-e0cd-d329-7558-6eb548b3fc53@redhat.com>
Date:   Sat, 6 Nov 2021 08:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC][PATCH 15/22] x86,vmx: Remove .fixup usage
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, mbenes@suse.cz
References: <20211104164729.226550532@infradead.org>
 <20211104165525.408049586@infradead.org> <YYV1UeFeWUtnQ4jV@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YYV1UeFeWUtnQ4jV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 19:17, Sean Christopherson wrote:
> On Thu, Nov 04, 2021, Peter Zijlstra wrote:
>> In the vmread exceptin path, use the, thus far, unused output register
>> to push the @fault argument onto the stack. This, in turn, enables the
>> exception handler to not do pushes and only modify that register when
>> an exception does occur.
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> ---
>>   arch/x86/kvm/vmx/vmx_ops.h |   14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> --- a/arch/x86/kvm/vmx/vmx_ops.h
>> +++ b/arch/x86/kvm/vmx/vmx_ops.h
>> @@ -80,9 +80,11 @@ static __always_inline unsigned long __v
>>   		      * @field, and bounce through the trampoline to preserve
>>   		      * volatile registers.
>>   		      */
>> -		     "push $0\n\t"
>> +		     "xorl %k1, %k1\n\t"
>> +		     "2:\n\t"
>> +		     "push %1\n\t"
>>   		     "push %2\n\t"
> 
> This trick doesn't work if the compiler selects the same GPR for %1 and %2, as
> the "field" will get lost.

Ouch, good catch.  It should be actually very simple to fix it, just 
mark "value" as an "early clobber" output:

       : ASM_CALL_CONSTRAINT, "=&r"(value) : "r"(field) : "cc");

That's an output which is written before the instruction is finished 
using the input operands.  The manual even says "this operand may not 
lie in a register that is read by the instruction or as part of any 
memory address", which is exactly what you caught with %1 and %2 both 
being the same GPR.

Paolo

