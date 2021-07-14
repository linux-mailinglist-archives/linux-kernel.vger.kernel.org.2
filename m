Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9930E3C8B91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbhGNTY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:24:27 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:37618 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhGNTYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:24:25 -0400
Received: by mail-io1-f46.google.com with SMTP id l18so3514219iow.4;
        Wed, 14 Jul 2021 12:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gh4zEBeE3cSd66l13kaZQNROzup4xRXlw8Sc/SVaLe8=;
        b=qfGB/8iYTWhXtPbapJUEdJw5TYBwvmePUdRANPMZAGYUyJil7ug9XgoweNlvJL/wuh
         ZRc1lgJoA6Svp4s5VPcjDA9o3SHkPvGWmjaMWULy8fxfXTlttY0uLn+7MqWyje8RWr1C
         4EUmLVwNO8tzG97MuMJA3esn7d/GneJm50nBa0S+bSSImDUjmDR+Rgp7PsgaEMgCuJBA
         5deRA9u1yeuHW49JNXXr4dyuWYa6BYb31rzy+rKF3ZFMPJZog5lIAagYo23iy+nQkT2x
         edImNVsov+/3JdGNWbW4yz5JmJUKl3kfXBDCxsUMfrQ3sFpXoLs7TXthTy4+dNDPd5EP
         rj9A==
X-Gm-Message-State: AOAM531Ste7vyBuw2czP7xeFflEqIIRLUuOFvR/6ZdmGtaoUIOgJz8uS
        WUR5zMOyHCogKK83ACtc6g==
X-Google-Smtp-Source: ABdhPJyp5uwIvrM7x/U669N+F147QBA4aAH/5x91kG+HuQhypzMASH9JvRdzCQWlMmplswGOjlMLhA==
X-Received: by 2002:a6b:5c07:: with SMTP id z7mr8294147ioh.26.1626290492683;
        Wed, 14 Jul 2021 12:21:32 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t15sm1675455iln.36.2021.07.14.12.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:21:32 -0700 (PDT)
Received: (nullmailer pid 3050937 invoked by uid 1000);
        Wed, 14 Jul 2021 19:21:30 -0000
Date:   Wed, 14 Jul 2021 13:21:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] clk: visconti: Add support common clock driver
 and reset driver
Message-ID: <20210714192130.GA3000985@robh.at.kernel.org>
References: <20210624034337.282386-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210624034337.282386-2-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624034337.282386-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 12:43:34PM +0900, Nobuhiro Iwamatsu wrote:
> This adds support for common interface of the common clock and reset driver
> for Toshiba Visconti5 and its SoC, TMPV7708. The PIPLLCT provides the PLL,
> and the PISMU provides clock and reset functionality.
> Each drivers are provided in this patch.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  drivers/clk/Makefile                         |   1 +
>  drivers/clk/visconti/Makefile                |   5 +
>  drivers/clk/visconti/clkc-tmpv770x.c         | 246 +++++++++++++
>  drivers/clk/visconti/clkc.c                  | 220 +++++++++++
>  drivers/clk/visconti/clkc.h                  |  75 ++++
>  drivers/clk/visconti/pll-tmpv770x.c          |  96 +++++
>  drivers/clk/visconti/pll.c                   | 369 +++++++++++++++++++
>  drivers/clk/visconti/pll.h                   |  63 ++++
>  drivers/clk/visconti/reset.c                 | 111 ++++++
>  drivers/clk/visconti/reset.h                 |  35 ++

>  include/dt-bindings/clock/toshiba,tmpv770x.h | 181 +++++++++
>  include/dt-bindings/reset/toshiba,tmpv770x.h |  41 +++

These belong with the binding.

>  12 files changed, 1443 insertions(+)
>  create mode 100644 drivers/clk/visconti/Makefile
>  create mode 100644 drivers/clk/visconti/clkc-tmpv770x.c
>  create mode 100644 drivers/clk/visconti/clkc.c
>  create mode 100644 drivers/clk/visconti/clkc.h
>  create mode 100644 drivers/clk/visconti/pll-tmpv770x.c
>  create mode 100644 drivers/clk/visconti/pll.c
>  create mode 100644 drivers/clk/visconti/pll.h
>  create mode 100644 drivers/clk/visconti/reset.c
>  create mode 100644 drivers/clk/visconti/reset.h
>  create mode 100644 include/dt-bindings/clock/toshiba,tmpv770x.h
>  create mode 100644 include/dt-bindings/reset/toshiba,tmpv770x.h

> diff --git a/include/dt-bindings/clock/toshiba,tmpv770x.h b/include/dt-bindings/clock/toshiba,tmpv770x.h
> new file mode 100644
> index 000000000000..923b47a11730
> --- /dev/null
> +++ b/include/dt-bindings/clock/toshiba,tmpv770x.h
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license DT headers please.

