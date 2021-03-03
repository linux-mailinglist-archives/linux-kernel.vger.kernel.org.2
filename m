Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5A32BEEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386193AbhCCRrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383590AbhCCOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:39:30 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A6C061226
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:39:13 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id f33so23702998otf.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydBX+pGjF/hly9LCkDMks/XbfuRt2icO3LWw0ubnZBg=;
        b=BipVVFvFZNSKC5Sq1DHK1KCd2wj2EtBh2kHvVE0HndwFfkwpIAdy0hddwyFpISP/hB
         gKkb6pX13Sqsp8jCQJehXkky1QLNkq7J43BSiV8cK65k3qb8fpV8SvqQaBO9123NTawu
         gIWhNmlD8oaqhOTZ8pXWjCjwZ3BS6baG1wTN0+jlajtEky0JxPrawqaadBROjkJc7EeQ
         kNS0vjRkBHUUCiqIvN7dA3+CB9eZgTm3Y0OnVwT8hKRFhfVn/lLlOED4HB3JKB0YYcXe
         RCugbz1s/+qqCTmCwqE87Au8n5uGKwzPpuZNWgKh13ocmtKVsLEmCW98dcRxXbdTbh7d
         lVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydBX+pGjF/hly9LCkDMks/XbfuRt2icO3LWw0ubnZBg=;
        b=ATri+p9wFVKmW6ooIGcP3a4gElDM/3ah2oE/YI9MDxj1sqYQ0xZsCbMygS7F+fOMFv
         RDsjHQtpn3KiXGfq/W3ob2GgAEDseFogsUx/DXDDUoxrr4TsRD6elgoFg34M42AS+Ztz
         fqhYDXHyqSHwFvuTJzHmAYP7qKQH4K7BxCjgT3HTZHDXGHeLUE4LKTz3bMWUVIRBd3TU
         J8uLa/vsrqhYUre2nvN44T9R2QgJ7wm2U/9fVIpNCtBZXu8QFUrCQUmZmlFjE3WyUPpC
         D3bDh2v8v9u9512efLJWSHVi0130TdPayfpSZjDUmTrlwI+267q/wGaKH9zpyVNokjay
         HJZg==
X-Gm-Message-State: AOAM533flmPRmpwSMhCwhI4uQHxj/potFgOA9R8cUhjV2NG/Mk3ZmT/9
        DiwxVqrGkhXYmuPXZQoGr3E5rQO1HuG/TOntBbFWbg==
X-Google-Smtp-Source: ABdhPJweXHPm4CwYRyWdlTFWK/3BUsDddAUhfYjRv5NkSivbrepGK/Cfmou9AvKZN8Ll0jcTjeGPNDJ7SG8d71Ri7hg=
X-Received: by 2002:a9d:644a:: with SMTP id m10mr23005815otl.233.1614782352144;
 Wed, 03 Mar 2021 06:39:12 -0800 (PST)
MIME-Version: 1.0
References: <e2e8728c4c4553bbac75a64b148e402183699c0c.1614780567.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e2e8728c4c4553bbac75a64b148e402183699c0c.1614780567.git.christophe.leroy@csgroup.eu>
From:   Marco Elver <elver@google.com>
Date:   Wed, 3 Mar 2021 15:38:59 +0100
Message-ID: <CANpmjNOvgbUCf0QBs1J-mO0yEPuzcTMm7aS1JpPB-17_LabNHw@mail.gmail.com>
Subject: Re: [PATCH v1] powerpc: Include running function as first entry in
 save_stack_trace() and friends
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 at 15:09, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> It seems like all other sane architectures, namely x86 and arm64
> at least, include the running function as top entry when saving
> stack trace.
>
> Functionnalities like KFENCE expect it.
>
> Do the same on powerpc, it allows KFENCE to properly identify the faulting
> function as depicted below. Before the patch KFENCE was identifying
> finish_task_switch.isra as the faulting function.
>
> [   14.937370] ==================================================================
> [   14.948692] BUG: KFENCE: invalid read in test_invalid_access+0x54/0x108
> [   14.948692]
> [   14.956814] Invalid read at 0xdf98800a:
> [   14.960664]  test_invalid_access+0x54/0x108
> [   14.964876]  finish_task_switch.isra.0+0x54/0x23c
> [   14.969606]  kunit_try_run_case+0x5c/0xd0
> [   14.973658]  kunit_generic_run_threadfn_adapter+0x24/0x30
> [   14.979079]  kthread+0x15c/0x174
> [   14.982342]  ret_from_kernel_thread+0x14/0x1c
> [   14.986731]
> [   14.988236] CPU: 0 PID: 111 Comm: kunit_try_catch Tainted: G    B             5.12.0-rc1-01537-g95f6e2088d7e-dirty #4682
> [   14.999795] NIP:  c016ec2c LR: c02f517c CTR: c016ebd8
> [   15.004851] REGS: e2449d90 TRAP: 0301   Tainted: G    B              (5.12.0-rc1-01537-g95f6e2088d7e-dirty)
> [   15.015274] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 22000004  XER: 00000000
> [   15.022043] DAR: df98800a DSISR: 20000000
> [   15.022043] GPR00: c02f517c e2449e50 c1142080 e100dd24 c084b13c 00000008 c084b32b c016ebd8
> [   15.022043] GPR08: c0850000 df988000 c0d10000 e2449eb0 22000288
> [   15.040581] NIP [c016ec2c] test_invalid_access+0x54/0x108
> [   15.046010] LR [c02f517c] kunit_try_run_case+0x5c/0xd0
> [   15.051181] Call Trace:
> [   15.053637] [e2449e50] [c005a68c] finish_task_switch.isra.0+0x54/0x23c (unreliable)
> [   15.061338] [e2449eb0] [c02f517c] kunit_try_run_case+0x5c/0xd0
> [   15.067215] [e2449ed0] [c02f648c] kunit_generic_run_threadfn_adapter+0x24/0x30
> [   15.074472] [e2449ef0] [c004e7b0] kthread+0x15c/0x174
> [   15.079571] [e2449f30] [c001317c] ret_from_kernel_thread+0x14/0x1c
> [   15.085798] Instruction dump:
> [   15.088784] 8129d608 38e7ebd8 81020280 911f004c 39000000 995f0024 907f0028 90ff001c
> [   15.096613] 3949000a 915f0020 3d40c0d1 3d00c085 <8929000a> 3908adb0 812a4b98 3d40c02f
> [   15.104612] ==================================================================
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Marco Elver <elver@google.com>

