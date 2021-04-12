Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ACF35C523
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbhDLLaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240382AbhDLLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618226994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nyeLo4FrE5zHreHQz7MasSEetE9tN3Jw9beLpfv7C+Q=;
        b=BF0oii0cxVA857hkwU4OpJDAeo7Pa9C4tu9B2K83mp1B1HqahG0tUxicnBX+mq0Ng4LEuN
        TosnZYVCXxjx4E7skQJLDbbRqHhWTMZHXgUJMdYgQzCz02+XnenJYfam/DnYqfpxp9GAyK
        JFqNUEdh+zZPm4/GxuLAFrQ67tTTz/k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-aISwoIz5PeuDoZ5X-EE6BA-1; Mon, 12 Apr 2021 07:29:52 -0400
X-MC-Unique: aISwoIz5PeuDoZ5X-EE6BA-1
Received: by mail-ed1-f72.google.com with SMTP id l22so3086794edt.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nyeLo4FrE5zHreHQz7MasSEetE9tN3Jw9beLpfv7C+Q=;
        b=inNty1cpDgQeKZUZRlUaULJO0rr/LVFGlJKmNWOfWHtaI4yzYFSEjPfjc9mEYf8hZ4
         iyCBRp1HT9H5+aQLz5CtMEfGTKf2lM8kgE41vUHOurmMh2IFRpHhZRVtKJvbQyBXMumi
         xgyf7zfxnheXCZ3UK/DjMAvqBKjTkZ9CsLSdPcwUVT8MiiKwm0csK+4AoeuauL/wiq0d
         dVtIrXleCxn34M7WxaCSpL7bfeI/DzItE8kH7sylIyHpdhQjo+k3o9FrBA1IZCuMDuB8
         a7xBGLmGGVkXB2O37ttTwNHpdnkS/nvd3/GXPLIWlzQ+ygNslAE2BFo3TlP4ectcLthS
         ucRQ==
X-Gm-Message-State: AOAM532iKy82tZxPp8jojln4cNPXFbBQIz4lD77gY4RxhlLXYaxjBvlr
        ra0K0Zwz4MsU3blaOKePHKC/7S8X9AI4QN3P+ZZKZP50u1mcTNjkSEmYa2K1gStHC/2vo/1GpT/
        vXLvE2cjE082zyJd7471Y4b/D
X-Received: by 2002:a05:6402:104c:: with SMTP id e12mr28076522edu.108.1618226991138;
        Mon, 12 Apr 2021 04:29:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyU49Hw6nOmYzmAj9jQhtd21t/eNOeTdT3HGIbQ8noTgP0Y7DfBr7L/L9OO7Hpodode77anZw==
X-Received: by 2002:a05:6402:104c:: with SMTP id e12mr28076506edu.108.1618226990993;
        Mon, 12 Apr 2021 04:29:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e16sm6427109edu.94.2021.04.12.04.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:29:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     Alexander Graf <graf@amazon.com>,
        Evgeny Iakovlev <eyakovl@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/4] KVM: hyper-v: Advertise support for fast XMM
 hypercalls
In-Reply-To: <20210412081110.GA16796@uc8bbc9586ea454.ant.amazon.com>
References: <20210407211954.32755-1-sidcha@amazon.de>
 <20210407211954.32755-5-sidcha@amazon.de>
 <87blap7zha.fsf@vitty.brq.redhat.com>
 <20210408142053.GA10636@u366d62d47e3651.ant.amazon.com>
 <8735w096pk.fsf@vitty.brq.redhat.com>
 <20210412081110.GA16796@uc8bbc9586ea454.ant.amazon.com>
Date:   Mon, 12 Apr 2021 13:29:49 +0200
Message-ID: <87czuz7nbm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Siddharth Chandrasekaran <sidcha@amazon.de> writes:

