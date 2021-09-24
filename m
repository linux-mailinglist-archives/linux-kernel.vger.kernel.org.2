Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8178F4176F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbhIXOnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:43:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:47633 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhIXOng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:43:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211326172"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="211326172"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 07:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="614520387"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 24 Sep 2021 07:41:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 24 Sep 2021 17:41:56 +0300
Date:   Fri, 24 Sep 2021 17:41:56 +0300
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
Subject: Re: [PATCH v2 4/6] usb: typec: tipd: Add support for Apple CD321X
Message-ID: <YU3jtIvYOk/IHUWn@kuha.fi.intel.com>
References: <20210923181321.3044-1-sven@svenpeter.dev>
 <20210923181321.3044-5-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923181321.3044-5-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One more question below.

On Thu, Sep 23, 2021 at 08:13:19PM +0200, Sven Peter wrote:
> Apple CD321x chips are a variant of the TI TPS 6598x chips.
> The major differences are the changed interrupt numbers and
> the concurrent connection to the SMC which we must not disturb.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> changes since v1:
>   - new commit since Heikki suggested to just add a separate irq handler
> 
>  drivers/usb/typec/tipd/core.c     | 86 ++++++++++++++++++++++++++++++-
>  drivers/usb/typec/tipd/tps6598x.h |  6 +++
>  drivers/usb/typec/tipd/trace.h    | 23 +++++++++
>  3 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index cd1e37eb8a0c..6c9c8f19a1cf 100644
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
> @@ -76,6 +77,16 @@ static const char *const modes[] = {
>  /* Unrecognized commands will be replaced with "!CMD" */
>  #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
>  
> +enum tipd_hw_type {
> +	HW_TPS6598X,
> +	HW_CD321X
> +};
> +
> +struct tipd_hw {
> +	enum tipd_hw_type type;
> +	irq_handler_t irq_handler;
> +};
> +
>  struct tps6598x {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -458,6 +469,51 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
>  	}
>  }
>  
> +static irqreturn_t cd321x_interrupt(int irq, void *data)
> +{
> +	struct tps6598x *tps = data;
> +	u64 event = 0;
> +	u32 status;
> +	int ret;
> +
> +	mutex_lock(&tps->lock);
> +
> +	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event);
> +	if (ret) {
> +		dev_err(tps->dev, "%s: failed to read events\n", __func__);
> +		goto err_unlock;
> +	}
> +	trace_cd321x_irq(event);
> +
> +	if (!event)
> +		goto err_unlock;
> +
> +	if (!tps6598x_read_status(tps, &status))
> +		goto err_clear_ints;
> +
> +	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE)
> +		if (!tps6598x_read_power_status(tps))
> +			goto err_clear_ints;
> +
> +	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
> +		if (!tps6598x_read_data_status(tps))
> +			goto err_clear_ints;
> +
> +	/* Handle plug insert or removal */
> +	if (event & APPLE_CD_REG_INT_PLUG_EVENT)
> +		tps6598x_handle_plug_event(tps, status);
> +
> +err_clear_ints:
> +	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event);
> +
> +err_unlock:
> +	mutex_unlock(&tps->lock);
> +
> +	if (event)
> +		return IRQ_HANDLED;
> +	return IRQ_NONE;
> +}
> +
>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> @@ -615,8 +671,19 @@ static int devm_tps6598_psy_register(struct tps6598x *tps)
>  	return PTR_ERR_OR_ZERO(tps->psy);
>  }
>  
> +static const struct tipd_hw ti_tps6598x_data = {
> +	.type = HW_TPS6598X,
> +	.irq_handler = tps6598x_interrupt,
> +};
> +
> +static const struct tipd_hw apple_cd321x_data = {
> +	.type = HW_CD321X,
> +	.irq_handler = cd321x_interrupt,
> +};
> +
>  static int tps6598x_probe(struct i2c_client *client)
>  {
> +	const struct tipd_hw *hw;
>  	struct typec_capability typec_cap = { };
>  	struct tps6598x *tps;
>  	struct fwnode_handle *fwnode;
> @@ -629,6 +696,10 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (!tps)
>  		return -ENOMEM;
>  
> +	hw = of_device_get_match_data(&client->dev);
> +	if (!hw)
> +		hw = &ti_tps6598x_data;
> +
>  	mutex_init(&tps->lock);
>  	tps->dev = &client->dev;
>  
> @@ -655,6 +726,16 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	if (hw->type == HW_CD321X) {
> +		/* CD321X chips have all interrupts masked initially */
> +		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
> +					APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
> +					APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
> +					APPLE_CD_REG_INT_PLUG_EVENT);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
>  	if (ret < 0)
>  		return ret;
> @@ -736,7 +817,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	}
>  
>  	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -					tps6598x_interrupt,
> +					hw->irq_handler,
>  					IRQF_SHARED | IRQF_ONESHOT,
>  					dev_name(&client->dev), tps);

Couldn't you just use the compatible property and local variable here?

        irq_handler_t irq_handler = tps6598x_interrupt;
        struct device_node *np = client->dev.of_node;

        if (np && of_device_is_compatible(np, "apple,cd321x")) {
                /* CD321X chips have all interrupts masked initially */
                ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
                                        APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
                                        APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
                                        APPLE_CD_REG_INT_PLUG_EVENT);
                if (ret)
                        return ret;

                irq_handler = cd321x_interrupt;
        }

	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
					irq_handler,
					IRQF_SHARED | IRQF_ONESHOT,
					dev_name(&client->dev), tps);

I did not go over the whole series yet, so I may have missed
something.

thanks,

-- 
heikki
