Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13683A4D58
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 09:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFLH0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 03:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhFLH0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 03:26:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BC5861001;
        Sat, 12 Jun 2021 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623482685;
        bh=t/XgaghKUAW5fxfIyI1pGDsxc8Nx4j/oqsUFlYCf95A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F93w5krVy5rN/nUpUkyS3OZy1OARVmNHDpaf0oWXXjel4wxg1enDo26a4XVxfUpkf
         0gHrvfv8CGndUS5EYRTMDSw2b9KffdXfne8T5c7X9iM+/NxeKXbICNxcaER2paOKEo
         CYaulMrzN6yvV06erad0M3OGVTzh2d8eSbMco0zaq/uXFj7PUN3kU3OnUAh589h7Z7
         E8sasOynewQB0QjlkV+6tThNb/IbtF4bhFgxdGoxSD4yl2Q5xMCrNuYY8q22nTGRLV
         csA+pc9E12A+fYMQKiGt8OqhGe3n6jvvPey9wak3hvrpRWlpr6aTjCOwhwUxR3ihou
         /ppjuY3QEM3sw==
Date:   Sat, 12 Jun 2021 15:24:38 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Breno Lima <breno.lima@nxp.com>
Cc:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brenomatheus@gmail.com, jun.li@nxp.com
Subject: Re: [PATCH v2] mx8mm: usb: chipidea: Fix Battery Charger 1.2 CDP
 detection
Message-ID: <20210612072438.GA4580@Peter>
References: <20210611145607.147207-1-breno.lima@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611145607.147207-1-breno.lima@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-11 10:56:07, Breno Lima wrote:
> i.MX8MM cannot detect certain CDP USB HUBs. usbmisc_imx.c driver is not
> following CDP timing requirements defined by USB BC 1.2 specification
> and section 3.2.4 Detection Timing CDP.
> 
> During Primary Detection the i.MX device should turn on VDP_SRC and
> IDM_SINK for a minimum of 40ms (TVDPSRC_ON). After a time of TVDPSRC_ON,
> the PD is allowed to check the status of the D- line. Current
> implementation is waiting between 1ms and 2ms, and certain BC 1.2
> complaint USB HUBs cannot be detected. Increase delay to 40ms allowing
> enough time for primary detection.
> 
> During secondary detection the PD is required to disable VDP_SRC and

What does the "PD" mean here?

> IDM_SNK, and enable VDM_SRC and IDP_SINK for at least 40ms (TVDMSRC_ON).
> 
> Current implementation is not disabling VDP_SRC and IDM_SNK, introduce
> disable sequence in imx7d_charger_secondary_detection() function.
> 
> VDM_SRC and IDP_SINK should be enabled for at least 40ms (TVDMSRC_ON).
> Increase delay allowing enough time for detection.
> 
> Fixes: 746f316b753a ("usb: chipidea: introduce imx7d USB charger detection")

I assume this one needs to go stable tree?

Peter
> 
> Signed-off-by: Breno Lima <breno.lima@nxp.com>
> Signed-off-by: Jun Li <jun.li@nxp.com>
> ---
> Changes since V1:
> - Updated commit log to include commit ID fix
>  drivers/usb/chipidea/usbmisc_imx.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index 4545b23bda3f..bac0f5458cab 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -686,6 +686,16 @@ static int imx7d_charger_secondary_detection(struct imx_usbmisc_data *data)
>  	int val;
>  	unsigned long flags;
>  
> +	/* Clear VDATSRCENB0 to disable VDP_SRC and IDM_SNK required by BC 1.2 spec */
> +	spin_lock_irqsave(&usbmisc->lock, flags);
> +	val = readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
> +	val &= ~MX7D_USB_OTG_PHY_CFG2_CHRG_VDATSRCENB0;
> +	writel(val, usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
> +	spin_unlock_irqrestore(&usbmisc->lock, flags);
> +
> +	/* TVDMSRC_DIS */
> +	msleep(20);
> +
>  	/* VDM_SRC is connected to D- and IDP_SINK is connected to D+ */
>  	spin_lock_irqsave(&usbmisc->lock, flags);
>  	val = readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
> @@ -695,7 +705,8 @@ static int imx7d_charger_secondary_detection(struct imx_usbmisc_data *data)
>  				usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
>  	spin_unlock_irqrestore(&usbmisc->lock, flags);
>  
> -	usleep_range(1000, 2000);
> +	/* TVDMSRC_ON */
> +	msleep(40);
>  
>  	/*
>  	 * Per BC 1.2, check voltage of D+:
> @@ -798,7 +809,8 @@ static int imx7d_charger_primary_detection(struct imx_usbmisc_data *data)
>  				usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
>  	spin_unlock_irqrestore(&usbmisc->lock, flags);
>  
> -	usleep_range(1000, 2000);
> +	/* TVDPSRC_ON */
> +	msleep(40);
>  
>  	/* Check if D- is less than VDAT_REF to determine an SDP per BC 1.2 */
>  	val = readl(usbmisc->base + MX7D_USB_OTG_PHY_STATUS);
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

