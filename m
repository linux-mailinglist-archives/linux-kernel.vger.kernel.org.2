Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF04535875C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhDHOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhDHOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617893068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ND/bD1NdJfIUtWvmn9cztv2pnJuFNG076aZGLQ1xAK8=;
        b=Ii/AjKf9yBMDismGoddyK7vnW4lyRU0GI5+IWE28oDomAIHjQJL/jkc1p0s0PeUYhafunl
        1XUj3WCXe9KGZckfc71ZnBPnZtW4s/iV0pLyfs24QsVP+ptbq+6wCK+BUktgi/M2X67HxD
        RGBMohf6mEdyIWXAW0ugTypzgAcCHjo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-o-uY3chuPeO0-mHsEFd2lw-1; Thu, 08 Apr 2021 10:44:26 -0400
X-MC-Unique: o-uY3chuPeO0-mHsEFd2lw-1
Received: by mail-wr1-f71.google.com with SMTP id o2so1081329wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 07:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ND/bD1NdJfIUtWvmn9cztv2pnJuFNG076aZGLQ1xAK8=;
        b=VsfU5Z7vwIh+7X+4LobiinU/IAQaqRSVN1b5HUUd5ZPAlDN+ynTkTrFSy1bJqzhImV
         P0gSkk0qEb/XTx/K1AVTN30EJiY6WooKFRwVnORUdlE0LwD8JKrE8Ri/jZiwVJWgmXaC
         V1dWRNI87u8b2xqrOxGi8zzRDJkeIx20Mrah7bHqqw2VmuCxqLtzlOqOBFSCLG6SuLas
         cEYdwUNS8qJmoe/59CIzkUjnMcR7v4cNngGZifWiLqfvPs+IzXyVNYbFOEG6rYEHSdeJ
         3mrmfnMSbX5uqYRVQvvd64G1pm2zwzRu0JBZO87sANL3Z5Mlk9HUPQA+HjEsWmRZxDZB
         hcIQ==
X-Gm-Message-State: AOAM530QqAlu2EH8A9wrtUqRwoJUeqmYC/vzl3J7TWwIdqd75+Pawxw3
        oVMTH3fyDrIyRxlmWxhHPYeS60xRTp3t5O9mLvXtc1fK6GFg0kChAtGLljBrPPWVbmHA9hNm/Of
        g1FPQcZICgSc0iY0UlZ0EHeZ+
X-Received: by 2002:adf:83e3:: with SMTP id 90mr11839843wre.153.1617893065314;
        Thu, 08 Apr 2021 07:44:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTH+kdqLFdolRPxnu0qsP1VMV2il2nyLsAe0ntsvnHjriOiow9QvQwik3um6iZMqwUrlPMpQ==
X-Received: by 2002:adf:83e3:: with SMTP id 90mr11839814wre.153.1617893065111;
        Thu, 08 Apr 2021 07:44:25 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c2sm14162512wmr.22.2021.04.08.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 07:44:24 -0700 (PDT)
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
In-Reply-To: <20210408142053.GA10636@u366d62d47e3651.ant.amazon.com>
References: <20210407211954.32755-1-sidcha@amazon.de>
 <20210407211954.32755-5-sidcha@amazon.de>
 <87blap7zha.fsf@vitty.brq.redhat.com>
 <20210408142053.GA10636@u366d62d47e3651.ant.amazon.com>
Date:   Thu, 08 Apr 2021 16:44:23 +0200
Message-ID: <8735w096pk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Siddharth Chandrasekaran <sidcha@amazon.de> writes:

> On Thu, Apr 08, 2021 at 02:05:53PM +0200, Vitaly Kuznetsov wrote:
>> Siddharth Chandrasekaran <sidcha@amazon.de> writes:
>>
>> > Now that all extant hypercalls that can use XMM registers (based on
>> > spec) for input/outputs are patched to support them, we can start
>> > advertising this feature to guests.
>> >
>> > Cc: Alexander Graf <graf@amazon.com>
>> > Cc: Evgeny Iakovlev <eyakovl@amazon.de>
>> > Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
>> > ---
>> >  arch/x86/include/asm/hyperv-tlfs.h | 4 ++--
>> >  arch/x86/kvm/hyperv.c              | 1 +
>> >  2 files changed, 3 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> > index e6cd3fee562b..1f160ef60509 100644
>> > --- a/arch/x86/include/asm/hyperv-tlfs.h
>> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> > @@ -49,10 +49,10 @@
>> >  /* Support for physical CPU dynamic partitioning events is available*/
>> >  #define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE    BIT(3)
>> >  /*
>> > - * Support for passing hypercall input parameter block via XMM
>> > + * Support for passing hypercall input and output parameter block via XMM
>> >   * registers is available
>> >   */
>> > -#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE                BIT(4)
>> > +#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE                BIT(4) | BIT(15)
>>
>> TLFS 6.0b states that there are two distinct bits for input and output:
>>
>> CPUID Leaf 0x40000003.EDX:
>> Bit 4: support for passing hypercall input via XMM registers is available.
>> Bit 15: support for returning hypercall output via XMM registers is available.
>>
>> and HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE is not currently used
>> anywhere, I'd suggest we just rename
>>
>> HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE to HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE
>> and add HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE (bit 15).
>
> That is how I had it initially; but then noticed that we would never
> need to use either of them separately. So it seemed like a reasonable
> abstraction to put them together.
>

Actually, we may. In theory, KVM userspace may decide to expose just
one of these two to the guest as it is not obliged to copy everything
from KVM_GET_SUPPORTED_HV_CPUID so we will need separate
guest_cpuid_has() checks.

(This reminds me of something I didn't see in your series:
we need to check that XMM hypercall parameters support was actually
exposed to the guest as it is illegal for a guest to use it otherwise --
and we will likely need two checks, for input and output).

Also, (and that's what triggered my comment) all other HV_ACCESS_* in
kvm_get_hv_cpuid() are single bits so my first impression was that you
forgot one bit, but then I saw that you combined them together.

-- 
Vitaly

