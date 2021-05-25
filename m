Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387AF38FD33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhEYIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhEYIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:54:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E00C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:52:35 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so27905706otp.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S983RmEN+zCzGygvTomJowV0VqiLAFWLutr88hzTzxw=;
        b=DbQN+qgl1anJcSKUR0sYPQRpRiflWrFMnrR7kkeYJy0FQ5VD0ZE57trudkUUgESzSf
         ytqU5GoQ/xzctSsN4DItUI57KUC5v7TwHPali4oP10CnFzx+z3kWE2ynujI3t557WNhW
         8O5z8wKHIEpUUACm3x+3ToIuvY0pfSQFe4s/vgD4mXA+OUbuSLj89jzZTSB6a+jClPsE
         /2AHzsU05IImCxEYHZN8NWOtHc1e9U7aOekTUS6djnDJ8dSQWidxLq+R+E/flRMvz4bg
         y8eztIXisoRD9hfuhcwfqPk9eSLS/RvJ396xIg6zyPkrYFwNuemzZ36XMkEVjZ6Td94v
         fQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S983RmEN+zCzGygvTomJowV0VqiLAFWLutr88hzTzxw=;
        b=cPs7xqCYnDz8x8HLWrv3JrM1oUXhxPLpuYldMpE1nLYK5I1DMGA8VyfC2jVYfy2IVj
         JyBj0h/lj2Jy1id86PasHlqjPo/brzQqubeClxCqICLDLD7Y8VmNUPgHfhiqeLVmZosn
         r/vSoqNf/w9hmzVt6T0TAGrjcyFJhSiI6PCJ/2EPcT53MWR/I/9RCEby0BaNX/tXMIWD
         Fbm3BC/M8lsCjiX+vr4G5tZ5PykjDaZQ0424Fc5YhfI74sRTravAESAOyybpIj+J91E0
         Y/NiP2B0xg8aj0VsRgmuc7u8NKMryOQboZ1YF0z/3PH4kpGANnHsH1ftsaLXFU9j8wmg
         MiPA==
X-Gm-Message-State: AOAM531ybAQsoI8Emxdt4hpqi8a+xmZRZ09mpv7TN4X9pqtDrlLZk80W
        qaTnFbs2arhGSxcY2p3YdYStea9b+QVIxZ2QCYfo/Q==
X-Google-Smtp-Source: ABdhPJxI8s2jTZ5Bz7kX5AUrHHR69TdApWCOpzJQDD2JTfJhGMoCahNrKr3EGl7b+eYguFtbLZxwQg9nWVtbAy5BeZQ=
X-Received: by 2002:a05:6830:349b:: with SMTP id c27mr23119899otu.251.1621932754928;
 Tue, 25 May 2021 01:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-f2825fd1-15e0-403d-b972-d327494525e6@palmerdabbelt-glaptop> <0b584a85-79e2-fcdd-2adf-5b63f56cc591@huawei.com>
