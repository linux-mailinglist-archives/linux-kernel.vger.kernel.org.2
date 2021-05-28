Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756B1393E39
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhE1H4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:56:43 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbhE1H4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:56:42 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MD9Kj-1ldyd13tQH-009AlW for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021
 09:55:06 +0200
Received: by mail-wr1-f54.google.com with SMTP id r10so2277592wrj.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 00:55:06 -0700 (PDT)
X-Gm-Message-State: AOAM532MPSsrnF36mqjS0OuGYprczzzKUZxbEwrpoIm1MafWJr55y4lz
        9qiOLSoIN8Uc1wTHsN/oSZiBJ3JJL7CIJo/hReE=
X-Google-Smtp-Source: ABdhPJxtCA/iAW+OLP8xFsKArHSqvDr2GZoepVyWwZ73PMdxndP7NC9IdOzIAudCmGD4ukdBOEvRicXG4Tq8D72DlMc=
X-Received: by 2002:a05:6000:1b0b:: with SMTP id f11mr7342217wrz.165.1622188506607;
 Fri, 28 May 2021 00:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <be1c35eb997959b4939b304ef26664dfb9cd2275.1621941451.git.esben@geanix.com>
In-Reply-To: <be1c35eb997959b4939b304ef26664dfb9cd2275.1621941451.git.esben@geanix.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 May 2021 09:53:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1HGJpYnmhGb_eZzrv0ZopOJ-JuC6hyNP8V87C1Po9ruw@mail.gmail.com>
Message-ID: <CAK8P3a1HGJpYnmhGb_eZzrv0ZopOJ-JuC6hyNP8V87C1Po9ruw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: only enable pinctrl as needed
To:     Esben Haabendal <esben@geanix.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gt4cA1GgoMHRZ98J2I02Mo35o2S92yAxbOjfsm3fk4VvPVFtecX
 LX8rV3jlOI7TEc/zNAzqYpVeso3h8t95e317HLRJLJgJ2AVgkW9b2Cl/ZV5up7InWmR3hkL
 U2pC+G2wHuwneeeyh7UhKj9G68MBh6Kykp/cb7+nYaxmbfuw4JsuItK2aLocq09T1vA28mA
 comJayP/isE3f0bda00hw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N/ySsRk9ywg=:I28dxJS5eP5VsZo/PH8UvF
 Aym0MDq80wcDg1McPkpssiq6IL6OAbnEKXec+OHoC658aaorAWY/xiWgPjFCwUkr2EzH7grXf
 DoL8ZzWeloNWfEh7pOusUcWSa4gOrSt94YZpzmNOXsbO355+bP/zJwjW2FH8FXA3Fzbc7D+YN
 Q2yfa+2teNRfX46Ok/dh5rdQ66uOQh24JOrwQf1rkf/oITTDqki88I1rAVj9TKn2rC6155pBx
 OXZbS/hMiDsKddcYaHrID1mS3Z7jd4WMkV5rwXMsTRsxLpAGgziAEyaqYQuSPb92UIfTJw9m6
 m0Vd9rWDDBCZr+TThdH43RCPzJlKN0QAcjk/FTLG9kJXNEq5tPvtm7arNg2RXDfLV/TC5Mj+F
 8o39Ij4511I+HQiOh8/6gaEtn6wNpwW8mNvLc60baxja4N+DKu4/vBA2a4tlUqVvEShlEyvbz
 2gnKybBiYwxBmIXoxEg5Sa89mXSXDRXcIN8pZyk/DyzE1iOIn43Y61ZrwUpFoqFQ6AXDdcvtU
 q0BISCXarGCBLxdjA4nd/EUyrcCSIS9Nlxz8apypP0yUyJwM9anaKx+gJiFtpHZwtShvkQk9S
 ObU+I2kbbmKNp/V8Z7i+uXcC5AFt1p7Q/ruiBwQjRssMccRWdvKTv99rAnsGmnojOAjwyiN1i
 f+0w=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 1:22 PM Esben Haabendal <esben@geanix.com> wrote:
>
> As not all mach-imx platforms has support for run-time changes of pin
> configurations (such as LS1021A), a more selective approach to enabling
> pinctrl infrastructure makes sense, so that an e.g. an LS1021A only kernel
> could be built without pinctrl support.
>
> Signed-off-by: Esben Haabendal <esben@geanix.com>

I think it would be even better to leave all these drivers to be
user-configurable. The symbols are currently defined as e.g.

config PINCTRL_IMX51
        bool "IMX51 pinctrl driver"
        depends on SOC_IMX51
        select PINCTRL_IMX
        help
          Say Y here to enable the imx51 pinctrl driver

which could be changed to

config PINCTRL_IMX51
        bool "IMX51 pinctrl driver" if COMPILE_TEST && !SOC_IMX51
        depends on OF
        default SOC_IMX51
        select PINCTRL_IMX
        help
          Say Y here to enable the imx51 pinctrl driver

Today, having it configurable is pointless because you can't turn it off
when SOC_IMX51 is set, and you can't turn it on when SOC_IMX51
is disabled.

The second version allows turning off PINCTRL completely though, as
we do for other top-level subsystems that would likely make the system
unusable when disabled (block, serial, ...), and it allows compile-testing
on other machines, provided some dependencies (CONFIG_OF in the
example) are met. It could theoretically also allow making it a 'tristate'
option, as we do for an increasing number of drivers.

       Arnd
