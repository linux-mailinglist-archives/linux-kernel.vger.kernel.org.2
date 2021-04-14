Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2564F35F95C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352098AbhDNQ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351943AbhDNQ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618419537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooXI1eqVI95Q8agxrgrGK6HyUbaEXdlmhBwbh9iOSPc=;
        b=JGC028N94ajlKOi2oMyf7s38w914MoY32FKzRwYv9VwHAunVhdaFy6qOtjrf/ddLJL+t60
        sk4wWxzVWraH3dsvPRcTV1z0ivXBHVWACupXAQhnDIxAfV6IYKwPCzjMf4BZC++jyGLzeV
        o307O6CJvVFD+JblhRGEP9C+7Do+eCg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-rnzmsd85MJugSW-cBj4twA-1; Wed, 14 Apr 2021 12:58:55 -0400
X-MC-Unique: rnzmsd85MJugSW-cBj4twA-1
Received: by mail-ej1-f72.google.com with SMTP id lf6-20020a1709071746b029037cee5e31c4so5272ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ooXI1eqVI95Q8agxrgrGK6HyUbaEXdlmhBwbh9iOSPc=;
        b=TZreL7agfmbVLYcenA4kO7Le+sD1Fxnfjro+LHgltYJxH67W5dud1SJ3bYcbWof+9l
         7+tnLmfe3s/k0Ou6rIZ+oNoX3JGxSnld5y2EnjwsBGCYJNRS0fli4/sXxNtMKnD7xpQy
         rglZqJTCs5WfVxukTPCGqflN2CSNiO5bEEPAdGGSmInNs2WbBV/OSLFT9sUhJh2vAn0C
         K8eXAvzo2Y0yKgirHnyIpIuLghGekNMd/934fR0FZLzsYDhiX82DCkf0XxR5uvnmiFjs
         xMUKTnpYALfMYtZp3Dxrl5BFhORi9NIRrTs9hGjS2/YJMZ+KTrJ4bJlhhpGbPJKnCFd0
         XFVw==
X-Gm-Message-State: AOAM5322tkXIQfXXi30doRie0x9dDiF1SzVNaVi+fOWjfPFpfK9wxf1G
        WzpG2lZIVc5PT4MJIy7ZDUuTZ+tsK2eAMyyHkjkCiiScov4IktwmowNmcUIwc9bhf6nNPCaPm14
        hVA0DcK+SG3u4SQKJRRtuxSWk
X-Received: by 2002:a17:906:dfcc:: with SMTP id jt12mr38750477ejc.31.1618419533540;
        Wed, 14 Apr 2021 09:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzglppX4vTDWi8afiyN//7wxayw8/3KRKxeYiLKD51km0RS+4CNwUBbDvmhvHue1DXL1Xpjcw==
X-Received: by 2002:a17:906:dfcc:: with SMTP id jt12mr38750460ejc.31.1618419533368;
        Wed, 14 Apr 2021 09:58:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id a22sm140361edu.14.2021.04.14.09.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 09:58:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86: Fix split-irqchip vs interrupt injection
 window request
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Filippo Sironi <sironi@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "v4.7+" <stable@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20201127112114.3219360-1-pbonzini@redhat.com>
 <20201127112114.3219360-3-pbonzini@redhat.com>
 <CAJhGHyCdqgtvK98_KieG-8MUfg1Jghd+H99q+FkgL0ZuqnvuAw@mail.gmail.com>
 <YHS/BxMiO6I1VOEY@google.com>
 <CAJhGHyAcnwkCfTcnxXcgAHnF=wPbH2EDp7H+e74ce+oNOWJ=_Q@mail.gmail.com>
 <80b013dc-0078-76f4-1299-3cff261ef7d8@redhat.com>
 <CAJhGHyChfXdcAMzzD7P3aC8tnhFW5GvOt88vOY=D3pyb7hgNAA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d9dafb1-b8ff-82ef-93dc-da869fe7ba0f@redhat.com>
Date:   Wed, 14 Apr 2021 18:58:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJhGHyChfXdcAMzzD7P3aC8tnhFW5GvOt88vOY=D3pyb7hgNAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/21 04:28, Lai Jiangshan wrote:
> On Tue, Apr 13, 2021 at 8:15 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 13/04/21 13:03, Lai Jiangshan wrote:
>>> This patch claims that it has a place to
>>> stash the IRQ when EFLAGS.IF=0, but inject_pending_event() seams to ignore
>>> EFLAGS.IF and queues the IRQ to the guest directly in the first branch
>>> of using "kvm_x86_ops.set_irq(vcpu)".
>>
>> This is only true for pure-userspace irqchip.  For split-irqchip, in
>> which case the "place to stash" the interrupt is
>> vcpu->arch.pending_external_vector.
>>
>> For pure-userspace irqchip, KVM_INTERRUPT only cares about being able to
>> stash the interrupt in vcpu->arch.interrupt.injected.  It is indeed
>> wrong for userspace to call KVM_INTERRUPT if the vCPU is not ready for
>> interrupt injection, but KVM_INTERRUPT does not return an error.
> 
> Thanks for the reply.
> 
> May I ask what is the correct/practical way of using KVM_INTERRUPT ABI
> for pure-userspace irqchip.
> 
> gVisor is indeed a pure-userspace irqchip, it will call KVM_INTERRUPT
> when kvm_run->ready_for_interrupt_injection=1 (along with other conditions
> unrelated to our discussion).
> 
> https://github.com/google/gvisor/blob/a9441aea2780da8c93da1c73da860219f98438de/pkg/sentry/platform/kvm/bluepill_amd64_unsafe.go#L105
> 
> if kvm_run->ready_for_interrupt_injection=1 when expection pending or
> EFLAGS.IF=0, it would be unexpected for gVisor.

Not with EFLAGS.IF=0.  For pending exception, there is code to handle it 
in inject_pending_event:

         ... if (!vcpu->arch.exception.pending) {
                 if (vcpu->arch.nmi_injected) {
                         static_call(kvm_x86_set_nmi)(vcpu);
                         can_inject = false;
                 } else if (vcpu->arch.interrupt.injected) {
                         static_call(kvm_x86_set_irq)(vcpu);
                         can_inject = false;
                 }
         }
	...
         if (vcpu->arch.exception.pending) {
		...
                 can_inject = false;
         }
	// this is vcpu->arch.interrupt.injected for userspace LAPIC
         if (kvm_cpu_has_injectable_intr(vcpu)) {
                 r = can_inject ? 
static_call(kvm_x86_interrupt_allowed)(vcpu, true) : -EBUSY;
		if (r < 0)
			goto busy;
		...
	}

so what happens is:

- the interrupt will not be injected before the exception

- KVM will schedule an immediate vmexit to inject the interrupt as well

- if (as is likely) the exception has turned off interrupts, the next 
call to inject_pending_event will reach 
static_call(kvm_x86_enable_irq_window) and the interrupt will only be 
injected when IF becomes 1 again.

Paolo

