Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47F43E421
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhJ1OtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:49:24 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJ1OtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:49:22 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MkEdF-1n4Pod1uv3-00kjB2; Thu, 28 Oct 2021 16:46:54 +0200
Received: by mail-wm1-f45.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso4823191wmc.1;
        Thu, 28 Oct 2021 07:46:54 -0700 (PDT)
X-Gm-Message-State: AOAM533kV/clz+ICOwEee40X0YYb1L8sL+L4hYpch1022i5OeSu+b4DQ
        U0YUmaUfSKhPh7Amp+wdEU3OcSlaavthiKCRtY4=
X-Google-Smtp-Source: ABdhPJxA0GJLTQ+xD6zcoP0LSqb/ZsKcXqHw7zPvo6JWGp61LpzRYISo4RdkeFEDL6Qy0I1GY7j1Zdux6/P0jUeXB5Y=
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr13320221wmq.82.1635432414029;
 Thu, 28 Oct 2021 07:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-5-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-5-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:46:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2LhGWer=GXMW_KT-8=nqBeS0xhu6si7Z57WAF0wE_TUA@mail.gmail.com>
Message-ID: <CAK8P3a2LhGWer=GXMW_KT-8=nqBeS0xhu6si7Z57WAF0wE_TUA@mail.gmail.com>
Subject: Re: [PATCH 04/13] arm: drop an obsolete ifdef with the removed config PCI_HOST_ITE8152
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
X-Provags-ID: V03:K1:M0e272N5OTBkr1Hic8f7MYqzH43DPDJzeecww8hUzBT2FRHP/0Z
 5vB6c0WukRI9ZwL1J6KkAeeaRHxWtPCP0dY6tOceni4pEqbk1yDJnNyUqot/RQMEouLDEnB
 tw6Ka7bt1msVmURhha+y1RZatcM3V5E4ur+hiJqeRTpRcHcuXssb5CtOpvIS4m+GjhlR7C7
 02bp3344lnU9PQBE3U0Sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NbGCX54V3hw=:eqChudWfdjaThKrQwZgOMo
 IC5/lfPlfb7ozCC0kyr4Tn1xmtGq5VQjo5soeQGKsdTxxmQkbMK1iBlaKqlSKEjTHuKI67x3k
 AU7wv/StNgR5BQG7mn8ccjZAsDuPeoMS+5COxfcm8h25G5Zk33NAtnMKXVLBMsRsGFO0Ug5LQ
 0QIGcrmyB3TM2biYs8sJCCg+dC8UWo5rbgmD0gWGYjaxze+O0I2Yqjt6qS6xnbQFlaJ/bKlTR
 WljUM4Z5tO2TdTTsIrljSf2X13vi68y7juRJLeSjJKhlrCBBJnjMxPRykEnBNibabBr3IAx1G
 7ReTh/+P0g9D1AA6NcEgHgAx3QB5NnXP6nxe7CY8U5V7rU0suvdPKTiqxmgyeQirXap2nEF/M
 FJaWkKQsJOXT9D7Ut2Txi5LS085FD0wbz7kGs0xM7gCWeNXlKhVGbNKc9I/8PcJ1kcqRFzYwj
 pImOKHj/jtcUY1I7HpIDwWWFS6TdTD1SaTX2DuGe4QW5ioTgZhbQR1GuoBcyIO8nntAYDH+/m
 r2vu9iRCHVpik7RwStLLhKmk8u3Hzz3HVpOomowsakUNSSTUnKJlGhkFiIAaVAUQ8xyhF8sGo
 vvA33KxFSBAXTgh/gb6K2LqZyID7cyhBQalewoKDWXPb188OGbpP0joeeVZOXC5fjy/Meur31
 8YPjSqT9d9VstDdfzDY4rj3ROlkk29Pkvrw+EGm8cFTt6dj/XDvVp5H/njUb5mqWaUvSWH95W
 AUFI2Tmu//ePKlW/+27m7QWLxTSjs8b5w69qZ3+saKzC76AtJiQp2kWnAN9BkqdCMTHVDzNtp
 n99P4/mVlrJ1sPI2GSHWfFFW+Lfz8sJpgo1rexsSwjz1FuAdA8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 6da5238fa384 ("ARM: 8993/1: remove it8152 PCI controller driver")
> removes the config PCI_HOST_ITE8152, but left a dangling obsolete ifndef
> in ./arch/arm/kernel/bios32.c.
>
> Hence, ./scripts/checkkconfigsymbols.py warns:
>
> PCI_HOST_ITE8152
> Referencing files: arch/arm/kernel/bios32.c
>
> Remove this obsolete ifndef.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I wonder if we should just remove this function and use the
(non-empty) default version instead.

96c5590058d7 ("PCI: Pull PCI 'latency timer' setup up into the core")
introduced that generic version, and I suspect the arm version
was left out by mistake, but it's not clear from that patch.

         Arnd
