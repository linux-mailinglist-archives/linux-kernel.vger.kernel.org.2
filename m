Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C004134EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhIUOBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:01:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:57851 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233042AbhIUOBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:01:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210599486"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="210599486"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 06:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="613009248"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 21 Sep 2021 06:40:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Sep 2021 16:40:20 +0300
Date:   Tue, 21 Sep 2021 16:40:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [RFT PATCH 6/9] usb: typec: tipd: Setup IntMask explicitly
Message-ID: <YUngxBX8CSJK4nw8@kuha.fi.intel.com>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-7-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918120934.28252-7-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 02:09:31PM +0200, Sven Peter wrote:
> Right now the code relies on the bootloader to set up the interrupt mask
> correctly. This usually works but let's make sure to do it explicitly to
> guarantee it will always work.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/usb/typec/tipd/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index d191e7435018..2058e8cca631 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -728,6 +728,24 @@ static int tps6598x_probe(struct i2c_client *client)
>  			dev_err(&client->dev, "failed to register partner\n");
>  	}
>  
> +	if (tps->hw->use_int1) {
> +		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
> +					tps->hw->irq_power_status_update |
> +					tps->hw->irq_data_status_update |
> +					tps->hw->irq_plug_event);
> +		if (ret)
> +			goto err_role_put;
> +	}
> +
> +	if (tps->hw->use_int2) {
> +		ret = tps6598x_write64(tps, TPS_REG_INT_MASK2,
> +					tps->hw->irq_power_status_update |
> +					tps->hw->irq_data_status_update |
> +					tps->hw->irq_plug_event);
> +		if (ret)
> +			goto err_role_put;
> +	}

You should first only set the mask on your board. We can then see if
it's something that should be done on other boards as well later.

thanks,

-- 
heikki
