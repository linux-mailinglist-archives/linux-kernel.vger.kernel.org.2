Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2436E789
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbhD2JFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhD2JF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:05:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F634C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:04:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a22-20020a05600c2256b0290142870824e9so3908554wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JhU1X3vzNY9wzqlownyXgot5D1Z6xMdc1aK+MIYwVRU=;
        b=t/IbhjoE8jmfMZ9QBRuEgF4tv6CnbIFCLQAno93ZIaMtu5yv3p3e3DT29e5uJ4ziA7
         N+AFskSWzdmW9bPZYeBZXw7Q9jZuU2t+/l+tuwVNC6igNHRFYgz2IW0Diaotbj5TzwsD
         sLvhjVAAAU0gsE1qCZDkQnAJMsQRX6bgfouJZQutiHPYTzWUwU11KFfUzqaAEkUxPonm
         hVgVlYeSCu6BM3G9000OFKy/4zTlUrFRM7L6kkfTxUkExY8YzN/7ugaRmhppDePFGB8g
         SSKSZRHa8bFvL+E8Eh6bDfr0KPQvcOs8WxWltxBcjdHGFR5pFfqg2oTjT9CpdEwa6u33
         zSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhU1X3vzNY9wzqlownyXgot5D1Z6xMdc1aK+MIYwVRU=;
        b=OtEOVIX6sjerC1J5qlmc+yhPyw/EoiYs8624wfu6UIbjPcnMrt7vnde/g6l74KCbyX
         gQd5eLoFF/zxETm5tM2+9G2t7WE0nE1OwDVLCqmWT2PkOp9hCt2OBUz7AcpwylD/KpOI
         pQc46+SjlzlZ1uOoSiw9EESxsXPawSrf3MZOEXdazqD/XxhbKqVTDC4m4xn0jtJc1oI9
         lo2fi266Gxw5ZJlu40twWus3KiPvRu3D3rNWGfuLpjRPp1/d4ufZzJ6gWrRC6UWVtFTT
         9JY4ZwmtML9hFVAQQNuU0zZyRuANlYbSeAcgL60nDY0bE8KX/0jhmzm/ITNGUAF2c+N4
         defg==
X-Gm-Message-State: AOAM5303cfUj5u0wc3G+ATURP4rGREJtHhYHYM7ZPaKD6PKfWFsC2kJV
        Z7/hytqe7T40ZIaX4DT7zGEJtZe0XpCfx6E/MbmsBQ==
X-Google-Smtp-Source: ABdhPJzkClW+CZRM7U3328nJPfxASbz419Mgf0KujwF2sTQwvB0Bo179KhVMxhhdAv31iWSBSVxYp7xOyAOc9tfk4JY=
X-Received: by 2002:a7b:c348:: with SMTP id l8mr9414474wmj.152.1619687079775;
 Thu, 29 Apr 2021 02:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210429084541.28083-1-alex@ghiti.fr>
In-Reply-To: <20210429084541.28083-1-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 29 Apr 2021 14:34:28 +0530
Message-ID: <CAAhSdy0Wxjop+X2AUp8azDS9JdD21pmdapUjH0vU9rNBu7Evjg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Disallow to build XIP_KERNEL with SOC_SIFIVE
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 2:15 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> RISCV_ERRATA_ALTERNATIVE patches text at runtime which is not possible when
> the kernel is executed from the flash in XIP mode, and as the SIFIVE
> errata must be fixed somehow, disallow to build a XIP kernel that
> supports SIFIVE socs.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/Kconfig.erratas | 2 +-
>  arch/riscv/Kconfig.socs    | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index d5d03ae8d685..9537dbd67357 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -2,7 +2,7 @@ menu "CPU errata selection"
>
>  config RISCV_ERRATA_ALTERNATIVE
>         bool "RISC-V alternative scheme"
> -       default y
> +       default y if !XIP_KERNEL
>         help
>           This Kconfig allows the kernel to automatically patch the
>           errata required by the execution platform at run time. The
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 00c2b205654c..9cb38bc9d7cd 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -9,6 +9,7 @@ config SOC_MICROCHIP_POLARFIRE
>
>  config SOC_SIFIVE
>         bool "SiFive SoCs"
> +       depends on !XIP_KERNEL

Does this mean that now all SOCs will have to explicitly say
"depends on !XIP_KERNEL"

How about adding "depends on !XIP_KERNEL" for RISCV_ERRATA_ALTERNATIVE ?

Regards,
Anup

>         select SERIAL_SIFIVE if TTY
>         select SERIAL_SIFIVE_CONSOLE if TTY
>         select CLK_SIFIVE
> --
> 2.20.1
>
