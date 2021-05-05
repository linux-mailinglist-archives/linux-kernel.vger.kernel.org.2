Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0AA3732EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhEEABN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhEEABJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:01:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22074C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 17:00:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620172811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZzghc/nFD5fYlTllIJmP+Dhcf+7hU/myWi1v8XwhJQ=;
        b=vMKVmOxlToHWiasA1xWm8XkYL9pNS3a2/LMx3puvPlQ+DBFhzwOw4Ibq45GXoeQnqcijfy
        QcQrG5es7NXabAQ2/ydHndSOAIf9c/8HHrR4msa99G6fJ0vyFWV+TiDUpqhuZLHEiaOLMh
        XbbBhF1DpPWf5YaiO/jX1WTqdH20bhf5JNe/aaM5biU756r+IPYV/UF7rOoFQKIKI7l87+
        eYYdhv7ftQe3vJP9NlvekkqiCSCUmWCsr3BLfKS9KwV0KFfmBpy8JWp6O18ts4+Yne0LUs
        2b1wLY4fXTs9yACR0q0VCS9IgxbKcR8po73nmTqJyIC0qruffit9CHbpgAIHwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620172811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZzghc/nFD5fYlTllIJmP+Dhcf+7hU/myWi1v8XwhJQ=;
        b=rbeivPGOq5d/U+dluGnKE5Rkrq/cG+JtQbDQ6zSoRhhEEthtRTy56a3XhL/cpCJswICAT2
        xtnAaGeXLf8ntGDg==
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
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
        Juergen Gross <JGross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
In-Reply-To: <5d7ca301-a0b2-d389-3bc2-feb304c9f5b5@redhat.com>
References: <YJG6ztbGjtuctec4@google.com> <38B9D60F-F24F-4910-B2DF-2A57F1060452@amacapital.net> <625057c7-ea40-4f37-8bea-cddecfe1b855@redhat.com> <YJHBxvR2mqsSX0pU@google.com> <5d7ca301-a0b2-d389-3bc2-feb304c9f5b5@redhat.com>
Date:   Wed, 05 May 2021 02:00:10 +0200
Message-ID: <87im3yhwxh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04 2021 at 23:56, Paolo Bonzini wrote:
> On 04/05/21 23:51, Sean Christopherson wrote:
>> On Tue, May 04, 2021, Paolo Bonzini wrote:
>>> On 04/05/21 23:23, Andy Lutomirski wrote:
>>>>> On May 4, 2021, at 2:21 PM, Sean Christopherson <seanjc@google.com> wrote:
>>>>> FWIW, NMIs are masked if the VM-Exit was due to an NMI.
>>>
>>> Huh, indeed:  "An NMI causes subsequent NMIs to be blocked, but only after
>>> the VM exit completes".
>>>
>>>> Then this whole change is busted, since nothing will unmask NMIs. Revert it?
>>> Looks like the easiest way out indeed.
>> 
>> I've no objection to reverting to intn, but what does reverting versus handling
>> NMI on the kernel stack have to do with NMIs being blocked on VM-Exit due to NMI?
>> I'm struggling mightily to connect the dots.
>
> Nah, you're right: vmx_do_interrupt_nmi_irqoff will not call the handler 
> directly, rather it calls the IDT entrypoint which *will* do an IRET and 
> unmask NMIs.  I trusted Andy too much on this one. :)
>
> Thomas's posted patch ("[PATCH] KVM/VMX: Invoke NMI non-IST entry 
> instead of IST entry") looks good.

Well, looks good is one thing.

It would be more helpful if someone would actually review and/or test it.

Thanks,

        tglx
