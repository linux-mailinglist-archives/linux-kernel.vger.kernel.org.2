Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824F93731BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhEDVGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231445AbhEDVGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620162321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tw5bUCxCEUnsK4TGbmp0IiG4sv1v1/1xZqECKOsN3Pc=;
        b=RQ2GtrR5hS52NcGpAvCK/kMhO8XwJ/NXgSqCGVe1rvzL7aXLaP0vHmSX8aNEFhzpXNGr0x
        4kZ/EG0Oo8pBx+1lykpQl0Q9Uz+d/hfj6iJ878v+GlarD226sa6jVFqE2s4xvZsffyL1Ni
        1zqPe5G2Xv1qmUD7G0TXVoCXbEWX4DU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-68PeW4BmNlubyJRO_mIYuA-1; Tue, 04 May 2021 17:05:19 -0400
X-MC-Unique: 68PeW4BmNlubyJRO_mIYuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B00A8049ED;
        Tue,  4 May 2021 21:05:17 +0000 (UTC)
Received: from starship (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFD2B60C5A;
        Tue,  4 May 2021 21:05:10 +0000 (UTC)
Message-ID: <44e20d7cdbf0ffdb7d9dce7d480f86a6f14d16c1.camel@redhat.com>
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
Date:   Wed, 05 May 2021 00:05:09 +0300
In-Reply-To: <87r1imi8i1.ffs@nanos.tec.linutronix.de>
References: <20210426230949.3561-1-jiangshanlai@gmail.com>
         <20210426230949.3561-3-jiangshanlai@gmail.com>
         <87bl9rk23k.ffs@nanos.tec.linutronix.de>
         <878s4vk1l9.ffs@nanos.tec.linutronix.de>
         <875yzzjxth.ffs@nanos.tec.linutronix.de>
         <87wnseis8v.ffs@nanos.tec.linutronix.de>
         <87r1imi8i1.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-05-04 at 21:50 +0200, Thomas Gleixner wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> In VMX, the host NMI handler needs to be invoked after NMI VM-Exit.
> Before commit 1a5488ef0dcf6 ("KVM: VMX: Invoke NMI handler via indirect
> call instead of INTn"), this was done by INTn ("int $2"). But INTn
> microcode is relatively expensive, so the commit reworked NMI VM-Exit
> handling to invoke the kernel handler by function call.
> 
> But this missed a detail. The NMI entry point for direct invocation is
> fetched from the IDT table and called on the kernel stack.  But on 64-bit
> the NMI entry installed in the IDT expects to be invoked on the IST stack.
> It relies on the "NMI executing" variable on the IST stack to work
> correctly, which is at a fixed position in the IST stack.  When the entry
> point is unexpectedly called on the kernel stack, the RSP-addressed "NMI
> executing" variable is obviously also on the kernel stack and is
> "uninitialized" and can cause the NMI entry code to run in the wrong way.
> 
> Provide a non-ist entry point for VMX which shares the C-function with
> the regular NMI entry and invoke the new asm entry point instead.

I haven't followed this closely, so this was probably already discussed,
but anyway, do I understand correctly that while the NMI handler that was
invoked from VMX code, another NMI arrives, 
they won't share the stacks (one uses IST and other doesn't) and thus
the prevention of NMI nesting wont be activated?

Does this mean that we still rely on hardware NMI masking to be activated?

Or in other words, that is we still can't have an IRET between VM exit and 
the entry to the NMI handler?

Best regards,
	Maxim Levitsky

> 
> On 32-bit this just maps to the regular NMI entry point as 32-bit has no
> ISTs and is not affected.
> 
> [ tglx: Made it independent for backporting, massaged changelog ]
> 
> Fixes: 1a5488ef0dcf6 ("KVM: VMX: Invoke NMI handler via indirect call instead of INTn")
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
> 
> Note: That's the minimal fix which needs to be backported and the other
>       stuff is cleanup material on top for 5.14.
> 
> ---
>  arch/x86/include/asm/idtentry.h |   15 +++++++++++++++
>  arch/x86/kernel/nmi.c           |   10 ++++++++++
>  arch/x86/kvm/vmx/vmx.c          |   16 +++++++++-------
>  3 files changed, 34 insertions(+), 7 deletions(-)
> 
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -588,6 +588,21 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_MC,	xenpv_
>  #endif
>  
>  /* NMI */
> +
> +#if defined(CONFIG_X86_64) && IS_ENABLED(CONFIG_KVM_INTEL)
> +/*
> + * Special NOIST entry point for VMX which invokes this on the kernel
> + * stack. asm_exc_nmi() requires an IST to work correctly vs. the NMI
> + * 'executing' marker.
> + *
> + * On 32bit this just uses the regular NMI entry point because 32-bit does
> + * not have ISTs.
> + */
> +DECLARE_IDTENTRY(X86_TRAP_NMI,		exc_nmi_noist);
> +#else
> +#define asm_exc_nmi_noist		asm_exc_nmi
> +#endif
> +
>  DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
>  #ifdef CONFIG_XEN_PV
>  DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -524,6 +524,16 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
>  		mds_user_clear_cpu_buffers();
>  }
>  
> +#if defined(CONFIG_X86_64) && IS_ENABLED(CONFIG_KVM_INTEL)
> +DEFINE_IDTENTRY_RAW(exc_nmi_noist)
> +{
> +	exc_nmi(regs);
> +}
> +#endif
> +#if IS_MODULE(CONFIG_KVM_INTEL)
> +EXPORT_SYMBOL_GPL(asm_exc_nmi_noist);
> +#endif
> +
>  void stop_nmi(void)
>  {
>  	ignore_nmis++;
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -36,6 +36,7 @@
>  #include <asm/debugreg.h>
>  #include <asm/desc.h>
>  #include <asm/fpu/internal.h>
> +#include <asm/idtentry.h>
>  #include <asm/io.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/kexec.h>
> @@ -6415,18 +6416,17 @@ static void vmx_apicv_post_state_restore
>  
>  void vmx_do_interrupt_nmi_irqoff(unsigned long entry);
>  
> -static void handle_interrupt_nmi_irqoff(struct kvm_vcpu *vcpu, u32 intr_info)
> +static void handle_interrupt_nmi_irqoff(struct kvm_vcpu *vcpu,
> +					unsigned long entry)
>  {
> -	unsigned int vector = intr_info & INTR_INFO_VECTOR_MASK;
> -	gate_desc *desc = (gate_desc *)host_idt_base + vector;
> -
>  	kvm_before_interrupt(vcpu);
> -	vmx_do_interrupt_nmi_irqoff(gate_offset(desc));
> +	vmx_do_interrupt_nmi_irqoff(entry);
>  	kvm_after_interrupt(vcpu);
>  }
>  
>  static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
>  {
> +	const unsigned long nmi_entry = (unsigned long)asm_exc_nmi_noist;
>  	u32 intr_info = vmx_get_intr_info(&vmx->vcpu);
>  
>  	/* if exit due to PF check for async PF */
> @@ -6437,18 +6437,20 @@ static void handle_exception_nmi_irqoff(
>  		kvm_machine_check();
>  	/* We need to handle NMIs before interrupts are enabled */
>  	else if (is_nmi(intr_info))
> -		handle_interrupt_nmi_irqoff(&vmx->vcpu, intr_info);
> +		handle_interrupt_nmi_irqoff(&vmx->vcpu, nmi_entry);
>  }
>  
>  static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
>  {
>  	u32 intr_info = vmx_get_intr_info(vcpu);
> +	unsigned int vector = intr_info & INTR_INFO_VECTOR_MASK;
> +	gate_desc *desc = (gate_desc *)host_idt_base + vector;
>  
>  	if (WARN_ONCE(!is_external_intr(intr_info),
>  	    "KVM: unexpected VM-Exit interrupt info: 0x%x", intr_info))
>  		return;
>  
> -	handle_interrupt_nmi_irqoff(vcpu, intr_info);
> +	handle_interrupt_nmi_irqoff(vcpu, gate_offset(desc));
>  }
>  
>  static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
> 


