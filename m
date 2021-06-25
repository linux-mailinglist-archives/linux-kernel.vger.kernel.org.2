Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4FD3B4110
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFYKEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:04:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34331 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhFYKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:03:55 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAwsT-1m7Oom25ft-00BOEN; Fri, 25 Jun 2021 12:01:33 +0200
Received: by mail-wm1-f44.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so7454231wms.0;
        Fri, 25 Jun 2021 03:01:33 -0700 (PDT)
X-Gm-Message-State: AOAM530fqcPGyhm5ElcwnuJ28aGPwk3gP2KIEDObl0U1wgVVYKTT/N0D
        UysqdouorJcwylwU7qQui56OggFtQSD6fcFxQSo=
X-Google-Smtp-Source: ABdhPJyRRakIybOAARLEqgqFsAKTsqLCItavkxySt7puA/r0GJ3aVYwMKoJP0QL2cw8hz9fbIr1BZHd9ZDHu2XJ9KFw=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr9700348wmb.142.1624615293093;
 Fri, 25 Jun 2021 03:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210625095000.3358973-1-mnhagan88@gmail.com> <20210625095000.3358973-3-mnhagan88@gmail.com>
In-Reply-To: <20210625095000.3358973-3-mnhagan88@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Jun 2021 11:59:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3NAOgBa1j+Zsm6FwSm2ux49rFcnTEYJJsmSF8TggRnYA@mail.gmail.com>
Message-ID: <CAK8P3a3NAOgBa1j+Zsm6FwSm2ux49rFcnTEYJJsmSF8TggRnYA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ARM: dts: NSP: Add DT files for Meraki MX64 series
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cPZZH1H8tLkJZhzYVyg54dlhPrzq22n2d6a2s0M2uflfJSYFDxj
 8NO4E2VzN4gP0vhm7WVIIx06T/iI44gy0cIldB0ENBNcx/BUkHGScDNXtM7f3pPiAZHrwC8
 AXRThtPcrGn538z/EE+K7B7gVnbeZsTYRk2M7xzDiBHuaoGcp2ZkJZEDFGhmnrJstrr9s8q
 U5rKXEvk5LkNOEkAt8olA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fdZn1ST4yvo=:43VghYItvo8WWSMEG/1RpZ
 xifz/d9vVILF7xi7WX6uv3vbTXMQ6dYmKehEHVeeNu+gOhJbjBn9S9F/6hi/s5Ks0MqSjUNDZ
 dfaoj/8JFnhKyOF6oa4obXkLcDK93EUUxy+MtJ4foFLR3MR8uBxKwlYpq5vvRriFd5+QP7mlG
 +4hyAamO5VKqItVCCsvL5MnkrjR57tZn4COWaVFbyoAPpQTR52+nkBpFme75q+nLZWcK1EMtu
 79D0WrJRX80CgzYQTLymng5xPWv6yjguvIphcKUYQRrdudFlmF4yKCBCuGsCf1E0CgnquF6xW
 0jk6grm7UlA/F5o3oq+0K26bBvSUjusN0r750C599fyDMiZrwWsmJpANsWXTsXwnthmHcEWdY
 ebiDt78AzV1q8G8k5alVVoYIb37FzUnQFcpIFY0T4nFyOancc3otpnaO39UDAG6kUI7yYA2pX
 NrMm+XOS3oX4/Q650JZDbP9inf9G9VajQBGw7OPxuk2hmOG0JxC6RHcByJkspRSX/CChaNmjS
 qFxjqps9FgQAmVrmQLWpmxLdykLFGLYb3GBd0elJnbyGP9BVG9q80rBsGsMZi2nUFTDogBtmw
 Q1N+cWUqHibyHWhqbqWVpeAX03C9nLYzPpi59tXqrXX++Sbse+AZCZ1rILRSU3U1l8+lc441u
 9UcU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 11:52 AM Matthew Hagan <mnhagan88@gmail.com> wrote:
>
> MX64 & MX64W Hardware info:
>   - CPU: Broadcom BCM58625 Cortex A9 @ 1200Mhz
>   - RAM: 2 GB (4 x 4Gb SK Hynix H5TC4G83CFR)
>   - Storage: 1 GB (Micron MT29F8G08ABACA)
>   - Networking: BCM58625 internal switch (5x 1GbE ports)
>   - USB: 1x USB2.0
>   - Serial: Internal header
>   - WLAN(MX64W only): 2x Broadcom BCM43520KMLG on the PCI bus
>
> This patch adds the Meraki MX64 series-specific bindings. Since some
> devices make use of the older A0 SoC, changes need to be made to
> accommodate this case, including removal of coherency options and
> modification to the secondary-boot-reg.
>
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>

Removing the dma-coherent flags in the dts file seemed really odd until
I read the text above. It would seem more logical to me to have a .dtsi file
that has all the a0 revision specific changes, and include that from the
dts file.

On the other hand, the /chosen, /aliases and  /memory nodes that you have
in the .dtsi file should probably get moved into the .dts files, as these tend
to be board specific settings, even if the examples you have are all
the same.

       Arnd
