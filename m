Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D95F41D74A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349796AbhI3KLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:11:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:21485 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349785AbhI3KLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:11:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="225228654"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="225228654"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 03:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="618057269"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Sep 2021 03:09:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 30 Sep 2021 13:09:50 +0300
Date:   Thu, 30 Sep 2021 13:09:50 +0300
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
Subject: Re: [PATCH v3 4/6] usb: typec: tipd: Add support for Apple CD321X
Message-ID: <YVWM7tQMZeeF+Wc3@kuha.fi.intel.com>
References: <20210928155502.71372-1-sven@svenpeter.dev>
 <20210928155502.71372-5-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928155502.71372-5-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 05:55:00PM +0200, Sven Peter wrote:
> Apple CD321x chips are a variant of the TI TPS 6598x chips.
> The major differences are the changed interrupt numbers and
> the concurrent connection to the SMC which we must not disturb.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> changes since v2:
>   - switched from of_device_get_match_data to of_device_is_compatible
>     as suggested by Heikki
>   - replace "int ret = 0" with "int ret" in cd321x_interrupt since ret
>     doesn't need to be initialized
> 
> changes since v1:
>   - new commit since Heikki suggested to just add a separate irq handler
> 
>  drivers/usb/typec/tipd/core.c     | 63 ++++++++++++++++++++++++++++++-
>  drivers/usb/typec/tipd/tps6598x.h |  6 +++
>  drivers/usb/typec/tipd/trace.h    | 23 +++++++++++
>  3 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index e785e4aa2d4b..cc4a154eabcb 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -9,6 +9,7 @@
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/power_supply.h>
>  #include <linux/regmap.h>
>  #include <linux/interrupt.h>
> @@ -461,6 +462,51 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
>  	}
>  }
>  
> +static irqreturn_t cd321x_interrupt(int irq, void *data)
> +{
> +	struct tps6598x *tps = data;
> +	u64 event;
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
> @@ -620,6 +666,8 @@ static int devm_tps6598_psy_register(struct tps6598x *tps)
>  
>  static int tps6598x_probe(struct i2c_client *client)
>  {
> +	irq_handler_t irq_handler = tps6598x_interrupt;
> +	struct device_node *np = client->dev.of_node;
>  	struct typec_capability typec_cap = { };
>  	struct tps6598x *tps;
>  	struct fwnode_handle *fwnode;
> @@ -658,6 +706,18 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	if (np && of_device_is_compatible(np, "apple,cd321x")) {
> +		/* CD321X chips have all interrupts masked initially */
> +		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
> +					APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
> +					APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
> +					APPLE_CD_REG_INT_PLUG_EVENT);
> +		if (ret)
> +			return ret;
> +
> +		irq_handler = cd321x_interrupt;
> +	}
> +
>  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
>  	if (ret < 0)
>  		return ret;
> @@ -739,7 +799,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	}
>  
>  	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -					tps6598x_interrupt,
> +					irq_handler,
>  					IRQF_SHARED | IRQF_ONESHOT,
>  					dev_name(&client->dev), tps);
>  	if (ret) {
> @@ -773,6 +833,7 @@ static int tps6598x_remove(struct i2c_client *client)
>  
>  static const struct of_device_id tps6598x_of_match[] = {
>  	{ .compatible = "ti,tps6598x", },
> +	{ .compatible = "apple,cd321x", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, tps6598x_of_match);
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index 003a577be216..e13b16419843 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -129,6 +129,12 @@
>  #define TPS_REG_INT_HARD_RESET				BIT(1)
>  #define TPS_REG_INT_PD_SOFT_RESET			BIT(0)
>  
> +/* Apple-specific TPS_REG_INT_* bits */
> +#define APPLE_CD_REG_INT_DATA_STATUS_UPDATE		BIT(10)
> +#define APPLE_CD_REG_INT_POWER_STATUS_UPDATE		BIT(9)
> +#define APPLE_CD_REG_INT_STATUS_UPDATE			BIT(8)
> +#define APPLE_CD_REG_INT_PLUG_EVENT			BIT(1)
> +
>  /* TPS_REG_POWER_STATUS bits */
>  #define TPS_POWER_STATUS_CONNECTION(x)  TPS_FIELD_GET(BIT(0), (x))
>  #define TPS_POWER_STATUS_SOURCESINK(x)	TPS_FIELD_GET(BIT(1), (x))
> diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
> index 5d09d6f78930..12cad1bde7cc 100644
> --- a/drivers/usb/typec/tipd/trace.h
> +++ b/drivers/usb/typec/tipd/trace.h
> @@ -67,6 +67,13 @@
>  		{ TPS_REG_INT_USER_VID_ALT_MODE_ATTN_VDM,	"USER_VID_ALT_MODE_ATTN_VDM" }, \
>  		{ TPS_REG_INT_USER_VID_ALT_MODE_OTHER_VDM,	"USER_VID_ALT_MODE_OTHER_VDM" })
>  
> +#define show_cd321x_irq_flags(flags) \
> +	__print_flags_u64(flags, "|", \
> +		{ APPLE_CD_REG_INT_PLUG_EVENT,			"PLUG_EVENT" }, \
> +		{ APPLE_CD_REG_INT_POWER_STATUS_UPDATE,		"POWER_STATUS_UPDATE" }, \
> +		{ APPLE_CD_REG_INT_DATA_STATUS_UPDATE,		"DATA_STATUS_UPDATE" }, \
> +		{ APPLE_CD_REG_INT_STATUS_UPDATE,		"STATUS_UPDATE" })
> +
>  #define TPS6598X_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
>  						      TPS_STATUS_PP_5V0_SWITCH_MASK | \
>  						      TPS_STATUS_PP_HV_SWITCH_MASK | \
> @@ -207,6 +214,22 @@ TRACE_EVENT(tps6598x_irq,
>  		      show_irq_flags(__entry->event2))
>  );
>  
> +TRACE_EVENT(cd321x_irq,
> +	    TP_PROTO(u64 event),
> +	    TP_ARGS(event),
> +
> +	    TP_STRUCT__entry(
> +			     __field(u64, event)
> +			     ),
> +
> +	    TP_fast_assign(
> +			   __entry->event = event;
> +			   ),
> +
> +	    TP_printk("event=%s",
> +		      show_cd321x_irq_flags(__entry->event))
> +);
> +
>  TRACE_EVENT(tps6598x_status,
>  	    TP_PROTO(u32 status),
>  	    TP_ARGS(status),
> -- 
> 2.25.1

-- 
heikki
