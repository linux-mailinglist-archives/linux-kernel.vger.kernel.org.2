Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3B410952
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 04:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhISChD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 22:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbhISChC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 22:37:02 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FB3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 19:35:38 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i132so2160089qke.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 19:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bk4AhLnNfk3EYFQjUK0lAUBPIa1P/jSFZkkuoC+UJA8=;
        b=fbF2hxSNHg0/ExIIdnB5g+Zhy7Uq1b0xHEIuKTJMs62/xEA19OHtbeXx8GJA5e+AZw
         F0AXdQEIqyDtkxKyirrqudgI7tWh7mNU3GQbYg18HM4orwe8H81qA0kK7xGnzn+aWyE4
         uELuzQ2xce70pZeYO8F6GTxIylqJPWucx3aec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bk4AhLnNfk3EYFQjUK0lAUBPIa1P/jSFZkkuoC+UJA8=;
        b=UevpPEqmKp9KsTmPJHrXXkcldCU31vf9l6I/tyi0MvBLGyuapr22l20mc5jNy7uuEm
         ORFRJj+awgcMc8D1htGIZ3JFItH7fUdOFHBI082y5/OmsNO9KqHMfjZjelR5HxH4Ly3W
         FXB237dqUCf+gywanuqFiFYTKXzqlLyBldYdYC8GWbrxaGn/UsSK2ZckSTvFac8BSG0j
         x61n0jmcX2J1390LbfXEXNkDL7zXCLy4t/4CsElzBQ6ZB2LrGYIKSMMXytOLk7vS641M
         2gHOwIpFivoAdC5A71e3ebKpubtewn7L/elHaSnwY9n9zrT50Ryw6IMW20xb9Gki+02f
         NheA==
X-Gm-Message-State: AOAM533jvmWz5Jix1R+4pMpftop/XRaDjAXSzIIvI9chPDsj00LK+cT+
        PBLGA7/vQSTNc09xulLvaK4VERtq5RmnIQ/cnBH/
X-Google-Smtp-Source: ABdhPJwhpLY5/KBgGMVSWOLJn+k3TDnINgm6FVVrxdMPHncdxwCwvLkkoJlHrBOJpOLFTpBNyITbDxSPz6aXzlN3UBc=
X-Received: by 2002:a25:c745:: with SMTP id w66mr3323239ybe.505.1632018937524;
 Sat, 18 Sep 2021 19:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210918160221.111902-1-alex@ghiti.fr>
In-Reply-To: <20210918160221.111902-1-alex@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sat, 18 Sep 2021 19:35:26 -0700
Message-ID: <CAOnJCU++j8z1f6F8SPKe-SeSJYQYg1Sra27HPPTRFijyGXdOyA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Flush current cpu icache before other cpus
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 9:03 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> On SiFive Unmatched, I recently fell onto the following BUG when booting:
>
> [    0.000000] ftrace: allocating 36610 entries in 144 pages
> [    0.000000] Oops - illegal instruction [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.1+ #5
> [    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
> [    0.000000] epc : riscv_cpuid_to_hartid_mask+0x6/0xae
> [    0.000000]  ra : __sbi_rfence_v02+0xc8/0x10a
> [    0.000000] epc : ffffffff80007240 ra : ffffffff80009964 sp : ffffffff81803e10
> [    0.000000]  gp : ffffffff81a1ea70 tp : ffffffff8180f500 t0 : ffffffe07fe30000
> [    0.000000]  t1 : 0000000000000004 t2 : 0000000000000000 s0 : ffffffff81803e60
> [    0.000000]  s1 : 0000000000000000 a0 : ffffffff81a22238 a1 : ffffffff81803e10
> [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.000000]  a5 : 0000000000000000 a6 : ffffffff8000989c a7 : 0000000052464e43
> [    0.000000]  s2 : ffffffff81a220c8 s3 : 0000000000000000 s4 : 0000000000000000
> [    0.000000]  s5 : 0000000000000000 s6 : 0000000200000100 s7 : 0000000000000001
> [    0.000000]  s8 : ffffffe07fe04040 s9 : ffffffff81a22c80 s10: 0000000000001000
> [    0.000000]  s11: 0000000000000004 t3 : 0000000000000001 t4 : 0000000000000008
> [    0.000000]  t5 : ffffffcf04000808 t6 : ffffffe3ffddf188
> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000002
> [    0.000000] [<ffffffff80007240>] riscv_cpuid_to_hartid_mask+0x6/0xae
> [    0.000000] [<ffffffff80009474>] sbi_remote_fence_i+0x1e/0x26
> [    0.000000] [<ffffffff8000b8f4>] flush_icache_all+0x12/0x1a
> [    0.000000] [<ffffffff8000666c>] patch_text_nosync+0x26/0x32
> [    0.000000] [<ffffffff8000884e>] ftrace_init_nop+0x52/0x8c
> [    0.000000] [<ffffffff800f051e>] ftrace_process_locs.isra.0+0x29c/0x360
> [    0.000000] [<ffffffff80a0e3c6>] ftrace_init+0x80/0x130
> [    0.000000] [<ffffffff80a00f8c>] start_kernel+0x5c4/0x8f6
> [    0.000000] ---[ end trace f67eb9af4d8d492b ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>
> While ftrace is looping over a list of addresses to patch, it always failed
> when patching the same function: riscv_cpuid_to_hartid_mask. Looking at the
> backtrace, the illegal instruction is encountered in this same function.
> However, patch_text_nosync, after patching the instructions, calls
> flush_icache_range. But looking at what happens in this function:
>
> flush_icache_range -> flush_icache_all
>                    -> sbi_remote_fence_i
>                    -> __sbi_rfence_v02
>                    -> riscv_cpuid_to_hartid_mask
>
> The icache and dcache of the current cpu are never synchronized between the
> patching of riscv_cpuid_to_hartid_mask and calling this same function.
>
> So fix this by flushing the current cpu's icache before asking for the other
> cpus to do the same.
>

Is this the same bugs described in this thread ?

http://lkml.iu.edu/hypermail/linux/kernel/2108.1/05465.html


> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/cacheflush.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 094118663285..89f81067e09e 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -16,6 +16,8 @@ static void ipi_remote_fence_i(void *info)
>
>  void flush_icache_all(void)
>  {
> +       local_flush_icache_all();
> +
>         if (IS_ENABLED(CONFIG_RISCV_SBI))
>                 sbi_remote_fence_i(NULL);
>         else
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
