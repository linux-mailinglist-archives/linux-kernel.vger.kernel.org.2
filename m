Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831D036F636
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhD3HPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229744AbhD3HPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619766869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=88zcHBIvkFYTLwFj8R82kvHFKJmjmnE4dPY/zw0a/o0=;
        b=ZfntUJi3eOl/hZGp0aJhKmJk8j81A1TDHhmoH8eQ3aaq8ZdJrCP79lwA+5hWvUx6JAt8H2
        NBxUS8ueBHS1DJ92DZAUBxhyCkANCGOkXQAl2F+s8zysnJQZLycvHWF8oZ0Fj9wn89GP++
        ltbbN76mrM1IQ/FN8AY7QzaTmpld6bM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-DwWAaNo0N5GNDw-zcdxi9A-1; Fri, 30 Apr 2021 03:14:27 -0400
X-MC-Unique: DwWAaNo0N5GNDw-zcdxi9A-1
Received: by mail-ej1-f69.google.com with SMTP id bx15-20020a170906a1cfb029037415131f28so14693267ejb.18
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=88zcHBIvkFYTLwFj8R82kvHFKJmjmnE4dPY/zw0a/o0=;
        b=lWyfEjGTmRgg/EClZiDXDMgqKlh/cAw7PzcTgF/TQXnAE/hZoEkWTnFmX+GlJrCn7O
         fE9SQ6V8WGGNtUfKZJUPj/82zdo+WE0kVzKMpAXrxXry8c5TIaB+bnLSMFUZCxbtjaED
         g/zI/a0iRv4hyTcHR80aDBEH+pj7qK32d+dj0O608TP6WwKlRLLAnQvB/H0ymvBY3csn
         0F2ro6lIJn1JsR2babSVaNdAZxaItojfWor1L3ciD+l6qnv8ErdX4fe/JLRHxa/qq8N3
         d4CDXU9sF1xFx7Y+bu7FRfcQI7KNYuJcPtw7EjWV7kidLQg8vsuVxjzDFDA+eJEu6QJX
         Jwvg==
X-Gm-Message-State: AOAM531DwXQNAeYJ70cPV2hGRL8L9xpRxl/YTmt29g8t2tN1RfPCF7Di
        gAmb4NLM+skOPPGW316OPSnSi8umy1KTYDpTRMuscZlnau0quvtWMlaSKsEMQr8So+aJgpNEShy
        5TOfSHl2DTNfb8BEXvCpthQKv
X-Received: by 2002:a50:fe03:: with SMTP id f3mr3981334edt.92.1619766865757;
        Fri, 30 Apr 2021 00:14:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkX5+0d05v5IY9ScipRTZGdRgvaqONdXqS9ZQ2Ai/Zcc7UxMAXTt3J9TbGGUsBNxv8PqJXNw==
X-Received: by 2002:a50:fe03:: with SMTP id f3mr3981317edt.92.1619766865577;
        Fri, 30 Apr 2021 00:14:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d18sm1402990eja.71.2021.04.30.00.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 00:14:24 -0700 (PDT)
Subject: Re: [PATCH 0/4] x86: Don't invoke asm_exc_nmi() on the kernel stack
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210426230949.3561-1-jiangshanlai@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <228d8b10-84cb-4dd2-8810-3c94bc3ae07b@redhat.com>
Date:   Fri, 30 Apr 2021 09:14:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210426230949.3561-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/21 01:09, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> In VMX, the NMI handler needs to be invoked after NMI VM-Exit.
> 
> Before the commit 1a5488ef0dcf6 ("KVM: VMX: Invoke NMI handler via
> indirect call instead of INTn"), the work is done by INTn ("int $2").
> 
> But INTn microcode is relatively expensive, so the commit reworked
> NMI VM-Exit handling to invoke the kernel handler by function call.
> And INTn doesn't set the NMI blocked flag required by the linux kernel
> NMI entry.  So moving away from INTn are very reasonable.
> 
> Yet some details were missed.  After the said commit applied, the NMI
> entry pointer is fetched from the IDT table and called from the kernel
> stack.  But the NMI entry pointer installed on the IDT table is
> asm_exc_nmi() which expects to be invoked on the IST stack by the ISA.
> And it relies on the "NMI executing" variable on the IST stack to work
> correctly.  When it is unexpectedly called from the kernel stack, the
> RSP-located "NMI executing" variable is also on the kernel stack and
> is "uninitialized" and can cause the NMI entry to run in the wrong way.
> 
> During fixing the problem for KVM, I found that there might be the same
> problem for early booting stage where the IST is not set up. asm_exc_nmi()
> is not allowed to be used in this stage for the same reason about
> the RSP-located "NMI executing" variable.
> 
> For both cases, we should use asm_noist_exc_nmi() which is introduced
> in the patch 1 via renaming from an existing asm_xenpv_exc_nmi() and
> which is safe on the kernel stack.
> 
> https://lore.kernel.org/lkml/20200915191505.10355-3-sean.j.christopherson@intel.com/

For the KVM part,

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: kvm@vger.kernel.org
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Lai Jiangshan (4):
>    x86/xen/entry: Rename xenpv_exc_nmi to noist_exc_nmi
>    x86/entry: Use asm_noist_exc_nmi() for NMI in early booting stage
>    KVM/VMX: Invoke NMI non-IST entry instead of IST entry
>    KVM/VMX: fold handle_interrupt_nmi_irqoff() into its solo caller
> 
>   arch/x86/include/asm/idtentry.h |  4 +---
>   arch/x86/kernel/idt.c           |  8 +++++++-
>   arch/x86/kernel/nmi.c           | 12 ++++++++++++
>   arch/x86/kvm/vmx/vmx.c          | 27 ++++++++++++++-------------
>   arch/x86/xen/enlighten_pv.c     |  9 +++------
>   arch/x86/xen/xen-asm.S          |  2 +-
>   6 files changed, 38 insertions(+), 24 deletions(-)
> 

