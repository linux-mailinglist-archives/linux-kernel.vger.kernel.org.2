Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648B8368587
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbhDVRJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236287AbhDVRJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619111344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/uP9jbpp85SMbF11ayr/xFQAsNMSvflWFM/nt8RApM=;
        b=TD+0zo282yAZSyAJR0hRtCOk6d9tLhqbjAC2gdPt1HQt6znUBwTfZ6MX8NlMXdAf8k5XGB
        TGWBiCaTdrcWorqipauZuJLqlrGblLoFoDpFwZVAsDAPKv+yZTAI6CQKIs6CGz/m5MMo4y
        54BXvFKg0MYFuVk4R63+DLKw8SCFbIQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-Ja67jL7PPJGB4XThnSl0bA-1; Thu, 22 Apr 2021 13:09:02 -0400
X-MC-Unique: Ja67jL7PPJGB4XThnSl0bA-1
Received: by mail-ej1-f69.google.com with SMTP id r14-20020a1709062cceb0290373a80b4002so7446296ejr.20
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t/uP9jbpp85SMbF11ayr/xFQAsNMSvflWFM/nt8RApM=;
        b=qw3qvt6VKTfrJ76oX8A/UaaWFzCL9Kn6PVYpnKF3fdn/WrGFmjm5/9TjTNvLgwslQn
         l9bOIklTeFYPbgku6ZRotRa1/KkErL/vM+NLyjYfQo308K66UrgGaRF6i2bc8bdvNnX3
         zEq5zGmbpaq/fuTi7lTvVn4hIwmi2gqpbr0lYEKUJlQ5GXtfUrNVAoA7GyvnIOI28hWO
         OiY6vTMa0fJpku3ZbDJsoiKGwW7UthV4QHoBM8ACu5Geu8e05D8jjLGahtONruoP7XMY
         TmRiyUWJ2WnsdUvLRAB1CDBZJdWwywHynetCbAm+uI0KowemWXwD2p2mUJfphRzkX11M
         D8/Q==
X-Gm-Message-State: AOAM530GMiTn1e0X0WsW8O0bc30oVVutdhxYBO5z+mkjIW5whklnQ2mD
        8ZW9NViidO6d5a2vxGaKXJBKdgru5wFcixG8LnmMYClPrMWCmL7OuIBVN2/TpWuK/XQKsuCbg27
        qO0Vtu1GXTu3T3yZyNlp05lB9
X-Received: by 2002:a17:907:72cc:: with SMTP id du12mr4331291ejc.436.1619111341761;
        Thu, 22 Apr 2021 10:09:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztqUt5FLbriVzgssfU+9PJ4pZ4FwDyyaxMHua2xKvaLOp+j2RpJlJyTfVrvUIEsZ9IoH06dQ==
X-Received: by 2002:a17:907:72cc:: with SMTP id du12mr4331261ejc.436.1619111341587;
        Thu, 22 Apr 2021 10:09:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id m10sm2233288ejc.32.2021.04.22.10.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:09:01 -0700 (PDT)
Subject: Re: [PATCH v5 00/15] KVM: SVM: Misc SEV cleanups
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20210422021125.3417167-1-seanjc@google.com>
 <e32cb350-9fbe-5abd-930a-e820a4f4930b@redhat.com>
 <YIGeBHEZ27zIDByF@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <88a5a669-e94c-e197-5321-a1eb043209be@redhat.com>
Date:   Thu, 22 Apr 2021 19:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YIGeBHEZ27zIDByF@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 18:02, Sean Christopherson wrote:
> On Thu, Apr 22, 2021, Paolo Bonzini wrote:
>>> Paolo Bonzini (1):
>>>     KVM: SEV: Mask CPUID[0x8000001F].eax according to supported features
>>>
>>> Sean Christopherson (14):
>>>     KVM: SVM: Zero out the VMCB array used to track SEV ASID association
>>>     KVM: SVM: Free sev_asid_bitmap during init if SEV setup fails
>>>     KVM: SVM: Disable SEV/SEV-ES if NPT is disabled
>>>     KVM: SVM: Move SEV module params/variables to sev.c
>>>     x86/sev: Drop redundant and potentially misleading 'sev_enabled'
>>>     KVM: SVM: Append "_enabled" to module-scoped SEV/SEV-ES control
>>>       variables
>>>     KVM: SVM: Condition sev_enabled and sev_es_enabled on
>>>       CONFIG_KVM_AMD_SEV=y
>>>     KVM: SVM: Enable SEV/SEV-ES functionality by default (when supported)
>>>     KVM: SVM: Unconditionally invoke sev_hardware_teardown()
>>>     KVM: SVM: Explicitly check max SEV ASID during sev_hardware_setup()
>>>     KVM: SVM: Move SEV VMCB tracking allocation to sev.c
>>>     KVM: SVM: Drop redundant svm_sev_enabled() helper
>>>     KVM: SVM: Remove an unnecessary prototype declaration of
>>>       sev_flush_asids()
>>>     KVM: SVM: Skip SEV cache flush if no ASIDs have been used
>>>
>>>    arch/x86/include/asm/mem_encrypt.h |  1 -
>>>    arch/x86/kvm/cpuid.c               |  8 ++-
>>>    arch/x86/kvm/cpuid.h               |  1 +
>>>    arch/x86/kvm/svm/sev.c             | 80 ++++++++++++++++++++++--------
>>>    arch/x86/kvm/svm/svm.c             | 57 +++++++++------------
>>>    arch/x86/kvm/svm/svm.h             |  9 +---
>>>    arch/x86/mm/mem_encrypt.c          | 12 ++---
>>>    arch/x86/mm/mem_encrypt_identity.c |  1 -
>>>    8 files changed, 97 insertions(+), 72 deletions(-)
>>>
>>
>> Queued except for patch 6, send that separately since it's purely x86 and
>> maintainers will likely not notice it inside this thread.  You probably want
>> to avoid conflicts by waiting for the migration patches, though.
> 
> It can't be sent separately, having both the kernel's sev_enabled and KVM's
> sev_enabled doesn't build with CONFIG_AMD_MEM_ENCRYPT=y:

I discovered just as much a few hours later, but Boris has acked it 
already so it's all set.

Paolo

> arch/x86/kvm/svm/sev.c:33:13: error: static declaration of ‘sev_enabled’ follows non-static declaration
>     33 | static bool sev_enabled = true;
>        |             ^~~~~~~~~~~
> In file included from include/linux/mem_encrypt.h:17,
>                   from arch/x86/include/asm/page_types.h:7,
>                   from arch/x86/include/asm/page.h:9,
>                   from arch/x86/include/asm/thread_info.h:12,
>                   from include/linux/thread_info.h:58,
>                   from arch/x86/include/asm/preempt.h:7,
>                   from include/linux/preempt.h:78,
>                   from include/linux/percpu.h:6,
>                   from include/linux/context_tracking_state.h:5,
>                   from include/linux/hardirq.h:5,
>                   from include/linux/kvm_host.h:7,
>                   from arch/x86/kvm/svm/sev.c:11:
> arch/x86/include/asm/mem_encrypt.h:23:13: note: previous declaration of ‘sev_enabled’ was here
>     23 | extern bool sev_enabled;
>        |             ^~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:271: arch/x86/kvm/svm/sev.o] Error 1
> 

