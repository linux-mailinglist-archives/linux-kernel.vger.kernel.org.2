Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7993EBB1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhHMROI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 13:14:08 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50768
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhHMRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:11:23 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 06FEC3F247
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628874607;
        bh=8FqkbZBTRWV0AxSlmaQKOjvfV2RVpFuLWDlormJNSBQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=oeXPyfu99q37Os4lIEpe0ZmiyYuZqthT7GAn78dv9tKkMR05Wxnsh4rmJmlS6Df5F
         wQtT1q4P4vhg8jIuYdyjDgLko/FVGrL9f3Nuta761hqQtwsX4tJ4my2cvLBAE43I0v
         gl8gJ3JxuACnRjXbO9bWeSbOzUewychRnufrFezoTma8INeMrpMlAL0DB2ZEX4WRgp
         5i5IYgWQjZZb+UkKq5Q4j1hCDUUrLtgRPpYpmgamtR1hMb6s69Hf9Xpe6mtn6IVcgI
         DXHrepdZfZCSCG5xlVzbhqrqpJf5uP3Ed2U3QKXyVmBn1v/OWd+iXyUu1XMWQBWyR1
         whMparKiDIB/w==
Received: by mail-io1-f69.google.com with SMTP id o8-20020a0566021248b029058d0f91164eso5722116iou.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 10:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FqkbZBTRWV0AxSlmaQKOjvfV2RVpFuLWDlormJNSBQ=;
        b=KB7FweBeiMvmkYHku+w/raY/pBdqE+vtXobVUUxqN5LKOHLZDNU/EI8FQIz2APEiIQ
         +iVLN4Qy5wu7H1pLc6vMyR060xEErGYF4TWi7XuQEqg+xTOkh7rwEZgsgoVBrww9c2a5
         ojUf6vi/aWa441rIAGrVJOZTdB1wjcFOeqUsFJ16R/VC7ARpiTOGq8MybQDaeQBEjsg8
         VZIrrIShd1ex3rq1AbSWac6q5OcFEniGe7gymsC7WA29LHErPAO5IU0LGlZM9ANIc6Tx
         SBTf4cUFDg8RaySBPuvaFr5LdvKwYtxShBRm64T6j9vCWOq6QBW8pCCnw26PHJ9QUwFh
         r1OQ==
X-Gm-Message-State: AOAM532jq8OyBPSi7fO6nmHAIW6dUSfBzgW6ttIKiAJwCoDqiPe8V0h1
        zLcIVRC/QIwTGrj1tg0D1b50cVW3g1qIO0BiW84ENST4zmEmZSJd3ggODBDPSgZ5ljM7hKZdR57
        mJNNSzuevPCoXbV35OztLcGGSos+vA1lKj8yhbev+gcdEaBfCTgRLXw2o/g==
X-Received: by 2002:a6b:8f08:: with SMTP id r8mr2777987iod.42.1628874605865;
        Fri, 13 Aug 2021 10:10:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVux983Ruh0XqE6sNH39w7EPP8QIhYytDywc1JCFiM2xWArPpRtEv2c5H6lqf0CelaOEXDsCbHjlOsELavFUA=
X-Received: by 2002:a6b:8f08:: with SMTP id r8mr2777975iod.42.1628874605615;
 Fri, 13 Aug 2021 10:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210812123433.27871-1-dimitri.ledkov@canonical.com> <CAOnJCULTxFmRbpw4wp7SYN8EJxFhSN5J04QDE=cfxLAB01ZOFA@mail.gmail.com>
