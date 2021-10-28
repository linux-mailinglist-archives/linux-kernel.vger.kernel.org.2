Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D543E3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhJ1OmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:42:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42695 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhJ1OmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:42:04 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1McYP5-1nELWM3KUH-00d1Ud; Thu, 28 Oct 2021 16:39:35 +0200
Received: by mail-wr1-f44.google.com with SMTP id e4so10597062wrc.7;
        Thu, 28 Oct 2021 07:39:35 -0700 (PDT)
X-Gm-Message-State: AOAM533Fmk/gHzgo4WG+rvoS55ej8i90ec6DYx+dkdkPxCxCVSJ4F5A2
        4Z/XDdvymZM+ulMCAPdphUJvr2KeZI0MK1zyXa4=
X-Google-Smtp-Source: ABdhPJywcxOpdNSzG6Dz7Wo0Mfr5ZcmBRbk8+ke27ZX22Ol8jLoYbLDirLsu+KPslnCjLkVgZLhdwSyWSSptfkSO3xA=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr6354304wrq.428.1635431975426;
 Thu, 28 Oct 2021 07:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-3-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-3-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:39:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2raR70Xw3AT=BSojvqvua4WGeYrzasp+i7bnwTLVcxhg@mail.gmail.com>
Message-ID: <CAK8P3a2raR70Xw3AT=BSojvqvua4WGeYrzasp+i7bnwTLVcxhg@mail.gmail.com>
Subject: Re: [PATCH 02/13] arm: debug: reuse the config DEBUG_OMAP2UART{1,2}
 for OMAP{3,4,5}
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:O0+hG/032u5qnVL/LYERTy7yBBZqLM4cqY9KOXWXCEcfdFfJl6E
 855AovJ4XK8jzqhG1qKTfAGNFQ0vEIb5MMeKO59Ed2zLeL5tLHGLPuqlPDxokxQrDGzPW+l
 0HbmD+XJGE4GKsSMJJa/n/e4kQT+Btoth+AAva4DVFAbWd54TnigzHBqEMyxHdMBzX1Voj6
 eKXFx+S4O9eSg8zUSeoMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2/Tj9EHEsjQ=:5NqSNS2BxTu6Z/88fqYViy
 gcSPnND3qxNHoYANDG9nPtZ08It9M5vIXlgK+rc2Z64PQMHwaHiM3jnhcVplgbfGOEbxa8v47
 sHcn9vEmJ7uglduOkWK1as5AWIkZdTX864LTbMRUBhoLYIVEFu4UYdphKKRHZ8D98uRLR6kiR
 hQa3JrdcfaRkbtA3EbJrpVwg5XI557Jt7xeB0J9HTW7WtVLoSpo3Q3NoFc0qYlzNZGlwXxRnU
 tbg7xwudfbPhipC4U6voTcRot3ffVClhx1FZYtkBYGsmbk8i9ZBRyXkHtKkVaI592cVO35NNA
 6+iOHBtx1vuBYYr/TJuDJlqE1iUCH9mMVPjbMmB+Gje1m+vVM/cbpVpc/CwXQeJd9OUBDlqyn
 ztX7c7Rxb6uoT7eaQziuPHFEfpCaRt1GkL6I38NR7fdFGfnzgEbjwzUvwIUzoh1XEmo1kCbYx
 rUgtYDiqQ1ukoEUfCFUliMUV0hN0rGn9ca2xjXJSYAjbflGwuK3+skrYfnILyrDckUyXtiLwa
 NAdDO6szXEQ4CjtvFVgXxDDPEc/PJmuT82YOwSBo97UapEsswaVbTvEOcKnRC2PSvNCoDgR/o
 QXQHNEjquSnmfgCSy1v9xXP+T25eg0ozXQAeO5QJYDMamAbcslcVIyK5glT8XbsmcpGvnwOaV
 6ne4oR71dm8CDfduAV0Pxcg7ChhxeWXTk/emh+BdvAjUj2a77MrXYv1N//YxdCLNrXsLwgRBY
 vbV2oDYQRk4FqTVU0QXUkI13xj/LnxN79ponfwc4byhfF9Zqo1Thm0N4v9wZffY7faiwUyYXr
 H/QvGRyAdVDJKDgqHw++mFiQT/iZ/kld14KjvkiAo+vh23kajE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit d2b310b0234c ("ARM: debug: Use generic 8250 debug_ll for omap2 and
> omap3/4/5 common uarts") adds address definitions of DEBUG_UART_PHYS for
> OMAP2, OMAP3, OMAP4 and OMAP5 in ./arch/arm/Kconfig.debug.
>
> These definitions depend on DEBUG_OMAP{2,3,4,5}UART{1,2}; however, only
> DEBUG_OMAP2UART{1,2} are defined in ./arch/arm/Kconfig.debug, and
> DEBUG_OMAP{3,4,5}UART{1,2} are not defined. Hence, the script
> ./scripts/checkkconfigsymbols.py warns here on non-existing symbols.
> Simply reuse the config DEBUG_OMAP2UART{1,2}; there is no need to define
> separate config symbols for OMAP{3,4,5}. So, just delete the dead
> references to DEBUG_OMAP{3,4,5}UART{1,2}.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
