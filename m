Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD738E5E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhEXLyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232591AbhEXLym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621857194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zfCwhka2L7IMBYHuu50/MdZUm2+UjbEqYuiRuQJLXKE=;
        b=Rn7bA1+jC/ZaZu7RlWmeAy9h+Q8YMLpXZU10BgrXm9qFAqp+W47fmQIdKekIREQaVMKbju
        Y3zUbR/W7Qjuu3IetPPKJ3npHz+kqa+r3t/XtbEvmEVkBbVxyKmtaNvPDgqhAnG/4aSg51
        bLoIxPQLNniNQf3itM/npGUR/zYp5nA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-XDkCza2LONWW3gnQXCQSAg-1; Mon, 24 May 2021 07:53:13 -0400
X-MC-Unique: XDkCza2LONWW3gnQXCQSAg-1
Received: by mail-wr1-f71.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso9511377wrf.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 04:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zfCwhka2L7IMBYHuu50/MdZUm2+UjbEqYuiRuQJLXKE=;
        b=bNEyKHgdCk9sThDKyoKdAKTCw4CAOO9rZphFeh4kEjzi0L3DAVF8MDf6e8Rvbsl9Fz
         yyGSfWfAZRYyI+MVIXg01Omw04zvxJUQdSu1PHnsCObPmQ02VcAJgPxZQO/U/v26t6iP
         hByRImn/2+JvIFxX6UBTusofcbUqKgYat0AFDJzx7+xIT9JnWyfd1EDBeGKlfU8Lr3CA
         faDv3tPbdJ9EgoM+rq0ycBM9Iq6rEViIKeY21rx0KjVAl1RTsrPTZMVNEwv+fSneKDJA
         +110WNbXrVWCOLsRPo1EUHGOoJmN+66g7UWv8pB1OiS3f8qAI1/T4Om3Wb5ayLhBx1/q
         jVQQ==
X-Gm-Message-State: AOAM530mQpjGRrTHXN1wdRnQuLobAblzT9yhESaWnYwXtT2qOUYf1NNe
        V/xShuUjDIQoLm0LZlL1mPA0mfMRormTDrIhwgYeZAGFYQhAFIZjdzoty13Iqgd4yhpA893c4xP
        dOUuZASPtpvy55KNc3MMY9s1h
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr21348345wrw.239.1621857192032;
        Mon, 24 May 2021 04:53:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj5hA+mPY/6z6A3gV4eFAIFa4rKF/d+NdxDU035q9t0Udwa9q9VgydrjfjXD6Zu3/m0314gw==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr21348330wrw.239.1621857191811;
        Mon, 24 May 2021 04:53:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p14sm11925985wrm.70.2021.05.24.04.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 04:53:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] KVM: SVM: Assume a 64-bit hypercall for guests with
 protected state
In-Reply-To: <d0904f0d049300267665bd4abf96c3d7e7aa4825.1621701837.git.thomas.lendacky@amd.com>
References: <d0904f0d049300267665bd4abf96c3d7e7aa4825.1621701837.git.thomas.lendacky@amd.com>
Date:   Mon, 24 May 2021 13:53:08 +0200
Message-ID: <87pmxg73h7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Lendacky <thomas.lendacky@amd.com> writes:

> When processing a hypercall for a guest with protected state, currently
> SEV-ES guests, the guest CS segment register can't be checked to
> determine if the guest is in 64-bit mode. For an SEV-ES guest, it is
> expected that communication between the guest and the hypervisor is
> performed to shared memory using the GHCB. In order to use the GHCB, the
> guest must have been in long mode, otherwise writes by the guest to the
> GHCB would be encrypted and not be able to be comprehended by the
> hypervisor. Given that, assume that the guest is in 64-bit mode when
> processing a hypercall from a guest with protected state.
>
> Fixes: f1c6366e3043 ("KVM: SVM: Add required changes to support intercepts under SEV-ES")
> Reported-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kvm/x86.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9b6bca616929..e715c69bb882 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8403,7 +8403,12 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>  
>  	trace_kvm_hypercall(nr, a0, a1, a2, a3);
>  
> -	op_64_bit = is_64_bit_mode(vcpu);
> +	/*
> +	 * If running with protected guest state, the CS register is not
> +	 * accessible. The hypercall register values will have had to been
> +	 * provided in 64-bit mode, so assume the guest is in 64-bit.
> +	 */
> +	op_64_bit = is_64_bit_mode(vcpu) || vcpu->arch.guest_state_protected;
>  	if (!op_64_bit) {
>  		nr &= 0xFFFFFFFF;
>  		a0 &= 0xFFFFFFFF;

While this is might be a very theoretical question, what about other
is_64_bit_mode() users? Namely, a very similar to the above check exists
in kvm_hv_hypercall() and kvm_xen_hypercall().

-- 
Vitaly

