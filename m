Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD686372124
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhECUOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:14:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49466 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhECUOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:14:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620072800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5dt413OG5UBuq7D1Ux9Dz7fYEHc+6pjoGZB3RR2ob4=;
        b=kdUS0xnWESVKAut0MPBjD7qye+6DRoZBbCBUxDFUEnQcKvyT2pAnO/0vdfsQVVKUflWFFO
        CVxhydqrjH0PncmvuIOcRZSpx1S1KtKaQGR1P2ut7nYD+U6Irksey2gd52eveEBLQTRG2e
        bBVGbdakONF6YW7ZzJ/mDZ23F3JnyrU7c95YerJoXFoblxjn5b/LBos1+YVjfklduUbEjH
        pe1z3RMpE8C6b5rFLFSSzK7i4TmQijwvpwGFwk1wVrQCJpch7hSmKC00vWMPq38tGowPJa
        uKdBq03H4CtlOO5GRVwI4f5UN4CFGdAUqz+7daGyobdW49tHuD+viAxauYh/YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620072800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5dt413OG5UBuq7D1Ux9Dz7fYEHc+6pjoGZB3RR2ob4=;
        b=+NjQp1RX5P3qaNVDC2GdlgSCwy+Sr6riwakcMh4rAIaY31/+ZdJfmBrZFZvldeUZ2rVQP2
        NjDYLkx7V+e/lpDQ==
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
In-Reply-To: <20210426230949.3561-3-jiangshanlai@gmail.com>
References: <20210426230949.3561-1-jiangshanlai@gmail.com> <20210426230949.3561-3-jiangshanlai@gmail.com>
Date:   Mon, 03 May 2021 22:13:19 +0200
Message-ID: <87bl9rk23k.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27 2021 at 07:09, Lai Jiangshan wrote:
> + *
> + * While the other entries for the exceptions which use Interrupt stacks can
> + * be also used on the kernel stack, asm_exc_nmi() can not be used on the
> + * kernel stack for it relies on the RSP-located "NMI executing" variable
> + * which expects to on a fixed location in the NMI IST stack.  For early
> + * booting stage, asm_noist_exc_nmi() is used for NMI.
>   */
>  static const __initconst struct idt_data def_idts[] = {
>  	INTG(X86_TRAP_DE,		asm_exc_divide_error),
> -	INTG(X86_TRAP_NMI,		asm_exc_nmi),
> +	INTG(X86_TRAP_NMI,		asm_noist_exc_nmi),

Actually this is a x86_64 only problem. The 32bit variant is fine, but
for consistency there is no problem to have that extra entry point on
32bit as well.

Thanks,

        tglx