In-Reply-To: <0b584a85-79e2-fcdd-2adf-5b63f56cc591@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 25 May 2021 10:52:23 +0200
Message-ID: <CANpmjNPuhUVMdVYNMaQc1NARzp2w+A8A6F16L=WmzWpJOWz_sg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] riscv: Enable KFENCE for riscv64
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 at 03:56, Liu Shixin <liushixin2@huawei.com> wrote:
> On 2021/5/23 10:38, Palmer Dabbelt wrote:
> > On Fri, 14 May 2021 08:20:10 PDT (-0700), elver@google.com wrote:
> >> On Fri, 14 May 2021 at 05:11, Liu Shixin <liushixin2@huawei.com> wrote=
:
> >>> Add architecture specific implementation details for KFENCE and enabl=
e
> >>> KFENCE for the riscv64 architecture. In particular, this implements t=
he
> >>> required interface in <asm/kfence.h>.
> >>>
> >>> KFENCE requires that attributes for pages from its memory pool can
> >>> individually be set. Therefore, force the kfence pool to be mapped at
> >>> page granularity.
> >>>
> >>> I tested this patch using the testcases in kfence_test.c and all pass=
ed.
> >>>
> >>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >>
> >> Acked-by: Marco Elver <elver@google.com>
> >>
> >>
> >>> ---
> >>> v1->v2: Change kmalloc() to pte_alloc_one_kernel() for allocating pte=
.
> >>>
> >>>  arch/riscv/Kconfig              |  1 +
> >>>  arch/riscv/include/asm/kfence.h | 51 +++++++++++++++++++++++++++++++=
++
> >>>  arch/riscv/mm/fault.c           | 11 ++++++-
> >>>  3 files changed, 62 insertions(+), 1 deletion(-)
> >>>  create mode 100644 arch/riscv/include/asm/kfence.h
> >>>
> >>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>> index c426e7d20907..000d8aba1030 100644
> >>> --- a/arch/riscv/Kconfig
> >>> +++ b/arch/riscv/Kconfig
> >>> @@ -64,6 +64,7 @@ config RISCV
> >>>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >>>         select HAVE_ARCH_KASAN if MMU && 64BIT
> >>>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
> >>> +       select HAVE_ARCH_KFENCE if MMU && 64BIT
> >>>         select HAVE_ARCH_KGDB
> >>>         select HAVE_ARCH_KGDB_QXFER_PKT
> >>>         select HAVE_ARCH_MMAP_RND_BITS if MMU
> >>> diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm=
/kfence.h
> >>> new file mode 100644
> >>> index 000000000000..c25d67e0b8ba
> >>> --- /dev/null
> >>> +++ b/arch/riscv/include/asm/kfence.h
> >>> @@ -0,0 +1,51 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +
> >>> +#ifndef _ASM_RISCV_KFENCE_H
> >>> +#define _ASM_RISCV_KFENCE_H
> >>> +
> >>> +#include <linux/kfence.h>
> >>> +#include <linux/pfn.h>
> >>> +#include <asm-generic/pgalloc.h>
> >>> +#include <asm/pgtable.h>
> >>> +
> >>> +static inline bool arch_kfence_init_pool(void)
> >>> +{
> >>> +       int i;
> >>> +       unsigned long addr;
> >>> +       pte_t *pte;
> >>> +       pmd_t *pmd;
> >>> +
> >>> +       for (addr =3D (unsigned long)__kfence_pool; is_kfence_address=
((void *)addr);
> >>> +            addr +=3D PAGE_SIZE) {
> >>> +               pte =3D virt_to_kpte(addr);
> >>> +               pmd =3D pmd_off_k(addr);
> >>> +
> >>> +               if (!pmd_leaf(*pmd) && pte_present(*pte))
> >>> +                       continue;
> >>> +
> >>> +               pte =3D pte_alloc_one_kernel(&init_mm);
> >>> +               for (i =3D 0; i < PTRS_PER_PTE; i++)
> >>> +                       set_pte(pte + i, pfn_pte(PFN_DOWN(__pa((addr =
& PMD_MASK) + i * PAGE_SIZE)), PAGE_KERNEL));
> >>> +
> >>> +               set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(pte)), PAGE_TABLE)=
);
> >>> +               flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> >>> +       }
> >>> +
> >>> +       return true;
> >>> +}
> >
> > I'm not fundamentally opposed to this, but the arm64 approach where pag=
es are split at runtime when they have mis-matched permissions seems cleane=
r to me.  I'm not sure why x86 is doing it during init, though, as IIUC set=
_memory_4k() will work for both.
> >
> > Upgrading our __set_memory() with the ability to split pages (like arm6=
4 has) seems generally useful, and would let us trivially implement the dyn=
amic version of this.  We'll probably end up with the ability to split page=
s anyway, so that would be the least code in the long run.
> >
> > If there's some reason to prefer statically allocating the pages I'm fi=
ne with this, though.
> >
> As I understand=EF=BC=8Cthe arm64 approach does not implement dynamic spl=
itting.
> If kfence is enabled in arch arm64, the linear map need to be forcibly ma=
pped
> at page granularity. But x86 does not have such constraints as it only sp=
lit pages
> in the kfence pool, so I think the x86 approach is better as it has less =
influence
> on the whole.

Correct.

I think either riscv gains set_memory_4k(), like x86, or we go with
the approach in this patch. Unless you see this is trivially
implementable, I wouldn't want to block this patch. It's better to
have something working, and then incrementally improve later if riscv
ever gets set_memory_4k().

Thanks,
-- Marco
