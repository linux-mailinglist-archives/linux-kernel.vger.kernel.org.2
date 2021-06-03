Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC7139A2A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFCOBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhFCOBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:01:12 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83F78C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 06:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=2lajeQP1++NkLXsw13lGJiGVOormNEytLR
        e9zH5ul5I=; b=vHlDDfyzjmmivtzjm/nj5J+24RQYk0JgSZ9lks+9qm4h9QwBRK
        53cmpwKHsc9XyYoixbfvXmwVcnOeTaAqlnzgpmg1OZQ0BeicRI2PEnEvQaWA8FqA
        gUPS7nOC8PJGKqLeRi6XH77ZOQRwiWRxx5u8W/jmzkYw1pLRbEK1Dqvdk=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHjoon4LhgCF6JAA--.38078S2;
        Thu, 03 Jun 2021 21:59:03 +0800 (CST)
Date:   Thu, 3 Jun 2021 21:53:37 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Anup Patel <anup@brainfault.org>, Alex Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] riscv: Factorize xip and !xip kernel address
 conversion macros
Message-ID: <20210603215337.4da052e2@xhacker>
In-Reply-To: <CAAhSdy2kPPrBzFCA01NSvWptoftY27+PsMzLDWFzvOzNdUByhA@mail.gmail.com>
References: <20210603082749.1256129-1-alex@ghiti.fr>
        <20210603082749.1256129-2-alex@ghiti.fr>
        <20210603202748.2775f739@xhacker>
        <64cdb4f9-06f0-59b9-acf9-6fc298db37d7@ghiti.fr>
        <CAAhSdy2kPPrBzFCA01NSvWptoftY27+PsMzLDWFzvOzNdUByhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygCHjoon4LhgCF6JAA--.38078S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW8JrW8ur4xZw4UJFyUtrb_yoW7WF1rpr
        1DGFnrKFWfXryYk3yqv3s09as5twnrGryagrsrK34rZa4qyF1xWF4jqw13uryqqFWUXF4f
        Zry7Gr1a9w1jqwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8GYLUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 18:46:47 +0530
Anup Patel <anup@brainfault.org> wrote:

> On Thu, Jun 3, 2021 at 6:27 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >
> > Hi Jisheng,

Hi,

> >
> > Le 3/06/2021 =C3=A0 14:27, Jisheng Zhang a =C3=A9crit : =20
> > > On Thu,  3 Jun 2021 10:27:47 +0200
> > > Alexandre Ghiti <alex@ghiti.fr> wrote:
> > > =20
> > >> To simplify the kernel address conversion code, make the same defini=
tion of
> > >> kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for b=
oth xip
> > >> and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.
> > >>
> > >> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > >> ---
> > >>   arch/riscv/include/asm/page.h    | 14 +++-----------
> > >>   arch/riscv/include/asm/pgtable.h |  2 ++
> > >>   2 files changed, 5 insertions(+), 11 deletions(-)
> > >>
> > >> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/=
page.h
> > >> index 6a7761c86ec2..6e004d8fda4d 100644
> > >> --- a/arch/riscv/include/asm/page.h
> > >> +++ b/arch/riscv/include/asm/page.h
> > >> @@ -93,9 +93,7 @@ extern unsigned long va_pa_offset;
> > >>   #ifdef CONFIG_64BIT
> > >>   extern unsigned long va_kernel_pa_offset;
> > >>   #endif
> > >> -#ifdef CONFIG_XIP_KERNEL
> > >>   extern unsigned long va_kernel_xip_pa_offset;
> > >> -#endif
> > >>   extern unsigned long pfn_base;
> > >>   #define ARCH_PFN_OFFSET            (pfn_base)
> > >>   #else
> > >> @@ -103,6 +101,7 @@ extern unsigned long pfn_base;
> > >>   #ifdef CONFIG_64BIT
> > >>   #define va_kernel_pa_offset        0
> > >>   #endif
> > >> +#define va_kernel_xip_pa_offset 0
> > >>   #define ARCH_PFN_OFFSET            (PAGE_OFFSET >> PAGE_SHIFT)
> > >>   #endif /* CONFIG_MMU */
> > >>
> > >> @@ -110,29 +109,22 @@ extern unsigned long kernel_virt_addr;
> > >>
> > >>   #ifdef CONFIG_64BIT
> > >>   #define linear_mapping_pa_to_va(x) ((void *)((unsigned long)(x) + =
va_pa_offset))
> > >> -#ifdef CONFIG_XIP_KERNEL
> > >>   #define kernel_mapping_pa_to_va(y) ({                             =
                 \
