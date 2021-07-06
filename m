Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563963BD8F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhGFOxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232440AbhGFOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625583015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5YRgxjBVFyVrsecYfIDXV3/UmWdoKFIP6xE5czOL/I=;
        b=C+5oIvcsExb6HTA4JNTUPGu/Xz8twfOTMZRl2650xREe8vIAu04Qs6wMYPqRwwXFTLaG/B
        5XVR2J92D0Y2XdIP2WB2GUjr4CAFp7TgEsBQztfXesPuFS7KHEnvawm0iYgW1G1n1EAC27
        Qflc9cKtP/e9fdlUD5v4ySvMa6cq9go=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-cdEXeeCnO5GgY0su-p87Bw-1; Tue, 06 Jul 2021 10:50:14 -0400
X-MC-Unique: cdEXeeCnO5GgY0su-p87Bw-1
Received: by mail-wm1-f70.google.com with SMTP id k16-20020a7bc3100000b02901d849b41038so1183315wmj.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s5YRgxjBVFyVrsecYfIDXV3/UmWdoKFIP6xE5czOL/I=;
        b=RNGft0DtCpH/nBu7eUub2FGTo75dJ1g6jn2qq+tNjCjFHqZkq3HCoawsN6NvoE9XIU
         3f9Xg+GHGvghTJQsYHHewTT+jQ+qU/YOrcRfHH+gJdCImC3By92pCasS7bqlEIQ4OsYi
         TU/G8gsRPtgkFKfy2Sc8t9x5KUKb5RWoOifrOyEZQv/NgeZyi/fyJJRlQ5g/enFaZ9WW
         PRvpRAGjEFEFPDvrEAsNOqNWof4tiqMb5Y4IYgJVQWJyB/8rNEMxqjXzJmfJb9HA3Fq9
         1O/Yx1qEu7drgFsJwy5+s5dynaNcFSoUpbEGvgGSlaalTDufINUe1ovyIpB34JBJFBHq
         AyOw==
X-Gm-Message-State: AOAM533DK0BGgW7cp58GUeTRU7y1VzyvdHBiXd0aEb1G+vFntiRC2pX7
        aEFTBtpvPnuuDKStnY80P71Ze+NM3SDcUURtMa7aFso8BxEditbohJZxCgi8V26Jqwcx1Fe/VHp
        +Xs5aDQ5ENbppIoKbYMVHa45A
X-Received: by 2002:a5d:530f:: with SMTP id e15mr21899224wrv.217.1625583013664;
        Tue, 06 Jul 2021 07:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJUXd4AsURshO/WOcPijFSw+4/Maf9g/IRtAdvHhF7Ym+8rdnyoGw/RRjS3QkvtHK5WXo4aA==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr21899201wrv.217.1625583013504;
        Tue, 06 Jul 2021 07:50:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w8sm18306728wrt.83.2021.07.06.07.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:50:12 -0700 (PDT)
Subject: Re: [RFC PATCH v2 37/69] KVM: x86: Check for pending APICv interrupt
 in kvm_vcpu_has_events()
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <489df8a1b8fb43677c2c2c5347398ce985713577.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02369ee0-8e21-2b30-03c6-94bb885a0ffb@redhat.com>
Date:   Tue, 6 Jul 2021 16:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <489df8a1b8fb43677c2c2c5347398ce985713577.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Return true for kvm_vcpu_has_events() if the vCPU has a pending APICv
> interrupt to support TDX's usage of APICv.  Unlike VMX, TDX doesn't have
> access to vmcs.GUEST_INTR_STATUS and so can't emulate posted interrupts,
> i.e. needs to generate a posted interrupt and more importantly can't
> manually move requested interrupts into the vIRR (which it also doesn't
> have access to).
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/kvm/x86.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f1d5e0a53640..92d5a6649a21 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11341,7 +11341,9 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
>   
>   	if (kvm_arch_interrupt_allowed(vcpu) &&
>   	    (kvm_cpu_has_interrupt(vcpu) ||
> -	    kvm_guest_apic_has_interrupt(vcpu)))
> +	     kvm_guest_apic_has_interrupt(vcpu) ||
> +	     (vcpu->arch.apicv_active &&
> +	      kvm_x86_ops.dy_apicv_has_pending_interrupt(vcpu))))
>   		return true;
>   
>   	if (kvm_hv_has_stimer_pending(vcpu))
> 

Please remove "dy_" from the name of the callback, and use the static 
call.  Also, if it makes sense, please consider using the same test as 
for patch 38 to choose *between* either kvm_cpu_has_interrupt() + 
kvm_guest_apic_has_interrupt() or 
kvm_x86_ops.dy_apicv_has_pending_interrupt().

Paolo

