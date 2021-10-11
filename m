Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C87428633
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 07:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhJKF3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 01:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhJKF3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 01:29:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F71C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 22:27:23 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mZnqA-0004do-9g; Mon, 11 Oct 2021 07:27:10 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mZnq8-0001Ul-GZ; Mon, 11 Oct 2021 07:27:08 +0200
Date:   Mon, 11 Oct 2021 07:27:08 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6dl-prtrvt: drop undocumented TRF7970A NFC
 properties
Message-ID: <20211011052708.GH29653@pengutronix.de>
References: <20211010133215.145722-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211010133215.145722-1-krzysztof.kozlowski@canonical.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:26:38 up 235 days,  8:50, 102 users,  load average: 0.03, 0.08,
 0.12
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 03:32:15PM +0200, Krzysztof Kozlowski wrote:
> Neither the bindings nor the device driver use/document
> "vin-voltage-override" and "t5t-rmb-extra-byte-quirk" properties.
> 
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

> ---
>  arch/arm/boot/dts/imx6dl-prtrvt.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-prtrvt.dts b/arch/arm/boot/dts/imx6dl-prtrvt.dts
> index 5ac84445e9cc..56bb1ca56a2d 100644
> --- a/arch/arm/boot/dts/imx6dl-prtrvt.dts
> +++ b/arch/arm/boot/dts/imx6dl-prtrvt.dts
> @@ -67,11 +67,9 @@ nfc@0 {
>  		ti,enable-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>,
>  				  <&gpio5 11 GPIO_ACTIVE_LOW>;
>  		vin-supply = <&reg_3v3>;
> -		vin-voltage-override = <3100000>;
>  		autosuspend-delay = <30000>;
>  		irq-status-read-quirk;
>  		en2-rf-quirk;
> -		t5t-rmb-extra-byte-quirk;
>  		status = "okay";
>  	};
>  };
> -- 
> 2.30.2
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
