Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3CD41B379
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbhI1QFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:05:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbhI1QFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:05:40 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBDvU-1mgkpV0Ta2-00CjlS for <linux-kernel@vger.kernel.org>; Tue, 28 Sep
 2021 18:03:59 +0200
Received: by mail-wr1-f41.google.com with SMTP id s21so18904726wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:03:59 -0700 (PDT)
X-Gm-Message-State: AOAM530EA8/mQ8konAhHIfY76jOF4ZOjo1nz7ImJWLqYi3lwyOsS19iv
        TJWGX8ZLy3hEzu0W2a3PPbBUq347EeQW2R/2Eek=
X-Google-Smtp-Source: ABdhPJw+coVsYhAKlrQ8b/B+WK+KvNu4fWn5G6HVe+DPeBuINN0lX7+Ci9tC38wz5cxx9uuIJ0yoR8dy9/Ij5UWd+qg=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr994769wru.336.1632845038822;
 Tue, 28 Sep 2021 09:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-2-arnd@kernel.org>
In-Reply-To: <20210928154143.2106903-2-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Sep 2021 18:03:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2mrVOXHzNKnLuHsdNCR3uVePE9W-Yn2CmW3nDpE8J7iA@mail.gmail.com>
Message-ID: <CAK8P3a2mrVOXHzNKnLuHsdNCR3uVePE9W-Yn2CmW3nDpE8J7iA@mail.gmail.com>
Subject: Re: [PATCH 01/14] ARM: RiscPC needs older gcc version
To:     Russell King <linux@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/w0L4XuowLl2x7uR67SP8bAtVqLBOvqrtY0O5QxT43msAx3Z7f6
 HF23PZCuTpR1c1LsHSaA6RDZRvAnRfpk6HwoBTkuLKiz4gmIz3IxMFilM5aszdxtXcwdfTi
 iD7UzX2K/fKDCWqPal7Tyx9Ty4GNUXzcCxPFxR1D7Mb9XJX0SxSHSBsKTZhvB/7if09lcnF
 7tfb76ynPFWY5tnEKMXhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IBfpXaO6lkQ=:q67Xn0/7nl9F7OHRagefLY
 88sQskRM9zptRo09LlhFKbBU3j5rDuXIOBfW3UjKHTXiIwDhGZUiga9kwa0YogBJ2Gp1CESnu
 aiF7vFt0qm2GgrhWQPo2ZkzczPl1Y3m/ueFR6qdANNXiUo8oaZeyHP7KkwsPbPp63F46drJjj
 l0ds3nb0njxnReUqIrDtIyfYMz0xrgAfl6xXsPFMeinzDDesck8uVbKArqK7LgB261+UzJ4fG
 VeROUeLHPjYKgb7kfhUt2+11glqGzNPLGB8DgkiHnhRoD20Hw5d5exF8zld3fg0nmCsPV3Iek
 rdwwHqylIk7sizZm1MTjqlGGKDvnSvVfHUIF8Bl4JSI7RsNNjtvXRCCsFUekM8qOyC4akayBR
 Bs65IPLjT7fiHoJkrTthUdspzIdFYaPAqBvzkfW3KWYA9AWBNNKMSrw5N1ifWLIvF1VHKfmAJ
 6r+nNfj4A7UdTNr9T02NG1UOjy/SBuHeYD7a3DOPpTT5Mak3kNEB8yiKXum42gXketGGZzrQN
 cng353DsreiEx5LwIMfxSnlSv/uoJFHyPaO3JNsc9L+9F6qj3bk9MWa8wS+uQVrwTcEZcF8gc
 UrscNKa6l6jemTO/tpfKcd1P/KbOF8VYSvPsBZaUELJsydz5O7+cyH4GAsOrFtOququsZE/PT
 Vu0Fs4VTTg0wDr3RLBS2woqbLIvJVRlCTsHiLmM0dZay6HwjAcwciK0enQT4/KEl0kJcTyjzc
 BUYeYICmIgo5UIVYflAoIXqrr7qR+pf+67KeuQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 5:42 PM Arnd Bergmann <arnd@kernel.org> wrote:

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fc196421b2ce..12a0bd4b315d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -431,7 +431,7 @@ config ARCH_PXA
>
>  config ARCH_RPC
>         bool "RiscPC"
> -       depends on MMU

This line was a botched rebase, it obviously has to stay here.

      Arnd

> +       depends on !CC_IS_CLANG || GCC_VERSION < 90100
>         select ARCH_ACORN
>         select ARCH_MAY_HAVE_PC_FDC
>         select ARCH_SPARSEMEM_ENABLE
> --
> 2.29.2
>