> > >>      unsigned long _y =3D y;                                        =
                   \
> > >>      (_y >=3D CONFIG_PHYS_RAM_BASE) ? =20
> > >
> > > This CONFIG_PHYS_RAM_BASE is only available for XIP, could result in a
> > > compiler error for !XIP? =20
> >
> > You're right, I have this patch in my branch and forgot to squash it
> > =20
> > >
> > > I'm also concerned with the unecessary overhead of kernel_mapping_pa_=
to_va()
> > > for !XIP case, there's a "if" condition branch, and extra symbol: va_=
kernel_xip_pa_offset =20
> >
> > I understand your concerns even if I don't find that the overhead is
> > that important here, I prefer the readability improvement. I can always

For readability, we still can avoid introducing va_kernel_xip_pa_offset
symbol by simply define va_kernel_xip_pa_offset as 0 if XIP as you did
for XIP_OFFSET

PS: this may need a preparation patch:
http://lists.infradead.org/pipermail/linux-riscv/2021-June/006802.html

> > add unlikely/likely builtin to improve things or completely remove this
> > patch if others agree with you. =20
>=20
> I would also prefer readable code for long-term maintainability. Currentl=
y,
> the nested "#ifdefs" are increasing causing developers to easily break
> untested combinations.
>=20
> Regards,
> Anup
>=20
> >
> > Thanks,
> >
> > Alex
> > =20
> > > =20
> > >>              (void *)((unsigned long)(_y) + va_kernel_pa_offset + XI=
P_OFFSET) :      \
> > >>              (void *)((unsigned long)(_y) + va_kernel_xip_pa_offset)=
;                \
> > >>      })
> > >> -#else
> > >> -#define kernel_mapping_pa_to_va(x)  ((void *)((unsigned long)(x) + =
va_kernel_pa_offset))
> > >> -#endif
> > >>   #define __pa_to_va_nodebug(x)              linear_mapping_pa_to_va=
(x)
> > >>
> > >>   #define linear_mapping_va_to_pa(x) ((unsigned long)(x) - va_pa_off=
set)
> > >> -#ifdef CONFIG_XIP_KERNEL
> > >>   #define kernel_mapping_va_to_pa(y) ({                             =
                 \
> > >>      unsigned long _y =3D y;                                        =
           \
> > >>      (_y < kernel_virt_addr + XIP_OFFSET) ?                         =
         \
> > >>              ((unsigned long)(_y) - va_kernel_xip_pa_offset) :      =
         \
> > >>              ((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET=
);       \
> > >>      }) =20
> > >
> > > Similar as kernel_mapping_pa_to_va(), an overhead of "if" condition b=
ranch
> > > for !XIP and extra va_kernel_xip_pa_offset symbol.
> > > =20
> > >> -#else
> > >> -#define kernel_mapping_va_to_pa(x)  ((unsigned long)(x) - va_kernel=
_pa_offset)
> > >> -#endif
> > >> +
> > >>   #define __va_to_pa_nodebug(x)      ({                             =
                 \
> > >>      unsigned long _x =3D x;                                        =
           \
> > >>      (_x < kernel_virt_addr) ?                                      =
         \
> > >> @@ -141,7 +133,7 @@ extern unsigned long kernel_virt_addr;
> > >>   #else
> > >>   #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_=
pa_offset))
> > >>   #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
> > >> -#endif
> > >> +#endif /* CONFIG_64BIT */
> > >>
> > >>   #ifdef CONFIG_DEBUG_VIRTUAL
> > >>   extern phys_addr_t __virt_to_phys(unsigned long x);
> > >> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/a=
sm/pgtable.h
> > >> index bde8ce3bfe7c..d98e931a31e5 100644
> > >> --- a/arch/riscv/include/asm/pgtable.h
> > >> +++ b/arch/riscv/include/asm/pgtable.h
> > >> @@ -77,6 +77,8 @@
> > >>
> > >>   #ifdef CONFIG_XIP_KERNEL
> > >>   #define XIP_OFFSET         SZ_8M
> > >> +#else
> > >> +#define XIP_OFFSET          0
> > >>   #endif
> > >>
> > >>   #ifndef __ASSEMBLY__ =20
> > >
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > =20


