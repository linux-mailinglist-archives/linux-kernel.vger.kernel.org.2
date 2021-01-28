Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6C30780A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhA1O3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhA1O26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:28:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E8A464DDF;
        Thu, 28 Jan 2021 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611844097;
        bh=g+svnb872V2gEjrQRAURCdMhmMC6P1ol879JHGB4ztA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vN44u2RVR6z3VYYZVmETECBL9mFFYHCPI66S1E6Fx7OaPfcP+k8+mIs3ofK9ArU5O
         Lnrm8zUEWm+iDJadxDTrLMc57zKbhkju+ztz1+sCjI14lonOE8Hb/XmCfftMFffSge
         TcfoBIlLhORP8UQSuOwM/1e63MOcvkWUfXpnhAjqOjI/S0kUEXWCkCdoBKzRlXCgAa
         5kwmKuhpyKTgJE11VQOznqRNNDAVViKMHXVk7khF+3/24ZQmrvblJtprHyF/Vr0ECS
         +T2Fhm67x6nB0ejgBze5G77sgEDPaSLeV1tSTlEXo/59z0AvwgV9xVb8W9wh96u0QZ
         htnvnRenHajiw==
Received: by mail-oi1-f179.google.com with SMTP id k25so6148114oik.13;
        Thu, 28 Jan 2021 06:28:17 -0800 (PST)
X-Gm-Message-State: AOAM530gDYYX47X8hvX6bSYvBwRdw+s0X1DUrH0hn+8ClTGkMaFuO4Uw
        NSlgxf2+h0kv52mNBbZU4WfklGsYd9aS8Pych9I=
X-Google-Smtp-Source: ABdhPJzvR965chipjx26jhgmeWtunUplGEZ9LYudt2xG6T6psgopbevW0CweYJAmTen4xv/AOVDG+rkdGPAwQdSS/Zc=
X-Received: by 2002:aca:d908:: with SMTP id q8mr137434oig.67.1611844096571;
 Thu, 28 Jan 2021 06:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20210116032740.873-1-thunder.leizhen@huawei.com> <20210116032740.873-3-thunder.leizhen@huawei.com>
In-Reply-To: <20210116032740.873-3-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 28 Jan 2021 15:28:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1biznW80EjZLK-LKDVgs0iZ6oiqXOjgU_rctcxRWj1qA@mail.gmail.com>
Message-ID: <CAK8P3a1biznW80EjZLK-LKDVgs0iZ6oiqXOjgU_rctcxRWj1qA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] ARM: hisi: add support for Kunpeng50x SoC
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 4:32 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Enable support for the Hisilicon Kunpeng506 and Kunpeng509 SoC.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm/mach-hisi/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
> index 2e980f834a6aa1b..c724acc5c642b97 100644
> --- a/arch/arm/mach-hisi/Kconfig
> +++ b/arch/arm/mach-hisi/Kconfig
> @@ -55,6 +55,14 @@ config ARCH_HIX5HD2
>         help
>           Support for Hisilicon HIX5HD2 SoC family
>
> +config ARCH_KUNPENG50X
> +       bool "Hisilicon Kunpeng50x family"
> +       depends on ARCH_MULTI_V7
> +       select ARCH_FLATMEM_ENABLE
> +       select ARCH_HAS_HOLES_MEMORYMODEL if SPARSEMEM

I think the two 'select' statements are both wrong, though for
different reasons:

- ARCH_FLATMEM_ENABLE is already selected by ARCH_MULTIPLATFORM,
  and is something that should not be platform specific

- ARCH_HAS_HOLES_MEMORYMODEL was removed in v5.11,
  and should also not be selected by a platform.

Otherwise, this seems fine.

         Arnd
