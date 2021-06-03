Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3976939A479
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhFCPYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhFCPY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:24:29 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91E7FC061756
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=NrqTccpLIylkR0T9OgNeAoE3H+cHZLBXN0
        4t97OMHQ8=; b=vtM8/ejS6bnxVqpyfw/SMDNyJ0fh6QJg1euouSwVMWMKGJUNQp
        r6yLzW7uwQlbMAs3wStvSHeiEUwfNK9cT10q1/ztb1koOVzGyXcwQ1pMY4CNPEKh
        /d32vZ2lyY5KYxZyQUOXLmH7VMhclKka1sIplryr6Om6geTYwYDhAWG0s=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygA3taOu87hgvc2JAA--.45389S2;
        Thu, 03 Jun 2021 23:22:22 +0800 (CST)
Date:   Thu, 3 Jun 2021 23:16:56 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] riscv: Factorize xip and !xip kernel address
 conversion macros
Message-ID: <20210603231656.47ca101f@xhacker>
In-Reply-To: <e50b56f5-7405-2eef-f8e9-7d9fa4df7c77@ghiti.fr>
References: <20210603082749.1256129-1-alex@ghiti.fr>
        <20210603082749.1256129-2-alex@ghiti.fr>
        <20210603202748.2775f739@xhacker>
        <64cdb4f9-06f0-59b9-acf9-6fc298db37d7@ghiti.fr>
        <CAAhSdy2kPPrBzFCA01NSvWptoftY27+PsMzLDWFzvOzNdUByhA@mail.gmail.com>
        <20210603215337.4da052e2@xhacker>
        <e50b56f5-7405-2eef-f8e9-7d9fa4df7c77@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygA3taOu87hgvc2JAA--.45389S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1kuryxKFy5AFWDuF4DArb_yoWxAr17pr
        1DGF1UKr4rJryYk3yqv3s0kryYywnrJry3Wrn8G348Za4DtF1UWF1UXw15uryqqF15JF4f
        Xry7Gr13uw1UJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 17:06:39 +0200
Alex Ghiti <alex@ghiti.fr> wrote:

> Le 3/06/2021 =C3=A0 15:53, Jisheng Zhang a =C3=A9crit=C2=A0:
> > On Thu, 3 Jun 2021 18:46:47 +0530
> > Anup Patel <anup@brainfault.org> wrote:
> >  =20
> >> On Thu, Jun 3, 2021 at 6:27 PM Alex Ghiti <alex@ghiti.fr> wrote: =20
> >>>
> >>> Hi Jisheng, =20
> >=20
> > Hi,
> >  =20
> >>>
> >>> Le 3/06/2021 =C3=A0 14:27, Jisheng Zhang a =C3=A9crit : =20
> >>>> On Thu,  3 Jun 2021 10:27:47 +0200
> >>>> Alexandre Ghiti <alex@ghiti.fr> wrote:
> >>>>    =20
> >>>>> To simplify the kernel address conversion code, make the same defin=
ition of
> >>>>> kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for =
both xip
> >>>>> and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.
> >>>>>
> >>>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> >>>>> ---
> >>>>>    arch/riscv/include/asm/page.h    | 14 +++-----------
> >>>>>    arch/riscv/include/asm/pgtable.h |  2 ++
> >>>>>    2 files changed, 5 insertions(+), 11 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm=
/page.h
> >>>>> index 6a7761c86ec2..6e004d8fda4d 100644
> >>>>> --- a/arch/riscv/include/asm/page.h
> >>>>> +++ b/arch/riscv/include/asm/page.h
> >>>>> @@ -93,9 +93,7 @@ extern unsigned long va_pa_offset;
> >>>>>    #ifdef CONFIG_64BIT
> >>>>>    extern unsigned long va_kernel_pa_offset;
> >>>>>    #endif
> >>>>> -#ifdef CONFIG_XIP_KERNEL
> >>>>>    extern unsigned long va_kernel_xip_pa_offset;
> >>>>> -#endif
> >>>>>    extern unsigned long pfn_base;
> >>>>>    #define ARCH_PFN_OFFSET            (pfn_base)
> >>>>>    #else
> >>>>> @@ -103,6 +101,7 @@ extern unsigned long pfn_base;
> >>>>>    #ifdef CONFIG_64BIT
> >>>>>    #define va_kernel_pa_offset        0
> >>>>>    #endif
> >>>>> +#define va_kernel_xip_pa_offset 0
> >>>>>    #define ARCH_PFN_OFFSET            (PAGE_OFFSET >> PAGE_SHIFT)
> >>>>>    #endif /* CONFIG_MMU */
> >>>>>
> >>>>> @@ -110,29 +109,22 @@ extern unsigned long kernel_virt_addr;
> >>>>>
> >>>>>    #ifdef CONFIG_64BIT
> >>>>>    #define linear_mapping_pa_to_va(x) ((void *)((unsigned long)(x) =
+ va_pa_offset))
> >>>>> -#ifdef CONFIG_XIP_KERNEL
> >>>>>    #define kernel_mapping_pa_to_va(y) ({                           =
                   \
> >>>>>       unsigned long _y =3D y;                                      =
                     \
> >>>>>       (_y >=3D CONFIG_PHYS_RAM_BASE) ? =20
> >>>>
> >>>> This CONFIG_PHYS_RAM_BASE is only available for XIP, could result in=
 a
