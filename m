Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65630D6AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhBCJtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhBCJt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:49:28 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A2FC061573;
        Wed,  3 Feb 2021 01:48:47 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d85so22733019qkg.5;
        Wed, 03 Feb 2021 01:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oSSy7zwcCIz5No/RItIw1OJIHP7SD2GK0HzMtnMRPcI=;
        b=AFXZh983PeUKJLnKVoyNDag77zYCzBAG5gEBLyEx9Ety055Ho9EDYvKKhafEkJMLlM
         bRDeWborrTcsZL1yNzjeVcnCWj0D3fr7aH5sM7jihRVDmsyYhnWLQ8BHOf4mg7/iyLKe
         i9ihzpMfqrhuT3TPLuXW4TFzJzL4OIbTa79Qq1f+K6HDn7whT/5pwFtua3iXNuD8sIzI
         MQXKpZcyeBVXV6Y1E3IDjArBER5pSNOwOe579Ro5tANi3BO9zcadNx02+e9u76JTpp+3
         /HZ565OwutyrHLgqjuUw+N8l2gjIsWDc2+yMEq3hM7wkYYzuOLvHr9tpAeDVAPlOteE4
         Napw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oSSy7zwcCIz5No/RItIw1OJIHP7SD2GK0HzMtnMRPcI=;
        b=TFIiQhh5p6Nfeptdcno5mYOH/AqiV+Ou1p67YbxHjvfV2GpUjXjLhzYxK8A+5DPExI
         3cio8jYYLGPZ2s96Q5UslPrEjd/WOTqtCxabN2L7Lwdl3rLVvumG+b76U+3L80O35th4
         52eiScn5YjICTM9ZgC+vVo3CHALb4+XfrFVhE90xo0Aivk7akf8RGbB/ZX+5fgEfakvk
         20FEO6cEbgJPdbKx0uQ0lEXiaeQE2UvIqmuWRqHvCOIJbkP4v6VlNM0Jx1hY1xjQxCNT
         EhkyEdquxL1rK50xTM7ZPC01dDdMXgEJK70rD9divkD+C9/ut6R9pnQosgbdhOLl74p8
         aU9Q==
X-Gm-Message-State: AOAM5336WbugOK46X+ogt2KDQShTbEHr/OvuaTNdJSioHW5WnysjPxzi
        2cAhJ2mMP0MY4aBrEUs7yvYZbWkvYacvyeIv8Dg=
X-Google-Smtp-Source: ABdhPJyYG+6XbfASKZFGU7C6GrkOVRBhbuH5lkmlj8lJIwOaI/ZeBJu0epP3Cye6xu8ej6PPa5wdW/222+k6I15jX4Y=
X-Received: by 2002:a37:8b46:: with SMTP id n67mr1678191qkd.167.1612345726540;
 Wed, 03 Feb 2021 01:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-16-lee.jones@linaro.org> <CAHb3i=tVE+hJ46tPp-WYoAXRmWnempbSPtww+9v+B4rS2Y2VFA@mail.gmail.com>
In-Reply-To: <CAHb3i=tVE+hJ46tPp-WYoAXRmWnempbSPtww+9v+B4rS2Y2VFA@mail.gmail.com>
From:   Tali Perry <tali.perry1@gmail.com>
Date:   Wed, 3 Feb 2021 11:52:11 +0200
Message-ID: <CAHb3i=sMr3CeuEg6hWh=HKtyrmyX80fbsrg1n4NgbH27rdpA=g@mail.gmail.com>
Subject: Re: [PATCH 15/21] clk: clk-npcm7xx: Remove unused static const tables
 'npcm7xx_gates' and 'npcm7xx_divs_fx'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nuvoton Technologies <tali.perry@nuvoton.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resend

