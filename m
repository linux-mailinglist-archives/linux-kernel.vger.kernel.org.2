Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF145B546
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbhKXHZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:25:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235488AbhKXHZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:25:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C6866069B;
        Wed, 24 Nov 2021 07:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637738557;
        bh=m+3a1qX76TOmy0A/GhuywzFOTTKk1nZ3PH5KhZasyeo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SNnims8xeSABSjkfJg++ZfHXR7acdlnBfNWTSQpEpU9VcK4e7qrVU4jqPY6B0dU1M
         yVAym3I29Dy+Cv09oFBjN9mWcC+eNrXAA78PgiV7lxjFIWjs//g1z7KiAqopa/GwCD
         LgHMJ0MeCKu3CqXj7yYEsEEfdSc/Hoon8ahxzGDBPsH4RbW17hLHWogPcU0Kf1w2o8
         tsnyuJHF/+y0Bl9CWCzONk6LM1PpTwJAUn3QBjzmmIzQ4pBK8BPYYd/r5itpVBtuJM
         syhWAWdlwwAxOOvWWt2LGRsGBC6Vvxitq6Bgbtr8PSXRTzeRwWZ2QzF0+BQDznbq4a
         63U/Sy1iV5ezw==
Received: by mail-ua1-f53.google.com with SMTP id o1so3146104uap.4;
        Tue, 23 Nov 2021 23:22:37 -0800 (PST)
X-Gm-Message-State: AOAM532l0j/IePY7hfM6OBwPcIv/tddaFpMaI2mK/emvwVkr6khrQRBQ
        MIRYgHF6bATC2bHf94k+RzWeIV1QFD+1xK/RhEs=
X-Google-Smtp-Source: ABdhPJx0YOtKVw+POvXrhVmjRsH6kZEPFr+RFNGWIpADmf6yHbBf8CHOPdlm5hTz+qL/nQoaLC4UAC+sw6lqLbGPtEI=
X-Received: by 2002:ab0:5b59:: with SMTP id v25mr6588500uae.57.1637738556783;
 Tue, 23 Nov 2021 23:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20211124060521.614015-1-guoren@kernel.org> <CAAhSdy1CZbdAPEYxFOhrn=wUcmc9Yea0ziMUmHjaudKdH2Yw1w@mail.gmail.com>
In-Reply-To: <CAAhSdy1CZbdAPEYxFOhrn=wUcmc9Yea0ziMUmHjaudKdH2Yw1w@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 24 Nov 2021 15:22:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRAXAmo4cVSfArf=eMU9CxXZr3kjaKcQ1u8764cnL+N_Q@mail.gmail.com>
Message-ID: <CAJF2gTRAXAmo4cVSfArf=eMU9CxXZr3kjaKcQ1u8764cnL+N_Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup one-page wasting
To:     Anup Patel <anup@brainfault.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Atish Patra <Atish.Patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 2:55 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Nov 24, 2021 at 11:35 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > For small memory systems(Allwinner D1s/F133), one page size memory
> > cannot be ignored.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Alexandre Ghiti <alex@ghiti.fr>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Atish Patra <Atish.Patra@wdc.com>
>
> This PATCH breaks the CPU hotplug functionality.
>
> When a CPU/HART is turned off and turned on at runtime, the
> low-level relocate() will be called to enable MMU on the CPU
> being brought-up which in-turn uses trampoline_pg_dir.
Yeah, I forgot that.

How about removing trampoline_pg_dir totally and using
early_pg_dir/swapper_pg_dir for relocate directly?

>
> Regards,
> Anup
>
> > ---
> >  arch/riscv/mm/init.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 24b2b8044602..097bb3bc4020 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -241,9 +241,9 @@ unsigned long riscv_pfn_base __ro_after_init;
> >  EXPORT_SYMBOL(riscv_pfn_base);
> >
> >  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> > -pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> >  static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> >
> > +pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> >  pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> >  static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> >
> > --
> > 2.25.1
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
