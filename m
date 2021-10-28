Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0675E43E460
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhJ1O7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:59:37 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhJ1O7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:59:36 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxUfn-1mrI4Y3qH3-00xpfR; Thu, 28 Oct 2021 16:57:07 +0200
Received: by mail-wr1-f49.google.com with SMTP id k7so10658875wrd.13;
        Thu, 28 Oct 2021 07:57:07 -0700 (PDT)
X-Gm-Message-State: AOAM530wNYAkG1XaEVBtLjYZuUB1wIime9QTvn7wtHlcbBox1Jyulkvc
        dlmg6n40AbUeRb/vAS3Y1BZ6xpeAAwhM5LpH0JA=
X-Google-Smtp-Source: ABdhPJxP1grjJwE+eREFwm/g0od2WsyCmYOCzERrnEnwT7SMwPO/+TGcXtuVQVGPKCHOmgziQBHKU/CZ/dq+VUSxnJ4=
X-Received: by 2002:adf:ab46:: with SMTP id r6mr6397722wrc.71.1635433027582;
 Thu, 28 Oct 2021 07:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-12-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-12-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:56:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Nq9hLbGiPCQTjVTiGFPR9-tdhN8Tf06Q=cWTgMK78yw@mail.gmail.com>
Message-ID: <CAK8P3a0Nq9hLbGiPCQTjVTiGFPR9-tdhN8Tf06Q=cWTgMK78yw@mail.gmail.com>
Subject: Re: [PATCH 11/13] arm: npcm: drop selecting non-existing ARM_ERRATA_794072
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
X-Provags-ID: V03:K1:K69ee536+KosoO56BzVgfCa3QF1AsVV/vnYyNvM5vhpsARkvQxg
 k8owT2eK6V/o8/EM0rnEisbkr8c4Sp9DEoZqg0ZJ9i329ZtdNw22plEHyF3bDPgCkx2yid/
 8PAD/bqP9O2h9/MG0Jw+lbBce8ywUqKGjhYYCd/EcfSo4CITF9wnQUgfkJ6ZU9Dmazan2yE
 fqTXpjn2AaVAlJ734p57w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EOdx6tYTdlg=:nITkJVxSExEAyoYC0WdiPb
 kRSvUX9E1bKR1zypZqWFg/VS8zhz0MguJCFv5uTnIpRaCvfCXALwWFP7+GFMYl2QBMz7lJLVJ
 hGyQ31z+NjG035ie9ToOkmsPpiUkkl2mXBDVmf5t5p/gdocCQfcnYukVI4LXxuFXrRIBvVgZF
 IpKaq+M/I8kgMePyzKcnr1belG3R+9VIQDfkzN8nd2FOlU2Tm2i7kJRCyF8XGIiNUqpfRED0m
 1X4vJj6tLNg2IS5DZZK8zDaz5i3+ZlQeNgVleT+kD4NX7YoCEugx/5K/cKcc3oyzEQ0DhWWbb
 7kPnz1B2dprSXcqEG2yuyLa39k2PYpGybXFatPUgqBMFTuymNPIs1Ne17/NgoLvnjX1wztDkl
 vsSAhExWozZErhSrGkHwF4OVtf7htTCR+btEsIquyfXkObFTHSTJ8zX4bM/5oCp4X5HgP1LRw
 bTEpmRqIE9LfqTwXVTSZ2uKIXldfSyqlXvVhaW9vuWoRjMmHRjD/2X1//T3RHpw8PLpHDBxYW
 vRUPM/idR03grgv5wcu0Jn06wl6fOSWhZ++2qMEDS2d4qTDK5PS50cSD8+aRKfKq+2klEJE8M
 p+5QqFcVdBetN5yOpso0tSG4kPpF0MxcHwEEl/beMRjsAgu9rtuWrx4xxpxb5079605yMAy0B
 2CmaWBK8mW+nB49erbUmrdstXCXEVdEqQqPt5G5L143A8BLHbg0nY5m+4dnGqOTxm2QVIsfUh
 7Izuct8BtG5laCUz7fBhzy1TAVGxqph9b0ltFKkqJvuaTfHfLhzAGbz2X57EhDIChs9X+5Spj
 pJ5MHd7VZYvLWHvDFEKncoBYqPkFANLuyJfOLgzjWOOdSOXyW6u4AJCzSH1fNmCYJKetAxP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> There is no and never was a Kconfig for ARM_ERRATA_794072 in the kernel
> tree. So, there is no need to select ARM_ERRATA_794072 in
> ./arch/arm/mach-npcm/Kconfig.
>
> Simply drop selecting the non-existing ARM_ERRATA_794072.
>
> This issue was discovered with ./scripts/checkkconfigsymbols.py.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Could this be a typo? Maybe we need to enable a different errata workaround
here, or maybe that code is actually needed and has to get sent.

        Arnd
