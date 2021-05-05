Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE3373ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 17:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhEEPpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 11:45:53 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60185 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233466AbhEEPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 11:45:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0UXoki5R_1620229489;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UXoki5R_1620229489)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 May 2021 23:44:50 +0800
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
To:     Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
        Juergen Gross <JGross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
References: <YJG6ztbGjtuctec4@google.com>
 <38B9D60F-F24F-4910-B2DF-2A57F1060452@amacapital.net>
 <625057c7-ea40-4f37-8bea-cddecfe1b855@redhat.com>
 <YJHBxvR2mqsSX0pU@google.com>
 <5d7ca301-a0b2-d389-3bc2-feb304c9f5b5@redhat.com>
 <87im3yhwxh.ffs@nanos.tec.linutronix.de>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <91013efa-da53-2a3a-0e65-1ddb4318cb70@linux.alibaba.com>
Date:   Wed, 5 May 2021 23:44:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87im3yhwxh.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/5 08:00, Thomas Gleixner wrote:
> On Tue, May 04 2021 at 23:56, Paolo Bonzini wrote:
>> On 04/05/21 23:51, Sean Christopherson wrote:
>>> On Tue, May 04, 2021, Paolo Bonzini wrote:
>>>> On 04/05/21 23:23, Andy Lutomirski wrote:
>>>>>> On May 4, 2021, at 2:21 PM, Sean Christopherson <seanjc@google.com> wrote:
>>>>>> FWIW, NMIs are masked if the VM-Exit was due to an NMI.
>>>>
>>>> Huh, indeed:  "An NMI causes subsequent NMIs to be blocked, but only after
>>>> the VM exit completes".
>>>>
>>>>> Then this whole change is busted, since nothing will unmask NMIs. Revert it?
>>>> Looks like the easiest way out indeed.
>>>
>>> I've no objection to reverting to intn, but what does reverting versus handling
>>> NMI on the kernel stack have to do with NMIs being blocked on VM-Exit due to NMI?
>>> I'm struggling mightily to connect the dots.
>>
>> Nah, you're right: vmx_do_interrupt_nmi_irqoff will not call the handler
>> directly, rather it calls the IDT entrypoint which *will* do an IRET and
>> unmask NMIs.  I trusted Andy too much on this one. :)
>>
>> Thomas's posted patch ("[PATCH] KVM/VMX: Invoke NMI non-IST entry
>> instead of IST entry") looks good.
> 
> Well, looks good is one thing.
> 
> It would be more helpful if someone would actually review and/or test it.
> 
> Thanks,
> 
>          tglx
> 

I tested it with the following testing-patch applied, it shows that the
problem is fixed.

The only one line of code in vmenter.S in the testing-patch just emulates
the situation that a "uninitialized" garbage in the kernel stack happens
to be 1 and it happens to be at the same location of the RSP-located
"NMI executing" variable.


First round:
# apply the testing-patch
# perf record events of a vm which does kbuild inside
# dmesg shows that there are the same number of "kvm nmi" and "kvm nmi miss"
It shows that the problem exists with regard to the invocation of the NMI
handler.

Second Round:
# apply the fix from tglx
# apply the testing-patch
# perf record events of a vm which does kbuild inside
# dmesg shows that there are some "kvm nmi" but no "kvm nmi miss".
It shows that the problem is fixed.


diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 3a6461694fc2..32096049c2a2 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -316,6 +316,7 @@ SYM_FUNC_START(vmx_do_interrupt_nmi_irqoff)
  #endif
  	pushf
  	push $__KERNEL_CS
+	movq $1, -24(%rsp) // "NMI executing": 1 = nested, non-1 = not-nested
  	CALL_NOSPEC _ASM_ARG1

  	/*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8586eca349a9..eefd22d22fce 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6439,8 +6439,17 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)

  	if (vmx->exit_reason.basic == EXIT_REASON_EXTERNAL_INTERRUPT)
  		handle_external_interrupt_irqoff(vcpu);
-	else if (vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI)
+	else if (vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI) {
+		unsigned long count = this_cpu_read(irq_stat.__nmi_count);
+
  		handle_exception_nmi_irqoff(vmx);
+
+		if (is_nmi(vmx_get_intr_info(&vmx->vcpu))) {
+			pr_info("kvm nmi\n");
+			if (count == this_cpu_read(irq_stat.__nmi_count))
+				pr_info("kvm nmi miss\n");
+		}
+	}
  }

  /*

