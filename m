Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3102440E66
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 13:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJaM20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 08:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhJaM2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 08:28:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B62360FC1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635683154;
        bh=nkgv+EKvnqTzv1dwMoIWYog82u0og4ytb4jtBgoI1O8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KidqRsyay24vaA00k0pgaaXq1Dbys+mZari5FTvfynX9jQVbo+kW5luky8SYB6LCT
         Nde7aVVJ7VE4/VUG0qA1PU0sKX9fWHeWPGkTAXrcPOdSO33ovhp1ByHZ1XikQDAkI7
         TvB/3+M0kgPZEcFZlJ9GrCe8LZdmo0r8xGdH8A9pWaewPoogeaE5aWbWqUPyCYz+OZ
         0T/RPXsLtXbzegx/6bwe7Bd1m+bdkPeQ06AeSxRX1qMNXvwPSadhpCMhN45CnEOhm+
         tXOenWotEVKcJUbDd78elXo739SSyta0pUBMPM7Nv4kPClAu9lprMnVwbM4EriWvDb
         exnQrAVBtUrig==
Received: by mail-oi1-f180.google.com with SMTP id w193so20933188oie.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 05:25:54 -0700 (PDT)
X-Gm-Message-State: AOAM531ZKi8q7TM8/EF6BMNTVTsNJfEHhRzQHWE5y6rJv94joB6W5qLs
        s8ob5lycEz5CtFHZuTxWR6KpoHwxyxFTI2Q5wss=
X-Google-Smtp-Source: ABdhPJweqivRLp599eXWrFHYU3iTyc3SQ2IgU/Lu43BfXW/lirAZtZp27sSAHu+ELOFl6ZfjbJQHgULEilOLm9gwwhg=
X-Received: by 2002:a05:6808:4d9:: with SMTP id a25mr15669997oie.33.1635683153473;
 Sun, 31 Oct 2021 05:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211030183200.51295-1-rongwei.wang@linux.alibaba.com> <20211030183200.51295-2-rongwei.wang@linux.alibaba.com>
In-Reply-To: <20211030183200.51295-2-rongwei.wang@linux.alibaba.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 31 Oct 2021 13:25:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHnhnyyL4_WnUFdjJhk7Rcz8hLG8d13y3nRkV5xvBoPKg@mail.gmail.com>
Message-ID: <CAMj1kXHnhnyyL4_WnUFdjJhk7Rcz8hLG8d13y3nRkV5xvBoPKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: trans_pgd: fix incorrect use of
 pmd_populate_kernel in copy_pte()
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2021 at 20:32, Rongwei Wang
<rongwei.wang@linux.alibaba.com> wrote:
>
> In commit 5de59884ac0e ("arm64: trans_pgd: pass NULL instead
> of init_mm to *_populate functions"), simply replace init_mm
> with NULL for pmd_populate_kernel. But in commit 59511cfd08f3
> ("arm64: mm: use XN table mapping attributes for user/kernel
> mappings"), adding the check of mm context in
> pmd_populate_kernel. And these changes will cause a crash when
> executing copy_pte/trans_pgd.c, as follows:
>
> kernel BUG at arch/arm64/include/asm/pgalloc.h:79!
> Internal error: Oops - BUG: 0 [#1] SMP
> Modules linked in: rfkill(E) aes_ce_blk(E) aes_ce_cipher(E) ...
> CPU: 21 PID: 1617 Comm: a.out Kdump: loaded Tainted: ... 5.15.0-rc7-mm1+ #8
> Hardware name: ECS, BIOS 0.0.0 02/06/2015
> pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : trans_pgd_create_copy+0x4ac/0x4f0
> lr : trans_pgd_create_copy+0x34c/0x4f0
> sp : ffff80001bf2bc50
> x29: ffff80001bf2bc50 x28: ffff0010067f1000 x27: ffff800011072000
> x26: ffff001fffff8000 x25: ffff008000000000 x24: 0040000000000041
> x23: 0040000000000001 x22: ffff80001bf2bd68 x21: ffff80001188ded8
> x20: ffff800000000000 x19: ffff000000000000 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 00000000200004c0
> x14: ffff00003fffffff x13: ffff007fffffffff x12: ffff800010f882a8
> x11: 0000000000face57 x10: 0000000000000001 x9 : 0000000000000000
> x8 : ffff00100cece000 x7 : ffff001001c9f000 x6 : ffff00100ae40000
> x5 : 0000000000000040 x4 : 0000000000000000 x3 : ffff001fffff7000
> x2 : ffff000000200000 x1 : ffff000040000000 x0 : ffff00100cecd000
> Call trace:
>  trans_pgd_create_copy+0x4ac/0x4f0
>  machine_kexec_post_load+0x94/0x3bc
>  do_kexec_load+0x11c/0x2e0
>  __arm64_sys_kexec_load+0xa8/0xf4
>  invoke_syscall+0x50/0x120
>  el0_svc_common.constprop.0+0x58/0x190
>  do_el0_svc+0x2c/0x90
>  el0_svc+0x28/0xe0
>  el0t_64_sync_handler+0xb0/0xb4
>  el0t_64_sync+0x180/0x184
> Code: f90000c0 d5033a9f d5033fdf 17ffff7b (d4210000)
> ---[ end trace cc5461ffe1a085db ]---
> Kernel panic - not syncing: Oops - BUG: Fatal exception
>
> This bug can be reproduced by a user case:
>
> void execute_kexec_load(void)
> {
>         syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>         syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
>         syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>
>         *(uint64_t*)0x200004c0 = 0;
>         *(uint64_t*)0x200004c8 = 0;
>         *(uint64_t*)0x200004d0 = 0;
>         *(uint64_t*)0x200004d8 = 0;
>         syscall(__NR_kexec_load, 0ul, 1ul, 0x200004c0ul, 0ul);
> }
>
> And this patch just make some simple changes, and including
> replace pmd_populate_kernel with pmd_populate.
>
> Fixes: 59511cfd08f3 ("arm64: mm: use XN table mapping attributes for user/kernel mappings")
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> ---
>  arch/arm64/mm/trans_pgd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> index d7da8ca40d2e..3f1fc6cb9c9d 100644
> --- a/arch/arm64/mm/trans_pgd.c
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -62,12 +62,13 @@ static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
>  {
>         pte_t *src_ptep;
>         pte_t *dst_ptep;
> +       struct page *page;
>         unsigned long addr = start;
>
> -       dst_ptep = trans_alloc(info);
> -       if (!dst_ptep)
> +       page = virt_to_page(trans_alloc(info));
> +       if (!page)
>                 return -ENOMEM;
> -       pmd_populate_kernel(NULL, dst_pmdp, dst_ptep);
> +       pmd_populate(NULL, dst_pmdp, page);

Are you sure this truly fixes the underlying issue rather than the symptom?

pmd_populate() will create a table entry with the PXN attribute set,
which means nothing below it will be executable by the kernel,
regardless of the executable permissions at the PTE level.


>         dst_ptep = pte_offset_kernel(dst_pmdp, start);
>
>         src_ptep = pte_offset_kernel(src_pmdp, start);
> --
> 2.27.0
>
