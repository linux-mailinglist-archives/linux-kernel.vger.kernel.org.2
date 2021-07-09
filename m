Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3493C287B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhGIRfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229830AbhGIRfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625851967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qyUyDfDQFucT3mnKk6Ep8rVKPAmQm+DsdTWTzMJRa+I=;
        b=eB7yH+LodPm3v92ysP/Si4D0UZ9BR5M1JmmAVp8E3C1reG/i/+uNQ9IRmL99RR8aeesNQ3
        NhaDYhYoV8RoK9bh1nFJA21j0o8Au1WzZhwrazeKEM9NvsrWc/L4pYXN7T+LULQZYGxZuX
        WJVOdvKEWH+Ga5pv9ZipU8lSml+nqcs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-b66EZIvRMhG302Eyfgan1g-1; Fri, 09 Jul 2021 13:32:46 -0400
X-MC-Unique: b66EZIvRMhG302Eyfgan1g-1
Received: by mail-ed1-f71.google.com with SMTP id p13-20020a05640210cdb029039560ff6f46so5612595edu.17
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qyUyDfDQFucT3mnKk6Ep8rVKPAmQm+DsdTWTzMJRa+I=;
        b=A9jNAshBFmA/M5r6MV5y+Lp37OEnRKpuFieODGbKleAoU1M6ZcPzAd2rdPs4AJoERR
         zQsSjYvk03PXZ84hKSIQOTg18e2ULsH0bR9ruFa428lSHZ+xUj+2xzSGO/+fvmmLL3Bm
         P1/RTBs91cDa7Pcmdfhx56ACbBKLnBCfJ55GX4v6UtAvq5jKEGGJapqkldX7JW2Blt5p
         dIUnGxxCnHxmI+TIEeFMYm1KmeXGi1jTXkyIqfQ7sNod4twVFFNt5HRLnhnuEuEm9fbd
         2VbmUigNdiacIQqO9cUmfFsStv6OHN+nTIFW77ZsabuR4yuvzcRz6i+pGYyGDGSESF+1
         XZ/Q==
X-Gm-Message-State: AOAM531xNKGwnJow1RagoMRhYR7mLhhcSVCpYLz9GhEGHT/uPBcPq/vR
        aNKi05C2m4MPdl+ntXua3pypMU0V6RIm9lIcoQa7t+pO3uY/ZOvc/F/i29q713xH6AFJ8ixKRDV
        Vagj2Ks0alTs6KA5O/NgZxD/OptW7nHqsLC70vE3EegZOBVe/VaQ9OGR0Y1qhIaaYZCNO6A1HRw
        wo
X-Received: by 2002:a17:906:b6c5:: with SMTP id ec5mr38237011ejb.290.1625851964773;
        Fri, 09 Jul 2021 10:32:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiWFhCEUJ8t9TftB4iYAR9bScs0f1Zi0mWSYglVqwpxlRsDdhaG+y76H0FumksZI70LjpqZQ==
X-Received: by 2002:a17:906:b6c5:: with SMTP id ec5mr38236987ejb.290.1625851964580;
        Fri, 09 Jul 2021 10:32:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id gg26sm2006803ejb.103.2021.07.09.10.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 10:32:43 -0700 (PDT)
Subject: Re: [PATCH] Revert "KVM: x86: WARN and reject loading KVM if NX is
 supported but not enabled"
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210625001853.318148-1-seanjc@google.com>
 <28ec9d07-756b-f546-dad1-0af751167838@redhat.com>
 <YOiFsB9vZgMcpJZu@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fd442781-d254-13b0-db76-90c6177c3faf@redhat.com>
Date:   Fri, 9 Jul 2021 19:32:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOiFsB9vZgMcpJZu@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/21 19:21, Sean Christopherson wrote:
> On Thu, Jul 08, 2021, Paolo Bonzini wrote:
>> On 25/06/21 02:18, Sean Christopherson wrote:
>>> Let KVM load if EFER.NX=0 even if NX is supported, the analysis and
>>> testing (or lack thereof) for the non-PAE host case was garbage.
>>>
>>> If the kernel won't be using PAE paging, .Ldefault_entry in head_32.S
>>> skips over the entire EFER sequence.  Hopefully that can be changed in
>>> the future to allow KVM to require EFER.NX, but the motivation behind
>>> KVM's requirement isn't yet merged.  Reverting and revisiting the mess
>>> at a later date is by far the safest approach.
>>>
>>> This reverts commit 8bbed95d2cb6e5de8a342d761a89b0a04faed7be.
>>>
>>> Fixes: 8bbed95d2cb6 ("KVM: x86: WARN and reject loading KVM if NX is supported but not enabled")
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> ---
>>>
>>> Hopefully it's not too late to just drop the original patch...
>>>
>>>    arch/x86/kvm/x86.c | 3 ---
>>>    1 file changed, 3 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 4a597aafe637..1cc02a3685d0 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -10981,9 +10981,6 @@ int kvm_arch_hardware_setup(void *opaque)
>>>    	int r;
>>>    	rdmsrl_safe(MSR_EFER, &host_efer);
>>> -	if (WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_NX) &&
>>> -			 !(host_efer & EFER_NX)))
>>> -		return -EIO;
>>>    	if (boot_cpu_has(X86_FEATURE_XSAVES))
>>>    		rdmsrl(MSR_IA32_XSS, host_xss);
>>>
>>
>> So do we want this or "depends on X86_64 || X86_PAE"?
> 
> Hmm, I'm leaning towards keeping !PAE support purely for testing the !PAE<->PAE
> MMU transitions for nested virtualization.  It's not much coverage, and the !PAE
> NPT horror is a much bigger testing gap (because KVM doesn't support it), but on
> the other hand setting EFER.NX for !PAE kernels appears to be trivial, e.g.
> 
> diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
> index 67f590425d90..bfbea25a9fe8 100644
> --- a/arch/x86/kernel/head_32.S
> +++ b/arch/x86/kernel/head_32.S
> @@ -214,12 +214,6 @@ SYM_FUNC_START(startup_32_smp)
>          andl $~1,%edx                   # Ignore CPUID.FPU
>          jz .Lenable_paging              # No flags or only CPUID.FPU = no CR4
> 
> -       movl pa(mmu_cr4_features),%eax
> -       movl %eax,%cr4
> -
> -       testb $X86_CR4_PAE, %al         # check if PAE is enabled
> -       jz .Lenable_paging
> -
>          /* Check if extended functions are implemented */
>          movl $0x80000000, %eax
>          cpuid
> 
> My only hesitation is the risk of somehow breaking ancient CPUs by falling into
> the NX path.  Maybe try forcing EFER.NX=1 for !PAE, and fall back to requiring
> PAE if that gets NAK'd or needs to be reverted for whatever reason?
> 

For now let's revert anyway.  Thanks!

Paolo