> >>>> compiler error for !XIP? =20
> >>>
> >>> You're right, I have this patch in my branch and forgot to squash it
> >>>    =20
> >>>>
> >>>> I'm also concerned with the unecessary overhead of kernel_mapping_pa=
_to_va()
> >>>> for !XIP case, there's a "if" condition branch, and extra symbol: va=
_kernel_xip_pa_offset =20
> >>>
> >>> I understand your concerns even if I don't find that the overhead is
> >>> that important here, I prefer the readability improvement. I can alwa=
ys =20
> >=20
> > For readability, we still can avoid introducing va_kernel_xip_pa_offset
> > symbol by simply define va_kernel_xip_pa_offset as 0 if XIP as you did
> > for XIP_OFFSET
> >=20
> > PS: this may need a preparation patch:
> > http://lists.infradead.org/pipermail/linux-riscv/2021-June/006802.html =
=20
>=20
> IIUC, that won't improve readability, just avoid to allocate=20
> va_kernel_xip_pa_offset in !XIP kernel right?

I mean even we can improve code readability while still avoid the
va_kernel_xip_pa_offset symbol for !XIP case. Probably it's implemented
as you did for XIP_OFFSET:

#ifdef CONFIG_XIP_KERNEL
extern unsigned long va_kernel_xip_pa_offset;
#else
#define va_kernel_xip_pa_offset 0
#endif

But since currently va_kernel_xip_pa_offset always exisits no matter XIP
is enabled or not, so you may need the preparation patch to clean up, other=
wise
there may be compiler error.
>=20
> >  =20
> >>> add unlikely/likely builtin to improve things or completely remove th=
is
> >>> patch if others agree with you. =20
> >>
> >> I would also prefer readable code for long-term maintainability. Curre=
ntly,
> >> the nested "#ifdefs" are increasing causing developers to easily break
> >> untested combinations.
> >>
> >> Regards,
> >> Anup
> >> =20
> >>>
> >>> Thanks,
> >>>
> >>> Alex
> >>>    =20
> >>>>    =20
> >>>>>               (void *)((unsigned long)(_y) + va_kernel_pa_offset + =
XIP_OFFSET) :      \
> >>>>>               (void *)((unsigned long)(_y) + va_kernel_xip_pa_offse=
t);                \
> >>>>>       })
> >>>>> -#else
> >>>>> -#define kernel_mapping_pa_to_va(x)  ((void *)((unsigned long)(x) +=
 va_kernel_pa_offset))
> >>>>> -#endif
> >>>>>    #define __pa_to_va_nodebug(x)              linear_mapping_pa_to_=
va(x)
> >>>>>
> >>>>>    #define linear_mapping_va_to_pa(x) ((unsigned long)(x) - va_pa_o=
ffset)
> >>>>> -#ifdef CONFIG_XIP_KERNEL
> >>>>>    #define kernel_mapping_va_to_pa(y) ({                           =
                   \
> >>>>>       unsigned long _y =3D y;                                      =
             \
> >>>>>       (_y < kernel_virt_addr + XIP_OFFSET) ?                       =
           \
> >>>>>               ((unsigned long)(_y) - va_kernel_xip_pa_offset) :    =
           \
> >>>>>               ((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFS=
ET);       \
> >>>>>       }) =20
> >>>>
> >>>> Similar as kernel_mapping_pa_to_va(), an overhead of "if" condition =
branch
> >>>> for !XIP and extra va_kernel_xip_pa_offset symbol.
> >>>>    =20
> >>>>> -#else
> >>>>> -#define kernel_mapping_va_to_pa(x)  ((unsigned long)(x) - va_kerne=
l_pa_offset)
> >>>>> -#endif
> >>>>> +
> >>>>>    #define __va_to_pa_nodebug(x)      ({                           =
                   \
> >>>>>       unsigned long _x =3D x;                                      =
             \
> >>>>>       (_x < kernel_virt_addr) ?                                    =
           \
> >>>>> @@ -141,7 +133,7 @@ extern unsigned long kernel_virt_addr;
> >>>>>    #else
> >>>>>    #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + v=
a_pa_offset))
> >>>>>    #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offse=
t)
> >>>>> -#endif
> >>>>> +#endif /* CONFIG_64BIT */
> >>>>>
> >>>>>    #ifdef CONFIG_DEBUG_VIRTUAL
> >>>>>    extern phys_addr_t __virt_to_phys(unsigned long x);
> >>>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/=
asm/pgtable.h
> >>>>> index bde8ce3bfe7c..d98e931a31e5 100644
> >>>>> --- a/arch/riscv/include/asm/pgtable.h
> >>>>> +++ b/arch/riscv/include/asm/pgtable.h
> >>>>> @@ -77,6 +77,8 @@
> >>>>>
> >>>>>    #ifdef CONFIG_XIP_KERNEL
> >>>>>    #define XIP_OFFSET         SZ_8M
> >>>>> +#else
> >>>>> +#define XIP_OFFSET          0
> >>>>>    #endif
> >>>>>
> >>>>>    #ifndef __ASSEMBLY__ =20
> >>>>
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> linux-riscv mailing list
> >>>> linux-riscv@lists.infradead.org
> >>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>>>    =20
> >=20
> >=20
> >=20
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >  =20


