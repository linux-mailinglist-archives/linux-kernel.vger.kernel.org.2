Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8973F1E24
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhHSQkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234786AbhHSQji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629391142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3p2/vtk0jECaEq9Opdy1U0ndXxwF4zZ0NkReVHjVbJo=;
        b=FXJMBj+foCCU1nZivMeHH8RmPNc+FjWQlgmdRiU5OFVPVAzAai9mwu4qy2BjvC1XtiHocA
        ULnTPuFc9p1mm1OJLuw7+zwKq5EnMZ666r1gxVL0/aUOswa/lwp2cMdRNzDqNLFYuqnKdB
        YCExbgX5P1PWX2zCh0ONxgUHIMyqxJQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-_LXfTGG9Pgu1hT5sUaPQSQ-1; Thu, 19 Aug 2021 12:39:01 -0400
X-MC-Unique: _LXfTGG9Pgu1hT5sUaPQSQ-1
Received: by mail-ed1-f71.google.com with SMTP id b16-20020a0564022790b02903be6352006cso3089439ede.15
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3p2/vtk0jECaEq9Opdy1U0ndXxwF4zZ0NkReVHjVbJo=;
        b=O/xM8LP6nx1Qj64s8e35bXAa8OpEiT0OxQb05lVOLCxwC5WIl2HTkCzTtl0c5IjW3U
         eg8sY5cqgOCswzHPrB52plbhwZxVuT0qaoTf769rtENEhc0xM6SAW4oK3fRA+VNgBBaA
         PtnQfCSS5KrUAmj4LacaOPW4V1YA0b3W/1+fv/DuOgwJQ5/U3yM5m2dVR0AjGe41UJwz
         yhMH2rv762pRcYnD0/a8vXDh78tIAFPJyVBoxyHLhXt4YKxBJBpyKECmqsvepOVEt+0t
         S6pBJ2WV3NcnXRxD9u5du+EEq6cnX0m4JXPnVMvn55MVsyd604gjxwo1biZibOMAwwSi
         qGAA==
X-Gm-Message-State: AOAM530wyP/ZznnUFjxLfiu/UFi7lkJ8KsC3WL29PDyYIcjyQES1J31o
        D903cc6j7t5ofMVlGAXTzlGGLrelxm78ipHVHmEWQ+yfhy7JO8szk2Pxjs3oUFjCYOrUaIGvtQ7
        Y6nVzQG30F9gVG0BJZY21WNTI
X-Received: by 2002:a17:906:a18b:: with SMTP id s11mr17076310ejy.8.1629391139969;
        Thu, 19 Aug 2021 09:38:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOdH+eJ6Wno44KalFXnhRgah0GFAbuXK7572PyLLUjd5u6riwor5wGbINUfFiggJne5e+AnA==
X-Received: by 2002:a17:906:a18b:: with SMTP id s11mr17076280ejy.8.1629391139764;
        Thu, 19 Aug 2021 09:38:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id da1sm2054086edb.26.2021.08.19.09.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 09:38:59 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] KVM: SVM: Add 5-level page table support for SVM
To:     Sean Christopherson <seanjc@google.com>,
        Wei Huang <wei.huang2@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
References: <20210818165549.3771014-1-wei.huang2@amd.com>
 <20210818165549.3771014-4-wei.huang2@amd.com> <YR1EPNRNtIZZ7LXd@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d5894435-c5e1-890d-880c-6b6390fe50d8@redhat.com>
Date:   Thu, 19 Aug 2021 18:38:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR1EPNRNtIZZ7LXd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/21 19:32, Sean Christopherson wrote:
> On Wed, Aug 18, 2021, Wei Huang wrote:
>> When the 5-level page table is enabled on host OS, the nested page table
>> for guest VMs must use 5-level as well. Update get_npt_level() function
>> to reflect this requirement. In the meanwhile, remove the code that
>> prevents kvm-amd driver from being loaded when 5-level page table is
>> detected.
>>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> If this patch authored by Paolo, he needs to be attributed via From:.  If Paolo
> is a co-author, he needs a Co-developed-by:.  If either of those is true, your
> SOB needs to be last in the chain since you are the last handler of the patch.
> If neither is true, Paolo's SOB should be removed.

I didn't even remember writing this, but it's possible I pseudocoded in 
an email just like you did below.

>> -	return PT64_ROOT_4LEVEL;
>> +	bool la57 = (cr4_read_shadow() & X86_CR4_LA57) != 0;
>> +
>> +	return la57 ? PT64_ROOT_5LEVEL : PT64_ROOT_4LEVEL;
> 
> Why obfuscate this?  KVM is completely hosed if pgtable_l5_enabled() doesn't
> match host CR4.  E.g.
> 
> 	return pgtable_l5_enabled() ? PT64_ROOT_5LEVEL : PT64_ROOT_4LEVEL;

That also suggests the above pseudocoding scenario, where I'd be too 
lazy to look up the correct spelling of pgtable_l5_enabled().

Paolo

>>   #else
>>   	return PT32E_ROOT_LEVEL;
>>   #endif
>> @@ -462,11 +464,6 @@ static int has_svm(void)
>>   		return 0;
>>   	}
>>   
>> -	if (pgtable_l5_enabled()) {
>> -		pr_info("KVM doesn't yet support 5-level paging on AMD SVM\n");
>> -		return 0;
>> -	}
>> -
>>   	return 1;
>>   }
>>   
>> -- 
>> 2.31.1
>>
> 

