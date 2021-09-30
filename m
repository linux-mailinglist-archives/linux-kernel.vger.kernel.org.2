Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFCE41D761
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349940AbhI3KNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:13:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:48112 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349832AbhI3KMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:12:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212231060"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="212231060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 03:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="618057563"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Sep 2021 03:10:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 30 Sep 2021 13:10:37 +0300
Date:   Thu, 30 Sep 2021 13:10:37 +0300
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
Subject: Re: [PATCH v3 5/6] usb: typec: tipd: Switch CD321X power state to S0
Message-ID: <YVWNHad3Yubhk81h@kuha.fi.intel.com>
References: <20210928155502.71372-1-sven@svenpeter.dev>
 <20210928155502.71372-6-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928155502.71372-6-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 05:55:01PM +0200, Sven Peter wrote:
> The Apple CD321x comes up in a low-power state after boot. Usually, the
> bootloader will already power it up to S0 but let's do it here as well
> in case that didn't happen.
> 
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Suggested-by: Stan Skowronek <stan@corellium.com>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> no changes since v2
> 
> changes since v1:
>   - dropped the supports_spss flag and only call this for the Apple chip
>   - added Alyssa's r-b
> 
>  drivers/usb/typec/tipd/core.c     | 37 +++++++++++++++++++++++++++++++
>  drivers/usb/typec/tipd/tps6598x.h |  6 +++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index cc4a154eabcb..c74fc9ae1686 100644
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
> @@ -152,6 +153,11 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
>  	return regmap_raw_write(tps->regmap, reg, data, len + 1);
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
> @@ -635,6 +641,32 @@ static int tps6598x_psy_get_prop(struct power_supply *psy,
>  	return ret;
>  }
>  
> +static int cd321x_switch_power_state(struct tps6598x *tps, u8 target_state)
> +{
> +	u8 state;
> +	int ret;
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
> @@ -707,6 +739,11 @@ static int tps6598x_probe(struct i2c_client *client)
>  		return ret;
>  
>  	if (np && of_device_is_compatible(np, "apple,cd321x")) {
> +		/* Switch CD321X chips to the correct system power state */
> +		ret = cd321x_switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
> +		if (ret)
> +			return ret;
> +
>  		/* CD321X chips have all interrupts masked initially */
>  		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
>  					APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index e13b16419843..3dae84c524fb 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -135,6 +135,12 @@
>  #define APPLE_CD_REG_INT_STATUS_UPDATE			BIT(8)
>  #define APPLE_CD_REG_INT_PLUG_EVENT			BIT(1)
>  
> +/* TPS_REG_SYSTEM_POWER_STATE states */
> +#define TPS_SYSTEM_POWER_STATE_S0	0x00
> +#define TPS_SYSTEM_POWER_STATE_S3	0x03
> +#define TPS_SYSTEM_POWER_STATE_S4	0x04
> +#define TPS_SYSTEM_POWER_STATE_S5	0x05
> +
>  /* TPS_REG_POWER_STATUS bits */
>  #define TPS_POWER_STATUS_CONNECTION(x)  TPS_FIELD_GET(BIT(0), (x))
>  #define TPS_POWER_STATUS_SOURCESINK(x)	TPS_FIELD_GET(BIT(1), (x))
> -- 
> 2.25.1

-- 
heikki