On Wed, Feb 3, 2021 at 10:08 AM Tali Perry <tali.perry1@gmail.com> wrote:
>
> Reviewed-by: Tali Perry <tali.perry1@gmail.com>
>
> Thanks for the fix !
>
> On Tue, Jan 26, 2021 at 2:46 PM Lee Jones <lee.jones@linaro.org> wrote:
>>
>> Fixes the following W=3D1 kernel build warning(s):
>>
>>  drivers/clk/clk-npcm7xx.c:438:43: warning: =E2=80=98npcm7xx_gates=E2=80=
=99 defined but not used [-Wunused-const-variable=3D]
>>  drivers/clk/clk-npcm7xx.c:365:48: warning: =E2=80=98npcm7xx_divs_fx=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
>>
>> Cc: Avi Fishman <avifishman70@gmail.com>
>> Cc: Tomer Maimon <tmaimon77@gmail.com>
>> Cc: Tali Perry <tali.perry1@gmail.com>
>> Cc: Patrick Venture <venture@google.com>
>> Cc: Nancy Yuen <yuenn@google.com>
>> Cc: Benjamin Fair <benjaminfair@google.com>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: Nuvoton Technologies <tali.perry@nuvoton.com>
>> Cc: openbmc@lists.ozlabs.org
>> Cc: linux-clk@vger.kernel.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>  drivers/clk/clk-npcm7xx.c | 108 --------------------------------------
>>  1 file changed, 108 deletions(-)
>>
>> diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
>> index 27a86b7a34dbf..e677bb5a784b9 100644
>> --- a/drivers/clk/clk-npcm7xx.c
>> +++ b/drivers/clk/clk-npcm7xx.c
>> @@ -361,13 +361,6 @@ static const struct npcm7xx_clk_mux_data npcm7xx_mu=
xes[] __initconst =3D {
>>         dvcssel_mux_parents, ARRAY_SIZE(dvcssel_mux_parents), 0, -1},
>>  };
>>
>> -/* fixed ratio dividers (no register): */
>> -static const struct npcm7xx_clk_div_fixed_data npcm7xx_divs_fx[] __init=
const =3D {
>> -       { 1, 2, NPCM7XX_CLK_S_MC, NPCM7XX_CLK_S_MC_MUX, 0, NPCM7XX_CLK_M=
C},
>> -       { 1, 2, NPCM7XX_CLK_S_PLL1_DIV2, NPCM7XX_CLK_S_PLL1, 0, -1},
>> -       { 1, 2, NPCM7XX_CLK_S_PLL2_DIV2, NPCM7XX_CLK_S_PLL2, 0, -1},
>> -};
>> -
>>  /* configurable dividers: */
>>  static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst =3D=
 {
>>         {NPCM7XX_CLKDIV1, 28, 3, NPCM7XX_CLK_S_ADC,
>> @@ -435,107 +428,6 @@ static const struct npcm7xx_clk_div_data npcm7xx_d=
ivs[] __initconst =3D {
>>
>>  };
>>
>> -static const struct npcm7xx_clk_gate_data npcm7xx_gates[] __initconst =
=3D {
>> -       {NPCM7XX_CLKEN1, 31, "smb1-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN1, 30, "smb0-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN1, 29, "smb7-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN1, 28, "smb6-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN1, 27, "adc-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN1, 26, "wdt-gate", NPCM7XX_CLK_S_TIMER, 0},
>> -       {NPCM7XX_CLKEN1, 25, "usbdev3-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN1, 24, "usbdev6-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN1, 23, "usbdev5-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN1, 22, "usbdev4-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN1, 21, "emc2-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN1, 20, "timer5_9-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN1, 19, "timer0_4-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN1, 18, "pwmm0-gate", NPCM7XX_CLK_S_APB3, 0},
>> -       {NPCM7XX_CLKEN1, 17, "huart-gate", NPCM7XX_CLK_S_UART, 0},
>> -       {NPCM7XX_CLKEN1, 16, "smb5-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN1, 15, "smb4-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN1, 14, "smb3-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN1, 13, "smb2-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN1, 12, "mc-gate", NPCM7XX_CLK_S_MC, 0},
>> -       {NPCM7XX_CLKEN1, 11, "uart01-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN1, 10, "aes-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN1, 9, "peci-gate", NPCM7XX_CLK_S_APB3, 0},
>> -       {NPCM7XX_CLKEN1, 8, "usbdev2-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN1, 7, "uart23-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN1, 6, "emc1-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN1, 5, "usbdev1-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN1, 4, "shm-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       /* bit 3 is reserved */
>> -       {NPCM7XX_CLKEN1, 2, "kcs-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN1, 1, "spi3-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN1, 0, "spi0-gate", NPCM7XX_CLK_S_AHB, 0},
>> -
>> -       {NPCM7XX_CLKEN2, 31, "cp-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN2, 30, "tock-gate", NPCM7XX_CLK_S_TOCK, 0},
>> -       /* bit 29 is reserved */
>> -       {NPCM7XX_CLKEN2, 28, "gmac1-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN2, 27, "usbif-gate", NPCM7XX_CLK_S_USBIF, 0},
>> -       {NPCM7XX_CLKEN2, 26, "usbhost-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN2, 25, "gmac2-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       /* bit 24 is reserved */
>> -       {NPCM7XX_CLKEN2, 23, "pspi2-gate", NPCM7XX_CLK_S_APB5, 0},
>> -       {NPCM7XX_CLKEN2, 22, "pspi1-gate", NPCM7XX_CLK_S_APB5, 0},
>> -       {NPCM7XX_CLKEN2, 21, "3des-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       /* bit 20 is reserved */
>> -       {NPCM7XX_CLKEN2, 19, "siox2-gate", NPCM7XX_CLK_S_APB3, 0},
>> -       {NPCM7XX_CLKEN2, 18, "siox1-gate", NPCM7XX_CLK_S_APB3, 0},
>> -       /* bit 17 is reserved */
>> -       {NPCM7XX_CLKEN2, 16, "fuse-gate", NPCM7XX_CLK_S_APB4, 0},
>> -       /*  bit 15 is reserved */
>> -       {NPCM7XX_CLKEN2, 14, "vcd-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN2, 13, "ece-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN2, 12, "vdma-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN2, 11, "ahbpcibrg-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN2, 10, "gfxsys-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN2, 9, "sdhc-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN2, 8, "mmc-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN2, 7, "mft7-gate", NPCM7XX_CLK_S_APB4, 0},
>> -       {NPCM7XX_CLKEN2, 6, "mft6-gate", NPCM7XX_CLK_S_APB4, 0},
>> -       {NPCM7XX_CLKEN2, 5, "mft5-gate", NPCM7XX_CLK_S_APB4, 0},
>> -       {NPCM7XX_CLKEN2, 4, "mft4-gate", NPCM7XX_CLK_S_APB4, 0},
>> -       {NPCM7XX_CLKEN2, 3, "mft3-gate", NPCM7XX_CLK_S_APB4, 0},
>> -       {NPCM7XX_CLKEN2, 2, "mft2-gate", NPCM7XX_CLK_S_APB4, 0},
>> -       {NPCM7XX_CLKEN2, 1, "mft1-gate", NPCM7XX_CLK_S_APB4, 0},
>> -       {NPCM7XX_CLKEN2, 0, "mft0-gate", NPCM7XX_CLK_S_APB4, 0},
>> -
>> -       {NPCM7XX_CLKEN3, 31, "gpiom7-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN3, 30, "gpiom6-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN3, 29, "gpiom5-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN3, 28, "gpiom4-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN3, 27, "gpiom3-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN3, 26, "gpiom2-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN3, 25, "gpiom1-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN3, 24, "gpiom0-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN3, 23, "espi-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN3, 22, "smb11-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN3, 21, "smb10-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN3, 20, "smb9-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN3, 19, "smb8-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN3, 18, "smb15-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN3, 17, "rng-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN3, 16, "timer10_14-gate", NPCM7XX_CLK_S_APB1, 0},
>> -       {NPCM7XX_CLKEN3, 15, "pcirc-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN3, 14, "sececc-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN3, 13, "sha-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN3, 12, "smb14-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       /* bit 11 is reserved */
>> -       /* bit 10 is reserved */
>> -       {NPCM7XX_CLKEN3, 9, "pcimbx-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       /* bit 8 is reserved */
>> -       {NPCM7XX_CLKEN3, 7, "usbdev9-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN3, 6, "usbdev8-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN3, 5, "usbdev7-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN3, 4, "usbdev0-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN3, 3, "smb13-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN3, 2, "spix-gate", NPCM7XX_CLK_S_AHB, 0},
>> -       {NPCM7XX_CLKEN3, 1, "smb12-gate", NPCM7XX_CLK_S_APB2, 0},
>> -       {NPCM7XX_CLKEN3, 0, "pwmm1-gate", NPCM7XX_CLK_S_APB3, 0},
>> -};
>> -
>>  static DEFINE_SPINLOCK(npcm7xx_clk_lock);
>>
>>  static void __init npcm7xx_clk_init(struct device_node *clk_np)
>> --
>> 2.25.1
>>
