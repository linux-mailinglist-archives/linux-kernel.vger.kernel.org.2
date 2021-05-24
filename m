Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57E738F1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhEXRDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232920AbhEXRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621875743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcEmMLIpMt542BRC/ArOGeP47HD5D7lnjpPaTzmc9ZE=;
        b=CbFz429eBGEkD2C67KRB+CuvKeI0wVHC76It+yn8eErUhQzfR3PJ+cPs8TeuT7ODwE8Ffd
        PKE/osTTOaGVZaNkSVp9BJCrMEO6mOOMOcJj619COHgt7BMJmMVXzXrWkCLgbqfzLOV8Ic
        EWhbzyHCWCMmzFIMdoRcDGt1SpLy04Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-skqBv4HvOymSfGA0AgPz1A-1; Mon, 24 May 2021 13:02:21 -0400
X-MC-Unique: skqBv4HvOymSfGA0AgPz1A-1
Received: by mail-ej1-f69.google.com with SMTP id la2-20020a170906ad82b02903d4bcc8de3bso7813666ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wcEmMLIpMt542BRC/ArOGeP47HD5D7lnjpPaTzmc9ZE=;
        b=KMYg4ybpPspFLLn+fyXXv1/pC4i8GqtftIr2nKLuOfrxkYgKw0ZWra1HIPFnrBtA/0
         oiI9O6FDBV1nvF1BP1ugnA6+nWfi6uYqvcKnqXmy132RXUsKCzau+3Uc4gOrNDy0faHK
         78aX5ZChNyx4oANKCtMlN3vimwlT7/F7grJYGgwPYRG+ZlSxvpj4d8qAa9J5vsp1k9c0
         8mMXH/StysyyncqY0NhbvWPUMDqL0NAivdxxVXVzSCeoQgVD/UqtIMNYOc2X+FHyc4iL
         TfQWfh0WV9T5+lFmj4Lu84Zxvzx2RxGLF/fAg5X9vZ8cKqKBJwYAd4fmRcR8PaSFK9z2
         xC1g==
X-Gm-Message-State: AOAM530awkJy5gy+ZnMf3FkUTXB+9MxwKaR8rLIwrZVqZW9GupxoG1l3
        E6YVQFBS8g9dUEfuRcWmST9tzZdtswmlGQFvMrmeBDl5nVLUJmlD68Ee+41Lh8L6NNRFUK9ZmpC
        47F+08jr0o1hiC2N62s27SJWm6Vr1SDlZlUtbK4X1mbUpdOfknjLUPEapuGzN0mADqJRQ7PhfqF
        Xs
X-Received: by 2002:a50:9346:: with SMTP id n6mr26905883eda.365.1621875740226;
        Mon, 24 May 2021 10:02:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXLp1wRWeU2aBKnMEdIF+0UPlJKMdflp6xiudWJxTSxzYSssv1QjXUKON/oNsCX11ZOGuiqw==
X-Received: by 2002:a50:9346:: with SMTP id n6mr26905848eda.365.1621875739988;
        Mon, 24 May 2021 10:02:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q16sm9562165edw.87.2021.05.24.10.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 10:02:19 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] KVM: x86: Use common 'enable_apicv' variable for
 both APICv and AVIC
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Kechen Lu <kechenl@nvidia.com>, linux-kernel@vger.kernel.org
References: <20210518144339.1987982-1-vkuznets@redhat.com>
 <20210518144339.1987982-4-vkuznets@redhat.com> <YKQmG3rMpwSI3WrV@google.com>
 <12eadbce-f688-77a1-27bf-c33fee2e7543@redhat.com>
 <YKvZ6vI2vFVmkCeb@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa5ef24e-6235-ad25-2f01-580efd2f1bbb@redhat.com>
Date:   Mon, 24 May 2021 19:02:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKvZ6vI2vFVmkCeb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/21 18:52, Sean Christopherson wrote:
> On Mon, May 24, 2021, Paolo Bonzini wrote:
>> On 18/05/21 22:39, Sean Christopherson wrote:
>>>> +/* enable / disable AVIC */
>>>> +static int avic;
>>>> +module_param(avic, int, 0444);
>>> We should opportunistically make avic a "bool".
>>>
>>
>> And also:
>>
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 11714c22c9f1..48cb498ff070 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -185,9 +185,12 @@ module_param(vls, int, 0444);
>>   static int vgif = true;
>>   module_param(vgif, int, 0444);
>> -/* enable / disable AVIC */
>> -static int avic;
>> -module_param(avic, int, 0444);
>> +/*
>> + * enable / disable AVIC.  Because the defaults differ for APICv
>> + * support between VMX and SVM we cannot use module_param_named.
>> + */
>> +static bool avic;
>> +module_param(avic, bool, 0444);
>>   bool __read_mostly dump_invalid_vmcb;
>>   module_param(dump_invalid_vmcb, bool, 0644);
>> @@ -1013,11 +1016,7 @@ static __init int svm_hardware_setup(void)
>>   			nrips = false;
>>   	}
>> -	if (!npt_enabled || !boot_cpu_has(X86_FEATURE_AVIC))
>> -		avic = false;
>> -
>> -	/* 'enable_apicv' is common between VMX/SVM but the defaults differ */
>> -	enable_apicv = avic;
>> +	enable_apicv = avic && npt_enabled && boot_cpu_has(X86_FEATURE_AVIC);
>>   	if (enable_apicv) {
>>   		pr_info("AVIC enabled\n");
>>
>> The "if" can come back when AVIC is enabled by default.
> 
> But "avic" is connected to the module param, even if it's off by default its
> effective value should be reflected in sysfs.  E.g. the user may incorrectly
> think AVIC is in use if they set avic=1 but the CPU doesn't support AVIC.
> Forcing the user to check /proc/cpuinfo or look for "AVIC enabled" in dmesg is
> kludgy at best.

Indeed -- I even tested the above, but only before realizing that 
module_param_named would change the default.  So for now this needs to
be "enable_apicv = avic = ...", and later it can become just

	enable_apicv &= npt_enabled && boot_cpu_has(X86_FEATURE_AVIC);

Paolo


