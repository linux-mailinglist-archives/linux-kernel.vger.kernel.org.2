Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5574243E432
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhJ1OvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:51:00 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41577 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhJ1Ou6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:50:58 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MvazO-1myC7M13iQ-00sauL; Thu, 28 Oct 2021 16:48:30 +0200
Received: by mail-wm1-f51.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so5292819wmz.2;
        Thu, 28 Oct 2021 07:48:30 -0700 (PDT)
X-Gm-Message-State: AOAM533IHk2CG9gLnGNwYXh9677jySanJxrSP1Ysgg5+esQBpkW5Hfsp
        c63eB/KHdKHtIPnzhdKWhofNp9j1wH/8ZE670E4=
X-Google-Smtp-Source: ABdhPJzL3MD7Ov/YpXP8VB2S/9zdo9mXJlPWHWLikatiPP2chN2QqBJfFmmZsDznohWi1xDRgcrL/A+XHkQgb3o6kX0=
X-Received: by 2002:a05:600c:1912:: with SMTP id j18mr12838474wmq.173.1635432509957;
 Thu, 28 Oct 2021 07:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-8-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-8-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:48:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1T1Q5YJEhd5sM03H7vmEWzBmJ_PR3cPsdn6y=nDpyd2w@mail.gmail.com>
Message-ID: <CAK8P3a1T1Q5YJEhd5sM03H7vmEWzBmJ_PR3cPsdn6y=nDpyd2w@mail.gmail.com>
Subject: Re: [PATCH 07/13] arm: imx: remove dead left-over from i.MX{27,31,35} removal
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
X-Provags-ID: V03:K1:i8E5+bBIjLQRy8bgdJbRy3fJUS7sO/fSgIeaqrTLXO2rTzHZg8u
 u4mFfVwgkOr06tu0OM83mjJdMwSMIr7p/ibRJnupR5dLiJNdzwwg4OW49FAob230BaSqdQP
 N6BWQsI2FXDfdqAMz+YlFFjHf8gydCBSzCKGYYyDL7WPubmQQWFVrI7UMCrND0ne6DXaXwB
 3BuVBj5xzkbE6bNU9qzUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tlRF4qwqolg=:dRB+mGqCKOrecBndDfSWKy
 2zbhrKKjnFgOY3lStyxle2n8VI3P9bRMKTxTUjA8uOUs80eztXg+E5kO5Gf3ID7nNUnjbxVZE
 w6gdgIDFZwt3EAK/gsGOhlapcuKYgA1rRMc6isZzusdwk1Ul7rM8eHc3dufNTtZP85N2iSjaL
 2t5z2oNdw6GZfilg+fyK7qr599c5diAYNanUlm2DhToWNoN044RyzMx8xjzfv2Su6D8zlcHkC
 HEpaazd2X7xyabTCgp9RGzR8erfXVICYwLz8BYmAj+1lUpAacZ1DvALHGAiScpWYRSzuuPXjE
 BqWAvcfWRs4/regjErTUyipa5NIxXaJLhB+GBF/53aHqckSxPmicI4EmojtIQgD6KZdaR3akj
 TsmNJcPEnT04gx0UbeCOrXh4VvGMJx1n2f0b8pameUgYJ+iOeiaYJtwJpSjIDfIOKBQAzOJOJ
 yB7I2D0LlefprwSav4ugxnInSk3b7V9GeTVd02NfWurSSrFmB/plwK+Rv4lWnKJUVqhaPhNcT
 SPH6NC5PkZTAY9mNx5J3Mgtn2Xd58MIC1n+2BEKssufr0K06G6DKWGIwquNt5FpVwAbhFrRWE
 +X6vMmm3jzCcbTyzPu89NLAaWFwU7PBa8pLEd25IeY56naT2beIA+rFt1FA8X6ITxACD/ODwL
 pF5uq7lCsyvXgWngvkP38twJ+kBNcwQ72fpK34prifemSQByWO/jCG+Y94WUM0ASYBaQfmfHE
 u4EvD1rFvStPkhkC3wduZLyGvtwpKSLOjuE+wl/IakjzUl7InEMqo785pZw5Q5NVBcHVt0zlg
 Suk5+vTyAeew7a9pnyRNo19lALnjN6bO8DQo4lR+XJ4ZdAN2mE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The commits:
>
>   commit 879c0e5e0ac7 ("ARM: imx: Remove i.MX27 board files")
>   commit c93197b0041d ("ARM: imx: Remove i.MX31 board files")
>   commit e1324ece2af4 ("ARM: imx: Remove i.MX35 board files")
>
> remove the config MACH_MX27_3DS, MACH_MX31_3DS and MACH_MX35_3DS.
> Commit a542fc18168c ("ARM: imx31: Remove remaining i.MX31 board code")
> further removes arch/arm/mach-imx/3ds_debugboard.{c,h}. So, only some
> dead left-over in Kconfig and Makefile remains.
>
> Remove this remaining left-over.
>
> This issue was identified with ./scripts/checkkconfigsymbols.py,
> which warns on references to the non-existing configs
> MACH_MX{27,31,35}_3DS in ./arch/arm/mach-imx/Kconfig.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
