Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB54455C62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 14:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhKRNPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:15:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:45241 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhKRNPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:15:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="294993928"
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="294993928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 05:12:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="646558745"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 18 Nov 2021 05:12:18 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 18 Nov 2021 15:12:17 +0200
Date:   Thu, 18 Nov 2021 15:12:17 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: tipd: Fix initialization sequence for
 cd321x
Message-ID: <YZZRMfchQ7Y6gPqQ@kuha.fi.intel.com>
References: <20211117151450.207168-1-marcan@marcan.st>
 <20211117151450.207168-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117151450.207168-3-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 18, 2021 at 12:14:50AM +0900, Hector Martin wrote:
> The power state switch needs to happen first, as that
> kickstarts the firmware into normal mode.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Please resend these with the appropriate Fixes tag included.

> ---
>  drivers/usb/typec/tipd/core.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 4da5a0b2aed2..6d27a5b5e3ca 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -707,6 +707,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	u32 conf;
>  	u32 vid;
>  	int ret;
> +	u64 mask1;
>  
>  	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
>  	if (!tps)
> @@ -730,11 +731,6 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		tps->i2c_protocol = true;
>  
> -	/* Make sure the controller has application firmware running */
> -	ret = tps6598x_check_mode(tps);
> -	if (ret)
> -		return ret;
> -
>  	if (np && of_device_is_compatible(np, "apple,cd321x")) {
>  		/* Switch CD321X chips to the correct system power state */
>  		ret = cd321x_switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
> @@ -742,24 +738,27 @@ static int tps6598x_probe(struct i2c_client *client)
>  			return ret;
>  
>  		/* CD321X chips have all interrupts masked initially */
> -		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
> -					APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
> -					APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
> -					APPLE_CD_REG_INT_PLUG_EVENT);
> -		if (ret)
> -			return ret;
> +		mask1 = APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
> +			APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
> +			APPLE_CD_REG_INT_PLUG_EVENT;
>  
>  		irq_handler = cd321x_interrupt;
>  	} else {
>  		/* Enable power status, data status and plug event interrupts */
> -		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
> -				       TPS_REG_INT_POWER_STATUS_UPDATE |
> -				       TPS_REG_INT_DATA_STATUS_UPDATE |
> -				       TPS_REG_INT_PLUG_EVENT);
> -		if (ret)
> -			return ret;
> +		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
> +			TPS_REG_INT_DATA_STATUS_UPDATE |
> +			TPS_REG_INT_PLUG_EVENT;
>  	}
>  
> +	/* Make sure the controller has application firmware running */
> +	ret = tps6598x_check_mode(tps);
> +	if (ret)
> +		return ret;
> +
> +	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, mask1);
> +	if (ret)
> +		return ret;
> +
>  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.33.0

thanks,

-- 
heikki