> On Thu, Apr 08, 2021 at 04:44:23PM +0200, Vitaly Kuznetsov wrote:
>> Siddharth Chandrasekaran <sidcha@amazon.de> writes:
>> > On Thu, Apr 08, 2021 at 02:05:53PM +0200, Vitaly Kuznetsov wrote:
>> >> Siddharth Chandrasekaran <sidcha@amazon.de> writes:
>> >> > Now that all extant hypercalls that can use XMM registers (based on
>> >> > spec) for input/outputs are patched to support them, we can start
>> >> > advertising this feature to guests.
>> >> >
>> >> > Cc: Alexander Graf <graf@amazon.com>
>> >> > Cc: Evgeny Iakovlev <eyakovl@amazon.de>
>> >> > Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
>> >> > ---
>> >> >  arch/x86/include/asm/hyperv-tlfs.h | 4 ++--
>> >> >  arch/x86/kvm/hyperv.c              | 1 +
>> >> >  2 files changed, 3 insertions(+), 2 deletions(-)
>> >> >
>> >> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> >> > index e6cd3fee562b..1f160ef60509 100644
>> >> > --- a/arch/x86/include/asm/hyperv-tlfs.h
>> >> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> >> > @@ -49,10 +49,10 @@
>> >> >  /* Support for physical CPU dynamic partitioning events is available*/
>> >> >  #define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE    BIT(3)
>> >> >  /*
>> >> > - * Support for passing hypercall input parameter block via XMM
>> >> > + * Support for passing hypercall input and output parameter block via XMM
>> >> >   * registers is available
>> >> >   */
>> >> > -#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE                BIT(4)
>> >> > +#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE                BIT(4) | BIT(15)
>> >>
>> >> TLFS 6.0b states that there are two distinct bits for input and output:
>> >>
>> >> CPUID Leaf 0x40000003.EDX:
>> >> Bit 4: support for passing hypercall input via XMM registers is available.
>> >> Bit 15: support for returning hypercall output via XMM registers is available.
>> >>
>> >> and HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE is not currently used
>> >> anywhere, I'd suggest we just rename
>> >>
>> >> HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE to HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE
>> >> and add HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE (bit 15).
>> >
>> > That is how I had it initially; but then noticed that we would never
>> > need to use either of them separately. So it seemed like a reasonable
>> > abstraction to put them together.
>> >
>> 
>> Actually, we may. In theory, KVM userspace may decide to expose just
>> one of these two to the guest as it is not obliged to copy everything
>> from KVM_GET_SUPPORTED_HV_CPUID so we will need separate
>> guest_cpuid_has() checks.
>
> Looks like guest_cpuid_has() check is for x86 CPU features only (if I'm
> not mistaken) and I don't see a suitable alternative that looks into
> vcpu->arch.cpuid_entries[]. So I plan to add a new method
> hv_guest_cpuid_has() in hyperv.c to have this check; does that sound
> right to you?
> If you can give a quick go-ahead, I'll make the changes requested so
> far and send v2 this series.

Sorry my mistake, guest_cpuid_has() was the wrong function to name. In the
meantime I started working on fine-grained access to the existing
Hyper-V enlightenments as well and I think the best approach would be to
cache CPUID 0x40000003 (EAX, EBX, EDX) in kvm_hv_set_cpuid()  to avoid
looping through all guest CPUID entries on every hypercall. Your check
will then look like

 if (hv_vcpu->cpuid_cache.features_edx & HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE)
 ...


 if (hv_vcpu->cpuid_cache.features_edx & HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE)
 ...

We can wrap this into a hv_guest_cpuid_has() helper indeed, it'll look like:

 if (hv_guest_cpuid_has(vcpu, HYPERV_CPUID_FEATURES, CPUID_EDX, HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE))
 ...

but I'm not sure it's worth it, maybe raw check is shorter and better.

I plan to send something out in a day or two, I'll Cc: you. Feel free to
do v2 without this, if your series gets merged first I can just add the
'fine-grained access' to mine.

Thanks!

-- 
Vitaly

