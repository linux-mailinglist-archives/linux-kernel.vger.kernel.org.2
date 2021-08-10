Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B193E5278
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhHJEz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhHJEz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:55:59 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1047C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:55:37 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id h7-20020a4ab4470000b0290263c143bcb2so5030957ooo.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmsMf35zTdaoUj3oiQt7gw4OgBcT1En81zKadpNn/No=;
        b=shz03uptQm2duha7ZUkpvHh5KSx7nzGS2KJ6dhmO4x0Si2KLtPdk0kBOWmy6JCCefv
         rqwOp50eH2s07aFli9nZBL7AiawL3P5sZRTBlZTfdT2cWOO3Bvyz3gWuV+ZC476CIB9n
         /uIDBEXtKX8ARC3eNWzHugtQtVmifeiQXtrmH0APc88RHOMTY45PcTVZRhbHEB+KkG+X
         9g5jnuWZyzqZym4AWAtKzcl31PpiAn14PKc0WiGdEoNpUB3BhPU1d75vuG/X/R835hfT
         bRADrOvxCY4lXjRgvQ+zOj/mKv2o+wH+34IvyyvPg2xxkv2AgyxVsVi739zbFBoDMzxd
         B8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmsMf35zTdaoUj3oiQt7gw4OgBcT1En81zKadpNn/No=;
        b=fi+btZTCmAeo+et/qeeCgHqts6/SXGkYq28KFl1qMPRHmbcJmff7kU06k+BfvLrhnZ
         KdMe3cz885+Shxbil/JM7a7ARb6zDzIsIHbDZLt5Sq/hicCDNWXc0InwY9ttg4W4D7nt
         XPUri0oQ0TdLXKk6M/uVqeMPy4K3OO1opGvEFsFXQBy5U9v443/6NU1wEkuRdVYBupnO
         tPii9nEsEKPf48I+r+rO7uUGiWKKcHBHzQLTG4YbcO4PKlZhk44g66mmlUqboT6/Uidc
         85Sa/qah3S48ZK4h21DAZfoJmUXnrvJkB4dkKSnJ6LU/uD7eCd9R/ozUFZLZ7LfchDIK
         qasQ==
X-Gm-Message-State: AOAM533Dv/dhCeEswwi1uGs2V48MEux1p3HF+nlpp4iO0DeY+eJc6l+a
        4m+6g9BEe6PCxodsjEmmolD1738frKwRe490zKGfvA==
X-Google-Smtp-Source: ABdhPJx3zBvrdOUCIqwcPKtkix3hMsfC8nzn+fHxLC6Fac+88W+YYZJh/qx7nmiwao/qYiR0gb/t05gmIgMkUHq88po=
X-Received: by 2002:a4a:c896:: with SMTP id t22mr8317214ooq.70.1628571336932;
 Mon, 09 Aug 2021 21:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-22-qperret@google.com>
In-Reply-To: <20210809152448.1810400-22-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 Aug 2021 06:55:00 +0200
Message-ID: <CA+EHjTz4fYdAj50KXkeccb4SMxiwWeZBz1ORhs99kY76ZF=9OA@mail.gmail.com>
Subject: Re: [PATCH v4 21/21] KVM: arm64: Make __pkvm_create_mappings static
To:     Quentin Perret <qperret@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Mon, Aug 9, 2021 at 5:25 PM Quentin Perret <qperret@google.com> wrote:
>
> The __pkvm_create_mappings() function is no longer used outside of
> nvhe/mm.c, make it static.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

>  arch/arm64/kvm/hyp/include/nvhe/mm.h | 2 --
>  arch/arm64/kvm/hyp/nvhe/mm.c         | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> index c76d7136ed9b..c9a8f535212e 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> @@ -24,8 +24,6 @@ int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
>  int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
>  int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
>  int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
> -int __pkvm_create_mappings(unsigned long start, unsigned long size,
> -                          unsigned long phys, enum kvm_pgtable_prot prot);
>  unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
>                                             enum kvm_pgtable_prot prot);
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
> index 6fbe8e8030f6..2fabeceb889a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mm.c
> @@ -23,8 +23,8 @@ u64 __io_map_base;
>  struct memblock_region hyp_memory[HYP_MEMBLOCK_REGIONS];
>  unsigned int hyp_memblock_nr;
>
> -int __pkvm_create_mappings(unsigned long start, unsigned long size,
> -                         unsigned long phys, enum kvm_pgtable_prot prot)
> +static int __pkvm_create_mappings(unsigned long start, unsigned long size,
> +                                 unsigned long phys, enum kvm_pgtable_prot prot)
>  {
>         int err;
>
> --
> 2.32.0.605.g8dce9f2422-goog
>
