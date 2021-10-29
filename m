Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF878440545
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 00:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJ2WIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 18:08:16 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJ2WIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:08:15 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mzydy-1mtHtm3LZW-00x5NC for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021
 00:05:44 +0200
Received: by mail-wr1-f43.google.com with SMTP id u18so18865663wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:05:44 -0700 (PDT)
X-Gm-Message-State: AOAM530H/wtUY/3yZbzluDy+jn63vJcIckBBziQRcyEvv76rzdroo/lg
        wWDg7b6/4bFBJUgY8ii35QbOxoKU36SzS5c9XYM=
X-Google-Smtp-Source: ABdhPJzfwgv0LbgG3Xfr6UzxkXiZK9hLeraT8h4hEKjoLlmK3OAyU4Iib390eAxpmKqgo6ROOvk/JmnenK1h2Z2xv4E=
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr17331452wrq.411.1635545144483;
 Fri, 29 Oct 2021 15:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211029203110.8343-1-julianbraha@gmail.com>
In-Reply-To: <20211029203110.8343-1-julianbraha@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Oct 2021 00:05:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1L8x48ZGhFKaMNa0MXCGrouw2EEwe9uo640bnnf=4dOA@mail.gmail.com>
Message-ID: <CAK8P3a1L8x48ZGhFKaMNa0MXCGrouw2EEwe9uo640bnnf=4dOA@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix unmet dependency on BITREVERSE for HAVE_ARCH_BITREVERSE
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fazilyildiran@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Vupko7xIT5uNd9SYbd+5fxgmOxygq6hPgunKDTymd0BhZQySXhd
 WDUm/3CcUHiY7NjuLScIQtlzNWWELBp4tBDRAnpLUKafOFr+ehGxGw0eh5OretM1atMtSr8
 75jnteroEHTrK+JEHo7IywY3/KsocH7yCRK7PGR89VOK5keeA/Uma56zx1ZuIViAGUbn9AH
 q7J0fmZzgsYNowbUQRFPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ga9JNT9RWjo=:Xk5179wHn3DiAgGVGmyNO0
 91WTOK3no8/SP9TQrbxGk3kCR9GXfDhJAFmBj+Ie5ciG5gEv4Fkg+DNzzIN2jh6MMZLH2dIEO
 Tcf/YNpJ+t2Yd+QWQvJ33pDJv6Wn23G3/KKqxgeWAUVfHKsmzYnAup7fYiEMlYLwvKFvGheoA
 bF+NPt2WeoRPfObWQVreE+cSO89f7tQaU1J61UEz2UIsY2xNlW6kJAYboIPxMbWbFn4OUHbtG
 1Wp8syPEForFwYKmuEIB4vTqmR8JHIS5wB0+3nSrHaGGnfFr5hkuidun3LT0FkYzdFi2GCMck
 DCSmFdcK1l/l3G1XSL/xAKbp6UqTgBDFM7r7nNV9yfhnwwCJbkuEnkO1pDIWlS4P9RL07gUgI
 ZP7EHUPwLuAkMFdxByQh4m//01XeOBYD6XkeiX+w13DKjQi4AIEBJ5u92t4k354BB+BFSW9z9
 vojFSpRzrC7vY4dRan0l137+aQKEYPDSaHpfTzvfNrOBc5BR6MSOzFcW8HL0nDv9JuXY6TY59
 9KbcuLvgVoujS6iXnnY/AvFXmk6ClQ0tz7CYJQz1fE+2WoW7bU98+jBQyKfOAOM8NNZ9c4jxd
 XewoIMAt8feIpJv75ypmDeRtmuKtxHA3BegVwPLe53JhMFPcmiFcStlrq6fNa3lRZikde9dkW
 zmw46EVbIfC1lIeM2jki13LkrnCCAYn+qoBsc2IS4eBUR/HN/h7qdzhVApD4A3AJlhs0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 10:31 PM Julian Braha <julianbraha@gmail.com> wrote:
>
> When ARM is enabled, and BITREVERSE is disabled,
> Kbuild gives the following warning:
>
> WARNING: unmet direct dependencies detected for HAVE_ARCH_BITREVERSE
>   Depends on [n]: BITREVERSE [=n]
>   Selected by [y]:
>   - ARM [=y] && (CPU_32v7M [=n] || CPU_32v7 [=y]) && !CPU_32v6 [=n]
>
> This is because ARM selects HAVE_ARCH_BITREVERSE
> without selecting BITREVERSE, despite
> HAVE_ARCH_BITREVERSE depending on BITREVERSE.
>
> This unmet dependency bug was found by Kismet,
> a static analysis tool for Kconfig. Please advise if this
> is not the appropriate solution.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

This works, but I think it would be better handled differently:

The other 'select BITREVERSE' instances are for drivers that use
bitrever(), not those that provide it.

We can probably just remove the dependency. Alternatively we could
change arch/arm/ to

     select HAVE_ARCH_BITREVERSE if BITREVERSE && ((CPU_32v7M ||
CPU_32v7) && !CPU_32v6)

Regardless of what we do here, note that

a) the 'select' lines in CONFIG_ARM are sorted alphabetically, and
   should be kept that way

b) the same probably exists on arch/mips and arch/arm64, whatever we
   do here should be the same as on the other architectures.

        Arnd
