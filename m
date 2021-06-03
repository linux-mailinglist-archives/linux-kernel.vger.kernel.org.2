Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0943539A20A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhFCNT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:19:56 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:38903 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhFCNTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:19:55 -0400
Received: by mail-wm1-f51.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso5864313wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kVmiKNflK1YqQSK946ogFvaiqc4a4AwLLd7mkDQytwo=;
        b=KJfWoDsEFR+xkEK8fqCohWR3iG7FC4MQxI4/FZw1BOExXFJsTBny46F7WkLIlQrq/z
         4AjURLtXA8XG8BT4KscUQ35iWl5jD2Dhn2rRidpH7DCPFD1p4A/O66X+nQXGZrqvMxUt
         GO15rY79//UX2QnH7WBOaIKaM62LKki0oZjQ0/UcqMR7obCyxXO3hBLQ/qcQ+d/olBG/
         M8cvlZ9YRvx0JcwB+Z/Aq4YjlSceH9SP1xlDIe6csU0ynlhoo+KBs61YofWZUWGwcHEw
         WQ4qZy99ys4wp6RNmahLclCMS7RByU7fQglZO99NQJkNOp8hZzVdS6BHf93AcqSCbow3
         lmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kVmiKNflK1YqQSK946ogFvaiqc4a4AwLLd7mkDQytwo=;
        b=qWlJOZlyOJbTXvlNXQW6Sta6wKMR6OoeSw6DWsvS41AjB1Ygqb/CprXFuEgu5wMJbu
         w1qudVx4asQfjjnPpEsXI2EDhzPFJ0Q8vNplZ2H7v9SDHD26R7XMaTfIq8BUcKqN0eq0
         TnjHsimjmg3HlLSAgXW4IjpQjlUEJd1igP7vbtU/y6C633a9qJXOQoHIjepM5y1qIKkd
         cGpFgLidx5JkxkZcYMWtumM7KR8/586GlEo+wsqVl5pp8jZULjkl19mZrlHSuDGZwoPs
         S1z3MIG2yWSUuEckF3AwtVwDI/Owu/gJNwj3PkSZzb/fZylRtemVkcQXtvEUvc9hELw3
         lBQw==
X-Gm-Message-State: AOAM531bGZFgKnjhtMEXFyNSGLe/6g7/BI/6x9J7Adtb3S+ISoCsDHx7
        HULo0+uFISQYZbubghJyTKAvttcqrw9oIuJYVJ/A2w==
X-Google-Smtp-Source: ABdhPJwrJsJZtC2CbERI2DymWgVkybpTdH/lrVRKG7SsyTSoC3smHhOZwAum9hW1SYerXRcZcLvaDywUzdNnakDxmlM=
X-Received: by 2002:a05:600c:35cb:: with SMTP id r11mr10350874wmq.152.1622726220166;
 Thu, 03 Jun 2021 06:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210603082749.1256129-1-alex@ghiti.fr> <20210603082749.1256129-2-alex@ghiti.fr>
 <20210603202748.2775f739@xhacker> <64cdb4f9-06f0-59b9-acf9-6fc298db37d7@ghiti.fr>
In-Reply-To: <64cdb4f9-06f0-59b9-acf9-6fc298db37d7@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 3 Jun 2021 18:46:47 +0530
Message-ID: <CAAhSdy2kPPrBzFCA01NSvWptoftY27+PsMzLDWFzvOzNdUByhA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: Factorize xip and !xip kernel address
 conversion macros
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 6:27 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Jisheng,
>
> Le 3/06/2021 =C3=A0 14:27, Jisheng Zhang a =C3=A9crit :
> > On Thu,  3 Jun 2021 10:27:47 +0200
> > Alexandre Ghiti <alex@ghiti.fr> wrote:
> >
> >> To simplify the kernel address conversion code, make the same definiti=
on of
> >> kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for bot=
h xip
> >> and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.
> >>
> >> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> >> ---
> >>   arch/riscv/include/asm/page.h    | 14 +++-----------
> >>   arch/riscv/include/asm/pgtable.h |  2 ++
> >>   2 files changed, 5 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/pa=
ge.h
> >> index 6a7761c86ec2..6e004d8fda4d 100644
> >> --- a/arch/riscv/include/asm/page.h
> >> +++ b/arch/riscv/include/asm/page.h
> >> @@ -93,9 +93,7 @@ extern unsigned long va_pa_offset;
> >>   #ifdef CONFIG_64BIT
> >>   extern unsigned long va_kernel_pa_offset;
> >>   #endif
> >> -#ifdef CONFIG_XIP_KERNEL
> >>   extern unsigned long va_kernel_xip_pa_offset;
> >> -#endif
> >>   extern unsigned long pfn_base;
> >>   #define ARCH_PFN_OFFSET            (pfn_base)
> >>   #else
> >> @@ -103,6 +101,7 @@ extern unsigned long pfn_base;
> >>   #ifdef CONFIG_64BIT
> >>   #define va_kernel_pa_offset        0
> >>   #endif
> >> +#define va_kernel_xip_pa_offset 0
> >>   #define ARCH_PFN_OFFSET            (PAGE_OFFSET >> PAGE_SHIFT)
> >>   #endif /* CONFIG_MMU */
> >>
> >> @@ -110,29 +109,22 @@ extern unsigned long kernel_virt_addr;
> >>
> >>   #ifdef CONFIG_64BIT
> >>   #define linear_mapping_pa_to_va(x) ((void *)((unsigned long)(x) + va=
_pa_offset))
> >> -#ifdef CONFIG_XIP_KERNEL
> >>   #define kernel_mapping_pa_to_va(y) ({                               =
               \
