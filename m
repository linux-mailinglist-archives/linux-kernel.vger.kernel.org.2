Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55584134EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhIUOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233042AbhIUOAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632232759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pc5zTd5423g5oCDswwWi0/B+KfF4NWiO9C9OXU0iE9E=;
        b=J9UbpqeEXxDW4HTvUo6lHNSfHQgcUmm4nsoHlIKQIw7h68wUrmxgz1Iehk/kOYhQboZ2Vd
        9kB6aMc99s4nHdQH7qg3dvx4D1q+k1KiX3JEOGDwlMPY1UwJzTF6IZr4zI4tyxkAT7xN+J
        9vaQiR10mWAXhaZQ7Z/SrU5qITJynJ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-LFNf3wRxPBmADkbsREKIqw-1; Tue, 21 Sep 2021 09:59:17 -0400
X-MC-Unique: LFNf3wRxPBmADkbsREKIqw-1
Received: by mail-wr1-f71.google.com with SMTP id s14-20020adff80e000000b001601b124f50so2072513wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 06:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Pc5zTd5423g5oCDswwWi0/B+KfF4NWiO9C9OXU0iE9E=;
        b=G5Yg55J3MiAZQd7h++p5l91DKpJIrOch7FMqOGTjrLR5py823/Fq0VwQsAcuAhIbC7
         7rKRzygS93ODexadYo8jfGP2ZdjdyFW+XQk8LOXLryPthBxnKbBrYjqbMABWMTEs8tRI
         CAV1rtRHNsf8w3Fl1NcRoFLad3vSUOXi/zf3uEsFQeuHsadAVDUZ8ZmI8Bk0yeeNbkEy
         N0vM4r0kHJt3FyCRIlEP9V1xjNxrAJyK+VZiFuqfRpDIPkdKp+GG0ScAKVkOhrS7xFEr
         HAb15cHPWz9GPIPHb/GMt4PdROlS/fSgWQQqEqo7iBMMaOG0orJSFSS/ujCA8Q/xMzWm
         AqcQ==
X-Gm-Message-State: AOAM532NyIB+eM54FpHUNWxbODevvIRgDGso/w1H27xe0jF2AKSlSoHF
        P6W9VcV46kOaHNiCAtiwo6zszeq1I2dO15gGExyHci7QKgTzYcXUhR2uUFUQnWUftbYGjQt7R/5
        pUahwB9Ulqur/ef17zOEBmB9k
X-Received: by 2002:adf:b7c5:: with SMTP id t5mr35306459wre.322.1632232755952;
        Tue, 21 Sep 2021 06:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfch/IQXeY1K+uMr/zZV4z09c6bx4WdCg2bKY2MIL2HNzsSxO6UdUPmI3PDEUkN2UmPgH0og==
X-Received: by 2002:adf:b7c5:: with SMTP id t5mr35306437wre.322.1632232755724;
        Tue, 21 Sep 2021 06:59:15 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t18sm18466238wrp.97.2021.09.21.06.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:59:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v2 10/10] KVM: x86: WARN on non-zero CRs at RESET to
 detect improper initalization
In-Reply-To: <20210921000303.400537-11-seanjc@google.com>
References: <20210921000303.400537-1-seanjc@google.com>
 <20210921000303.400537-11-seanjc@google.com>
Date:   Tue, 21 Sep 2021 15:59:14 +0200
Message-ID: <8735py9gi5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> WARN if CR0, CR3, or CR4 are non-zero at RESET, which given the current
> KVM implementation, really means WARN if they're not zeroed at vCPU
> creation.  VMX in particular has several ->set_*() flows that read other
> registers to handle side effects, and because those flows are common to
> RESET and INIT, KVM subtly relies on emulated/virtualized registers to be
> zeroed at vCPU creation in order to do the right thing at RESET.
>
> Use CRs as a sentinel because they are most likely to be written as side
> effects, and because KVM specifically needs CR0.PG and CR0.PE to be '0'
> to correctly reflect the state of the vCPU's MMU.  CRs are also loaded
> and stored from/to the VMCS, and so adds some level of coverage to verify
> that KVM doesn't conflate zero-allocating the VMCS with properly
> initializing the VMCS with VMWRITEs.
>
> Note, '0' is somewhat arbitrary, vCPU creation can technically stuff any
> value for a register so long as it's coherent with respect to the current
> vCPU state.  In practice, '0' works for all registers and is convenient.
>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ec61b90d9b73..4e25baac3977 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10800,6 +10800,16 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  	unsigned long new_cr0;
>  	u32 eax, dummy;
>  
> +	/*
> +	 * Several of the "set" flows, e.g. ->set_cr0(), read other registers
> +	 * to handle side effects.  RESET emulation hits those flows and relies
> +	 * on emulated/virtualized registers, including those that are loaded
> +	 * into hardware, to be zeroed at vCPU creation.  Use CRs as a sentinel
> +	 * to detect improper or missing initialization.
> +	 */
> +	WARN_ON_ONCE(!init_event &&
> +		     (old_cr0 || kvm_read_cr3(vcpu) || kvm_read_cr4(vcpu)));
> +
>  	kvm_lapic_reset(vcpu, init_event);
>  
>  	vcpu->arch.hflags = 0;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

