Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15FC43E43C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhJ1Ovv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:51:51 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:48221 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhJ1Ovu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:51:50 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MO9qz-1mIEAq3Trd-00OUlN; Thu, 28 Oct 2021 16:49:21 +0200
Received: by mail-wr1-f47.google.com with SMTP id k7so10617755wrd.13;
        Thu, 28 Oct 2021 07:49:21 -0700 (PDT)
X-Gm-Message-State: AOAM530mOIWgIXfT3W0S5P0bF9zXVRQ54gyQr2UdG6/2bNI6Efy4J9yT
        sHgMnNDlMzWOCR6FrI2ZVOr+bKQR4D7EM+kmwVI=
X-Google-Smtp-Source: ABdhPJyZaPDPCoaDGyatBTS5bhSohWogOcSmV50vy7mFoGeznOuDlcMqq0iyn1grr0cj7qSdSBNBCx/C2MgWvgadgZU=
X-Received: by 2002:adf:e292:: with SMTP id v18mr6094633wri.369.1635432561472;
 Thu, 28 Oct 2021 07:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-9-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-9-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:49:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ZBwDdgZfwLMPqfV=MrinyiZ0vYppt_2PLviAbHNKZhA@mail.gmail.com>
Message-ID: <CAK8P3a3ZBwDdgZfwLMPqfV=MrinyiZ0vYppt_2PLviAbHNKZhA@mail.gmail.com>
Subject: Re: [PATCH 08/13] arm: imx: rename DEBUG_IMX21_IMX27_UART to DEBUG_IMX27_UART
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
X-Provags-ID: V03:K1:H4FlXSogfU/bOumyrnnm96iBDKu58sU0fHPlZ17SC5MmnUKX4hQ
 Sva2FJjC+edcwEUINefzoxT0493Fb9gvi5DDK/0hwtw0Sw/oHZ3qABMR/wemAT23Z7E6HHy
 yO9XjPzxlIlgb3+hWY33kyGkAQ1osQNKnSGN+ZNyT7mKpFOSJkqqfU8Nn/5w/vesUjbnQEo
 UzVGrwz7iZt39tqXLNf4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2W9N701yH/s=:gX5F75ckFm2eUgdYHllV+/
 B26p8tl0dkPq+JAHCLKvArk64OtPwG212FLnwPtD0jV7at62gZpToQFSoscBLMr6xl6WSXque
 CP1KzKvqs/UzvQW/FtYThUhBUH19UKEfXvD+kSkT/T7fbukgf9JhRj83UvUKMOoFAm41pD08F
 y3avzFs90TFZgrXMG43mnGFar4MHN2G0Pru3f3OKR6ki466hsfs35Q/kPQ/Bu7M4g1vfQd8qg
 W+jIklqNj5T2cMmW/gPCYW77zlJsDSR6nLUjHFxJXGwoGZxH/BV86Rb/JtjvzvPNZ14HzU0ak
 g4jFaCNynr+pNKc1rw38MivVhvDZUniL+NklPa2iL4ubm8JO8Iqlx4GkgHDDLPhQ0UnU3JWhh
 mje5KkNIpgG7N23xtnfVIzjgtqpYP8zTnN71x+9vEcduMhRc1JB/eTpfPedCzSgBNFNy+m3YS
 1dDcv993i+XLmqB14M15lyRRE3TyYOQa5Pz8cPrzaDx2akBgn++3wJRVjXCosxvPV9O99OOPW
 bKv+QaLakfeyDDX9aFsfMMmjbgRBhCfWGpFX4LPB0m010gNAXDk0iTyDbza9vH6I5sJISpJio
 H46gXmL3vvMtj0kLhUoYshfZ+8cMU21X3U9mZ7EiOVJ6n/wOk5up7/HCStYidbwHxszfab7zY
 +xobvmkEuHeMGwpFBqwFnFWaLUjGzClLb+GB8/FK6QAcmbkjYjJWNN2E8N7ewOzszhiRKByeB
 usAnCm5swhlTBhsllsY64NvPSc61bvur545NdiI6Wxu+p9sw8S/HH9muZuN275dyjkQF80WL5
 RQx/aBbGAHcW8llnPDH+y9Q5i0pG5sXhRr7Z4NC0jD2r51jq25pTcQPejOLZgP86D3r2/D2XF
 xCNcnhUEADxUUVFEY3dsJQZyGjmBtQ7jD2zCgbCIRf+Yq0+2vVGfIQcIrLFCdvKSN0ZqqeJox
 jnF5OQauYdg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Since commit 4b563a066611 ("ARM: imx: Remove imx21 support"), the config
> DEBUG_IMX21_IMX27_UART is really only debug support for IMX27.
>
> So, rename this option to DEBUG_IMX27_UART and adjust dependencies in
> Kconfig and rename the definitions to IMX27 as further clean-up.
>
> This issue was discovered with ./scripts/checkkconfigsymbols.py, which
> reported that DEBUG_IMX21_IMX27_UART depends on the non-existing config
> SOC_IMX21.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>


Reviewed-by: Arnd Bergmann <arnd@arndb.de>
