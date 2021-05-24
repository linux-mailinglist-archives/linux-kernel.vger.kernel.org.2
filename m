Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5234B38E3AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhEXKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhEXKHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:07:04 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCBCC06138C
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 03:05:33 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so13535207otk.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KaEg544EKx/sjtrVBFvlwQggf1fXOzDvqUwgwSzvzl4=;
        b=EeLT1pDPker87k7YUNV9CUERwTgGs2rryic2+BmmUeIoJPp21eW/ngSn3LgajEXlve
         vWLBa84mnlHz0KGCdxmaHWTElGUdmxHFvSIz+6BkG4HMsjJTjvNPaMsRHWYOvj87BFMr
         22+Zqi/AU88HxSNhEq35ItxHrYsRogrLXf2zTK84hOwysRpUkiegoiBsym3u4/Sc4EfC
         qexSrbywI613fXcxXpmkaKBqOidiLsNGR8Y2wY1iAcNb7BjPdjvWcMMvdnGNTaO0ojiV
         W0gh4TxxznlnDQy+A11HL0VYPPa0b6xeRuwWcMb/sej9iAtKSn6H0SKD2uU71FKGxL22
         q9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KaEg544EKx/sjtrVBFvlwQggf1fXOzDvqUwgwSzvzl4=;
        b=G6XEFn+O0bj5mpsAkOLlMkA4/nUIFmhtKKVPfJEZgOSiabRzxCVK8z1eKI3yq6ppGL
         /4Pfq/v8Sev4c+E8Da45qj8sEEJsw6lW8Obh1fbTd1Hv8vuB5/a+bG43OzKhAEKzsTnL
         VJqWfrwDlOOeUdm5Df/hX1qt04KSm3gdFOS4ahX3rY59fx8MrHBmRvGaUOtHmDdLiHvX
         0RQDcotXcYADjTg3+kAJY/qfqUT0ywfPdkaxkFy9hinTvLSvZVoiGJMJgsn9jiY5zYy0
         dI9CI3TyQl2uv/4IQBG0u8kij6c3QQpHUgVFGxCMFqE2NsWpsx0NmH9LMNMOss3plNDf
         o1qA==
X-Gm-Message-State: AOAM533aMUZniTPbCBNlXQjKDsgY3LUbElm7PEFyHRAQLO8X7QIEhYQ2
        +UnlFc8OtkFKQRWF6HfbngJwbLUbcHBcDBdGFTKfhA==
X-Google-Smtp-Source: ABdhPJx+n9qvDWlTg5vzHHW9PD9FY8nCmrQJUlxnmSc0zBsnkG7oFdR7neKcSBrHmV/e8IpBBwDTltvqCYMtXsS21fE=
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr526619ots.233.1621850732396;
 Mon, 24 May 2021 03:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210524153659.58a707a9@xhacker.debian>
In-Reply-To: <20210524153659.58a707a9@xhacker.debian>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 May 2021 12:05:21 +0200
Message-ID: <CANpmjNPstZ8ytfmxqZFHMqDKSaZJtqCaOAmEC5n9R56YzC4GNg@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: don't use CON and BLK mapping if KFENCE is enabled
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 at 09:38, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Fix below warning if KFENCE=y but RODATA_FULL=n:
>

Is this patch still relevant given you just sent "arm64: remove page
granularity limitation from KFENCE" ?

> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at mm/memory.c:2462 apply_to_pmd_range+0xec/0x190
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-rc1+ #10
> [    0.000000] Hardware name: linux,dummy-virt (DT)
> [    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO BTYPE=--)
> [    0.000000] pc : apply_to_pmd_range+0xec/0x190
> [    0.000000] lr : __apply_to_page_range+0x94/0x170
> [    0.000000] sp : ffffffc010573e20
> [    0.000000] x29: ffffffc010573e20 x28: ffffff801f400000 x27: ffffff801f401000
> [    0.000000] x26: 0000000000000001 x25: ffffff801f400fff x24: ffffffc010573f28
> [    0.000000] x23: ffffffc01002b710 x22: ffffffc0105fa450 x21: ffffffc010573ee4
> [    0.000000] x20: ffffff801fffb7d0 x19: ffffff801f401000 x18: 00000000fffffffe
> [    0.000000] x17: 000000000000003f x16: 000000000000000a x15: ffffffc01060b940
> [    0.000000] x14: 0000000000000000 x13: 0098968000000000 x12: 0000000098968000
> [    0.000000] x11: 0000000000000000 x10: 0000000098968000 x9 : 0000000000000001
> [    0.000000] x8 : 0000000000000000 x7 : ffffffc010573ee4 x6 : 0000000000000001
> [    0.000000] x5 : ffffffc010573f28 x4 : ffffffc01002b710 x3 : 0000000040000000
> [    0.000000] x2 : ffffff801f5fffff x1 : 0000000000000001 x0 : 007800005f400705
> [    0.000000] Call trace:
> [    0.000000]  apply_to_pmd_range+0xec/0x190
> [    0.000000]  __apply_to_page_range+0x94/0x170
> [    0.000000]  apply_to_page_range+0x10/0x20
> [    0.000000]  __change_memory_common+0x50/0xdc
> [    0.000000]  set_memory_valid+0x30/0x40
> [    0.000000]  kfence_init_pool+0x9c/0x16c
> [    0.000000]  kfence_init+0x20/0x98
> [    0.000000]  start_kernel+0x284/0x3f8
>
> Fixes: 840b23986344 ("arm64, kfence: enable KFENCE for ARM64")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  arch/arm64/mm/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6dd9369e3ea0..89b66ef43a0f 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -515,7 +515,8 @@ static void __init map_mem(pgd_t *pgdp)
>          */
>         BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
>
> -       if (rodata_full || crash_mem_map || debug_pagealloc_enabled())
> +       if (rodata_full || crash_mem_map || debug_pagealloc_enabled() ||
> +           IS_ENABLED(CONFIG_KFENCE))
>                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>
>         /*
> --
> 2.31.0
>
