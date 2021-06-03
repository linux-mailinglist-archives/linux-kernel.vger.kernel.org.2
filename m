Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1509239A51A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFCP55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhFCP54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:57:56 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D4FBC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=S1F8wjCfxP6fei3oMOM80fl/LRAtNMxSy2
        SudXZrPwU=; b=hn8kklUuDGSVAYbKzR3OTrZis0iYbZFS32BPtT2jWoQWl5hdE5
        KsvJQ4UzcKeAuJQ4LcXIP0ScWETLZ9uPj7+yfbUCSOP2lw5L5dslgmOwJb3ueDWN
        6MAl0i6kvVG1CzUvK3lJaG5ERPMYjuYw7bhb94Q2tKjta6JXfktlm2F5A=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygA3taNk+7hgR_qJAA--.45436S2;
        Thu, 03 Jun 2021 23:55:17 +0800 (CST)
Date:   Thu, 3 Jun 2021 23:49:50 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] riscv: Factorize xip and !xip kernel address
 conversion macros
Message-ID: <20210603234950.3ff475e3@xhacker>
In-Reply-To: <CAM4kBBKo2qzgfXZMk4Zfkw-wgMnwNRcdj_ZCJHg4=JAG0kb9oQ@mail.gmail.com>
References: <20210603082749.1256129-1-alex@ghiti.fr>
        <20210603082749.1256129-2-alex@ghiti.fr>
        <20210603202748.2775f739@xhacker>
        <20210603204942.703c9cb4@xhacker>
        <CAM4kBBKo2qzgfXZMk4Zfkw-wgMnwNRcdj_ZCJHg4=JAG0kb9oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygA3taNk+7hgR_qJAA--.45436S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF47Xw13Jry7Ww17GrWrGrg_yoW5Jw4rpr
        1kKFsFkF4FqryYk3yqvas8ua4DtwnxGrySqr1DK34UZ3Z0vFWxWF48Kr17uryqqFyUZF4f
        uFyxJ34fuw1UJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4o7KUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 17:51:25 +0200
Vitaly Wool <vitaly.wool@konsulko.com> wrote:

> On Thu, Jun 3, 2021, 14:57 Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
> >
> > On Thu, 3 Jun 2021 20:27:48 +0800
> > Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
> >  
> > > On Thu,  3 Jun 2021 10:27:47 +0200
> > > Alexandre Ghiti <alex@ghiti.fr> wrote:
> > >  
> > > > To simplify the kernel address conversion code, make the same definition of
> > > > kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for both xip
> > > > and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.
> > > >
> > > > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > > > ---
> > > >  arch/riscv/include/asm/page.h    | 14 +++-----------
> > > >  arch/riscv/include/asm/pgtable.h |  2 ++
> > > >  2 files changed, 5 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > > > index 6a7761c86ec2..6e004d8fda4d 100644
> > > > --- a/arch/riscv/include/asm/page.h
> > > > +++ b/arch/riscv/include/asm/page.h
> > > > @@ -93,9 +93,7 @@ extern unsigned long va_pa_offset;
> > > >  #ifdef CONFIG_64BIT
> > > >  extern unsigned long va_kernel_pa_offset;
> > > >  #endif
> > > > -#ifdef CONFIG_XIP_KERNEL
> > > >  extern unsigned long va_kernel_xip_pa_offset;
> > > > -#endif
> > > >  extern unsigned long pfn_base;
> > > >  #define ARCH_PFN_OFFSET            (pfn_base)
> > > >  #else
> > > > @@ -103,6 +101,7 @@ extern unsigned long pfn_base;
> > > >  #ifdef CONFIG_64BIT
> > > >  #define va_kernel_pa_offset        0
> > > >  #endif
> > > > +#define va_kernel_xip_pa_offset 0
> > > >  #define ARCH_PFN_OFFSET            (PAGE_OFFSET >> PAGE_SHIFT)
> > > >  #endif /* CONFIG_MMU */
> > > >
> > > > @@ -110,29 +109,22 @@ extern unsigned long kernel_virt_addr;
> > > >
> > > >  #ifdef CONFIG_64BIT
> > > >  #define linear_mapping_pa_to_va(x) ((void *)((unsigned long)(x) + va_pa_offset))
> > > > -#ifdef CONFIG_XIP_KERNEL
> > > >  #define kernel_mapping_pa_to_va(y) ({                                              \
> > > >     unsigned long _y = y;                                                           \
> > > >     (_y >= CONFIG_PHYS_RAM_BASE) ?  
> > >
> > > This CONFIG_PHYS_RAM_BASE is only available for XIP, could result in a
> > > compiler error for !XIP?
> > >
> > > I'm also concerned with the unecessary overhead of kernel_mapping_pa_to_va()
> > > for !XIP case, there's a "if" condition branch, and extra symbol: va_kernel_xip_pa_offset  
> >
> > Err, I just found this symobl always exists no matter XIP is enabled or not.
> > I will send out a patch for this clean up  
> 
> What cleanup?
> 

http://lists.infradead.org/pipermail/linux-riscv/2021-June/006802.html

