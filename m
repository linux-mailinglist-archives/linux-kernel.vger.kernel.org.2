Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838B44442F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhKCODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231131AbhKCODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635948028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bkPllbGEaNokgSQGekCjbxHVsi6h/8ZMYmMh35cbn+8=;
        b=CkTP3cVN0iXHGsAmloOX6V8ssn3+X2Jl8FiOanVpjnsaIE6Ci/ZavDTkbWesQ4ZNySLKtd
        sIJux4Y7bRp9ZjbSw5lk7XqFfZMrOImKbiN3SDxyG62w6SKjkZ8bpGUaGMsJTGrAoIOdar
        suFO57nmCMT8sm2V/3SbmFLjK7fdJE8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-r2P8ZDqcM-29ZrLL5pRn4Q-1; Wed, 03 Nov 2021 10:00:26 -0400
X-MC-Unique: r2P8ZDqcM-29ZrLL5pRn4Q-1
Received: by mail-wm1-f71.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso1133136wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 07:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bkPllbGEaNokgSQGekCjbxHVsi6h/8ZMYmMh35cbn+8=;
        b=0PukF6dZy1C6+jyMqGe49TlWnoKAZyPRrrTaHS8+vswfd2Lp7QICdNiK/thJa4rwQ7
         qV1Zd0ajktynKaK4uCsMp/TOLiBSEsz7KnpDFVpx/NCE2D69zryrVf4YJZOliNSNaWPP
         TkbNNNzn0/8tNJzKqyAFBICrIa+Q/llcfMwFbkzEll//ptL7WGZtaDixnoR4AdF2Gha4
         h0JFle6owfHf0flVQs+Sb908jdv4Uh2CfV4PKV3U2WiWb6gfjwYL1ePpDYQTG65H7tAX
         I8Me8/jUxTU7HFhDtJXCTFrXb6hMvvGr0CD5PNQLrAlUwhKLFrdcnKbs1wMC+4XbFdcP
         7P9w==
X-Gm-Message-State: AOAM53284sKQ7xwlOE1Dg0n2BFVIB8hORfqhUTy09sCBB9JV3hNR64bc
        oFp34yLPM38Dz3/rPZsPsLeInDlMnX55GRNnXDhSJKL5YDcv7YNYFJMOR+OlhScEDDKmcV2T9NV
        OR3ky6S7Ab0Am7pGrpUThv/Vi
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr15746958wml.53.1635948025599;
        Wed, 03 Nov 2021 07:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMgTwPIYzqxHNj8sMq40jDbXoD8WnUEgxL3EAOD/McYtpojcrSyhMW5d8ces/LFemnLUqSZw==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr15746904wml.53.1635948025269;
        Wed, 03 Nov 2021 07:00:25 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o26sm5489583wmc.17.2021.11.03.07.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 07:00:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2] KVM: x86: inhibit APICv when KVM_GUESTDBG_BLOCKIRQ
 active
In-Reply-To: <8b7949ae8094217c92b714cfd193fc571654cea7.camel@redhat.com>
References: <20211103094255.426573-1-mlevitsk@redhat.com>
 <871r3xnzaw.fsf@vitty.brq.redhat.com>
 <8b7949ae8094217c92b714cfd193fc571654cea7.camel@redhat.com>
