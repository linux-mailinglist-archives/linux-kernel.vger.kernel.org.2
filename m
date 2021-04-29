Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B35236E7AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhD2JMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhD2JMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:12:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5274C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:12:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 4so43808618lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUQerQ7HmMjJ6I/BYS0A6Oi2QMhIX3dppb9FwnW9e9Y=;
        b=qRK90K4NjKongoIsln74lxIykKe/b2JvthSH33TfE2+g+CFr5PbnjGg4nkINSkxGpz
         PfmGGOHik/6elmqnxUB14vTAM9+M6l+nlU/atjUAKRk7y+0fpq5cEqtkyXYHkJBo89Bp
         7/5BschtB4EGHak5z7CgmUf45Bw/uy55yFMQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUQerQ7HmMjJ6I/BYS0A6Oi2QMhIX3dppb9FwnW9e9Y=;
        b=AwuUEEzfecgI9P3boDenYqmhzlyKRDbRnk8K5Ui6UkwvPlKE3o+5qjLk4trwWyvbK1
         dnNV9UUE4ACQZZrkvSmu7a6YN8egq5ldBb1vDVl4EvvHdeu6dGSunmlF9n1uDtboCXs7
         R0rGRVuejR/ZVkzcmMxNwMJcXE/M9U7smhpVfJJj829vPCgb64CdVIImOm6VCGlDS/kZ
         cXPsUm3EEx5prAFmLDyzilfY7uSKNmVpbzizVWYUTAnsRv5DRRDrMzksIDDojajS6Emg
         E9g4P/pVFm87SAP5qZ8MdXrT7vRN+Escq9q3GCUF1j23hcndN0iVDlqHTu6nuOLAKIRU
         YU7Q==
X-Gm-Message-State: AOAM530rpspfflc8Ngkq3CfyeRe7DdHZUlVkfo5BScaHZySpaJyGg/1W
        hM1vJhWcEa+V7iNx/brrir6hgAi8uJ4Bsn7tGKgNDg==
X-Google-Smtp-Source: ABdhPJwspHTwzOKICOpQaGFTHLVSyBQKTmIgOM5MIuJdnlGQ9vUHRtihLVXMxS4r52+QEJjZjC3nMP7Y9gaLzBivkx4=
X-Received: by 2002:ac2:5335:: with SMTP id f21mr23886022lfh.288.1619687526274;
 Thu, 29 Apr 2021 02:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210429084541.28083-1-alex@ghiti.fr>
In-Reply-To: <20210429084541.28083-1-alex@ghiti.fr>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 29 Apr 2021 11:11:55 +0200
Message-ID: <CAM4kBBK=yQ=jXYw85Ti7Y3EyGd11aOYt7QnD4+fFFkDhvrwcxA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Disallow to build XIP_KERNEL with SOC_SIFIVE
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:47 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> RISCV_ERRATA_ALTERNATIVE patches text at runtime which is not possible when
> the kernel is executed from the flash in XIP mode, and as the SIFIVE
> errata must be fixed somehow, disallow to build a XIP kernel that
> supports SIFIVE socs.

Could you please hold off this patch for a bit? I will try to come up
with an alternative solution. It should be possible to define a
special section within the RW area and place the functions that need
such patching there.
Not that I like that much but at least we'll keep the ability to use
XIP on SiFive.

Best regards,
   Vitaly

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
>         select SERIAL_SIFIVE if TTY
>         select SERIAL_SIFIVE_CONSOLE if TTY
>         select CLK_SIFIVE
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