Thank you, I think this looks like the right solution. Just a question below:

> ---
>  arch/powerpc/kernel/stacktrace.c | 42 +++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
> index b6440657ef92..67c2b8488035 100644
> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -22,16 +22,32 @@
>  #include <asm/kprobes.h>
>
>  #include <asm/paca.h>
> +#include <asm/switch_to.h>
>
>  /*
>   * Save stack-backtrace addresses into a stack_trace buffer.
>   */
> +static void save_entry(struct stack_trace *trace, unsigned long ip, int savesched)
> +{
> +       if (savesched || !in_sched_functions(ip)) {
> +               if (!trace->skip)
> +                       trace->entries[trace->nr_entries++] = ip;
> +               else
> +                       trace->skip--;
> +       }
> +}
> +
>  static void save_context_stack(struct stack_trace *trace, unsigned long sp,
> -                       struct task_struct *tsk, int savesched)
> +                              unsigned long ip, struct task_struct *tsk, int savesched)
>  {
> +       save_entry(trace, ip, savesched);
> +
> +       if (trace->nr_entries >= trace->max_entries)
> +               return;
> +
>         for (;;) {
>                 unsigned long *stack = (unsigned long *) sp;
> -               unsigned long newsp, ip;
> +               unsigned long newsp;
>
>                 if (!validate_sp(sp, tsk, STACK_FRAME_OVERHEAD))
>                         return;
> @@ -39,12 +55,7 @@ static void save_context_stack(struct stack_trace *trace, unsigned long sp,
>                 newsp = stack[0];
>                 ip = stack[STACK_FRAME_LR_SAVE];
>
> -               if (savesched || !in_sched_functions(ip)) {
> -                       if (!trace->skip)
> -                               trace->entries[trace->nr_entries++] = ip;
> -                       else
> -                               trace->skip--;
> -               }
> +               save_entry(trace, ip, savesched);
>
>                 if (trace->nr_entries >= trace->max_entries)
>                         return;
> @@ -59,23 +70,26 @@ void save_stack_trace(struct stack_trace *trace)
>
>         sp = current_stack_frame();
>
> -       save_context_stack(trace, sp, current, 1);
> +       save_context_stack(trace, sp, (unsigned long)save_stack_trace, current, 1);

This causes ip == save_stack_trace and also below for
save_stack_trace_tsk. Does this mean save_stack_trace() is included in
the trace? Looking at kernel/stacktrace.c, I think the library wants
to exclude itself from the trace, as it does '.skip = skipnr + 1' (and
'.skip   = skipnr + (current == tsk)' for the _tsk variant).

If the arch-helper here is included, should this use _RET_IP_ instead?

Thanks,
-- Marco

>  }
>  EXPORT_SYMBOL_GPL(save_stack_trace);
>
>  void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>  {
> -       unsigned long sp;
> +       unsigned long sp, ip;
>
>         if (!try_get_task_stack(tsk))
>                 return;
>
> -       if (tsk == current)
> +       if (tsk == current) {
> +               ip = (unsigned long)save_stack_trace_tsk;
>                 sp = current_stack_frame();
> -       else
> +       } else {
> +               ip = (unsigned long)_switch;
>                 sp = tsk->thread.ksp;
> +       }
>
> -       save_context_stack(trace, sp, tsk, 0);
> +       save_context_stack(trace, sp, ip, tsk, 0);
>
>         put_task_stack(tsk);
>  }
> @@ -84,7 +98,7 @@ EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
>  void
>  save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
>  {
> -       save_context_stack(trace, regs->gpr[1], current, 0);
> +       save_context_stack(trace, regs->gpr[1], regs->nip, current, 0);
>  }
>  EXPORT_SYMBOL_GPL(save_stack_trace_regs);
>
> --
> 2.25.0
>
