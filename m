Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72DB3D0F01
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhGUMFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:05:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46876 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhGUMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:05:40 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626871576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cdS1buxKYZqBBBQSENm52Z2BdiL5OnJduLY+Z3jB0eY=;
        b=19cTuzozpKz2m6yusdcjCowUC++mkWqLuMbFOlmc71QS6OURW5sQ6dio/NqnOtRZeXzL1/
        +sm52j62lmS4IzDSo2BJ19dqnWgssdXP5w8YxJXYiz2iWB/PXPeKvROVkwxP3thsSMyLrq
        vT5nJSVsl7l2xwbIcYE0ziUAViZLIVMnn7Cy7ZRhf1oaWPR3QimBaa0uM14kHH8ZSeB7iM
        YT/keUdJIe8LfMBpy7OMPwJ7QSb0mSLKRvhhKG7MYtwtJ0Ti9B0svmKRRP7jxfhIoXoSuX
        GycPdi8THSadrxXzDb/uC2gEGFUhul2oHeGVLPHLgTUFTx4wwdBN6U+SJUqNHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626871576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cdS1buxKYZqBBBQSENm52Z2BdiL5OnJduLY+Z3jB0eY=;
        b=Q3q0I7J1FXSbLrOv/qmQ4GnglOnFnnEdRZSKWXYKU6ktHo5Y2/FmNqCrN5Gn0IA5Cxbouu
        CMBE6+4XHA57LkDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Wolfram Sang \(Renesas\)" <wsa+renesas@sang-engineering.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongwei Song <sxwjean@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Vipin Sharma <vipinsh@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH printk v4 4/6] printk: remove NMI tracking
In-Reply-To: <20210721120026.y3dqno24ahw4sazy@pathway.suse.cz>
References: <20210715193359.25946-1-john.ogness@linutronix.de> <20210715193359.25946-5-john.ogness@linutronix.de> <20210721120026.y3dqno24ahw4sazy@pathway.suse.cz>
Date:   Wed, 21 Jul 2021 14:52:15 +0206
Message-ID: <877dhjygvc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-21, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -9647,7 +9647,7 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
>>  	tracing_off();
>>  
>>  	local_irq_save(flags);
>> -	printk_nmi_direct_enter();
>> +	printk_deferred_enter();
>
> I would prefer to do not manipulate the printk context here anymore,
> as it was done in v3.
>
> printk_nmi_direct_enter() was added here by the commit the commit
> 03fc7f9c99c1e7ae2925d4 ("printk/nmi: Prevent deadlock when
> accessing the main log buffer in NMI"). It was _not_ about console
> handling. The reason was to modify the default behavior under NMI
> and store the messages directly into the main log buffer.
>
> When I think about it. The original fix was not correct. We should have
> modified the context only when ftrace_dump() was really called under NMI:
>
> 	if (in_nmi())
> 		printk_nmi_direct_enter();
>
> By other words. We should try to show the messages on the console
> when ftrace_dump()/panic() is not called from NMI. It will help
> to see all messages even when the ftrace buffers are bigger
> than printk() ones.
>
> And we do not need any special handling here for NMI. vprintk()
> in printk/printk_safe.c will do the right thing for us.

Agreed. We need to mention this behavior change in the commit
message. Perhaps this as the commit message:

All NMI contexts are handled the same as the safe context: store the
message and defer printing. There is no need to have special NMI
context tracking for this. Using in_nmi() is enough.

There are several parts of the kernel that are manually calling into
the printk NMI context tracking in order to cause general printk
deferred printing:

    arch/arm/kernel/smp.c
    arch/powerpc/kexec/crash.c
    kernel/trace/trace.c

For arm/kernel/smp.c and powerpc/kexec/crash.c, provide a new
function pair printk_deferred_enter/exit that explicitly achieves the
same objective.

For ftrace, remove general printk deferring. This general deferrment
was added in commit 03fc7f9c99c1 ("printk/nmi: Prevent deadlock when
accessing the main log buffer in NMI"), but really should have only
been deferred when in NMI context. Since vprintk() now checks for
NMI context when deciding to defer, ftrace does not need any special
handling.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
