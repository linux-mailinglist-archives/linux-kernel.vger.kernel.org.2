Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF937A491
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEKK1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231340AbhEKK12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:27:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29BA26192C
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620728782;
        bh=95zZVK7qfIh+tOUiU4moyxlDwWV95Vmvl6IczEmpWaQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jB28dGoEQZhWVX4kG3NoWMrOUOJqKxtGnVTy20zjRDxZSYi5HDoH9X4KG04ToeloA
         cDtUs47l0amh5owyQHo9Y71oQ4LjdMeLKiJKekCv6EqMBcFAvE6kFY+zLTpnzK2c02
         7NweGlJAUMef4+eX+40tudEHBQhgb9TWfDjReYJgblgVGGMr9/GmZ/91vitXEd782t
         g9xjaa2eZafJ5DzGUi2oT6AyQqRubnfU9TEwg5H9ElYCJfxuOahiwURSuGFYl4ZES1
         rQXX3sG+FHbaG+SB1zpITPkwnC4j3iSe7CdYaT/+XuyT3ovBDEvX1eDXOge37ZUbm5
         6GXvX4c06Mn7w==
Received: by mail-ot1-f47.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso17061856otg.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:26:22 -0700 (PDT)
X-Gm-Message-State: AOAM533HyY+13MQi9DpLVqSBLVR5wEJgsb5C/LRAHGTgH5C5Etmx5SBW
        rnLG14elyAXaitk8hbE7bgF2xI/lYdnvvm4p15M=
X-Google-Smtp-Source: ABdhPJx7OAWZjUg75AH1MONFkX/rKqoEq6W+l0O8JhjgsRoszXYlOPWDD3ytFXdgmlzvdYrIN3iUwS6soQhwbypE0Tw=
X-Received: by 2002:a9d:7cd8:: with SMTP id r24mr13558179otn.90.1620728781371;
 Tue, 11 May 2021 03:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210511100550.28178-1-rppt@kernel.org> <20210511100550.28178-5-rppt@kernel.org>
In-Reply-To: <20210511100550.28178-5-rppt@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 11 May 2021 12:26:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE=XMhr6WB+DUZYN9Fr95azn6t_B7VS3BckMPNTn_ohkg@mail.gmail.com>
Message-ID: <CAMj1kXE=XMhr6WB+DUZYN9Fr95azn6t_B7VS3BckMPNTn_ohkg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: drop pfn_valid_within() and simplify pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 12:06, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> The arm64's version of pfn_valid() differs from the generic because of two
> reasons:
>
> * Parts of the memory map are freed during boot. This makes it necessary to
>   verify that there is actual physical memory that corresponds to a pfn
>   which is done by querying memblock.
>
> * There are NOMAP memory regions. These regions are not mapped in the
>   linear map and until the previous commit the struct pages representing
>   these areas had default values.
>
> As the consequence of absence of the special treatment of NOMAP regions in
> the memory map it was necessary to use memblock_is_map_memory() in
> pfn_valid() and to have pfn_valid_within() aliased to pfn_valid() so that
> generic mm functionality would not treat a NOMAP page as a normal page.
>
> Since the NOMAP regions are now marked as PageReserved(), pfn walkers and
> the rest of core mm will treat them as unusable memory and thus
> pfn_valid_within() is no longer required at all and can be disabled by
> removing CONFIG_HOLES_IN_ZONE on arm64.
>
> pfn_valid() can be slightly simplified by replacing
> memblock_is_map_memory() with memblock_is_memory().
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

... and many thanks for cleaning this up.


> ---
>  arch/arm64/Kconfig   | 3 ---
>  arch/arm64/mm/init.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 9f1d8566bbf9..d7dc8698cf8e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1052,9 +1052,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>         def_bool y
>         depends on NUMA
>
> -config HOLES_IN_ZONE
> -       def_bool y
> -
>  source "kernel/Kconfig.hz"
>
>  config ARCH_SPARSEMEM_ENABLE
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 798f74f501d5..fb07218da2c0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -251,7 +251,7 @@ int pfn_valid(unsigned long pfn)
>         if (!early_section(ms))
>                 return pfn_section_valid(ms, pfn);
>
> -       return memblock_is_map_memory(addr);
> +       return memblock_is_memory(addr);
>  }
>  EXPORT_SYMBOL(pfn_valid);
>
> --
> 2.28.0
>
