Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA263CB86B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhGPOKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGPOKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:10:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89400C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 07:07:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id k184so14978184ybf.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYUWmzUdnH0JTnpBiamPfJOy6/HDT0BS9cFs7kQWpY8=;
        b=IQkSEg7b5XVCdSeUTpBebnEB+YTZzsH18t2/V+btuhlD0wB/UHUhXDNIiFVTreZNOH
         mONCOjW17XcCClTm1EJ1BGf+cWpNLg2D/9ud6eQJRSEmcndLWPylBBY11yx77lktaHHD
         DvzN0UjpR7/SWUw1cgsHNQv/dBhnqqMJd3VP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYUWmzUdnH0JTnpBiamPfJOy6/HDT0BS9cFs7kQWpY8=;
        b=pfBBLrv+vaa3wvkaUFDol4L3kuy2Ba9VRo5/8BrHj2zJQ2+s/fYritCX1eQnGaLTZ4
         FIxI36yuK0fHRpJNMlvCLItaI7Z7jdykUCHBakwiGnDREWB5kFlpRK58LzPsl+o7eoVa
         dGRq4ZEtiXs7u0sgmHqN1QYRuVugTgk4gIR4vrUxxNFS4Jf3rkgTlmqxbjVeWrRgdSte
         sMfbfnK98yU+rr2YJuRKxwTn32MMy6mPoUtmBgXaS8H7r3SLyRMHiLB0qooXlpMBy7qI
         5Z0J6LmI1JVw619l9v3MUdXpxHKx3DCvylJNLda8aZbsjVnZH0poVULIwPnUJeHVu3fy
         FJrg==
X-Gm-Message-State: AOAM532ynno4IH7oAdkvuGuZBQeuDRYx49XYYJzDFiFshwH8QWHJsVKu
        8KWW9FeErDL7SHhaqEz/mWJpmcgPprqvPqGxj+Jt
X-Google-Smtp-Source: ABdhPJwuAu1PTuenOaymRy+9OSWKibsKVPubfbRZQaznJgEdRGjw1LGpHp+VWZYFwdyuwRx9EummxeFhi9X1xYl8NCU=
X-Received: by 2002:a05:6902:1507:: with SMTP id q7mr13636520ybu.326.1626444454843;
 Fri, 16 Jul 2021 07:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210716214051.32eea3a8@xhacker>
In-Reply-To: <20210716214051.32eea3a8@xhacker>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 16 Jul 2021 07:07:24 -0700
Message-ID: <CAOnJCU+h9uwBP57Nhh2tX9boOeQ9eV-_jjY0zSzUqhmi2Ptd2A@mail.gmail.com>
Subject: Re: [PATCH RESEND] riscv: stacktrace: Fix NULL pointer dereference
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 6:47 AM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
> When CONFIG_FRAME_POINTER=y, calling dump_stack() can always trigger
> NULL pointer dereference panic similar as below:
>
> [    0.396060] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc5+ #47
> [    0.396692] Hardware name: riscv-virtio,qemu (DT)
> [    0.397176] Call Trace:
> [    0.398191] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000960
> [    0.399487] Oops [#1]
> [    0.399739] Modules linked in:
> [    0.400135] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc5+ #47
> [    0.400570] Hardware name: riscv-virtio,qemu (DT)
> [    0.400926] epc : walk_stackframe+0xc4/0xdc
> [    0.401291]  ra : dump_backtrace+0x30/0x38
> [    0.401630] epc : ffffffff80004922 ra : ffffffff8000496a sp : ffffffe000f3bd00
> [    0.402115]  gp : ffffffff80cfdcb8 tp : ffffffe000f30000 t0 : ffffffff80d0b0cf
> [    0.402602]  t1 : ffffffff80d0b0c0 t2 : 0000000000000000 s0 : ffffffe000f3bd60
> [    0.403071]  s1 : ffffffff808bc2e8 a0 : 0000000000001000 a1 : 0000000000000000
> [    0.403448]  a2 : ffffffff803d7088 a3 : ffffffff808bc2e8 a4 : 6131725dbc24d400
> [    0.403820]  a5 : 0000000000001000 a6 : 0000000000000002 a7 : ffffffffffffffff
> [    0.404226]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
> [    0.404634]  s5 : ffffffff803d7088 s6 : ffffffff808bc2e8 s7 : ffffffff80630650
> [    0.405085]  s8 : ffffffff80912a80 s9 : 0000000000000008 s10: ffffffff804000fc
> [    0.405388]  s11: 0000000000000000 t3 : 0000000000000043 t4 : ffffffffffffffff
> [    0.405616]  t5 : 000000000000003d t6 : ffffffe000f3baa8
> [    0.405793] status: 0000000000000100 badaddr: 0000000000000960 cause: 000000000000000d
> [    0.406135] [<ffffffff80004922>] walk_stackframe+0xc4/0xdc
> [    0.407032] [<ffffffff8000496a>] dump_backtrace+0x30/0x38
> [    0.407797] [<ffffffff803d7100>] show_stack+0x40/0x4c
> [    0.408234] [<ffffffff803d9e5c>] dump_stack+0x90/0xb6
> [    0.409019] [<ffffffff8040423e>] ptdump_init+0x20/0xc4
> [    0.409681] [<ffffffff800015b6>] do_one_initcall+0x4c/0x226
> [    0.410110] [<ffffffff80401094>] kernel_init_freeable+0x1f4/0x258
> [    0.410562] [<ffffffff803dba88>] kernel_init+0x22/0x148
> [    0.410959] [<ffffffff800029e2>] ret_from_exception+0x0/0x14
> [    0.412241] ---[ end trace b2ab92c901b96251 ]---
> [    0.413099] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>
> The reason is the task is NULL when we finally call walk_stackframe()
> the NULL is passed from __dump_stack():
>
> |static void __dump_stack(void)
> |{
> |        dump_stack_print_info(KERN_DEFAULT);
> |        show_stack(NULL, NULL, KERN_DEFAULT);
> |}
>
> Fix this issue by checking "task == NULL" case in walk_stackframe().
>
> Fixes: eac2f3059e02 ("riscv: stacktrace: fix the riscv stacktrace when CONFIG_FRAME_POINTER enabled"
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/stacktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index bde85fc53357..7bc8af75933a 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -27,7 +27,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>                 fp = frame_pointer(regs);
>                 sp = user_stack_pointer(regs);
>                 pc = instruction_pointer(regs);
> -       } else if (task == current) {
> +       } else if (task == NULL || task == current) {
>                 fp = (unsigned long)__builtin_frame_address(1);
>                 sp = (unsigned long)__builtin_frame_address(0);
>                 pc = (unsigned long)__builtin_return_address(0);
> --
> 2.32.0
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
