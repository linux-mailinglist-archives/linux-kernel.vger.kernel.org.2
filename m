Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3341DAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351021AbhI3NWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350955AbhI3NWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:22:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E063C6187A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633008053;
        bh=/+EC8L1UcUE2bi7NaYazSzOjmyEsgKAWrMxnFdVdCPQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NTPAmls2GL2KfPIOOOLIv84iDTCtVJLUjEzIZUke3I11cGXeqADFtRsFkYkQRujy0
         kOVl3MgQ4bsRgFaOWtC4wAMYf0OEguMi+Ma2VhAGx5LtTw25WUXUQ4cyjjajkINLBf
         W5x6F9UKxeXLsiQFVHBupEzK9cOUoEEcUsLYvVG3xDLtVBsPuKBfZV0O8xLtzqQ3lB
         ZmIh507VWJBdFfSje0kTIDEbGaTo3pb25rQ46WL9k3oGqcw9XH2ZP5qXzBdiICCyzt
         Umq+oYg+aM5gBn2CBjkJY4Cs0KxPM6NZjD2Iu18ycL0gF01o4tVeKwdYpRgheS9tWW
         LP8uph3PzQoGg==
Received: by mail-ot1-f47.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso7196485otu.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:20:53 -0700 (PDT)
X-Gm-Message-State: AOAM5337OHoxHLZgdyiV92a5JKWbEsYCiYokoU7OBIKT5kBC4Ip6mrm0
        qAlQ3ez5i3PtXHetdbosWlWJRODU6va+3tJyt3A=
X-Google-Smtp-Source: ABdhPJyX3dUfNrRdnBfeIOI0e6zSzZNGMx1qPgZ0waL3ol7Q1cgu+PgFg/3esEaLptf6cwMUu0WgJVr0QAN0uxZJx5U=
X-Received: by 2002:a9d:63c7:: with SMTP id e7mr5289543otl.30.1633008052198;
 Thu, 30 Sep 2021 06:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210930125813.197418-1-ardb@kernel.org> <20210930125813.197418-2-ardb@kernel.org>
 <6b003f58-48df-7ac4-4dbf-81b2c5bca5d9@csgroup.eu> <CAMj1kXECGp=5QRQS8HQNfE6RyA=eQfRiciDdjXp_ucpk8OxkDQ@mail.gmail.com>
 <f634b2fe-3d89-709b-a56e-7da08af3988e@csgroup.eu>
In-Reply-To: <f634b2fe-3d89-709b-a56e-7da08af3988e@csgroup.eu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Sep 2021 15:20:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuzDSxbE7OTV0Sb5UYaGQ5v_yFeq8LYE--kZ_AffaB4g@mail.gmail.com>
Message-ID: <CAMj1kXFuzDSxbE7OTV0Sb5UYaGQ5v_yFeq8LYE--kZ_AffaB4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] arm64: add CPU field to struct thread_info
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sept 2021 at 15:15, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 30/09/2021 =C3=A0 15:07, Ard Biesheuvel a =C3=A9crit :
> > On Thu, 30 Sept 2021 at 15:06, Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >>
> >>
> >> Le 30/09/2021 =C3=A0 14:58, Ard Biesheuvel a =C3=A9crit :
> >>> The CPU field will be moved back into thread_info even when
> >>> THREAD_INFO_IN_TASK is enabled, so add it back to arm64's definition =
of
> >>> struct thread_info.
> >>>
> >>> Note that arm64 always has CONFIG_SMP=3Dy so there is no point in gua=
rding
> >>> the CPU field with an #ifdef.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >>> Acked-by: Mark Rutland <mark.rutland@arm.com>
> >>> ---
> >>>    arch/arm64/include/asm/thread_info.h | 1 +
> >>>    arch/arm64/kernel/asm-offsets.c      | 1 +
> >>>    2 files changed, 2 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/includ=
e/asm/thread_info.h
> >>> index 6623c99f0984..c02bc8c183c3 100644
> >>> --- a/arch/arm64/include/asm/thread_info.h
> >>> +++ b/arch/arm64/include/asm/thread_info.h
> >>> @@ -42,6 +42,7 @@ struct thread_info {
> >>>        void                    *scs_base;
> >>>        void                    *scs_sp;
> >>>    #endif
> >>> +     u32                     cpu;
> >>>    };
> >>>
> >>>    #define thread_saved_pc(tsk)        \
> >>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-=
offsets.c
> >>> index 551427ae8cc5..cee9f3e9f906 100644
> >>> --- a/arch/arm64/kernel/asm-offsets.c
> >>> +++ b/arch/arm64/kernel/asm-offsets.c
> >>> @@ -29,6 +29,7 @@ int main(void)
> >>>      DEFINE(TSK_ACTIVE_MM,             offsetof(struct task_struct, a=
ctive_mm));
> >>>      DEFINE(TSK_CPU,           offsetof(struct task_struct, cpu));
> >>>      BLANK();
> >>> +  DEFINE(TSK_TI_CPU,         offsetof(struct task_struct, thread_inf=
o.cpu));
> >>
> >> Why adding that now ? For powerpc you do the switch in 5.
> >>
> >
> >
> > Why not?
>
> Maybe to remain consistent between archs ?
>

Does it matter?

> >
> >
> >>>      DEFINE(TSK_TI_FLAGS,              offsetof(struct task_struct, t=
hread_info.flags));
> >>>      DEFINE(TSK_TI_PREEMPT,    offsetof(struct task_struct, thread_in=
fo.preempt_count));
> >>>    #ifdef CONFIG_ARM64_SW_TTBR0_PAN
> >>>
