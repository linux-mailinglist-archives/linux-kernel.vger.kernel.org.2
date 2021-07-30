Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A084F3DBB0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbhG3OtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:49:00 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50063 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhG3Osy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:48:54 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MEF87-1mHUZW220j-00AIuU; Fri, 30 Jul 2021 16:48:47 +0200
Received: by mail-wm1-f53.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so6571490wms.0;
        Fri, 30 Jul 2021 07:48:47 -0700 (PDT)
X-Gm-Message-State: AOAM532W48PRPlWNKyrVz+bhKa+YRIZjm5brFPiLH6HLu7uDUDTU5q3N
        40EAimBfdhrhKRZ6+umwmzhEi0C7aKtDWUeCGyU=
X-Google-Smtp-Source: ABdhPJwxA8AAasBBW3VKflsPcxiuqWSltuaS5SquSu42uKZuyUP5jQPtS+/EQtoTrxkhDcf5NycgUzqgKr/2pIRgW9w=
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr3407459wmm.120.1627656527120;
 Fri, 30 Jul 2021 07:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134552.853350-1-bert@biot.com> <20210730134552.853350-5-bert@biot.com>
In-Reply-To: <20210730134552.853350-5-bert@biot.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Jul 2021 16:48:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com>
Message-ID: <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
To:     Bert Vermeulen <bert@biot.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        John Crispin <john@phrozen.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hskRNcduIWRyAvf6oOytdqFz5krLFwyvXBVRljfe9BftBbt6/rV
 TGRbL+WJFtj6w5IPrpY5zJPP/JbltzrfL03Np7e7aaYX/mWgmpmK3XF6KPB3l7NMryIKk2V
 PFb3En/EntLO0WyDd5LxDUAo5TRsaJaSxp48U3z1+v68IlF5VX2AT7UcmXfwwpuk78OTYBp
 WhUtEqfoPYERkHSQVbmDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ryVFF2M6/2Q=:zvEUHgygZYPKG/ZJs0uqZw
 BmKOZTqyDoVh/pHWznQn7o7TXzPPw2sHcqDQQUSudhYMfrY5tsWH4mAsPfRSnEBAe19Q81eC1
 lZclmoJ3hrjn+c91ibBTms9NXyr2rDhUBLI6KyeQm8SlRXoShBtBJC7rEmFEZb4/Pvh6oQcjw
 eksj01L5OoKQZ+JCZTR2i+4Ui7ljq+Vjz9GS8SQILtrEQqnZUjdmJPFM0jAGT6s1aUlAAGuSQ
 8CRcV11/U4XQzA/ONPdRqKVgQCtK3xyIwA/jVv+Gka7oPsq280M3JRngL+7c+8olnQdBMCZEj
 RYR5iVUC2i54Ye1lIMtZBrzTxAiwWL8tLoSDHyQiwAibt/zqJ7H2mEEQbjcEQEdyb2Sat3B3x
 VhiVIvXLzQlyon+mmDCHm+UXx1xub41ftGe3TG4if/4ybagpebxUi+vn+p4Yvy3RPqbjDy2+6
 VB2ITl5Sd6OmumGJSph03gB9isAVXloXJYF3mTm6kOG7IYxWo1cHl6syzEwBK/9nK7YmO0Zo4
 NT23Pgaw00/khcblmwRk7qq7jzkJbDOejTTqv8ztAsYR8kQnJgI8F+D/bTqGM6FwyQIIo8XLb
 z2qMRRfjju5xqIV5F5le4quvIS1ECIwIeqLveEUrLtRJbp5772uOR0Dfl/WzM8Q3fNml/q5Ay
 PFKy/Ysa0JS82wRl4NhlLCsTEM9IYehitgt55ip8ymgIz0XTNQh8ZmytZw8YsObMtvtGe1mbJ
 c3uHheZ+cHH2Tzynmidd1BOWtyPAEPA2+F5+nbNb4yYRK+6GTytctqZ+c2kOUNol5OCpxdKBZ
 sb3CFkvyxB46F4Zg3/i8BA4gsRulytbNGzOPEJkaHfzxWmz2DfbNrNENDkzniap/ZLsj8De
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 3:45 PM Bert Vermeulen <bert@biot.com> wrote:
>
> From: John Crispin <john@phrozen.org>
>
> EN7523 is an armv7 based silicon used inside broadband access type devices
> such as xPON and xDSL. It shares various silicon blocks with MediaTek
> silicon such as the MT7622.
>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>

It's always nice to see a new SoC family.

> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -580,6 +580,20 @@ config ARCH_VIRT
>         select HAVE_ARM_ARCH_TIMER
>         select ARCH_SUPPORTS_BIG_ENDIAN
>
> +config ARCH_ECONET
> +       bool "Econet SoC Support"
> +       depends on ARCH_MULTI_V7
> +       select ARM_AMBA
> +       select ARM_GIC
> +       select ARM_GIC_V3
> +       select ARM_DMA_USE_IOMMU
> +       select ARM_PSCI
> +       select HAVE_ARM_ARCH_TIMER
> +       select IOMMU_DMA
> +       select COMMON_CLK
> +       help
> +         Support for Econet EN7523 SoCs

Given how closely related this probably is to MT7623/MT7622, should this
perhaps just be part of arch/arm/mach-mediatek? According to
https://wikidevi.wi-cat.ru/MediaTek#xPON, the older (mips based) MT752x
chips are apparently just rebranded to EN752x after the business unit
was spun off, but I guess they are still in the same family.

> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 173da685a52e..1bff0aa29c07 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
>  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
>  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
>  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
> +textofs-$(CONFIG_ARCH_ECONET) := 0x00088000

Why is this needed?

Note also the comment directly above it exlaining
# Text offset. This list is sorted numerically by address in order to
# provide a means to avoid/resolve conflicts in multi-arch kernels.

       Arnd
