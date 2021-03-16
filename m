Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD34933CCE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhCPFGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhCPFFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:05:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4A3C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:05:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d15so9775747wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rZPaiH/yLq0MFAG35XUjXrCO0vB48E4LQTZ529JMwM=;
        b=yzKHB/sj0OrojWnnyNv5CkC4WHXtNIJLI1b1CsWFdrfmC5WfyBbkiUxDe++33+yQvE
         7f8eseKsakhlg40g2gBu+kfGQkxMfqyuyKPSkcv7n6IfGktuGzdq6OzDYah+RcJ1yyRg
         NkWwMqKbG2G49SrT2aeIPzvrFBuRfBjzMH2zd85igOUJsdJJcdq652pfqu64R36UPnqH
         GKfTSvifu6E76jvNiKTcSJf234VaDFSWLGUS3ZI2nvE6u8pldceXL0o/8uHnf4gmhIKM
         s7LUL/yMg9GrNdNZvjpaK3jV/ddFaloOnVrv0z0bhMpyGmpiYx8aLMdhlht1wDe320wR
         LdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rZPaiH/yLq0MFAG35XUjXrCO0vB48E4LQTZ529JMwM=;
        b=QXo3HvtdyHFujQafH9DqCdepQVBDMThL0o5iVNGLFGKSCxpXrb4saFseP6u90nFBgU
         tbZcy+U30YRQb7t7kQppEN5MBxvfOeKpD55dJT+JFdaposSJbFb1ExeYgU0bZVK75+bO
         zsC4xOFnrIR9v4LNz17+Ua38CYwhoecTfrUele2I0fs8YyqyUpFp9mGYZK93kx47SmbG
         nCmLyKiWlJXETd2dCb5Gi3h/y6fK6McIdGvVE9JeZ5baNQWx/BH60FdWHwQqNtbzIYrG
         amWeo0suR7G4mGDH5Qw5MHssGQDzG1lIAp7K+x9XLY+Kog8gVDn5zlmx97BPt1rEE2eN
         Echw==
X-Gm-Message-State: AOAM532Q6ULHBiUHxuCwg68Pfth4r3k5aVY9qf6eE7iZa/Ac2MaRmiq4
        cj2psDxvHJZJryLwnCGJkKICO11Lkk0Y4sXeUZdzBw==
X-Google-Smtp-Source: ABdhPJxXkpJb4tW52fMmIx4jAzy+Kw374RtzHxkfzAZabF5T1ohxVHpJRhZ6rYBTD41wHDr5gn9s3bsMyVTCZHXvvD4=
X-Received: by 2002:adf:9544:: with SMTP id 62mr2695924wrs.128.1615871149865;
 Mon, 15 Mar 2021 22:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210316015328.13516-1-liu@jiuyang.me> <20210316034638.16276-1-liu@jiuyang.me>
In-Reply-To: <20210316034638.16276-1-liu@jiuyang.me>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 16 Mar 2021 10:35:38 +0530
Message-ID: <CAAhSdy3eEXtba_ebUnPW_OUHRMKsg+O9sBx_DHAmrkTUCfHXNg@mail.gmail.com>
Subject: Re: [PATCH] Insert SFENCE.VMA in function set_pte_at for RISCV
To:     Jiuyang Liu <liu@jiuyang.me>, Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Waterman <waterman@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Alex

On Tue, Mar 16, 2021 at 9:20 AM Jiuyang Liu <liu@jiuyang.me> wrote:
>
> This patch inserts SFENCE.VMA after modifying PTE based on RISC-V
> specification.
>
> arch/riscv/include/asm/pgtable.h:
> 1. implement pte_user, pte_global and pte_leaf to check correspond
> attribute of a pte_t.

Adding pte_user(), pte_global(), and pte_leaf() is fine.

>
> 2. insert SFENCE.VMA in set_pte_at based on RISC-V Volume 2, Privileged
> Spec v. 20190608 page 66 and 67:
> If software modifies a non-leaf PTE, it should execute SFENCE.VMA with
> rs1=x0. If any PTE along the traversal path had its G bit set, rs2 must
> be x0; otherwise, rs2 should be set to the ASID for which the
> translation is being modified.
> If software modifies a leaf PTE, it should execute SFENCE.VMA with rs1
> set to a virtual address within the page. If any PTE along the traversal
> path had its G bit set, rs2 must be x0; otherwise, rs2 should be set to
> the ASID for which the translation is being modified.
>
> arch/riscv/include/asm/tlbflush.h:
> 1. implement get_current_asid to get current program asid.
> 2. implement local_flush_tlb_asid to flush tlb with asid.

As per my understanding, we don't need to explicitly invalidate local TLB
in set_pte() or set_pet_at() because generic Linux page table management
(<linux>/mm/*) will call the appropriate flush_tlb_xyz() function after page
table updates. Also, just local TLB flush is generally not sufficient because
a lot of page tables will be used accross on multiple HARTs.

>
> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> ---
>  arch/riscv/include/asm/pgtable.h  | 27 +++++++++++++++++++++++++++
>  arch/riscv/include/asm/tlbflush.h | 12 ++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index ebf817c1bdf4..5a47c60372c1 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -222,6 +222,16 @@ static inline int pte_write(pte_t pte)
>         return pte_val(pte) & _PAGE_WRITE;
>  }
>
> +static inline int pte_user(pte_t pte)
> +{
> +       return pte_val(pte) & _PAGE_USER;
> +}
> +
> +static inline int pte_global(pte_t pte)
> +{
> +       return pte_val(pte) & _PAGE_GLOBAL;
> +}
> +
>  static inline int pte_exec(pte_t pte)
>  {
>         return pte_val(pte) & _PAGE_EXEC;
> @@ -248,6 +258,11 @@ static inline int pte_special(pte_t pte)
>         return pte_val(pte) & _PAGE_SPECIAL;
>  }
>
> +static inline int pte_leaf(pte_t pte)
> +{
> +       return pte_val(pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC);
> +}
> +
>  /* static inline pte_t pte_rdprotect(pte_t pte) */
>
>  static inline pte_t pte_wrprotect(pte_t pte)
> @@ -358,6 +373,18 @@ static inline void set_pte_at(struct mm_struct *mm,
>                 flush_icache_pte(pteval);
>
>         set_pte(ptep, pteval);
> +
> +       if (pte_present(pteval)) {
> +               if (pte_leaf(pteval)) {
> +                       local_flush_tlb_page(addr);
> +               } else {
> +                       if (pte_global(pteval))
> +                               local_flush_tlb_all();
> +                       else
> +                               local_flush_tlb_asid();
> +
> +               }
> +       }
>  }
>
>  static inline void pte_clear(struct mm_struct *mm,
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 394cfbccdcd9..1f9b62b3670b 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -21,6 +21,18 @@ static inline void local_flush_tlb_page(unsigned long addr)
>  {
>         __asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
>  }
> +
> +static inline unsigned long get_current_asid(void)
> +{
> +       return (csr_read(CSR_SATP) >> SATP_ASID_SHIFT) & SATP_ASID_MASK;
> +}
> +
> +static inline void local_flush_tlb_asid(void)
> +{
> +       unsigned long asid = get_current_asid();
> +       __asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
> +}
> +
>  #else /* CONFIG_MMU */
>  #define local_flush_tlb_all()                  do { } while (0)
>  #define local_flush_tlb_page(addr)             do { } while (0)
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup
