Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773FD3B1400
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 08:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFWGj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 02:39:28 -0400
Received: from smtp-34-i2.italiaonline.it ([213.209.12.34]:59188 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229801AbhFWGj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:39:26 -0400
Received: from oxapps-13-074.iol.local ([10.101.8.84])
        by smtp-34.iol.local with ESMTPA
        id vwVXl5TSw97oOvwVXlCLyB; Wed, 23 Jun 2021 08:37:08 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1624430228; bh=qs4ASD2L5TkNDfmQ7MCmNJrKRUyy1OPwHjAIdosR+5I=;
        h=From;
        b=0RMwn7AeYaxPd6rYzeG0CPwnyZBWK6DAssDX29syXbStJQ71sgtYSiEuG19cjAI0w
         3hwVvbpL2POcIZYcDaZryTh9qUi4SWx84CGX+u1OWdgd25dTgApYo3NNbKxqKGdjKM
         GB8RpSJ6AgV0Swn1QdWZ3LLL4xU+QjlVFnwvuBd5lFz6mcuJNZ7dwcViVBNpmZLXIY
         l0kxXp475K2WJzi0/D34Z0wvzKwAYM4eNjNyyH2w5XLajcx9h3nPVIjruIhk9uDEBJ
         ngVEYljJj/uDcz/IzvqlZqsehWsUwa80vBr1d7MncuSV7HW9mPyUo079sKj8KM0nw8
         HD9PiL6kMQ7/w==
X-CNFS-Analysis: v=2.4 cv=AO6vEo6Y c=1 sm=1 tr=0 ts=60d2d694 cx=a_exe
 a=+htklNqd2nUvwHGxo3khsw==:117 a=C-c6dMTymFoA:10 a=IkcTkHD0fZMA:10
 a=vesc6bHxzc4A:10 a=8b9GpE9nAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=IpJZQVW2AAAA:8 a=JfrnYn6hAAAA:8 a=phlkwaE_AAAA:8 a=JUomssDXxHmgQRfMaoYA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=AjGcO6oz07-iQ99wixmX:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=1CNFftbPRP8L7MoqJWF3:22 a=uKTQOUHymn4LaG7oTSIC:22
Date:   Wed, 23 Jun 2021 08:37:07 +0200 (CEST)
From:   Dario Binacchi <dariobin@libero.it>
To:     Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Cc:     Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Gabriel FERNANDEZ - foss <gabriel.fernandez@foss.st.com>
Message-ID: <1431023086.718458.1624430227963@mail1.libero.it>
In-Reply-To: <AM8PR10MB47856D4CA879CD0230ED171081089@AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM>
References: <20210622211401.25604-1-dariobin@libero.it>
 <AM8PR10MB47856D4CA879CD0230ED171081089@AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev34
X-Originating-IP: 185.33.57.41
X-Originating-Client: open-xchange-appsuite
x-libjamsun: ZBxioyyykQfQXYWwnvpDoEaCrjpOglkK
x-libjamv: m4emuayYq2g=
X-CMAE-Envelope: MS4xfNkRxDJMlk72dWUCfSezNUS1W7kOEswjd6Xb/LV2d9185/2Fmz7fytGG5GBVWAfRIjBqKIkQOaMWOQWFsv0D1NPHfriw+xF1+sy4/N8w6fY+5xxlGlJ2
 5b3bSvRjNT2f3mD47yRsROUC9c6YUXkalTT8yGyxPX9rcqFuk+zTFp2GskWNt5zEIzzllfRXg8g/Be4SmG8i6fsOwP4NKw9iuUhsiPwFDIQKG/6DAj+08M22
 evLFNdXmWLY1RI7rW2IjeeTM1gm0skiRtDDBlsbfb77c0sEIPYSeI0Jh08+GRKacA9QzxvYZg//E8yHF7RHCh/tVdgGCf7K7Sg68DOSea5f+78oj/EDhnkBB
 G0QqrRIfKd1mkEegS2+Au+uagnbNKWrdjM8sEg4SUm9zdqOoxfYRvsPJaUTaMs9bB52jiYeEvCNpcUhKsRui9elGbPv0kdPmLmrdJAWtzimzxe+c6YbzDo5b
 8W9DTqZyHZEcMRQsDS3jh/Z4JFtgk9deUAoHyaWseyAdxaxKFaNO+NAi1FQPeW4WLwjM48Ce+jDDWypElNieDushMkVLFDvBBX4tIvaORpfIs8QMdxVYxhzf
 2PY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

> Il 23/06/2021 08:27 Gabriel FERNANDEZ <gabriel.fernandez@st.com> ha scrit=
to:
>=20
> =20
> Hi Dario,
>=20
> I agree with your analyse.=20
> You have to change also 'u8 pll_num' from 'stm32f4_pll_post_div_data' str=
ucture into 'int pll_idx'=20
> or something like that.

Always in the same patch or in a different one?

Thanks and regards,
Dario

> Many Thanks !
> Gabriel
>=20
>=20
> From: Dario Binacchi <dariobin@libero.it>
> Sent: Tuesday, June 22, 2021 11:14 PM
> To: linux-clk@vger.kernel.org <linux-clk@vger.kernel.org>
> Cc: Dario Binacchi <dariobin@libero.it>; Alexandre TORGUE - foss <alexand=
re.torgue@foss.st.com>; Gabriel FERNANDEZ <gabriel.fernandez@st.com>; Maxim=
e Coquelin <mcoquelin.stm32@gmail.com>; Michael Turquette <mturquette@bayli=
bre.com>; Stephen Boyd <sboyd@kernel.org>; linux-arm-kernel@lists.infradead=
.org <linux-arm-kernel@lists.infradead.org>; linux-kernel@vger.kernel.org <=
linux-kernel@vger.kernel.org>; linux-stm32@st-md-mailman.stormreply.com <li=
nux-stm32@st-md-mailman.stormreply.com>
> Subject: [PATCH] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs=20
> =C2=A0
> Enabling the framebuffer leads to a system hang. Running, as a debug
> hack, the store_pan() function in drivers/video/fbdev/core/fbsysfs.c
> without taking the console_lock, allows to see the crash backtrace on
> the serial line.
>=20
> ~ # echo 0 0 > /sys/class/graphics/fb0/pan
>=20
> [=C2=A0=C2=A0=C2=A0 9.719414] Unhandled exception: IPSR =3D 00000005 LR =
=3D fffffff1
> [=C2=A0=C2=A0=C2=A0 9.726937] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-=
rc5 #9
> [=C2=A0=C2=A0=C2=A0 9.733008] Hardware name: STM32 (Device Tree Support)
> [=C2=A0=C2=A0=C2=A0 9.738296] PC is at clk_gate_is_enabled+0x0/0x28
> [=C2=A0=C2=A0=C2=A0 9.743426] LR is at stm32f4_pll_div_set_rate+0xf/0x38
> [=C2=A0=C2=A0=C2=A0 9.748857] pc : [<0011e4be>]=C2=A0=C2=A0=C2=A0 lr : [<=
0011f9e3>]=C2=A0=C2=A0=C2=A0 psr: 0100000b
> [=C2=A0=C2=A0=C2=A0 9.755373] sp : 00bc7be0=C2=A0 ip : 00000000=C2=A0 fp =
: 001f3ac4
> [=C2=A0=C2=A0=C2=A0 9.760812] r10: 002610d0=C2=A0 r9 : 01efe920=C2=A0 r8 =
: 00540560
> [=C2=A0=C2=A0=C2=A0 9.766269] r7 : 02e7ddb0=C2=A0 r6 : 0173eed8=C2=A0 r5 =
: 00000000=C2=A0 r4 : 004027c0
> [=C2=A0=C2=A0=C2=A0 9.773081] r3 : 0011e4bf=C2=A0 r2 : 02e7ddb0=C2=A0 r1 =
: 0173eed8=C2=A0 r0 : 1d3267b8
> [=C2=A0=C2=A0=C2=A0 9.779911] xPSR: 0100000b
> [=C2=A0=C2=A0=C2=A0 9.782719] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-=
rc5 #9
> [=C2=A0=C2=A0=C2=A0 9.788791] Hardware name: STM32 (Device Tree Support)
> [=C2=A0=C2=A0=C2=A0 9.794120] [<0000afa1>] (unwind_backtrace) from [<0000=
a33f>] (show_stack+0xb/0xc)
> [=C2=A0=C2=A0=C2=A0 9.802421] [<0000a33f>] (show_stack) from [<0000a8df>]=
 (__invalid_entry+0x4b/0x4c)
>=20
> The `pll_num' field in the post_div_data configuration contained a wrong
> value which also referenced an uninitialized hardware clock when
> clk_register_pll_div() was called.
>=20
> Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
>=20
> ---
>=20
> =C2=A0drivers/clk/clk-stm32f4.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> index 18117ce5ff85..42ca2dd86aea 100644
> --- a/drivers/clk/clk-stm32f4.c
> +++ b/drivers/clk/clk-stm32f4.c
> @@ -557,13 +557,13 @@ static const struct clk_div_table post_divr_table[]=
 =3D {
> =C2=A0
> =C2=A0#define MAX_POST_DIV 3
> =C2=A0static const struct stm32f4_pll_post_div_data=C2=A0 post_div_data[M=
AX_POST_DIV] =3D {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q=
-div", "plli2s-q",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { CLK_I2SQ_PDIV, PLL_VCO_I2S, "plli=
2s-q-div", "plli2s-q",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 0, 5, 0,=
 NULL},
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q=
-div", "pllsai-q",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { CLK_SAIQ_PDIV, PLL_VCO_SAI, "plls=
ai-q-div", "pllsai-q",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 8, 5, 0,=
 NULL },
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { NO_IDX, PLL_SAI, "pllsai-r-div", =
"pllsai-r", CLK_SET_RATE_PARENT,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { NO_IDX, PLL_VCO_SAI, "pllsai-r-di=
v", "pllsai-r", CLK_SET_RATE_PARENT,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 STM32F4_RCC_DCKCFGR, 16, 2, 0, post_divr_table },
> =C2=A0};
> =C2=A0
> --=20
> 2.17.1
