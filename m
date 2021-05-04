Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E617A372A46
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhEDMon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhEDMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:44:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B684C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 05:43:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620132225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BR3v2+p903dGyaTnMIq3ixCFpMkgOvkdYdpyOkK9gWA=;
        b=YGpYnDubeYG4hztg6Ab9SMmTMvPkQnJ+39Xc91UX1nvVlQRdSkpj6YLRaHf+ZSA9+AU72G
        gKfXtHbWoUDv5aB5S2E7vvewUGiz/F+h9a2ZEXre+KsKAhtadRFKCup5O/hzvksW0HRjGH
        rh3mPaT4kOyaX2ciYp1whIQXkshvinHoI+pvfVz+HSXcxPsa/PPOI/LoQsOj2+cgBZ/J8r
        8GUBpgEBftxyBbTrex3kgHJ9LgZmYy5HYw33rj14Ert4J4Gg4cS4sKPtswOMVhWJs9YhwW
        J1xt2Lmdkzm2tUv97S1z2u9ggh7ll2hOWx8DVllI8mY0jrTIHIdeR3ROpQrg4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620132225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BR3v2+p903dGyaTnMIq3ixCFpMkgOvkdYdpyOkK9gWA=;
        b=S1B4Qb8VmFFB8YO1vKikYM+tXoOcZz1BocPDW/Hx7/m2cG9qidy0SVZkSAV5eNpCQOJ2Oa
        WX+qTtFezIHDrNBQ==
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
In-Reply-To: <875yzzjxth.ffs@nanos.tec.linutronix.de>
References: <20210426230949.3561-1-jiangshanlai@gmail.com> <20210426230949.3561-3-jiangshanlai@gmail.com> <87bl9rk23k.ffs@nanos.tec.linutronix.de> <878s4vk1l9.ffs@nanos.tec.linutronix.de> <875yzzjxth.ffs@nanos.tec.linutronix.de>
Date:   Tue, 04 May 2021 14:43:44 +0200
Message-ID: <87wnseis8v.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03 2021 at 23:45, Thomas Gleixner wrote:
> The problem was introduced in 4.14 with b70543a0b2b6 ("x86/idt: Move
> regular trap init to tables").
>
> Before that trap_init() installed an IST gate right away, but looking
> deeper this was broken forever because there is a hen and egg problem.
>
> ISTs only work after TSS is initialized and the ordering here is:
>
> trap_init()
>   init_idt()
>   cpu_init()
>     init_tss()
>
> So the original code had a race window between init_idt() and
> init_tss(). Any IST using exception in that window goes south because
> TSS is not initialized.
>
> b70543a0b2b6 traded the above with that NMI issue. All other
> exceptions are fine...
>
> I'll think about it tomorrow some more...

It does not really matter which way around we do it. Even if we do that
noist dance then still any NMI hitting _before_ init_idt() is going to
lala land. So having this tiny step in between is more or less cosmetic.

And just for completness sake, I don't see a reason why we have to set
up the idt gates _before_ the TSS muck, i.e. before cpu_init().

The only thing cpu_init() needs working which is not installed in the
early_idt is #GP because some cpu init code uses rd/wrmsrl_safe(). But
that's pretty much all of it.

So this wants a proper cleanup and not some paper over it with an extra
step and I don't see a reason why any of this should be backported
simply because it does not matter at all whether the early idt which
only populates a few essential gates is active for a bit longer.

So what we need is a solution for that KVM wreckage but that can be
stand alone.

Thanks,

        tglx