> +
> +#ifndef _DT_BINDINGS_CLOCK_TOSHIBA_TMPV770X_H_
> +#define _DT_BINDINGS_CLOCK_TOSHIBA_TMPV770X_H_
> +
> +/* PLL */
> +#define TMPV770X_PLL_PIPLL0		0
> +#define TMPV770X_PLL_PIPLL1		1
> +#define TMPV770X_PLL_PIDNNPLL		2
> +#define TMPV770X_PLL_PIETHERPLL		3
> +#define TMPV770X_PLL_PIDDRCPLL		4
> +#define TMPV770X_PLL_PIVOIFPLL		5
> +#define TMPV770X_PLL_PIIMGERPLL		6
> +#define TMPV770X_NR_PLL		7
> +
> +/* Clocks */
> +#define TMPV770X_CLK_PIPLL1_DIV1	0
> +#define TMPV770X_CLK_PIPLL1_DIV2	1
> +#define TMPV770X_CLK_PIPLL1_DIV4	2
> +#define TMPV770X_CLK_PIDNNPLL_DIV1	3
> +#define TMPV770X_CLK_DDRC_PHY_PLL0	4
> +#define TMPV770X_CLK_DDRC_PHY_PLL1	5
> +#define TMPV770X_CLK_D_PHYPLL		6
> +#define TMPV770X_CLK_PHY_PCIEPLL	7
> +#define TMPV770X_CLK_CA53CL0		8
> +#define TMPV770X_CLK_CA53CL1		9
> +#define TMPV770X_CLK_PISDMAC		10
> +#define TMPV770X_CLK_PIPDMAC0		11
> +#define TMPV770X_CLK_PIPDMAC1		12
> +#define TMPV770X_CLK_PIWRAM		13
> +#define TMPV770X_CLK_DDRC0		14
> +#define TMPV770X_CLK_DDRC0_SCLK		15
> +#define TMPV770X_CLK_DDRC0_NCLK		16
> +#define TMPV770X_CLK_DDRC0_MCLK		17
> +#define TMPV770X_CLK_DDRC0_APBCLK	18
> +#define TMPV770X_CLK_DDRC1		19
> +#define TMPV770X_CLK_DDRC1_SCLK		20
> +#define TMPV770X_CLK_DDRC1_NCLK		21
> +#define TMPV770X_CLK_DDRC1_MCLK		22
> +#define TMPV770X_CLK_DDRC1_APBCLK	23
> +#define TMPV770X_CLK_HOX		24
> +#define TMPV770X_CLK_PCIE_MSTR		25
> +#define TMPV770X_CLK_PCIE_AUX		26
> +#define TMPV770X_CLK_PIINTC		27
> +#define TMPV770X_CLK_PIETHER_BUS	28
> +#define TMPV770X_CLK_PISPI0		29
> +#define TMPV770X_CLK_PISPI1		30
> +#define TMPV770X_CLK_PISPI2		31
> +#define TMPV770X_CLK_PISPI3		32
> +#define TMPV770X_CLK_PISPI4		33
> +#define TMPV770X_CLK_PISPI5		34
> +#define TMPV770X_CLK_PISPI6		35
> +#define TMPV770X_CLK_PIUART0		36
> +#define TMPV770X_CLK_PIUART1		37
> +#define TMPV770X_CLK_PIUART2		38
> +#define TMPV770X_CLK_PIUART3		39
> +#define TMPV770X_CLK_PII2C0		40
> +#define TMPV770X_CLK_PII2C1		41
> +#define TMPV770X_CLK_PII2C2		42
> +#define TMPV770X_CLK_PII2C3		43
> +#define TMPV770X_CLK_PII2C4		44
> +#define TMPV770X_CLK_PII2C5		45
> +#define TMPV770X_CLK_PII2C6		46
> +#define TMPV770X_CLK_PII2C7		47
> +#define TMPV770X_CLK_PII2C8		48
> +#define TMPV770X_CLK_PIGPIO		49
> +#define TMPV770X_CLK_PIPGM		50
> +#define TMPV770X_CLK_PIPCMIF		51
> +#define TMPV770X_CLK_PIPCMIF_AUDIO_O	52
> +#define TMPV770X_CLK_PIPCMIF_AUDIO_I	53
> +#define TMPV770X_CLK_PICMPT0		54
> +#define TMPV770X_CLK_PICMPT1		55
> +#define TMPV770X_CLK_PITSC		56
> +#define TMPV770X_CLK_PIUWDT		57
> +#define TMPV770X_CLK_PISWDT		58
> +#define TMPV770X_CLK_WDTCLK		59
> +#define TMPV770X_CLK_PISUBUS_150M	60
> +#define TMPV770X_CLK_PISUBUS_300M	61
> +#define TMPV770X_CLK_PIPMU		62
> +#define TMPV770X_CLK_PIGPMU		63
> +#define TMPV770X_CLK_PITMU		64
> +#define TMPV770X_CLK_WRCK		65
> +#define TMPV770X_CLK_PIEMM		66
> +#define TMPV770X_CLK_PIMISC		67
> +#define TMPV770X_CLK_PIGCOMM		68
> +#define TMPV770X_CLK_PIDCOMM		69
> +#define TMPV770X_CLK_PICKMON		70
> +#define TMPV770X_CLK_PIMBUS		71
> +#define TMPV770X_CLK_SBUSCLK		72
> +#define TMPV770X_CLK_DDR0_APBCLKCLK	73
> +#define TMPV770X_CLK_DDR1_APBCLKCLK	74
> +#define TMPV770X_CLK_DSP0_PBCLK		75
> +#define TMPV770X_CLK_DSP1_PBCLK		76
> +#define TMPV770X_CLK_DSP2_PBCLK		77
> +#define TMPV770X_CLK_DSP3_PBCLK		78
> +#define TMPV770X_CLK_DSVIIF0_APBCLK	79
> +#define TMPV770X_CLK_VIIF0_APBCLK	80
> +#define TMPV770X_CLK_VIIF0_CFGCLK	81
> +#define TMPV770X_CLK_VIIF1_APBCLK	82
> +#define TMPV770X_CLK_VIIF1_CFGCLK	83
> +#define TMPV770X_CLK_VIIF2_APBCLK	84
> +#define TMPV770X_CLK_VIIF2_CFGCLK	85
> +#define TMPV770X_CLK_VIIF3_APBCLK	86
> +#define TMPV770X_CLK_VIIF3_CFGCLK	87
> +#define TMPV770X_CLK_VIIF4_APBCLK	88
> +#define TMPV770X_CLK_VIIF4_CFGCLK	89
> +#define TMPV770X_CLK_VIIF5_APBCLK	90
> +#define TMPV770X_CLK_VIIF5_CFGCLK	91
> +#define TMPV770X_CLK_VOIF_SBUSCLK	92
> +#define TMPV770X_CLK_VOIF_PROCCLK	93
> +#define TMPV770X_CLK_VOIF_DPHYCFGCLK	94
> +#define TMPV770X_CLK_DNN0		95
> +#define TMPV770X_CLK_STMAT		96
> +#define TMPV770X_CLK_HWA0		97
> +#define TMPV770X_CLK_AFFINE0		98
> +#define TMPV770X_CLK_HAMAT		99
> +#define TMPV770X_CLK_SMLDB		100
> +#define TMPV770X_CLK_HWA0_ASYNC		101
> +#define TMPV770X_CLK_HWA2		102
> +#define TMPV770X_CLK_FLMAT		103
> +#define TMPV770X_CLK_PYRAMID		104
> +#define TMPV770X_CLK_HWA2_ASYNC		105
> +#define TMPV770X_CLK_DSP0		106
> +#define TMPV770X_CLK_VIIFBS0		107
> +#define TMPV770X_CLK_VIIFBS0_L2ISP	108
> +#define TMPV770X_CLK_VIIFBS0_L1ISP	109
> +#define TMPV770X_CLK_VIIFBS0_PROC	110
> +#define TMPV770X_CLK_VIIFBS1		111
> +#define TMPV770X_CLK_VIIFBS2		112
> +#define TMPV770X_CLK_VIIFOP_MBUS	113
> +#define TMPV770X_CLK_VIIFOP0_PROC	114
> +#define TMPV770X_CLK_PIETHER_2P5M	115
> +#define TMPV770X_CLK_PIETHER_25M	116
> +#define TMPV770X_CLK_PIETHER_50M	117
> +#define TMPV770X_CLK_PIETHER_125M	118
> +#define TMPV770X_CLK_VOIF0_DPHYCFG	119
> +#define TMPV770X_CLK_VOIF0_PROC		120
> +#define TMPV770X_CLK_VOIF0_SBUS		121
> +#define TMPV770X_CLK_VOIF0_DSIREF	122
> +#define TMPV770X_CLK_VOIF0_PIXEL	123
> +#define TMPV770X_CLK_PIREFCLK		124
> +#define TMPV770X_CLK_SBUS		125
> +#define TMPV770X_CLK_BUSLCK		126
> +#define TMPV770X_NR_CLK			127
> +
> +/* Reset */
> +#define TMPV770X_RESET_PIETHER_2P5M	0
> +#define TMPV770X_RESET_PIETHER_25M	1
> +#define TMPV770X_RESET_PIETHER_50M	2
> +#define TMPV770X_RESET_PIETHER_125M	3
> +#define TMPV770X_RESET_HOX		4
> +#define TMPV770X_RESET_PCIE_MSTR	5
> +#define TMPV770X_RESET_PCIE_AUX		6
> +#define TMPV770X_RESET_PIINTC		7
> +#define TMPV770X_RESET_PIETHER_BUS	8
> +#define TMPV770X_RESET_PISPI0		9
> +#define TMPV770X_RESET_PISPI1		10
> +#define TMPV770X_RESET_PISPI2		11
> +#define TMPV770X_RESET_PISPI3		12
> +#define TMPV770X_RESET_PISPI4		13
> +#define TMPV770X_RESET_PISPI5		14
> +#define TMPV770X_RESET_PISPI6		15
> +#define TMPV770X_RESET_PIUART0		16
> +#define TMPV770X_RESET_PIUART1		17
> +#define TMPV770X_RESET_PIUART2		18
> +#define TMPV770X_RESET_PIUART3		19
> +#define TMPV770X_RESET_PII2C0		20
> +#define TMPV770X_RESET_PII2C1		21
> +#define TMPV770X_RESET_PII2C2		22
> +#define TMPV770X_RESET_PII2C3		23
> +#define TMPV770X_RESET_PII2C4		24
> +#define TMPV770X_RESET_PII2C5		25
> +#define TMPV770X_RESET_PII2C6		26
> +#define TMPV770X_RESET_PII2C7		27
> +#define TMPV770X_RESET_PII2C8		28
> +#define TMPV770X_RESET_PIPCMIF		29
> +#define TMPV770X_RESET_PICKMON		30
> +#define TMPV770X_RESET_SBUSCLK		31
> +#define TMPV770X_NR_RESET		32
> +
> +#endif /*_DT_BINDINGS_CLOCK_TOSHIBA_TMPV770X_H_ */
> diff --git a/include/dt-bindings/reset/toshiba,tmpv770x.h b/include/dt-bindings/reset/toshiba,tmpv770x.h
> new file mode 100644
> index 000000000000..080de7e69e68
> --- /dev/null
> +++ b/include/dt-bindings/reset/toshiba,tmpv770x.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _DT_BINDINGS_RESET_TOSHIBA_TMPV770X_H_
> +#define _DT_BINDINGS_RESET_TOSHIBA_TMPV770X_H_
> +
> +/* Reset */
> +#define TMPV770X_RESET_PIETHER_2P5M	0
> +#define TMPV770X_RESET_PIETHER_25M	1
> +#define TMPV770X_RESET_PIETHER_50M	2
> +#define TMPV770X_RESET_PIETHER_125M	3
> +#define TMPV770X_RESET_HOX		4
> +#define TMPV770X_RESET_PCIE_MSTR	5
> +#define TMPV770X_RESET_PCIE_AUX		6
> +#define TMPV770X_RESET_PIINTC		7
> +#define TMPV770X_RESET_PIETHER_BUS	8
> +#define TMPV770X_RESET_PISPI0		9
> +#define TMPV770X_RESET_PISPI1		10
> +#define TMPV770X_RESET_PISPI2		11
> +#define TMPV770X_RESET_PISPI3		12
> +#define TMPV770X_RESET_PISPI4		13
> +#define TMPV770X_RESET_PISPI5		14
> +#define TMPV770X_RESET_PISPI6		15
> +#define TMPV770X_RESET_PIUART0		16
> +#define TMPV770X_RESET_PIUART1		17
> +#define TMPV770X_RESET_PIUART2		18
> +#define TMPV770X_RESET_PIUART3		19
> +#define TMPV770X_RESET_PII2C0		20
> +#define TMPV770X_RESET_PII2C1		21
> +#define TMPV770X_RESET_PII2C2		22
> +#define TMPV770X_RESET_PII2C3		23
> +#define TMPV770X_RESET_PII2C4		24
> +#define TMPV770X_RESET_PII2C5		25
> +#define TMPV770X_RESET_PII2C6		26
> +#define TMPV770X_RESET_PII2C7		27
> +#define TMPV770X_RESET_PII2C8		28
> +#define TMPV770X_RESET_PIPCMIF		29
> +#define TMPV770X_RESET_PICKMON		30
> +#define TMPV770X_RESET_SBUSCLK		31
> +#define TMPV770X_NR_RESET		32
> +
> +#endif /*_DT_BINDINGS_RESET_TOSHIBA_TMPV770X_H_ */
> -- 
> 2.32.0
> 
> 
