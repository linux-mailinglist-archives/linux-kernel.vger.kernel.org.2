Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3CB3B2996
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhFXHp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231740AbhFXHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624520588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Ee7updzwSXDScwuOwS9Mi80C6tuY/612ATdebIhkns=;
        b=IyYGKbSXcOgPK4kEofkxgvx2RFgJWAzaTMSKr8QZSba2KJS/5LsrVzYSMNKWSnXWGA+A8+
        6YyZ5NJcJVjDtXn9DkQNb31untAaGgNZLakjpjy9eLNTVPU6t9GeVNo9mT8hLPzi8ZGmTV
        /cKLVqN2pjwMyJYqq5Bi346hiOh9mFU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-Pa31IyXaNqemgPl4_naROg-1; Thu, 24 Jun 2021 03:43:06 -0400
X-MC-Unique: Pa31IyXaNqemgPl4_naROg-1
Received: by mail-ed1-f72.google.com with SMTP id v12-20020aa7dbcc0000b029038fc8e57037so2906362edt.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Ee7updzwSXDScwuOwS9Mi80C6tuY/612ATdebIhkns=;
        b=RDdVhhVK2jS7SGXzhAPrItJwYSyoX/LXTnyTkP4kISer8Wyr2nJghf0a+bXiLurNbp
         6P3ZozMrmfmSyfC4EDkg5LZqabTDrbX5YuFGd33ByZElUGSmDWdMh3kdYbndWTCiMPOs
         uPEne6Or17GBFGR21IPNzWYyBKRE+gbozKK0pt87u/pj0xwRJIsB6r17u3yGOwxmdGoM
         tU7+ROwu3o2POUMWEnaKbJY9Q1dKkLxMcRnZFDafX5yD9SOmQaN7NC7Yf7rbyTZbLCqT
         +ObcwmaOHnum/8vamG5yxxEOA8R0LcPTqhEqZxKb2rPNCzk6OjcqllpPJGBUuplntUQe
         9cMw==
X-Gm-Message-State: AOAM533r2+O9ghns9GAldULCc0v5OigTuYR/pQsYhLWnmj/gnPblMKhG
        a166/NP3rsJc5aDcC/93YLIN8subji5lJ1px2upaTH38nOQx8JLeXbRugjblaEnUOz66wWbG8MC
        +zgG/KW7c9A+gE69Mc7Jgb/Td
X-Received: by 2002:a17:906:d20b:: with SMTP id w11mr4039388ejz.242.1624520585305;
        Thu, 24 Jun 2021 00:43:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQSSRwPS6ea2idy2dt/9VFPF5iJN22Sg5bUpEw+GW0oYQnd2fQHWwj9sl6kPJ78MXVifTBLg==
X-Received: by 2002:a17:906:d20b:: with SMTP id w11mr4039368ejz.242.1624520585127;
        Thu, 24 Jun 2021 00:43:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dh23sm1357519edb.53.2021.06.24.00.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 00:43:04 -0700 (PDT)
Subject: Re: [PATCH 0/7] KVM: x86: guest MAXPHYADDR and C-bit fixes
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210623230552.4027702-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66d6d077-9766-1711-d8dc-795bde299b97@redhat.com>
Date:   Thu, 24 Jun 2021 09:43:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210623230552.4027702-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/21 01:05, Sean Christopherson wrote:
> A few fixes centered around enumerating guest MAXPHYADDR and handling the
> C-bit in KVM.
> 
> DISCLAIMER: I have no idea if patch 04, "Truncate reported guest
> MAXPHYADDR to C-bit if SEV is" is architecturally correct.  The APM says
> the following about the C-bit in the context of SEV, but I can't for the
> life of me find anything in the APM that clarifies whether "effectively
> reduced" is supposed to apply to _only_ SEV guests, or any guest on an
> SEV enabled platform.
> 
>    Note that because guest physical addresses are always translated through
>    the nested page tables, the size of the guest physical address space is
>    not impacted by any physical address space reduction indicated in
>    CPUID 8000_001F[EBX]. If the C-bit is a physical address bit however,
>    the guest physical address space is effectively reduced by 1 bit.
> 
> In practice, I have observed that Rome CPUs treat the C-bit as reserved for
> non-SEV guests (another disclaimer on this below).  Long story short, commit
> ef4c9f4f6546 ("KVM: selftests: Fix 32-bit truncation of vm_get_max_gfn()")
> exposed the issue by inadvertantly causing selftests to start using GPAs
> with bit 47 set.
> 
> That said, regardless of whether or not the behavior is intended, it needs
> to be addressed by KVM.  I think the only difference is whether this is
> KVM's _only_ behavior, or whether it's gated by an erratum flag.
> 
> The second disclaimer is that I haven't tested with memory encryption
> disabled in hardware.  I wrote the patch assuming/hoping that only CPUs
> that report SEV=1 treat the C-bit as reserved, but I haven't actually
> tested the SEV=0 case on e.g. CPUs with only SME (we might have these
> platforms, but I've no idea how to access/find them), or CPUs with SME/SEV
> disabled in BIOS (again, I've no idea how to do this with our BIOS).

I'm merging patches 1-3 right away, though not sending them to Linus 
(they will be picked up by stable after the 5.14 merge window); for 
patch 4, I'm creating a separate file for the "common" parts of 
paging_tmpl.h, called paging.h.

Paolo

> Sean Christopherson (7):
>    KVM: x86: Use guest MAXPHYADDR from CPUID.0x8000_0008 iff TDP is
>      enabled
>    KVM: x86: Use kernel's x86_phys_bits to handle reduced MAXPHYADDR
>    KVM: x86: Truncate reported guest MAXPHYADDR to C-bit if SEV is
>      supported
>    KVM: x86/mmu: Do not apply HPA (memory encryption) mask to GPAs
>    KVM: VMX: Refactor 32-bit PSE PT creation to avoid using MMU macro
>    KVM: x86/mmu: Bury 32-bit PSE paging helpers in paging_tmpl.h
>    KVM: x86/mmu: Use separate namespaces for guest PTEs and shadow PTEs
> 
>   arch/x86/kvm/cpuid.c            | 38 +++++++++++++++++---
>   arch/x86/kvm/mmu.h              | 11 ++----
>   arch/x86/kvm/mmu/mmu.c          | 63 ++++++++-------------------------
>   arch/x86/kvm/mmu/mmu_audit.c    |  6 ++--
>   arch/x86/kvm/mmu/mmu_internal.h | 14 ++++++++
>   arch/x86/kvm/mmu/paging_tmpl.h  | 52 ++++++++++++++++++++++++++-
>   arch/x86/kvm/mmu/spte.c         |  2 +-
>   arch/x86/kvm/mmu/spte.h         | 34 +++++++-----------
>   arch/x86/kvm/mmu/tdp_iter.c     |  6 ++--
>   arch/x86/kvm/mmu/tdp_mmu.c      |  2 +-
>   arch/x86/kvm/svm/svm.c          | 37 ++++++++++++++-----
>   arch/x86/kvm/vmx/vmx.c          |  2 +-
>   arch/x86/kvm/x86.c              |  3 ++
>   arch/x86/kvm/x86.h              |  1 +
>   14 files changed, 170 insertions(+), 101 deletions(-)
> 

