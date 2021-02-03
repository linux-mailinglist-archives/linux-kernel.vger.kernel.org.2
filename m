Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEEE30E3B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhBCUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBCUAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:00:20 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440EAC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:59:39 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d6so407692ilo.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 11:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wBF4byGd+5E5RDbtRZawGnYXYpJKJhfC8tVLt9zM8w=;
        b=a2wkcb/4QfG25qaZwMQxxvix0HyxSs4FEaOOAbuBCzA1qJh53X4e9amlvPQQMSacx2
         LojD1MKa5DQgo9iAwXwQC9LtrNulf831ymnBu7n9peNHieAbMpeUu7FHUkpBFU1dPlHx
         I7NXa4gWorr3JQVVsjCiuuT4p60uN/WS8LQPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wBF4byGd+5E5RDbtRZawGnYXYpJKJhfC8tVLt9zM8w=;
        b=iAM0tI0P3mXoAua1gvfoqnDL36jTPUqzFaC7gHAv451b8K4Da5Mu9XapP4wk9AUJ5x
         Ubtc0ssWP2ufMCwwyKpeUqgCg53vn2mAxtJJu+aTgXM+HpDgJWNygbpaNylHt9Y1hxAD
         b8jU2f82Bzn9ZXmLD+4RoceSAeWJmGWCA9VqiiidPwD3nfEPjbWwLY+yfpnHmDsPWuas
         RWOiCqUjgEW3yvW5XfOfceB4xrrALmEIUJemLY9c/omIsodaZmG7ydiIpHgLw4jeFqvv
         DDJh59k7CD6wGSAe28XcqG5xkqjxC8vtKTjP0xYibqd8oSkZDOQSoT1VOTH6Clw2aqUS
         jpUA==
X-Gm-Message-State: AOAM5305sh8jh5T59Q2WMcUe5aAeHgGzRDrIO2N2H1ZUam9QV/pYksWV
        auxhCWXhsnAOgTZ4Fqn778jnbil5UxjCsc415J4e
X-Google-Smtp-Source: ABdhPJwLt1oJOjkGGy63nTsaaj7bj6cUqa2ptsl23PUfXbwNgsfCvM8mzR1Mg558w2izIlRiHyzUG88wh07IktBk5Sc=
X-Received: by 2002:a05:6e02:1608:: with SMTP id t8mr3922687ilu.79.1612382378741;
 Wed, 03 Feb 2021 11:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20210203142343.59781-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20210203142343.59781-1-wangkefeng.wang@huawei.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 3 Feb 2021 11:59:27 -0800
Message-ID: <CAOnJCULd0=FoQjorjmz6EVB7_YphjGBwUCuY+ntOP6JiUb4P6w@mail.gmail.com>
Subject: Re: [PATCH -next] RISCV: Add some depends for NUMA
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 6:20 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> The numa feature is useless for riscv32 platform(MAXPHYSMEM_1GB if 32bit),
> and it should depends on SMP feature, this also fix the build error,
>
>   riscv64-buildroot-linux-gnu-ld: mm/page_alloc.o: in function `.L0 ':
>   page_alloc.c:(.text+0x4808): undefined reference to `node_reclaim_distance'
>

Thanks for the fix. The commit text is a bit ambiguous. The
compilation issue error is due to SMP.
RV32 dependency is just another fix  as NUMA is not very useful for RV32.

> Fixes: 4f0e8eef772e ("riscv: Add numa support for riscv64 platform")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 22fa17898d29..ac7f5801bd82 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -312,6 +312,8 @@ endchoice
>  # Common NUMA Features
>  config NUMA
>         bool "NUMA Memory Allocation and Scheduler Support"
> +       depends on SMP
> +       depends on 64BIT
>         select GENERIC_ARCH_NUMA
>         select OF_NUMA
>         select ARCH_SUPPORTS_NUMA_BALANCING
> --
> 2.26.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atish.patra@wdc.com>
-- 
Regards,
Atish
