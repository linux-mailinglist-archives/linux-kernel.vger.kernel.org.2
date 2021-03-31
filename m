Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D748C3503DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhCaPyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:54:53 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60441 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhCaPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:54:31 -0400
X-Originating-IP: 90.65.110.174
Received: from localhost (lfbn-lyo-1-1679-174.w90-65.abo.wanadoo.fr [90.65.110.174])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D7FF81C0013;
        Wed, 31 Mar 2021 15:54:26 +0000 (UTC)
Date:   Wed, 31 Mar 2021 17:54:26 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/24] ARM: at91: sfrbu: add sfrbu registers definitions
 for sama7g5
Message-ID: <YGSbMtNzcVmBg7fQ@piout.net>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
 <20210331105908.23027-11-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331105908.23027-11-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2021 13:58:54+0300, Claudiu Beznea wrote:
> Add SFRBU registers definitions for SAMA7G5.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  include/soc/at91/sama7-sfrbu.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 include/soc/at91/sama7-sfrbu.h
> 
> diff --git a/include/soc/at91/sama7-sfrbu.h b/include/soc/at91/sama7-sfrbu.h
> new file mode 100644
> index 000000000000..76b740810d34
> --- /dev/null
> +++ b/include/soc/at91/sama7-sfrbu.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Microchip SAMA7 SFRBU registers offsets and bit definitions.
> + *
> + * Copyright (C) [2020] Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Claudu Beznea <claudiu.beznea@microchip.com>
> + */
> +
> +#ifndef __SAMA7_SFRBU_H__
> +#define __SAMA7_SFRBU_H__
> +
> +#ifdef CONFIG_SOC_SAMA7
> +
> +#define AT91_SFRBU_PSWBU			(0x00)		/* SFRBU Power Switch BU Control Register */
> +#define		AT91_SFRBU_PSWBU_PSWKEY		(0x4BD20C << 8)	/* Specific value mandatory to allow writing of other register bits */
> +#define		AT91_SFRBU_PSWBU_STATE		(1 << 2)	/* Power switch BU state */
> +#define		AT91_SFRBU_PSWBU_SOFTSWITCH	(1 << 1)	/* Power switch BU source selection */
> +#define		AT91_SFRBU_PSWBU_CTRL		(1 << 0)	/* Power switch BU control */

Please use BIT

> +
> +#define AT91_SFRBU_25LDOCR			(0x0C)		/* SFRBU 2.5V LDO Control Register */
> +#define		AT91_SFRBU_25LDOCR_LDOANAKEY	(0x3B6E18 << 8)	/* Specific value mandatory to allow writing of other register bits. */
> +#define		AT91_SFRBU_25LDOCR_STATE	(1 << 3)	/* LDOANA Switch On/Off Control */
> +#define		AT91_SFRBU_25LDOCR_LP		(1 << 2)	/* LDOANA Low-Power Mode Control */
> +#define		AT91_SFRBU_PD_VALUE_MSK		(0x3)

GENMASK

> +#define		AT91_SFRBU_25LDOCR_PD_VALUE(v)	((v) & AT91_SFRBU_PD_VALUE_MSK)	/* LDOANA Pull-down value */

this macro is not necessary, you can use FIELD_PREP with the previous
define.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
