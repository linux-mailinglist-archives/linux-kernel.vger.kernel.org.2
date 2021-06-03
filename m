Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1339A502
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFCPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:54:22 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:33556 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFCPyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:54:21 -0400
Received: by mail-yb1-f181.google.com with SMTP id f84so9571028ybg.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0E1bQ+uKUVeIFgvkIlglV33FCznGkcgKYHmyJqXHZ4=;
        b=L6c8kr29xlQkfikA6a4PIf875euklpqQN8EDPNIOkcCRGCACOIUxKiYzdH59e2Gdz+
         llM+M3HbTJjzz6D1YkvrdHTH9mma5v1oj3jm5hcu8R+6tfq84GXqAJp4V1WLddFy0ZQI
         wFzBY0zW2VLkGcBJY5JoJV2nZ1aADn2s7hVRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0E1bQ+uKUVeIFgvkIlglV33FCznGkcgKYHmyJqXHZ4=;
        b=WstAp8+LSD8WzWOyeeGzgDZZ0ikW9Xjc1lM/oQoIpU7RRTPcOCOSLtMOgbhjD8/tQO
         S8TXHpbA/S7tk/xnO53s27IvmVVUELl1LP688CXftk1D5l6vODFTjc+PpHd7YcDtxCHc
         YmH8ILNZWvu3dZfaXPqF0x2NwaKBEUYSJCwCa2dQc3G70kksZsOPh72RL9CJVm2EbTAt
         Io12TcTKRJDXsjvfWbAYXfkuYXXnzmhvTiVDkT8wePVsOPSQ/ypFxLkfAPciuWa3Ai51
         69ru/miG+DJXNL0cMLbOMkTjHRxuezut9vjM8I1gyx0RmDQ6Sw0mRYTtptWArYf8K0Of
         0aqg==
X-Gm-Message-State: AOAM532GJqfvp7lcjX+6EuicQfy4tjevbotz5uAO8u17sISWUR6jLTd/
        VGR0iAHPocun/jjIQh+t1CmPJl9kBWHausCCcdLbIw==
X-Google-Smtp-Source: ABdhPJyP9W19k/Ki6c2DwddIwJwVZOUopod0HSUrSsvq+oGgiLZQc/+ykQGJfWEIsf0Ermak0Nf58vUycg2mFIDfLuQ=
X-Received: by 2002:a25:d256:: with SMTP id j83mr825910ybg.421.1622735496472;
 Thu, 03 Jun 2021 08:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210603082749.1256129-1-alex@ghiti.fr> <20210603082749.1256129-2-alex@ghiti.fr>
 <20210603202748.2775f739@xhacker> <20210603204942.703c9cb4@xhacker>
