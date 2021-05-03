Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACA23722A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhECVqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 17:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECVqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 17:46:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB67C061573
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 14:45:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620078347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t+Ejisuprx3ftvApEGME3UjjFrRg0Y/XsNzoTrxyrjc=;
        b=iOe48t54REAGqSrJRAGkrI+yYSEISLaj08uZLiwgyReAWrsa6dizN8NF4pfciBqN4Lh5wo
        36mlOUAcWY2mHTfu8tFn+D49GvfSX+bDf6sk0P2KDTyyd0YOAErCJUz3YSc++ZG9g5LvIV
        ihyuZF3kL+n6OI3A8wB6/nMjJVMTvkuvDGcKgn+/gENwCDSct4A5Yp8pAwUQpKDAK/sFkV
        oAx9kqpMXe2mU8zQ8FfhxwrPgcld+Gftrq8Z8uTmtnuU04I1fDios0TVaUrqpt9iC79Jvn
        sdsxdZ5MroGIW547Oi85MoSt7rGgTaCfPXz6erbt/PbOvhF/ng1WmJxIOFeKiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620078347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t+Ejisuprx3ftvApEGME3UjjFrRg0Y/XsNzoTrxyrjc=;
        b=ooXX7KoKAYQexcdNU7peIHJLnbkpGYDjWxBCqUH7xy5NA0c4bvtuVFYRslHPG9HcTMxTXq
        8Ypk1vYoX1R4YeAA==
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
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
        Maxim Levitsky <mlevitsk@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
Subject: Re: [PATCH 2/4] x86/entry: Use asm_noist_exc_nmi() for NMI in early booting stage
In-Reply-To: <878s4vk1l9.ffs@nanos.tec.linutronix.de>
References: <20210426230949.3561-1-jiangshanlai@gmail.com> <20210426230949.3561-3-jiangshanlai@gmail.com> <87bl9rk23k.ffs@nanos.tec.linutronix.de> <878s4vk1l9.ffs@nanos.tec.linutronix.de>
Date:   Mon, 03 May 2021 23:45:46 +0200
Message-ID: <875yzzjxth.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03 2021 at 22:24, Thomas Gleixner wrote:

> On Mon, May 03 2021 at 22:13, Thomas Gleixner wrote:
>
>> On Tue, Apr 27 2021 at 07:09, Lai Jiangshan wrote:
>>> + *
>>> + * While the other entries for the exceptions which use Interrupt stacks can
>>> + * be also used on the kernel stack, asm_exc_nmi() can not be used on the
>>> + * kernel stack for it relies on the RSP-located "NMI executing" variable
>>> + * which expects to on a fixed location in the NMI IST stack.  For early
>>> + * booting stage, asm_noist_exc_nmi() is used for NMI.
>>>   */
>>>  static const __initconst struct idt_data def_idts[] = {
>>>  	INTG(X86_TRAP_DE,		asm_exc_divide_error),
>>> -	INTG(X86_TRAP_NMI,		asm_exc_nmi),
>>> +	INTG(X86_TRAP_NMI,		asm_noist_exc_nmi),
>>
>> Actually this is a x86_64 only problem. The 32bit variant is fine, but
>> for consistency there is no problem to have that extra entry point on
>> 32bit as well.
>
> Bah, no. This patch breaks 32bit because on 32bit nothing sets the entry
> to asm_exc_nmi() later on.

Sigh. Finding a fixes tag for this is complicated.

The problem was introduced in 4.14 with b70543a0b2b6 ("x86/idt: Move
regular trap init to tables").

Before that trap_init() installed an IST gate right away, but looking
deeper this was broken forever because there is a hen and egg problem.

ISTs only work after TSS is initialized and the ordering here is:

trap_init()
  init_idt()
  cpu_init()
    init_tss()

So the original code had a race window between init_idt() and
init_tss(). Any IST using exception in that window goes south because
TSS is not initialized.

b70543a0b2b6 traded the above with that NMI issue. All other
exceptions are fine...

I'll think about it tomorrow some more...

