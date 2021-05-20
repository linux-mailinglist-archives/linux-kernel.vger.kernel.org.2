Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDD038B34B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbhETPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhETPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:34:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC8C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:32:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g18so10962652pfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QqhQoZDC7MFz94mqk6sQxq+J1Jy4fBaSrpD5HtvukHo=;
        b=GQSB+yNcvl5WPFbVhTJo/8wAPCuvLh16okEgrqHpFrFUV3NTURO4VWAB3v3p7xp/Xc
         j5DA5s9+ro8UFgpiyQjQV57tEOSKPVr8LekLgk/OZcVTAFRFyDK6P152hDnS7/OJeGQl
         FrqcluT/D8ZCCU+wz4VCeah/rPynotwzKrVGaWgKtdyQT4bGPgNCmVMuAQraNggt0fGd
         IW8blAZCvCUzLVdoG3OZ6gHSePwK43Ewot2qGWVoWOam2SnA3b5MBNW2JNdq9EDtdHlz
         u07M0nPG1UZLKvMhLqvSdGzBuveA8n5FY1afFHvPWvRUvsWacS9OG5c6O2AZP13SA/6z
         zoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqhQoZDC7MFz94mqk6sQxq+J1Jy4fBaSrpD5HtvukHo=;
        b=ViAE0BsTaSg7ZJ2TUisB680CQxU4FOzNdBP8sdeBtT/VvmpQIzjusoHIfRDhtw5zQU
         wktMhMJ597TP7XAiqePndBQVgqn0a/LWygPJzVymzEA+o4Jq6DASQ4X3MhyjV2vrJ3rk
         xh0dWPuSPQG8EEuL9qTeSbe0G+wNVKWkvfwxQZK3POJ8FRVAzY57rgNxxm1g8Jur3dEZ
         R+t2EMlPVadUItpW98zHEH/OdvaLHMy6pMxdeAP4rYq6Xk6yONnlcZZH53R3hIFd8vXp
         jj7/o814iQIglycWniSRuUmdN/6D62gQjeyfhH5DGXQ3f0OGlJirZOwppHFcwfJ6gm3d
         8VGA==
X-Gm-Message-State: AOAM5321E+X3aWHoqdlxPKjefVrHrLsHsqONpYeNMjIayDEZDxyxGNZM
        cYgp+SsOM9pIAxabq2fJ2FjrYg==
X-Google-Smtp-Source: ABdhPJyxvbxrZPmj/KlN7YOo7aIh+a1ENMCrOndc7hi/C1Hq0/wMBwci1QNKvhWXJmcugaqCarl11g==
X-Received: by 2002:a63:7048:: with SMTP id a8mr5242227pgn.194.1621524758571;
        Thu, 20 May 2021 08:32:38 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id s3sm2298779pfu.9.2021.05.20.08.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:32:37 -0700 (PDT)
Date:   Thu, 20 May 2021 15:32:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Stefano De Venuto <stefano.devenuto99@gmail.com>
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        rostedt@goodmis.org, y.karadz@gmail.com,
        Dario Faggioli <dfaggioli@suse.com>
Subject: Re: [PATCH] Move VMEnter and VMExit tracepoints closer to the actual
 event
Message-ID: <YKaBEn6oUXaVAb0K@google.com>
References: <20210519182303.2790-1-stefano.devenuto99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519182303.2790-1-stefano.devenuto99@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021, Stefano De Venuto wrote:
> The kvm_entry and kvm_exit tracepoints are still quite far from the
> actual VMEnters/VMExits. This means that in a trace we can find host
> events after a kvm_entry event and before a kvm_exit one, as in this
> example:
> 
>            trace.dat:  CPU 0/KVM-4594  [001]  2.167191: kvm_entry:
>            trace.dat:  CPU 0/KVM-4594  [001]  2.167192: write_msr: 48, value 0
>            trace.dat:  CPU 0/KVM-4594  [001]  2.167192: rcu_utilization: Start context switch
>            trace.dat:  CPU 0/KVM-4594  [001]  2.167192: rcu_utilization: End context switch
> trace-tumbleweed.dat:     <idle>-0     [000]  2.167196: hrtimer_cancel:
> trace-tumbleweed.dat:     <idle>-0     [000]  2.167197: hrtimer_expire_entry:
> trace-tumbleweed.dat:     <idle>-0     [000]  2.167201: hrtimer_expire_exit:
> trace-tumbleweed.dat:     <idle>-0     [000]  2.167201: hrtimer_start:
>            trace.dat:  CPU 0/KVM-4594  [001]  2.167203: read_msr: 48, value 0
>            trace.dat:  CPU 0/KVM-4594  [001]  2.167203: write_msr: 48, value 4
>            trace.dat:  CPU 0/KVM-4594  [001]  2.167204: kvm_exit: 
> 
> This patch moves the tracepoints closer to the events, for both Intel
> and AMD, so that a combined host-guest trace will offer a more
> realistic representation of what is really happening, as shown here:
> 
>            trace.dat:  CPU 0/KVM-2553  [000]  2.190290: write_msr: 48, value 0

