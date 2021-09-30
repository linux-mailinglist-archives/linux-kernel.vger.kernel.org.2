Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EC241D740
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbhI3KKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:10:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:48013 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238316AbhI3KKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:10:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212230851"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="212230851"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 03:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="618056924"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Sep 2021 03:08:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 30 Sep 2021 13:08:58 +0300
Date:   Thu, 30 Sep 2021 13:08:58 +0300
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
Subject: Re: [PATCH v3 2/6] usb: typec: tipd: Split interrupt handler
Message-ID: <YVWMuleXQqJMvZ1f@kuha.fi.intel.com>
References: <20210928155502.71372-1-sven@svenpeter.dev>
 <20210928155502.71372-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928155502.71372-3-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 05:54:58PM +0200, Sven Peter wrote:
> Split the handlers for the individual interrupts into their own functions
> to prepare for adding a second interrupt handler for the Apple CD321x
> chips
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> no changes since v2
> 
> changes since v1:
>   - new commit since Heikki suggested to add a separate irq handler
>     for the cd321x variant
> 
>  drivers/usb/typec/tipd/core.c | 96 ++++++++++++++++++++++++-----------
>  1 file changed, 65 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 93e56291f0cf..172715c6c238 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -404,13 +404,69 @@ static const struct typec_operations tps6598x_ops = {
>  	.pr_set = tps6598x_pr_set,
>  };
>  
> +static bool tps6598x_read_status(struct tps6598x *tps, u32 *status)
> +{
> +	int ret;
> +
> +	ret = tps6598x_read32(tps, TPS_REG_STATUS, status);
> +	if (ret) {
> +		dev_err(tps->dev, "%s: failed to read status\n", __func__);
> +		return false;
> +	}
> +	trace_tps6598x_status(*status);
> +
> +	return true;
> +}
> +
> +static bool tps6598x_read_data_status(struct tps6598x *tps)
> +{
> +	u32 data_status;
> +	int ret;
> +
> +	ret = tps6598x_read32(tps, TPS_REG_DATA_STATUS, &data_status);
> +	if (ret < 0) {
> +		dev_err(tps->dev, "failed to read data status: %d\n", ret);
> +		return false;
> +	}
> +	trace_tps6598x_data_status(data_status);
> +
> +	return true;
> +}
> +
> +static bool tps6598x_read_power_status(struct tps6598x *tps)
> +{
> +	u16 pwr_status;
> +	int ret;
> +
> +	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
> +	if (ret < 0) {
> +		dev_err(tps->dev, "failed to read power status: %d\n", ret);
> +		return false;
> +	}
> +	trace_tps6598x_power_status(pwr_status);
> +
> +	return true;
> +}
> +
> +static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
> +{
> +	int ret;
> +
> +	if (status & TPS_STATUS_PLUG_PRESENT) {
> +		ret = tps6598x_connect(tps, status);
> +		if (ret)
> +			dev_err(tps->dev, "failed to register partner\n");
> +	} else {
> +		tps6598x_disconnect(tps, status);
> +	}
> +}
> +
>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
>  	u64 event1;
>  	u64 event2;
> -	u32 status, data_status;
> -	u16 pwr_status;
> +	u32 status;
>  	int ret;
>  
>  	mutex_lock(&tps->lock);
> @@ -423,42 +479,20 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  	}
>  	trace_tps6598x_irq(event1, event2);
>  
> -	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
> -	if (ret) {
> -		dev_err(tps->dev, "%s: failed to read status\n", __func__);
> +	if (!tps6598x_read_status(tps, &status))
>  		goto err_clear_ints;
> -	}
> -	trace_tps6598x_status(status);
>  
> -	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE) {
> -		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
> -		if (ret < 0) {
> -			dev_err(tps->dev, "failed to read power status: %d\n", ret);
> +	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
> +		if (!tps6598x_read_power_status(tps))
>  			goto err_clear_ints;
> -		}
> -		trace_tps6598x_power_status(pwr_status);
> -	}
>  
> -	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE) {
> -		ret = tps6598x_read32(tps, TPS_REG_DATA_STATUS, &data_status);
> -		if (ret < 0) {
> -			dev_err(tps->dev, "failed to read data status: %d\n", ret);
> +	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
> +		if (!tps6598x_read_data_status(tps))
>  			goto err_clear_ints;
> -		}
> -		trace_tps6598x_data_status(data_status);
> -	}
>  
>  	/* Handle plug insert or removal */
> -	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT) {
> -		if (status & TPS_STATUS_PLUG_PRESENT) {
> -			ret = tps6598x_connect(tps, status);
> -			if (ret)
> -				dev_err(tps->dev,
> -					"failed to register partner\n");
> -		} else {
> -			tps6598x_disconnect(tps, status);
> -		}
> -	}
> +	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
> +		tps6598x_handle_plug_event(tps, status);
>  
>  err_clear_ints:
>  	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
> -- 
> 2.25.1

thanks,

-- 
heikki
