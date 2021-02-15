Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC0B31C272
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBOT2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhBOT2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:28:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BF0964E30
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613417246;
        bh=w4G+ZyLh+woYu86LtKHqAZTToaVVIVyNYojyfWZy4Pk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fss4mr6R/HB8LOl1IsZjElpSpNxIVYQBQMXv9v01Ga86WVLR0+7eHcmmgDDYpfBBN
         pIpbWh4Zw6Pp8wypOl7R8ndrFnbIxjDOYRirwgIN8Z2wLiFbVLEwFlg6DE7SLea9Yj
         42KzxJg9jnIfZqiMNfK+e6MK+2ukk51bZfXe2VmWFLZvxCP7ikKdXBQAJ3HsA1fbjD
         VLRwZTtk6+ktdM1VrYiLDPcUQbawdIzekguJVOVs6RSLLfr2+TGTcrDf38nSI/il2W
         jdONh7pUdn8AmX6fTr9FQI7HehxEJxKAWoqLBc8xR3F/d6vJJwxFbAK5tLFncqgorn
         3GKdL8ZIWtOZA==
Received: by mail-ot1-f45.google.com with SMTP id b8so2381726oti.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:27:26 -0800 (PST)
X-Gm-Message-State: AOAM5337VPiyK7vhEBmef8J6jI+gAdvbBGpZH5/FE2C0WbfmwA3nSwhG
        D/xgsECoNKBOH3A9SnOg/4QhByIMet+LotCodFs=
X-Google-Smtp-Source: ABdhPJwNkT0sikbJpgwWhRHKNYVROgTfvnA7OWHSMYLlbr6mYQ2CfJLwVJUPykJQX7pXYX+klwaJAUWxeM2a1GZmz6U=
X-Received: by 2002:a05:6830:13ce:: with SMTP id e14mr12009264otq.108.1613417245716;
 Mon, 15 Feb 2021 11:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20210215192237.362706-1-pasha.tatashin@soleen.com> <20210215192237.362706-2-pasha.tatashin@soleen.com>
In-Reply-To: <20210215192237.362706-2-pasha.tatashin@soleen.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Feb 2021 20:27:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
Message-ID: <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: mm: correct the inside linear map
 boundaries during hotplug check
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 at 20:22, Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
> linear map range is not checked correctly.
>
> The start physical address that linear map covers can be actually at the
> end of the range because of randomization. Check that and if so reduce it
> to 0.
>
> This can be verified on QEMU with setting kaslr-seed to ~0ul:
>
> memstart_offset_seed = 0xffff
> START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
> END:   __pa(PAGE_END - 1) =  1000bfffffff
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
> Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>

> ---
>  arch/arm64/mm/mmu.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ae0c3d023824..cc16443ea67f 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1444,14 +1444,30 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
>
>  static bool inside_linear_region(u64 start, u64 size)
>  {
> +       u64 start_linear_pa = __pa(_PAGE_OFFSET(vabits_actual));
> +       u64 end_linear_pa = __pa(PAGE_END - 1);
> +
> +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> +               /*
> +                * Check for a wrap, it is possible because of randomized linear
> +                * mapping the start physical address is actually bigger than
> +                * the end physical address. In this case set start to zero
> +                * because [0, end_linear_pa] range must still be able to cover
> +                * all addressable physical addresses.
> +                */
> +               if (start_linear_pa > end_linear_pa)
> +                       start_linear_pa = 0;
> +       }
> +
> +       WARN_ON(start_linear_pa > end_linear_pa);
> +
>         /*
>          * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
>          * accommodating both its ends but excluding PAGE_END. Max physical
>          * range which can be mapped inside this linear mapping range, must
>          * also be derived from its end points.
>          */
> -       return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
> -              (start + size - 1) <= __pa(PAGE_END - 1);

Can't we simply use signed arithmetic here? This expression works fine
if the quantities are all interpreted as s64 instead of u64


> +       return start >= start_linear_pa && (start + size - 1) <= end_linear_pa;
>  }
>
>  int arch_add_memory(int nid, u64 start, u64 size,
> --
> 2.25.1
>
