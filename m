Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363C13326F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhCINYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:24:08 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:26885 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhCINXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:23:34 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 129DNEQS012165
        for <linux-kernel@vger.kernel.org>; Tue, 9 Mar 2021 22:23:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 129DNEQS012165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615296195;
        bh=CbxFHgVB2SQpcb7VqdqRvEaqw6KWWQMVs3wq83fC9II=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H7BjHJmkJdH7UxMG1b9+HPUXTaQjAMU9LdYogVB3/sm3ljM/fmYsCUXO5GEHwxOxb
         yWuz3kTtoZanY2b8FqMmucj+fFuB1+NYTjVtg/7dknF0zHJ5EUuqVtvctndTc6G8A1
         Buj2Mz5x/vthBsx1nhm/t/LLdCDB87gydxwe1NTRaIXFYtKXNIYn6Ikt2dAgDPqSV5
         uZQ9HGpBO5Q35UfzHpBlf2jegJGokKodBA8YcWrD1xL+FEB2y65kyM98gJELlTLpay
         /KrCg8YwPZkRes4mARE3+tZTPMpOTEJEn5Jxztnepozi+wGnmZvdf/3eo44Wmpx+ja
         7JfvYtijWIIow==
X-Nifty-SrcIP: [209.85.216.49]
Received: by mail-pj1-f49.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso2742703pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:23:15 -0800 (PST)
X-Gm-Message-State: AOAM533t9mndTUZj8BThpyLm8md8qZBqfjgNPH0OobPoObdMpf16WymN
        b60crvVn+kqSM26YRC1AIaV+bQonVBBqcRuQbI8=
X-Google-Smtp-Source: ABdhPJzow4w2e+hJT29V+2d6CV+NG/d5KPhJP+FZyJVekp6Fwamd2svGL+/DBpfJCfSWpya7xsKKGbXzHrMWpHE2pGQ=
X-Received: by 2002:a17:90a:5510:: with SMTP id b16mr4718167pji.87.1615296194334;
 Tue, 09 Mar 2021 05:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20210309123544.14040-1-msuchanek@suse.de>
In-Reply-To: <20210309123544.14040-1-msuchanek@suse.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 9 Mar 2021 22:22:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+8mGunqXSPLHxhF1FTXQEzbAoKPY=48pBgtLbhcB0jg@mail.gmail.com>
Message-ID: <CAK7LNAT+8mGunqXSPLHxhF1FTXQEzbAoKPY=48pBgtLbhcB0jg@mail.gmail.com>
Subject: Re: [PATCH] arm64: make STACKPROTECTOR_PER_TASK configurable.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 9:35 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> When using dummy-tools STACKPROTECTOR_PER_TASK is unconditionally
> selected. This defeats the purpose of the all-enabled tool.
>
> Description copied from arm
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>


Could you explain what problem
this patch is trying to solve?


> ---
>  arch/arm64/Kconfig | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a8ff7cd5f096..f59d391e31a4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1549,9 +1549,20 @@ config RANDOMIZE_MODULE_REGION_FULL
>  config CC_HAVE_STACKPROTECTOR_SYSREG
>         def_bool $(cc-option,-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=0)
>
> +
>  config STACKPROTECTOR_PER_TASK
> -       def_bool y
> +       bool "Use a unique stack canary value for each task"
>         depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
> +       default y
> +       help
> +         Due to the fact that GCC uses an ordinary symbol reference from
> +         which to load the value of the stack canary, this value can only
> +         change at reboot time on SMP systems, and all tasks running in the
> +         kernel's address space are forced to use the same canary value for
> +         the entire duration that the system is up.
> +
> +         Enable this option to switch to a different method that uses a
> +         different canary value for each task.
>
>  endmenu
>
> --
> 2.26.2
>


-- 
Best Regards
Masahiro Yamada
