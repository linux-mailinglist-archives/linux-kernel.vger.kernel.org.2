Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A232337213A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhECUZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:25:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49542 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECUZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:25:13 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620073459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsGZRYcArR19w+OvKvYI7n69VdE3F0dhloZhD9EbYtQ=;
        b=IS5+Bth2WdBNR4eSFjR+CrYFV1/qm3j+qYmEd2CDPgXLR2jtfcBZLHw8afywxFUgwVvmae
        ZAgduX47sC1IEAHO7AjMWaqmpLvKKLjluwGnHonw/r8qPAVbs6SmL2dIkJ30ivKizCrsVr
        i5YOjN/RcWy/4f7mXiSrQ47vK+nCT+jeCp/8NT96mf2MhGKfPws+j9ayihm3s89U9MY1WT
        3z4AAOh3Fy/CEr87U/ps1HOiDS/xILj9++whwaETgNEFNwlyijCxykRV6XPmyhv36lxIZz
        7aOv/A7O0Fc91/TSApBvR1SiZsf3J0/WaP9pqIsPXTgH1IEy+BJf7fsWqVvBlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620073459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsGZRYcArR19w+OvKvYI7n69VdE3F0dhloZhD9EbYtQ=;
        b=58siPrzmJIsGA/K+cYyQwtXL1C4cv86iICU7U5QZ0Pee+S7F48tN0arODuwjoOCFHeAZLk
        AjIjWGUIruMvtVAQ==
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
In-Reply-To: <87bl9rk23k.ffs@nanos.tec.linutronix.de>
References: <20210426230949.3561-1-jiangshanlai@gmail.com> <20210426230949.3561-3-jiangshanlai@gmail.com> <87bl9rk23k.ffs@nanos.tec.linutronix.de>
Date:   Mon, 03 May 2021 22:24:18 +0200
Message-ID: <878s4vk1l9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03 2021 at 22:13, Thomas Gleixner wrote:

> On Tue, Apr 27 2021 at 07:09, Lai Jiangshan wrote:
>> + *
>> + * While the other entries for the exceptions which use Interrupt stacks can
>> + * be also used on the kernel stack, asm_exc_nmi() can not be used on the
>> + * kernel stack for it relies on the RSP-located "NMI executing" variable
>> + * which expects to on a fixed location in the NMI IST stack.  For early
>> + * booting stage, asm_noist_exc_nmi() is used for NMI.
>>   */
>>  static const __initconst struct idt_data def_idts[] = {
>>  	INTG(X86_TRAP_DE,		asm_exc_divide_error),
>> -	INTG(X86_TRAP_NMI,		asm_exc_nmi),
>> +	INTG(X86_TRAP_NMI,		asm_noist_exc_nmi),
>
> Actually this is a x86_64 only problem. The 32bit variant is fine, but
> for consistency there is no problem to have that extra entry point on
> 32bit as well.

Bah, no. This patch breaks 32bit because on 32bit nothing sets the entry
to asm_exc_nmi() later on.

Thanks,

        tglx
