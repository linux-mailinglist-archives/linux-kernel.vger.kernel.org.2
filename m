Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD98A3C1778
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhGHQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhGHQ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625763225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zOv/MDfEWcH9s0zWRUnQQNA4xFdmSTmuagPnlN1tB8=;
        b=fHiE//kX0HDHxKHUZzhuNUmrYb3AzsKMZ60dkLSosaaCykmuTFdxOlvYFqG9CKS9Hacjo6
        O4LBEqgej8p8Vgg/EZWTNimyGi4gTgM6f7hWJ+oQTMPgnOSoz8+AQ82y++++W0GxZO8NHZ
        iwlkj2uq+ahI+XU0YYwd54FoLXvyp48=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-MHMYsE5EPi-ZDkCvXE_lFg-1; Thu, 08 Jul 2021 12:53:44 -0400
X-MC-Unique: MHMYsE5EPi-ZDkCvXE_lFg-1
Received: by mail-lj1-f197.google.com with SMTP id f14-20020a2ea0ce0000b0290187d7481310so71150ljm.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 09:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8zOv/MDfEWcH9s0zWRUnQQNA4xFdmSTmuagPnlN1tB8=;
        b=kvII6rVa3TIbC4Wd2M4rzoLlM7eHiCd0UvFpMK46rltmTgq+T1w7Q2VDSTEpFrsIEH
         2sMIDS+6DBHgcYQ4h+3sN3BRj9gt6XyOqVBHgTU0W6PJaTzbQ/OxROrg3m2+vjz1580I
         2kuvrIol6IQk8WygFHxLNdIFnSW2aYgD8guwtXhAJlisKXYUpC4OZ1JjliUyjfxtUvE6
         AXNOyDOuAcrrMGeWNlp8KlL6U+UqvoCG9WE4yN/vU6QXj1TaMtA45v+UHNUZai3o9p6A
         /PGzf/S4gcpGOeOybDax8vzCCTJAmvFZs/bGD0exrnfsWMuy3DUPwuxwT8E0KtL5wJRZ
         0seA==
X-Gm-Message-State: AOAM5335aMjrXUQp2XVyy3HhsfhyeMOImTPvJWgYwmzlIzDeMBFrtHwy
        8MavvvOO3L1DGN4Qhd/XONxUUCWb6V4p20XpmbJlUmjcfEwkKnDaJUAX99GNurH3gKsSWr8ntxm
        jKmA7aMJqSxSgQzvCGnXLQrZm
X-Received: by 2002:a17:907:ea5:: with SMTP id ho37mr31944244ejc.109.1625762903187;
        Thu, 08 Jul 2021 09:48:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3a5F1wHTH5P/QRmbTxUMdjhRN2uE1z7VdPPF6Jl7c6aaYv8oJSi/bC2ELxd8i4zc3tObZCg==
X-Received: by 2002:a17:907:ea5:: with SMTP id ho37mr31944235ejc.109.1625762903030;
        Thu, 08 Jul 2021 09:48:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g17sm1552964edb.37.2021.07.08.09.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 09:48:22 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Also reload the debug registers before
 kvm_x86->run() when the host is using them
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
References: <20210628172632.81029-1-jiangshanlai@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46e0aaf1-b7cd-288f-e4be-ac59aa04908f@redhat.com>
Date:   Thu, 8 Jul 2021 18:48:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628172632.81029-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/21 19:26, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> When the host is using debug registers but the guest is not using them
> nor is the guest in guest-debug state, the kvm code does not reset
> the host debug registers before kvm_x86->run().  Rather, it relies on
> the hardware vmentry instruction to automatically reset the dr7 registers
> which ensures that the host breakpoints do not affect the guest.
> 
> But there are still problems:
> 	o The addresses of the host breakpoints can leak into the guest
> 	  and the guest may use these information to attack the host.

I don't think this is true, because DRn reads would exit (if they don't, 
switch_db_regs would be nonzero).  But otherwise it makes sense to do at 
least the DR7 write, and we might as well do all of them.

> 	o It violates the non-instrumentable nature around VM entry and
> 	  exit.  For example, when a host breakpoint is set on
> 	  vcpu->arch.cr2, #DB will hit aftr kvm_guest_enter_irqoff().
> 
> Beside the problems, the logic is not consistent either. When the guest
> debug registers are active, the host breakpoints are reset before
> kvm_x86->run(). But when the guest debug registers are inactive, the
> host breakpoints are delayed to be disabled.  The host tracing tools may
> see different results depending on there is any guest running or not.

More precisely, the host tracing tools may see different results 
depending on what the guest is doing.

Queued (with fixed commit message), thanks!

Paolo

> To fix the problems, we also reload the debug registers before
> kvm_x86->run() when the host is using them whenever the guest is using
> them or not.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>   arch/x86/kvm/x86.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b594275d49b5..cce316655d3c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9320,7 +9320,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>   	if (test_thread_flag(TIF_NEED_FPU_LOAD))
>   		switch_fpu_return();
>   
> -	if (unlikely(vcpu->arch.switch_db_regs)) {
> +	if (unlikely(vcpu->arch.switch_db_regs || hw_breakpoint_active())) {
>   		set_debugreg(0, 7);
>   		set_debugreg(vcpu->arch.eff_db[0], 0);
>   		set_debugreg(vcpu->arch.eff_db[1], 1);
> 

