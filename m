Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8101410B67
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 14:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhISMDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 08:03:32 -0400
Received: from rosenzweig.io ([138.197.143.207]:46536 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231993AbhISMD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:03:28 -0400
Date:   Sun, 19 Sep 2021 07:33:46 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>
Subject: Re: [RFT PATCH 8/9] usb: typec: tipd: Switch power state to S0 for
 Apple variant
Message-ID: <YUcgGtoA2P3PV8C0@sunset>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-9-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918120934.28252-9-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

On Sat , Sep 18, 2021 at 02:09:33PM +0200, Sven Peter wrote:
> The Apple CD321x comes up in a low-power state after boot. Usually, the
> bootloader will already power it up to S0 but let's do it here as well
> in case that didn't happen.
> 
> Suggested-by: Stan Skowronek <stan@corellium.com>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/usb/typec/tipd/core.c     | 44 +++++++++++++++++++++++++++++++
>  drivers/usb/typec/tipd/tps6598x.h |  6 +++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index e96b17fe6af6..26807c050662 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -30,6 +30,7 @@
>  #define TPS_REG_INT_MASK2		0x17
>  #define TPS_REG_INT_CLEAR1		0x18
>  #define TPS_REG_INT_CLEAR2		0x19
> +#define TPS_REG_SYSTEM_POWER_STATE	0x20
>  #define TPS_REG_STATUS			0x1a
>  #define TPS_REG_SYSTEM_CONF		0x28
>  #define TPS_REG_CTRL_CONF		0x29
> @@ -84,6 +85,8 @@ struct tps6598x_hw {
>  	unsigned int irq_data_status_update;
>  	unsigned int irq_plug_event;
>  	void (*irq_trace)(u64 event1, u64 event2);
> +
> +	bool supports_spss;
>  };
>  static const struct tps6598x_hw ti_tps6598x_data;
>  
> @@ -161,6 +164,11 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
>  	return regmap_raw_write(tps->regmap, reg, data, sizeof(data));
>  }
>  
> +static inline int tps6598x_read8(struct tps6598x *tps, u8 reg, u8 *val)
> +{
> +	return tps6598x_block_read(tps, reg, val, sizeof(u8));
> +}
> +
>  static inline int tps6598x_read16(struct tps6598x *tps, u8 reg, u16 *val)
>  {
>  	return tps6598x_block_read(tps, reg, val, sizeof(u16));
> @@ -572,6 +580,35 @@ static int tps6598x_psy_get_prop(struct power_supply *psy,
>  	return ret;
>  }
>  
> +static int cd321x_switch_power_state(struct tps6598x *tps, u8 target_state)
> +{
> +	u8 state;
> +	int ret;
> +
> +	if (!tps->hw->supports_spss)
> +		return 0;
> +
> +	ret = tps6598x_read8(tps, TPS_REG_SYSTEM_POWER_STATE, &state);
> +	if (ret)
> +		return ret;
> +
> +	if (state == target_state)
> +		return 0;
> +
> +	ret = tps6598x_exec_cmd(tps, "SPSS", sizeof(u8), &target_state, 0, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = tps6598x_read8(tps, TPS_REG_SYSTEM_POWER_STATE, &state);
> +	if (ret)
> +		return ret;
> +
> +	if (state != target_state)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int devm_tps6598_psy_register(struct tps6598x *tps)
>  {
>  	struct power_supply_config psy_cfg = {};
> @@ -648,6 +685,11 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	/* Switch Apple chips to the correct system power state */
> +	ret = cd321x_switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
> +	if (ret)
> +		return ret;
> +
>  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
>  	if (ret < 0)
>  		return ret;
> @@ -786,6 +828,7 @@ static const struct tps6598x_hw ti_tps6598x_data = {
>  	.irq_data_status_update = TPS_REG_INT_DATA_STATUS_UPDATE,
>  	.irq_plug_event = TPS_REG_INT_PLUG_EVENT,
>  	.irq_trace = trace_tps6598x_irq,
> +	.supports_spss = false,
>  };
>  
>  static const struct tps6598x_hw apple_cd321x_data = {
> @@ -795,6 +838,7 @@ static const struct tps6598x_hw apple_cd321x_data = {
>  	.irq_data_status_update = APPLE_TPS_REG_INT_DATA_STATUS_UPDATE,
>  	.irq_plug_event = APPLE_TPS_REG_INT_PLUG_EVENT,
>  	.irq_trace = trace_cd321x_irq,
> +	.supports_spss = true,
>  };
>  
>  static const struct of_device_id tps6598x_of_match[] = {
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index 36b482733297..5e6ff51aa657 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -135,6 +135,12 @@
>  #define APPLE_TPS_REG_INT_STATUS_UPDATE			BIT(8)
>  #define APPLE_TPS_REG_INT_PLUG_EVENT			BIT(1)
>  
> +/* TPS_REG_SYSTEM_POWER_STATE states */
> +#define TPS_SYSTEM_POWER_STATE_S0			0x00
> +#define TPS_SYSTEM_POWER_STATE_S3			0x03
> +#define TPS_SYSTEM_POWER_STATE_S4			0x04
> +#define TPS_SYSTEM_POWER_STATE_S5			0x05
> +
>  /* TPS_REG_POWER_STATUS bits */
>  #define TPS_POWER_STATUS_CONNECTION(x)  TPS_FIELD_GET(BIT(0), (x))
>  #define TPS_POWER_STATUS_SOURCESINK(x)	TPS_FIELD_GET(BIT(1), (x))
> -- 
> 2.25.1
> 
