Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2029F3EAAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhHLT0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:26:51 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55075 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhHLT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:26:50 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id ADCAFE0002;
        Thu, 12 Aug 2021 19:26:22 +0000 (UTC)
Date:   Thu, 12 Aug 2021 21:26:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hari Prasath <Hari.PrasathGE@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        robh@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Subject: Re: [PATCH 2/2] ARM: at91: dts: at91-sama5d2_xplained: Add comments
 for sama5d29
Message-ID: <YRV13nfgpEEuOOxB@piout.net>
References: <20210812140758.28273-1-Hari.PrasathGE@microchip.com>
 <20210812140758.28273-2-Hari.PrasathGE@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812140758.28273-2-Hari.PrasathGE@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 12/08/2021 19:37:58+0530, Hari Prasath wrote:
> Add comments for the end user for modifying the DTS file for
> instantiating the sama5d29 SoC.
> 
> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 627b7bf88d83..faa30063d9a9 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -6,6 +6,11 @@
>   *                2015 Nicolas Ferre <nicolas.ferre@atmel.com>
>   */
>  /dts-v1/;
> +/*
> + * Replace the line below with "sama5d29.dtsi" in order to instantiate the
> + * sama5d29 SoC of the sama5d2 family.Otherwise, leave it unchanged when
> + * using sama5d27 SoC for instance.
> + */

I guess it would be better to have a at91-sama5d29_xplained.dts (and we
should have had a at91-sama5d27_xplained.dts), else, you can't create an
image that will support both variants.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
