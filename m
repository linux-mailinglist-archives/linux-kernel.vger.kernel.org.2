Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1343E9247
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhHKNLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230196AbhHKNLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628687450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8sWpMxpIZDBmpCGl8ZAafxxVgEbTAfN82/liA2rLIM=;
        b=fZe/Hb8rzm33pbj2QokEpHuuEviyqQUOdONQY7BNIdzXLtmdxZaL2m7RZbTFzjBlBqqGEs
        FXes8h1bTWxXMugswm6ygP0BkF6K+x7YPHO8NQqCnXKERB5OG4R+OjwiCrN6NC1XaidiKZ
        jwidlBCbqIlLRKPEZO+EKIVqm1g3bWo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-vBm1EFYYMX61LJcPurfX2w-1; Wed, 11 Aug 2021 09:10:48 -0400
X-MC-Unique: vBm1EFYYMX61LJcPurfX2w-1
Received: by mail-ej1-f71.google.com with SMTP id ci25-20020a1709072679b029058e79f6c38aso660458ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H8sWpMxpIZDBmpCGl8ZAafxxVgEbTAfN82/liA2rLIM=;
        b=UQyPVzUqmonAFACAUZdrbaPG85bvcEQp4mdIV4UyqhOSFEtQKfBg8qEZzbW3dM9PQi
         QMxR2iqzaPHUJesfsD4mHnja0YeZ9sE98GPeryxmmUmy8Jp7IVtJC5dMku+scA9iTn/r
         Sb2h9i9kCVOcyDsgAmpw8l/d6pQYZcKa1V2pF6QkGWmOy1DZojNK7twCCJZ4zcB5F9yc
         zakooCet+cH6dK6813Kya2URdciqqcxqdS9FNTqhPdo2hyqPEj5MrRHxchdagAgRWJ1p
         o7dO/jNvCqXAlqZLQ94wq8yFnQehgvCJcDF6f1R5727EkAztjGRxDA8xSCDSDOH9WT3Q
         SYdA==
X-Gm-Message-State: AOAM530Kf7bzumkavg7wg+tUUwNxYHZfvCjRU4uJxrfALGNw4vDdC57X
        S3nYdeFUnzLgqT4701OUdhukw3l3BsCcFfrz/RTDpmy0B7n8xv2JzeRYbIskJOkFBCm/Zoe/vyV
        w+iXpAZJWcmRQKjTCmsuxve6W
X-Received: by 2002:a17:907:9602:: with SMTP id gb2mr3636068ejc.354.1628687446284;
        Wed, 11 Aug 2021 06:10:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFPjH6U5yQfTCMV1bM5Bqc+L0/4ww4/tZsl0Q75Sik3+sIXSUET2NDh+BgQ9F4aGHgJZzQcg==
X-Received: by 2002:a17:907:9602:: with SMTP id gb2mr3636035ejc.354.1628687445979;
        Wed, 11 Aug 2021 06:10:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id f15sm8159390ejt.75.2021.08.11.06.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 06:10:45 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] KVM: my debug patch queue
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1646763f-9f92-bb67-f358-9b17c8000b12@redhat.com>
Date:   Wed, 11 Aug 2021 15:10:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811122927.900604-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/21 14:29, Maxim Levitsky wrote:
> Hi!
> 
> I would like to publish two debug features which were needed for other stuff
> I work on.
> 
> One is the reworked lx-symbols script which now actually works on at least
> gdb 9.1 (gdb 9.2 was reported to fail to load the debug symbols from the kernel
> for some reason, not related to this patch) and upstream qemu.
> 
> The other feature is the ability to trap all guest exceptions (on SVM for now)
> and see them in kvmtrace prior to potential merge to double/triple fault.
> 
> This can be very useful and I already had to manually patch KVM a few
> times for this.
> I will, once time permits, implement this feature on Intel as well.
> 
> V2:
> 
>   * Some more refactoring and workarounds for lx-symbols script
> 
>   * added KVM_GUESTDBG_BLOCKIRQ flag to enable 'block interrupts on
>     single step' together with KVM_CAP_SET_GUEST_DEBUG2 capability
>     to indicate which guest debug flags are supported.
> 
>     This is a replacement for unconditional block of interrupts on single
>     step that was done in previous version of this patch set.
>     Patches to qemu to use that feature will be sent soon.
> 
>   * Reworked the the 'intercept all exceptions for debug' feature according
>     to the review feedback:
> 
>     - renamed the parameter that enables the feature and
>       moved it to common kvm module.
>       (only SVM part is currently implemented though)
> 
>     - disable the feature for SEV guests as was suggested during the review
>     - made the vmexit table const again, as was suggested in the review as well.
> 
> V3:
>   * Modified a selftest to cover the KVM_GUESTDBG_BLOCKIRQ
>   * Rebased on kvm/queue
> 
> Best regards,
>          Maxim Levitsky
> 
> Maxim Levitsky (6):
>    KVM: SVM: split svm_handle_invalid_exit
>    KVM: x86: add force_intercept_exceptions_mask
>    KVM: SVM: implement force_intercept_exceptions_mask
>    scripts/gdb: rework lx-symbols gdb script
>    KVM: x86: implement KVM_GUESTDBG_BLOCKIRQ
>    KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
> 
>   Documentation/virt/kvm/api.rst                |   1 +
>   arch/x86/include/asm/kvm_host.h               |   5 +-
>   arch/x86/include/uapi/asm/kvm.h               |   1 +
>   arch/x86/kvm/svm/svm.c                        |  87 +++++++-
>   arch/x86/kvm/svm/svm.h                        |   6 +-
>   arch/x86/kvm/x86.c                            |  12 +-
>   arch/x86/kvm/x86.h                            |   2 +
>   kernel/module.c                               |   8 +-
>   scripts/gdb/linux/symbols.py                  | 203 ++++++++++++------
>   .../testing/selftests/kvm/x86_64/debug_regs.c |  24 ++-
>   10 files changed, 266 insertions(+), 83 deletions(-)
> 

Queued 1-5-6.

For patches 2 and 3, please add VMX support too.

For patch 4, it's not KVM :) so please submit it separately.

Paolo

