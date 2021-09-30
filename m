Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092E541DAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351290AbhI3NJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351392AbhI3NJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:09:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E307D61A0A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633007268;
        bh=06oFCZzSWkWUUGuICzxy3RhOwyzZLkgV3lmtKojWf04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iWSVreCVGfRCuRTs2aywl5AFnFk0PYu9kCa6vHbVLgfKIwIj2Y3KduMGcVcGyYWIB
         DfSYzwbS9mRNhRaWQ6/0eOZr5Fec9qNufYYtxLxhDj64yeI9gSF3f3U0H/kazpMl65
         27ToqD0ahKrwzfEspYL7oQjozAN/ByB1UzEcdspsw4AJJDDY9VHa+1KQh3d9lREiMh
         nv/M6ul2Nh5L56kRLsEa4NA04doVPNQM6wwGmgNUJAYO2evGTfW+HJdixWzRpHX5p0
         xX/wqrGk5KnGj1P0QZw9eDp1WAZrCIk5UvHDuVLDxWq3XNAq6fIJbesx7UWqMTbLp9
         +/swGMKm7wjoQ==
Received: by mail-ot1-f42.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso7155289ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:07:48 -0700 (PDT)
X-Gm-Message-State: AOAM532ZXSQY11BtU087cDYi2j0e9y2teGXUtqPd7tRdhHiCd/mQzfwm
        AfgBOjIy2Bd5kv7iZWH23A7qW0zmb0TYHyJPfJI=
X-Google-Smtp-Source: ABdhPJxXAREFqwNV8sCerKfq16aoBz3pHomNrAPAcTAR77pD/z46aFPauW1+7DcQyexzsJx+gKKsjHhILeImYpM3+DQ=
X-Received: by 2002:a9d:63c7:: with SMTP id e7mr5216017otl.30.1633007268209;
 Thu, 30 Sep 2021 06:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210930125813.197418-1-ardb@kernel.org> <20210930125813.197418-2-ardb@kernel.org>
 <6b003f58-48df-7ac4-4dbf-81b2c5bca5d9@csgroup.eu>
In-Reply-To: <6b003f58-48df-7ac4-4dbf-81b2c5bca5d9@csgroup.eu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Sep 2021 15:07:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXECGp=5QRQS8HQNfE6RyA=eQfRiciDdjXp_ucpk8OxkDQ@mail.gmail.com>
Message-ID: <CAMj1kXECGp=5QRQS8HQNfE6RyA=eQfRiciDdjXp_ucpk8OxkDQ@mail.gmail.com>
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

On Thu, 30 Sept 2021 at 15:06, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 30/09/2021 =C3=A0 14:58, Ard Biesheuvel a =C3=A9crit :
> > The CPU field will be moved back into thread_info even when
> > THREAD_INFO_IN_TASK is enabled, so add it back to arm64's definition of
> > struct thread_info.
> >
> > Note that arm64 always has CONFIG_SMP=3Dy so there is no point in guard=
ing
> > the CPU field with an #ifdef.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >   arch/arm64/include/asm/thread_info.h | 1 +
> >   arch/arm64/kernel/asm-offsets.c      | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/=
asm/thread_info.h
> > index 6623c99f0984..c02bc8c183c3 100644
> > --- a/arch/arm64/include/asm/thread_info.h
> > +++ b/arch/arm64/include/asm/thread_info.h
> > @@ -42,6 +42,7 @@ struct thread_info {
> >       void                    *scs_base;
> >       void                    *scs_sp;
> >   #endif
> > +     u32                     cpu;
> >   };
> >
> >   #define thread_saved_pc(tsk)        \
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-of=
fsets.c
> > index 551427ae8cc5..cee9f3e9f906 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -29,6 +29,7 @@ int main(void)
> >     DEFINE(TSK_ACTIVE_MM,             offsetof(struct task_struct, acti=
ve_mm));
> >     DEFINE(TSK_CPU,           offsetof(struct task_struct, cpu));
> >     BLANK();
> > +  DEFINE(TSK_TI_CPU,         offsetof(struct task_struct, thread_info.=
cpu));
>
> Why adding that now ? For powerpc you do the switch in 5.
>


Why not?


> >     DEFINE(TSK_TI_FLAGS,              offsetof(struct task_struct, thre=
ad_info.flags));
> >     DEFINE(TSK_TI_PREEMPT,    offsetof(struct task_struct, thread_info.=
preempt_count));
> >   #ifdef CONFIG_ARM64_SW_TTBR0_PAN
> >