I'm not sure this is a good thing, as it's not clear to me that invoking tracing
with the guest's SPEC_CTRL loaded is desirable.  Maybe it's a non-issue, but it
should be explicitly called out and discussed.

And to some extent, the current behavior is _more_ accurate because it shows that
KVM started its VM-Enter sequence and then the WRMSR occured as part of that
sequence.  It is writing the guest's value after all.  Ditto for XCR0, XSS, PKRU,
Intel PT, etc...

A more concrete example would be perf; on VMX, if a perf NMI happens after KVM
invokes atomic_switch_perf_msrs() then I absolutely want to see that reflected
in the trace, e.g. to help debug the PEBS mess[*].  If the VM-Enter tracepoint
is moved closer to VM-Enter, that may or may not hold true depending on where the
NMI lands.

On VMX, I think the tracepoint can be moved below the VMWRITEs without much
contention (though doing so is likely a nop), but moving it below
kvm_load_guest_xsave_state() requires a bit more discussion.

I 100% agree that the current behavior can be a bit confusing, but I wonder if
we'd be better off "solving" that problem through documentation.

[*] https://lkml.kernel.org/r/20210209225653.1393771-1-jmattson@google.com

>            trace.dat:  CPU 0/KVM-2553  [000]  2.190290: rcu_utilization: Start context switch
>            trace.dat:  CPU 0/KVM-2553  [000]  2.190290: rcu_utilization: End context switch
>            trace.dat:  CPU 0/KVM-2553  [000]  2.190290: kvm_entry:
> trace-tumbleweed.dat:     <idle>-0     [000]  2.190290: write_msr:
> trace-tumbleweed.dat:     <idle>-0     [000]  2.190290: cpu_idle:
>            trace.dat:  CPU 0/KVM-2553  [000]  2.190291: kvm_exit:
>            trace.dat:  CPU 0/KVM-2553  [000]  2.190291: read_msr: 48, value 0
>            trace.dat:  CPU 0/KVM-2553  [000]  2.190291: write_msr: 48, value 4 
> 
> Signed-off-by: Stefano De Venuto <stefano.devenuto99@gmail.com>
> Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
> ---

...

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4bceb5ca3a89..33c732101b83 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6661,6 +6661,8 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  {
>  	kvm_guest_enter_irqoff();
>  
> +	trace_kvm_entry(vcpu);
> +
>  	/* L1D Flush includes CPU buffer clear to mitigate MDS */
>  	if (static_branch_unlikely(&vmx_l1d_should_flush))
>  		vmx_l1d_flush(vcpu);
> @@ -6675,6 +6677,9 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  
>  	vcpu->arch.cr2 = native_read_cr2();
>  
> +	vmx->exit_reason.full = vmcs_read32(VM_EXIT_REASON);
> +	trace_kvm_exit(vmx->exit_reason.full, vcpu, KVM_ISA_VMX);

This is wrong in the 'vmx->fail == true' case.

> +
>  	kvm_guest_exit_irqoff();
>  }
>  
> @@ -6693,8 +6698,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	if (vmx->emulation_required)
>  		return EXIT_FASTPATH_NONE;
>  
> -	trace_kvm_entry(vcpu);
> -
>  	if (vmx->ple_window_dirty) {
>  		vmx->ple_window_dirty = false;
>  		vmcs_write32(PLE_WINDOW, vmx->ple_window);
> @@ -6814,15 +6817,12 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  		return EXIT_FASTPATH_NONE;
>  	}
>  
> -	vmx->exit_reason.full = vmcs_read32(VM_EXIT_REASON);
>  	if (unlikely((u16)vmx->exit_reason.basic == EXIT_REASON_MCE_DURING_VMENTRY))
>  		kvm_machine_check();
>  
>  	if (likely(!vmx->exit_reason.failed_vmentry))
>  		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
>  
> -	trace_kvm_exit(vmx->exit_reason.full, vcpu, KVM_ISA_VMX);
> -
>  	if (unlikely(vmx->exit_reason.failed_vmentry))
>  		return EXIT_FASTPATH_NONE;
>  
> -- 
> 2.31.1
> 