> >>      unsigned long _y =3D y;                                          =
                 \
> >>      (_y >=3D CONFIG_PHYS_RAM_BASE) ?
> >
> > This CONFIG_PHYS_RAM_BASE is only available for XIP, could result in a
> > compiler error for !XIP?
>
> You're right, I have this patch in my branch and forgot to squash it.
>
> >
> > I'm also concerned with the unecessary overhead of kernel_mapping_pa_to=
_va()
> > for !XIP case, there's a "if" condition branch, and extra symbol: va_ke=
rnel_xip_pa_offset
>
> I understand your concerns even if I don't find that the overhead is
> that important here, I prefer the readability improvement. I can always
> add unlikely/likely builtin to improve things or completely remove this
> patch if others agree with you.

I would also prefer readable code for long-term maintainability. Currently,
the nested "#ifdefs" are increasing causing developers to easily break
untested combinations.

Regards,
Anup

>
> Thanks,
>
> Alex
>
> >
> >>              (void *)((unsigned long)(_y) + va_kernel_pa_offset + XIP_=
OFFSET) :      \
> >>              (void *)((unsigned long)(_y) + va_kernel_xip_pa_offset); =
               \
> >>      })
> >> -#else
> >> -#define kernel_mapping_pa_to_va(x)  ((void *)((unsigned long)(x) + va=
_kernel_pa_offset))
> >> -#endif
> >>   #define __pa_to_va_nodebug(x)              linear_mapping_pa_to_va(x=
)
> >>
> >>   #define linear_mapping_va_to_pa(x) ((unsigned long)(x) - va_pa_offse=
t)
> >> -#ifdef CONFIG_XIP_KERNEL
> >>   #define kernel_mapping_va_to_pa(y) ({                               =
               \
> >>      unsigned long _y =3D y;                                          =
         \
> >>      (_y < kernel_virt_addr + XIP_OFFSET) ?                           =
       \
> >>              ((unsigned long)(_y) - va_kernel_xip_pa_offset) :        =
       \
> >>              ((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET);=
       \
> >>      })
> >
> > Similar as kernel_mapping_pa_to_va(), an overhead of "if" condition bra=
nch
> > for !XIP and extra va_kernel_xip_pa_offset symbol.
> >
> >> -#else
> >> -#define kernel_mapping_va_to_pa(x)  ((unsigned long)(x) - va_kernel_p=
a_offset)
> >> -#endif
> >> +
> >>   #define __va_to_pa_nodebug(x)      ({                               =
               \
> >>      unsigned long _x =3D x;                                          =
         \
> >>      (_x < kernel_virt_addr) ?                                        =
       \
> >> @@ -141,7 +133,7 @@ extern unsigned long kernel_virt_addr;
> >>   #else
> >>   #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa=
_offset))
> >>   #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
> >> -#endif
> >> +#endif /* CONFIG_64BIT */
> >>
> >>   #ifdef CONFIG_DEBUG_VIRTUAL
> >>   extern phys_addr_t __virt_to_phys(unsigned long x);
> >> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm=
/pgtable.h
> >> index bde8ce3bfe7c..d98e931a31e5 100644
> >> --- a/arch/riscv/include/asm/pgtable.h
> >> +++ b/arch/riscv/include/asm/pgtable.h
> >> @@ -77,6 +77,8 @@
> >>
> >>   #ifdef CONFIG_XIP_KERNEL
> >>   #define XIP_OFFSET         SZ_8M
> >> +#else
> >> +#define XIP_OFFSET          0
> >>   #endif
> >>
> >>   #ifndef __ASSEMBLY__
> >
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
