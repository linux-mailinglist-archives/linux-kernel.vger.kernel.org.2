Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DECA429746
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 21:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhJKTIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhJKTIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:08:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8D0C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:06:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j5so77788203lfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bN6YNtOkrJhX2wwbUhuBUfzLucgwzma4xrj6nI0TWSQ=;
        b=Z9/iK3pqXdjZEqc2+ndmdywirvsyYqcMZRmCckcGfICXHyeToASrW6q7MFUH7+d9ts
         gG8I/ObD1cIsszHAXc+6VpuyMixitWB2eieQcYH/PYEMXbeCctwsAqSf1INSBCiepPMA
         zI8DNEtuyV6istdlBI0wB1RD3pM+SPlkOK1+7Uqi7PqDIXBCdxosL9JV8oFQGUBBlQxB
         QZGrqwLGKmNhMUKp5uCRPE0w4oSAJHGrdz7SG8hbLXvap6B8Mdk/7ZlLkFAN60j5wQXJ
         TNUCymMt9Gxr0+j5qHbg49+6CZlivk3G7iHuTY6xbl3lhcJ0P2W6R74qBdnV/wtbKqpS
         BTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bN6YNtOkrJhX2wwbUhuBUfzLucgwzma4xrj6nI0TWSQ=;
        b=F6mqz2hOB6+4QqU1YmbVHgeor1+WoE30NfHqevMiYp873eRgEXarRbRp+rRXEK6oUA
         FMI4/Oj5fZ8PCOw+ba+4trFtDm6ha6uERVmI4l2GUA48MTEJdAwTbpU2xXkEJhSHOHsk
         lZIZfDfQ/dyzVD2X5HZpv+3WRfcl+c9TM9ePY7Z9L24/niYEaAtjz7ejW/vdKuXEKsR+
         6qLDK+2dHsLHKYPTiVLoVJh9Z/XjwgFlccCeDDFBw0WM3lcxAtNmA6orxiwbC4XYgJ49
         3Z0Q+hWeNnp88mVqD0p9Mvnht2cPWHNTjbNqGDN02f4EfZSHX/itvN/ayROquN27EGXq
         r4mQ==
X-Gm-Message-State: AOAM530O8zpsUqgNrXIize3f1Pj4LfP6SOlLsQSj+u+U5obiSjzArC+6
        1Oo98p+EFVgKbEiNCbQwzCbfnMhfffxfmK8LCVpfKg==
X-Google-Smtp-Source: ABdhPJz8B0z5OxxuNF7iOezND3W6urCP638newduN0O2VzTNMBFa+rVWj1l9M2XBeb/OqjVxGdGRFdSxfUSqps76RKk=
X-Received: by 2002:a05:6512:b0c:: with SMTP id w12mr30160122lfu.240.1633979205128;
 Mon, 11 Oct 2021 12:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <163369609308.636038.15295764725220907794.stgit@devnote2> <163369615714.636038.1154348556499203165.stgit@devnote2>
In-Reply-To: <163369615714.636038.1154348556499203165.stgit@devnote2>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Oct 2021 12:06:32 -0700
Message-ID: <CAKwvOd=n_nUhqmVvy17tR0ZKSwFU76uzvcGu_t3LEvOA4OdO2Q@mail.gmail.com>
Subject: Re: [PATCH 7/8] ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 5:29 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Currently kretprobe on ARM just fills r0-r11 of pt_regs, but
> that is not enough for the stacktrace. Moreover, from the user
> kretprobe handler, stacktrace needs a frame pointer on the
> __kretprobe_trampoline.
>
> This adds a frame pointer on __kretprobe_trampoline for both gcc
> and clang case. Those have different frame pointer so we need
> different but similar stack on pt_regs.
>
> Gcc makes the frame pointer (fp) to point the 'pc' address of
> the {fp, ip (=sp), lr, pc}, this means {r11, r13, r14, r15}.
> Thus if we save the r11 (fp) on pt_regs->r12, we can make this
> set on the end of pt_regs.
>
> On the other hand, Clang makes the frame pointer to point the
> 'fp' address of {fp, lr} on stack. Since the next to the
> pt_regs->lr is pt_regs->sp, I reused the pair of pt_regs->fp
> and pt_regs->ip.
> So this stores the 'lr' on pt_regs->ip and make the fp to point
> pt_regs->fp.
>
> For both cases, saves __kretprobe_trampoline address to
> pt_regs->lr, so that the stack tracer can identify this frame
> pointer has been made by the __kretprobe_trampoline.
>
> Note that if the CONFIG_FRAME_POINTER is not set, this keeps
> fp as is.
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm/probes/kprobes/core.c |   29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> index 95f23b47ba27..7cbd65a22769 100644
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -368,16 +368,35 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>  /*
>   * When a retprobed function returns, trampoline_handler() is called,
>   * calling the kretprobe's handler. We construct a struct pt_regs to
> - * give a view of registers r0-r11 to the user return-handler.  This is
> - * not a complete pt_regs structure, but that should be plenty sufficient
> - * for kretprobe handlers which should normally be interested in r0 only
> - * anyway.
> + * give a view of registers r0-r11, sp, lr, and pc to the user
> + * return-handler. This is not a complete pt_regs structure, but that
> + * should be enough for stacktrace from the return handler with or
> + * without pt_regs.
>   */
>  void __naked __kprobes __kretprobe_trampoline(void)
>  {
>         __asm__ __volatile__ (
> -               "sub    sp, sp, #16             \n\t"
> +               "ldr    lr, =__kretprobe_trampoline     \n\t"
> +               "stmdb  sp!, {sp, lr, pc}       \n\t"
> +#ifdef CONFIG_FRAME_POINTER
> +       /* __kretprobe_trampoline makes a framepointer on pt_regs. */
> +#ifdef CONFIG_CC_IS_CLANG
> +               /* In clang case, pt_regs->ip = lr. */
> +               "stmdb  sp!, {lr}               \n\t"
>                 "stmdb  sp!, {r0 - r11}         \n\t"
> +               /* fp points regs->r11 (fp) */
> +               "add    fp, sp, #44             \n\t"
> +#else /* !CONFIG_CC_IS_CLANG */
> +               /* In gcc case, pt_regs->ip = fp. */
> +               "stmdb  sp!, {fp}               \n\t"
> +               "stmdb  sp!, {r0 - r11}         \n\t"
> +               /* fp points regs->r15 (pc) */
> +               "add    fp, sp, #60             \n\t"

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +#endif /* CONFIG_CC_IS_CLANG */
> +#else /* !CONFIG_FRAME_POINTER */
> +               "sub    sp, sp, #4              \n\t"
> +               "stmdb  sp!, {r0 - r11}         \n\t"
> +#endif /* CONFIG_FRAME_POINTER */
>                 "mov    r0, sp                  \n\t"
>                 "bl     trampoline_handler      \n\t"
>                 "mov    lr, r0                  \n\t"
>


-- 
Thanks,
~Nick Desaulniers