In-Reply-To: <20210603204942.703c9cb4@xhacker>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 3 Jun 2021 17:51:25 +0200
Message-ID: <CAM4kBBKo2qzgfXZMk4Zfkw-wgMnwNRcdj_ZCJHg4=JAG0kb9oQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: Factorize xip and !xip kernel address
 conversion macros
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021, 14:57 Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>
> On Thu, 3 Jun 2021 20:27:48 +0800
> Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>
> > On Thu,  3 Jun 2021 10:27:47 +0200
> > Alexandre Ghiti <alex@ghiti.fr> wrote:
> >
> > > To simplify the kernel address conversion code, make the same definition of
> > > kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for both xip
> > > and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.
> > >
> > > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > > ---
> > >  arch/riscv/include/asm/page.h    | 14 +++-----------
> > >  arch/riscv/include/asm/pgtable.h |  2 ++
> > >  2 files changed, 5 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > > index 6a7761c86ec2..6e004d8fda4d 100644
> > > --- a/arch/riscv/include/asm/page.h
> > > +++ b/arch/riscv/include/asm/page.h
> > > @@ -93,9 +93,7 @@ extern unsigned long va_pa_offset;
> > >  #ifdef CONFIG_64BIT
> > >  extern unsigned long va_kernel_pa_offset;
> > >  #endif
> > > -#ifdef CONFIG_XIP_KERNEL
> > >  extern unsigned long va_kernel_xip_pa_offset;
> > > -#endif
> > >  extern unsigned long pfn_base;
> > >  #define ARCH_PFN_OFFSET            (pfn_base)
> > >  #else
> > > @@ -103,6 +101,7 @@ extern unsigned long pfn_base;
> > >  #ifdef CONFIG_64BIT
> > >  #define va_kernel_pa_offset        0
> > >  #endif
> > > +#define va_kernel_xip_pa_offset 0
> > >  #define ARCH_PFN_OFFSET            (PAGE_OFFSET >> PAGE_SHIFT)
> > >  #endif /* CONFIG_MMU */
> > >
> > > @@ -110,29 +109,22 @@ extern unsigned long kernel_virt_addr;
> > >
> > >  #ifdef CONFIG_64BIT
> > >  #define linear_mapping_pa_to_va(x) ((void *)((unsigned long)(x) + va_pa_offset))
> > > -#ifdef CONFIG_XIP_KERNEL
> > >  #define kernel_mapping_pa_to_va(y) ({                                              \
> > >     unsigned long _y = y;                                                           \
> > >     (_y >= CONFIG_PHYS_RAM_BASE) ?
> >
> > This CONFIG_PHYS_RAM_BASE is only available for XIP, could result in a
> > compiler error for !XIP?
> >
> > I'm also concerned with the unecessary overhead of kernel_mapping_pa_to_va()
> > for !XIP case, there's a "if" condition branch, and extra symbol: va_kernel_xip_pa_offset
>
> Err, I just found this symobl always exists no matter XIP is enabled or not.
> I will send out a patch for this clean up

What cleanup?

Best regards,
   Vitaly

>
> >
> > >             (void *)((unsigned long)(_y) + va_kernel_pa_offset + XIP_OFFSET) :      \
> > >             (void *)((unsigned long)(_y) + va_kernel_xip_pa_offset);                \
> > >     })
> > > -#else
> > > -#define kernel_mapping_pa_to_va(x) ((void *)((unsigned long)(x) + va_kernel_pa_offset))
> > > -#endif
> > >  #define __pa_to_va_nodebug(x)              linear_mapping_pa_to_va(x)
> > >
> > >  #define linear_mapping_va_to_pa(x) ((unsigned long)(x) - va_pa_offset)
> > > -#ifdef CONFIG_XIP_KERNEL
> > >  #define kernel_mapping_va_to_pa(y) ({                                              \
> > >     unsigned long _y = y;                                                   \
> > >     (_y < kernel_virt_addr + XIP_OFFSET) ?                                  \
> > >             ((unsigned long)(_y) - va_kernel_xip_pa_offset) :               \
> > >             ((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET);       \
> > >     })
> >
> > Similar as kernel_mapping_pa_to_va(), an overhead of "if" condition branch
> > for !XIP and extra va_kernel_xip_pa_offset symbol.
> >
> > > -#else
> > > -#define kernel_mapping_va_to_pa(x) ((unsigned long)(x) - va_kernel_pa_offset)
> > > -#endif
> > > +
> > >  #define __va_to_pa_nodebug(x)      ({                                              \
> > >     unsigned long _x = x;                                                   \
> > >     (_x < kernel_virt_addr) ?                                               \
> > > @@ -141,7 +133,7 @@ extern unsigned long kernel_virt_addr;
> > >  #else
> > >  #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
> > >  #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
> > > -#endif
> > > +#endif /* CONFIG_64BIT */
> > >
> > >  #ifdef CONFIG_DEBUG_VIRTUAL
> > >  extern phys_addr_t __virt_to_phys(unsigned long x);
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > > index bde8ce3bfe7c..d98e931a31e5 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -77,6 +77,8 @@
> > >
> > >  #ifdef CONFIG_XIP_KERNEL
> > >  #define XIP_OFFSET         SZ_8M
> > > +#else
> > > +#define XIP_OFFSET         0
> > >  #endif
> > >
> > >  #ifndef __ASSEMBLY__
> >
> >
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
