Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D386E351CDA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhDASV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236890AbhDAR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brX6QE7MjhEomBWAbXjkcHLjpu7FoC0JOK5oa38RZow=;
        b=D67cJFB6ZY6iS03xATTYd97yObyFeEf8X9/nPc4jUFkBb5DMUO4ZE8B7LeHF8+z4BbJyIi
        0U+wCBUn7o+VsvGWmEwpZMclzerPPSFx+S97A/N7vRwZ4WXB840JTk1CefXxGlHIIGCTvj
        27X1QCb7F/RKA0gphULAtPLzm15q5Tw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-qbfuWER9MtmOIPU4OA7x3Q-1; Thu, 01 Apr 2021 11:57:36 -0400
X-MC-Unique: qbfuWER9MtmOIPU4OA7x3Q-1
Received: by mail-ed1-f71.google.com with SMTP id f9so3048301edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=brX6QE7MjhEomBWAbXjkcHLjpu7FoC0JOK5oa38RZow=;
        b=rJMNNErBvPb6ccaabmaTbBjRmm1vQURKXLIQbd3Lb21Z8l0DPFEavbKA8ZNO6ET6Az
         6CwW57ayoqHOh0v642qk1rriqVwELjwkOAhwahal9Dqs8wQPT8kZfVnoxZcn58ZD3zWe
         +JJaD+laY6p4JJw0FT7fhz4Lnp9SEuTulOecNgEWnKyDytZpSn95X93PZpLQ7lbxVm2I
         Qm/VMFfbMMHA6PiywK5BFsxZ8L7P18EiO8547302cLPJFHB6oslN6MeKT9VCRv5FgFo5
         6bG3BKjmTNyJtYXbktf1rhJr2zr/G+CIPphLHJVNp8La1hQRzBHCG39IT7M/sSpu7zwF
         IGxA==
X-Gm-Message-State: AOAM531OUkPxL4gCV1o2/dCRWrMYgTR6i41E0mdHsczj6MM066L90roU
        SbPxCA5isw8Ib8iKKiqUvpc6hHtP/n5Vg6e617EXSIZ2wrC2ay3kRbnzZl/2gsbvivoAcGFIAvh
        N0klHOPfq2lkCYCVD7ncoCU7I
X-Received: by 2002:a17:906:3a94:: with SMTP id y20mr9608597ejd.35.1617292655268;
        Thu, 01 Apr 2021 08:57:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGPBwotTdYkotuMCSsl5dzzf7/fFbVRH67ssRnZNdW0bRpfE22hOEqP36Ibs2QHciTPGMSCQ==
X-Received: by 2002:a17:906:3a94:: with SMTP id y20mr9608575ejd.35.1617292655051;
        Thu, 01 Apr 2021 08:57:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s13sm3841034edr.86.2021.04.01.08.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 08:57:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] KVM: nSVM: improve SYSENTER emulation on AMD
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20210401111928.996871-1-mlevitsk@redhat.com>
 <20210401111928.996871-3-mlevitsk@redhat.com>
 <87h7kqrwb2.fsf@vitty.brq.redhat.com>
 <6f138606-d6c3-d332-9dc2-9ba4796fd4ce@redhat.com>
 <87zgyic984.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b63e6c63-d781-3aef-a7b8-6b07d3c3568d@redhat.com>
Date:   Thu, 1 Apr 2021 17:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87zgyic984.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/21 17:31, Vitaly Kuznetsov wrote:
>>>> +		svm->sysenter_eip_hi = guest_cpuid_is_intel(vcpu) ? (data >> 32) : 0;
>>> (Personal taste) I'd suggest we keep the whole 'sysenter_eip'/'sysenter_esp'
>>> even if we only use the upper 32 bits of it. That would reduce the code
>>> churn a little bit (no need to change 'struct vcpu_svm').
>> Would there really be less changes?  Consider that you'd have to look at
>> the VMCB anyway because svm_get_msr can be reached not just for guest
>> RDMSR but also for ioctls.
>>
> I was thinking about the hunk in arch/x86/kvm/svm/svm.h tweaking
> vcpu_svm. My opinion is not strong at all here)

Ah okay, if it's just that I would consider the change a benefit, not a 
problem with this patch.

Paolo