Date:   Wed, 03 Nov 2021 15:00:23 +0100
Message-ID: <87y265mj9k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Wed, 2021-11-03 at 14:28 +0100, Vitaly Kuznetsov wrote:
>> Maxim Levitsky <mlevitsk@redhat.com> writes:
>> 
>> > KVM_GUESTDBG_BLOCKIRQ relies on interrupts being injected using
>> > standard kvm's inject_pending_event, and not via APICv/AVIC.
>> > 
>> > Since this is a debug feature, just inhibit it while it
>> > is in use.
>> > 
>> > Fixes: 61e5f69ef0837 ("KVM: x86: implement KVM_GUESTDBG_BLOCKIRQ")
>> > 
>> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> > ---
>> >  arch/x86/include/asm/kvm_host.h | 1 +
>> >  arch/x86/kvm/svm/avic.c         | 3 ++-
>> >  arch/x86/kvm/vmx/vmx.c          | 3 ++-
>> >  arch/x86/kvm/x86.c              | 3 +++
>> >  4 files changed, 8 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> > index 88fce6ab4bbd7..8f6e15b95a4d8 100644
>> > --- a/arch/x86/include/asm/kvm_host.h
>> > +++ b/arch/x86/include/asm/kvm_host.h
>> > @@ -1034,6 +1034,7 @@ struct kvm_x86_msr_filter {
>> >  #define APICV_INHIBIT_REASON_IRQWIN     3
>> >  #define APICV_INHIBIT_REASON_PIT_REINJ  4
>> >  #define APICV_INHIBIT_REASON_X2APIC	5
>> > +#define APICV_INHIBIT_REASON_BLOCKIRQ	6
>> >  
>> >  struct kvm_arch {
>> >  	unsigned long n_used_mmu_pages;
>> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>> > index 8052d92069e01..affc0ea98d302 100644
>> > --- a/arch/x86/kvm/svm/avic.c
>> > +++ b/arch/x86/kvm/svm/avic.c
>> > @@ -904,7 +904,8 @@ bool svm_check_apicv_inhibit_reasons(ulong bit)
>> >  			  BIT(APICV_INHIBIT_REASON_NESTED) |
>> >  			  BIT(APICV_INHIBIT_REASON_IRQWIN) |
>> >  			  BIT(APICV_INHIBIT_REASON_PIT_REINJ) |
>> > -			  BIT(APICV_INHIBIT_REASON_X2APIC);
>> > +			  BIT(APICV_INHIBIT_REASON_X2APIC) |
>> > +			  BIT(APICV_INHIBIT_REASON_BLOCKIRQ);
>> >  
>> >  	return supported & BIT(bit);
>> >  }
>> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> > index 71f54d85f104c..e4fc9ff7cd944 100644
>> > --- a/arch/x86/kvm/vmx/vmx.c
>> > +++ b/arch/x86/kvm/vmx/vmx.c
>> > @@ -7565,7 +7565,8 @@ static void hardware_unsetup(void)
>> >  static bool vmx_check_apicv_inhibit_reasons(ulong bit)
>> >  {
>> >  	ulong supported = BIT(APICV_INHIBIT_REASON_DISABLE) |
>> > -			  BIT(APICV_INHIBIT_REASON_HYPERV);
>> > +			  BIT(APICV_INHIBIT_REASON_HYPERV) |
>> > +			  BIT(APICV_INHIBIT_REASON_BLOCKIRQ);
>> >  
>> >  	return supported & BIT(bit);
>> >  }
>> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> > index ac83d873d65b0..dccf927baa4dd 100644
>> > --- a/arch/x86/kvm/x86.c
>> > +++ b/arch/x86/kvm/x86.c
>> > @@ -10747,6 +10747,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>> >  	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
>> >  		vcpu->arch.singlestep_rip = kvm_get_linear_rip(vcpu);
>> >  
>> > +	kvm_request_apicv_update(vcpu->kvm,
>> > +				 !(vcpu->guest_debug & KVM_GUESTDBG_BLOCKIRQ),
>> > +				 APICV_INHIBIT_REASON_BLOCKIRQ);
>> >  	/*
>> >  	 * Trigger an rflags update that will inject or remove the trace
>> >  	 * flags.
>> 
>> This fixes the problem for me!
>> 
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Cool!
>> 
>
> Now that I think about it, since guest debug flags are per-vcpu, this code won't
> work if there are multiple vCPUs and you enable KVM_GUESTDBG_BLOCKIRQ on all of them
> and then disable on this flag on just one of vCPUs, because this code will re-enable APICv/AVIC in this case.
> A counter is needed, like you did in synic/autoeoi case.
>

Right, I completely forgot about this peculiarity!

-- 
Vitaly

