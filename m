Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9861312F37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhBHKky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:40:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231933AbhBHKab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612780143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oi2Zi1UN4j9vTbRbY531ctfakDSWbSXduwEmeokxKAw=;
        b=JVyTLbSARhrwoCcb6tKvT3tcID08/teV173a5Qh2zcoizkkD93GNdEAAhrvNTVwu6Vq1Bo
        BJ9kOBywMiX2IH0Gt9fkSqyk8GBcZqJl6CJJcBD/23AD9ou5hZ9TSCsGaIfpGo4v3mpWdl
        79EE4/hfAWOtqh8py2A1ewiNFHhzvSY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-e5VdOWuFP86K1RgZBmGP3w-1; Mon, 08 Feb 2021 05:29:01 -0500
X-MC-Unique: e5VdOWuFP86K1RgZBmGP3w-1
Received: by mail-ej1-f72.google.com with SMTP id 7so1385844ejh.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 02:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oi2Zi1UN4j9vTbRbY531ctfakDSWbSXduwEmeokxKAw=;
        b=DxRVbY+NT3891JZ5KJGLbMQuQuZ0mFWcugOW/U30kOdHyWPhX/kaNMIb9oViSeKmWl
         /a1ec4LpEu1VJLqFJUxbMkOtuUXNmv6Y+okqLyEdUqZsCNwvTn935r6FsBKx+tyAK4il
         FWoVQEXLqcFgCWNGQGb1RQ5x7OgjVt4AbWqDcnEOI8XfwjDoHtpEqjR9D91RgNzaetsx
         UZNDH5u1ABfSGLqz0BzS5fnczrCWP3JLUOPJr1XW/Luc9cK4VAjsGaOcl0Rb9canNhXt
         q7EGLtqVp0WDERLEHu+kxz2041I2B0Y+iSdjKkaNkhzQJYYzeETLID2zXlTZ3fAeuxlU
         oEYw==
X-Gm-Message-State: AOAM530lxRmxSX2dRbLeq58ceGQpUN46Qvqqry4FLrh+jmbWVKjOGlmG
        arGIaVKaaRGhudBQJPiWjzNIgmJyeVxNyKG8qMVR7KHqSrD8+rHCZ8VTKZB3G1wgvmLWS2IBcpb
        zf6vFQ2UYQyV9YvFxcG0CQ7L7
X-Received: by 2002:a17:906:d189:: with SMTP id c9mr16608192ejz.36.1612780140100;
        Mon, 08 Feb 2021 02:29:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiuM8JRCBino8DZb9NZsSRmJgy+fRN/JE2UYUEDUSO4yCOnvnk8pmK+69QuXQocMzngfTSoQ==
X-Received: by 2002:a17:906:d189:: with SMTP id c9mr16608184ejz.36.1612780139975;
        Mon, 08 Feb 2021 02:28:59 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r3sm9225309edi.49.2021.02.08.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 02:28:59 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] KVM: x86: Set PF_VCPU when processing IRQs to fix
 tick-based accounting
In-Reply-To: <20210206004218.312023-1-seanjc@google.com>
References: <20210206004218.312023-1-seanjc@google.com>
Date:   Mon, 08 Feb 2021 11:28:58 +0100
Message-ID: <87lfbyonth.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Temporarily set PF_VCPU while processing IRQ VM-Exits so that a tick IRQ
> accounts the time slice to the guest.  Tick-based accounting of guest
> time is currently broken as PF_VCPU is only set during the relatively
> short VM-Enter sequence, which runs entirely with IRQs disabled, and IRQs
> that occur in the guest are processed well after PF_VCPU is cleared.
>
> Keep PF_VCPU set across both VMX's processing of already-acked IRQs
> (handle_exit_irqoff()) and the explicit IRQ window (SVM's processing,
> plus ticks that occur immediately after VM-Exit on both VMX and SVM).
>
> Fixes: 87fa7f3e98a1 ("x86/kvm: Move context tracking where it belongs")
> Cc: stable@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> This is quite obnoxious, hence the RFC, but I can't think of a clever,
> less ugly way to fix the accounting.
>
>  arch/x86/kvm/x86.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d9f931c63293..6ddf341cd755 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9118,6 +9118,13 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	vcpu->mode = OUTSIDE_GUEST_MODE;
>  	smp_wmb();
>  
> +	/*
> +	 * Temporarily pretend this task is running a vCPU when potentially
> +	 * processing an IRQ exit, including the below opening of an IRQ
> +	 * window.  Tick-based accounting of guest time relies on PF_VCPU
> +	 * being set when the tick IRQ handler runs.
> +	 */
> +	current->flags |= PF_VCPU;

Should we do it only when !vtime_accounting_enabled_cpu() maybe?

>  	static_call(kvm_x86_handle_exit_irqoff)(vcpu);
>  
>  	/*
> @@ -9132,6 +9139,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	++vcpu->stat.exits;
>  	local_irq_disable();
>  	kvm_after_interrupt(vcpu);
> +	current->flags &= ~PF_VCPU;
>  
>  	if (lapic_in_kernel(vcpu)) {
>  		s64 delta = vcpu->arch.apic->lapic_timer.advance_expire_delta;

-- 
Vitaly

