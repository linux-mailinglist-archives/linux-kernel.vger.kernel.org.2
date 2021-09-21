Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59214133CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhIUNLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:11:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:42555 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232344AbhIUNLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:11:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="221463249"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="221463249"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 06:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="613000879"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 21 Sep 2021 06:10:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Sep 2021 16:10:16 +0300
Date:   Tue, 21 Sep 2021 16:10:16 +0300
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
Subject: Re: [RFT PATCH 2/9] usb: typec: tipd: Prepare supporting different
 variants
Message-ID: <YUnZuOnyvoqsiRQj@kuha.fi.intel.com>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918120934.28252-3-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Sep 18, 2021 at 02:09:27PM +0200, Sven Peter wrote:
> Apple M1 machines come with a variant of the TI TPS6598x and will need
> some changes to the current logic. Let's prepare for that by setting up
> the infrastructure required to support different variants of this chip
> identified by the DT compatible.

I think in this case it would make sense to just squash this into the
next patch.

> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/usb/typec/tipd/core.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 21b3ae25c76d..656020e7f533 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -9,6 +9,7 @@
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/regmap.h>
>  #include <linux/interrupt.h>
> @@ -76,6 +77,10 @@ static const char *const modes[] = {
>  /* Unrecognized commands will be replaced with "!CMD" */
>  #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
>  
> +struct tps6598x_hw {
> +};

Black line here.

> +static const struct tps6598x_hw ti_tps6598x_data;
> +
>  struct tps6598x {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -91,6 +96,8 @@ struct tps6598x {
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
>  	enum power_supply_usb_type usb_type;
> +
> +	const struct tps6598x_hw *hw;
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -590,6 +597,13 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (!tps)
>  		return -ENOMEM;
>  
> +	if (client->dev.of_node)
> +		tps->hw = of_device_get_match_data(&client->dev);
> +	else
> +		tps->hw = &ti_tps6598x_data;
> +	if (!tps->hw)
> +		return -EINVAL;

	tps->hw = of_device_get_match_data(&client->dev);
        if (!tps->hw)
		tps->hw = &ti_tps6598x_data;

>  	mutex_init(&tps->lock);
>  	tps->dev = &client->dev;
>  
> @@ -729,8 +743,11 @@ static int tps6598x_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static const struct tps6598x_hw ti_tps6598x_data = {
> +};

You could also move that above tps6598x_probe() and get rid of the
forward declaration.

>  static const struct of_device_id tps6598x_of_match[] = {
> -	{ .compatible = "ti,tps6598x", },
> +	{ .compatible = "ti,tps6598x", .data = &ti_tps6598x_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, tps6598x_of_match);

thanks,

-- 
heikki
