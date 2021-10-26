Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6427D43AE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhJZI5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhJZI5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:57:45 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007A7C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:55:22 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i9so33004516ybi.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CM37jlaMXkRsHHkG1O7ZYac0cUBSPl49tFExN0NplIM=;
        b=ePr5qFxPNz+cniKDjqjnxTGizBNacE6tIlNCdgYWlexoJLScoR+dgcPTt3/6ANGC6Z
         GuCDWMkE91ICPc0oAUOnuRwKuX2Jx0PCyqQ/5dSHPqQtTPYsw9REBW95uMBOTtubTXYV
         quUXqBfSoBisaHnI6gvg7TD9nRxVoyZtj+Xjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CM37jlaMXkRsHHkG1O7ZYac0cUBSPl49tFExN0NplIM=;
        b=VLEMkT5Hu+NY2KLr+5wTnr0uYPYyfA/i7iga29dTjrA8kSQOAGXeKtRtzjCjnl3x8w
         PIW24uKxxcSqUM6s45Iglelv/ZZmIT9oB4bHSCKbtlPrAQHm5WOd50OekmZQ+7vz5/kw
         JFX3TweSJ1N6PJX6ISU8Gy2tpG77KtCjgIUmAK5nmQ0zOEQHFzecbROM5TIxu0Ce1rfa
         Y1+7pssH2L97DHQUVvRXDStNya0XiaCnP8TF/UgETRJn5yNZP48zJJK+cjbfNQOTn1XS
         6nA4Rfa5O/55dJ3enexdoI/FcZZzibM5iSljRafrw0jBesyjmmfe/triLaDjPWBxEC/l
         qMBg==
X-Gm-Message-State: AOAM5321+l84D0sDd8Lsp/c6n0X44uTgr/UMkIRYP3Dj42ZFcbRDtOOQ
        ALZIzgW7AjMsi8wmJfBpCuIf6zX0WRCVW/UgHvUJ
X-Google-Smtp-Source: ABdhPJyB73vh77mBkUQ0IhhABQewwC71dOMraIlg9euM8NVn/OxFSf32kB1GyZ07r4ay527SKk53DNhM85XoMR8rxIQ=
X-Received: by 2002:a05:6902:601:: with SMTP id d1mr1602196ybt.481.1635238520302;
 Tue, 26 Oct 2021 01:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 26 Oct 2021 01:55:09 -0700
Message-ID: <CAOnJCULgjUsnb__QrUFdop3Nr9t6G5WtSsG+EE2d4_e+b7Dy5Q@mail.gmail.com>
Subject: Re: Out-of-bounds access when hartid >= NR_CPUS
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 8:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi all,
>
> When booting a kernel with CONFIG_NR_CPUS=4 on Microchip PolarFire,
> the 4th CPU either fails to come online, or the system crashes.
>
> This happens because PolarFire has 5 CPU cores: hart 0 is an e51,
> and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in Linux:
>   - unused core has hartid 0 (sifive,e51),
>   - processor 0 has hartid 1 (sifive,u74-mc),
>   - processor 1 has hartid 2 (sifive,u74-mc),
>   - processor 2 has hartid 3 (sifive,u74-mc),
>   - processor 3 has hartid 4 (sifive,u74-mc).
>
> I assume the same issue is present on the SiFive fu540 and fu740
> SoCs, but I don't have access to these.  The issue is not present
> on StarFive JH7100, as processor 0 has hartid 1, and processor 1 has
> hartid 0.
>
> arch/riscv/kernel/cpu_ops.c has:
>
>     void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
>     void *__cpu_up_task_pointer[NR_CPUS] __section(".data");
>
>     void cpu_update_secondary_bootdata(unsigned int cpuid,
>                                        struct task_struct *tidle)
>     {
>             int hartid = cpuid_to_hartid_map(cpuid);
>
>             /* Make sure tidle is updated */
>             smp_mb();
>             WRITE_ONCE(__cpu_up_stack_pointer[hartid],
>                        task_stack_page(tidle) + THREAD_SIZE);
>             WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
>
> The above two writes cause out-of-bound accesses beyond
> __cpu_up_{stack,pointer}_pointer[] if hartid >= CONFIG_NR_CPUS.
>
>     }
>

Thanks for reporting this. We need to fix this and definitely shouldn't hide it
using configs. I guess I never tested with lower values (2 or 4) for
CONFIG_NR_CPUS which explains how this bug was not noticed until now.


> arch/riscv/kernel/smpboot.c:setup_smp(void) detects CPUs like this:
>
>     for_each_of_cpu_node(dn) {
>             hart = riscv_of_processor_hartid(dn);
>             if (hart < 0)
>                     continue;
>
>             if (hart == cpuid_to_hartid_map(0)) {
>                     BUG_ON(found_boot_cpu);
>                     found_boot_cpu = 1;
>                     early_map_cpu_to_node(0, of_node_to_nid(dn));
>                     continue;
>             }
>             if (cpuid >= NR_CPUS) {
>                     pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
>                             cpuid, hart);
>                     break;
>             }
>
>             cpuid_to_hartid_map(cpuid) = hart;
>             early_map_cpu_to_node(cpuid, of_node_to_nid(dn));
>             cpuid++;
>     }
>
> So cpuid >= CONFIG_NR_CPUS (too many CPU cores) is already rejected.
>
> How to fix this?
>
> We could skip hartids >= NR_CPUS, but that feels strange to me, as
> you need NR_CPUS to be larger (much larger if the first usable hartid
> is a large number) than the number of CPUs used.
>
> We could store the minimum hartid, and always subtract that when
> accessing __cpu_up_{stack,pointer}_pointer[] (also in
> arch/riscv/kernel/head.S), but that means unused cores cannot be in the
> middle of the hartid range.

Yeah. Both of the above proposed solutions are not ideal.

>
> Are hartids guaranteed to be continuous? If not, we have no choice but
> to index __cpu_up_{stack,pointer}_pointer[] by cpuid instead, which
> needs a more expensive conversion in arch/riscv/kernel/head.S.
>

This will work for ordered booting with SBI HSM extension. However, it may
fail for spinwait booting because cpuid_to_hartid_map might not have setup
depending on when secondary harts are jumping to linux.

Ideally, the size of the __cpu_up_{stack,task}_pointer[] should be the maximum
hartid possible. How about adding a config for that ?

We also need sanity checks cpu_update_secondary_bootdata to make sure
that the hartid is within the bounds to avoid issues due to the
suboptimal config value.

> Thanks for your comments!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