In-Reply-To: <CAOnJCULTxFmRbpw4wp7SYN8EJxFhSN5J04QDE=cfxLAB01ZOFA@mail.gmail.com>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Fri, 13 Aug 2021 18:09:29 +0100
Message-ID: <CADWks+bVr8OcrfeMzMCPJ15G-y9cGpbb-2+1_AGU4Y2QOQjjBg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: prevent sbi_send_cpumask_ipi race with ftrace
To:     Atish Patra <atishp@atishpatra.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Pierce Andjelkovic <pierceandjelkovic@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 12, 2021 at 4:53 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Thu, Aug 12, 2021 at 5:36 AM Dimitri John Ledkov
> <dimitri.ledkov@canonical.com> wrote:
> >
> > From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> >
> > ftrace will patch instructions in sbi_send_cpumask_ipi, which is going to
> > be used by flush_icache_range, leading to potential races and crashes like
> > this:
> >
> > [    0.000000] ftrace: allocating 38893 entries in 152 pages
> > [    0.000000] Oops - illegal instruction [#1]
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.11.0-1014-generic #14-Ubuntu
> > [    0.000000] epc: ffffffe00000920e ra : ffffffe000009384 sp : ffffffe001803d30
> > [    0.000000]  gp : ffffffe001a14240 tp : ffffffe00180f440 t0 : ffffffe07fe38000
> > [    0.000000]  t1 : ffffffe0019cd338 t2 : 0000000000000000 s0 : ffffffe001803d70
> > [    0.000000]  s1 : 0000000000000000 a0 : ffffffe0000095aa a1 : 0000000000000001
> > [    0.000000]  a2 : 0000000000000002 a3 : 0000000000000000 a4 : 0000000000000000
> > [    0.000000]  a5 : 0000000000000000 a6 : 0000000000000004 a7 : 0000000052464e43
> > [    0.000000]  s2 : 0000000000000002 s3 : 0000000000000001 s4 : 0000000000000000
> > [    0.000000]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
> > [    0.000000]  s8 : ffffffe001a170c0 s9 : 0000000000000001 s10: 0000000000000001
> > [    0.000000]  s11: 00000000fffcc5d0 t3 : 0000000000000068 t4 : 000000000000000b
> > [    0.000000]  t5 : ffffffe0019cd3e0 t6 : ffffffe001803cd8
> > [    0.000000] status: 0000000200000100 badaddr: 000000000513f187 cause: 0000000000000002
> > [    0.000000] ---[ end trace f67eb9af4d8d492b ]---
> > [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> >
> > Where ffffffe00000920e lies in the middle of sbi_send_cpumask_ipi.
> >
> > Reproduced on Unmatched board using Ubuntu kernels. See
> > https://people.canonical.com/~xnox/lp1934548/ for sample images,
> > kernels, debug symbols.
> >
> > BugLink: https://bugs.launchpad.net/bugs/1934548
> > Reported-by: Pierce Andjelkovic <pierceandjelkovic@gmail.com>
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> > cc: Paul Walmsley <paul.walmsley@sifive.com>
> > cc: linux-riscv@lists.infradead.org
> > cc: stable@vger.kernel.org
> > ---
> >  arch/riscv/kernel/sbi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 7402a417f38e..158199865c68 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -562,7 +562,7 @@ long sbi_get_mimpid(void)
> >         return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
> >  }
> >
> > -static void sbi_send_cpumask_ipi(const struct cpumask *target)
> > +static void notrace sbi_send_cpumask_ipi(const struct cpumask *target)
> >  {
> >         struct cpumask hartid_mask;
> >
>
> flush_icache_range doesn't invoke sbi_send_cpumask_ipi.
> flush_icache_range->flush_icache_all->sbi_remote_fence_i->__sbi_rfence->sbi_ecall
>
> Moreover, sbi.c should be removed from ftrace path as it is compiled
> with notrace flag after the patch [1]
>
> CFLAGS_REMOVE_sbi.o   = $(CC_FLAGS_FTRACE)
>
> This solution was proposed as a result of earlier discussion [2] last year.
>
> [1] https://patchwork.kernel.org/project/linux-riscv/patch/1608220905-1962-5-git-send-email-guoren@kernel.org/
> [2] https://lkml.org/lkml/2020/11/3/735
>
> The proposed fix probably hiding the root cause somehow.
>
> Do you have the patch[1] in your kernel ?
>

We do not. I have applied and tested it, and indeed it resolves the
boot issue too. And it does make a lot more sense. I see that it and
its prereq patch did not have CC: stable on them. I will submit them
to stable, as they are required to have bootable kernels. Thanks a lot
for the pointers.

So this patch that I sent is NACKed now.
-- 
Regards,

Dimitri.
