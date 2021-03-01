Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A082E328208
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhCAPPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:15:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:11688 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237005AbhCAPNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:13:37 -0500
IronPort-SDR: 9CXvj1kHUne/OWow7i7QlHtuNzprtVoZ+7XilGgDdlfDOWGeE2yHcGdqHcBjouQaHCgoRn/e/1
 ivd9kVYAhAcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="271492211"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="271492211"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 07:11:39 -0800
IronPort-SDR: eHYGJX2N6GrV7cRrPR6fkNqmkAdfugoBl4f96ePcvGHf8Wob5wR2v+pMTn2E9cqmsd7fxxkkC2
 obSOiKqqFcPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="505098954"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Mar 2021 07:11:36 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Mar 2021 17:11:35 +0200
Date:   Mon, 1 Mar 2021 17:11:35 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 3/4] usb: typec: tps6598x: Add trace event for power
 status register
Message-ID: <YD0EJ7GI4xdtCO4q@kuha.fi.intel.com>
References: <cover.1613389531.git.agx@sigxcpu.org>
 <3c92da489fa03d6fe67ac18443c48dccb1bf048a.1613389531.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c92da489fa03d6fe67ac18443c48dccb1bf048a.1613389531.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 12:46:44PM +0100, Guido Günther wrote:
> Together with the PD status register this is vital for debugging power
> negotiations at runtime.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tps6598x.c       | 19 +++++++++------
>  drivers/usb/typec/tps6598x.h       | 19 +++++++++++++++
>  drivers/usb/typec/tps6598x_trace.h | 38 ++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index 559aa175f948..3e6ad3ba7fc8 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -50,11 +50,6 @@ enum {
>  	TPS_PORTINFO_SOURCE,
>  };
>  
> -/* TPS_REG_POWER_STATUS bits */
> -#define TPS_POWER_STATUS_CONNECTION	BIT(0)
> -#define TPS_POWER_STATUS_SOURCESINK	BIT(1)
> -#define TPS_POWER_STATUS_PWROPMODE(p)	(((p) & GENMASK(3, 2)) >> 2)
> -
>  /* TPS_REG_RX_IDENTITY_SOP */
>  struct tps6598x_rx_identity_reg {
>  	u8 status;
> @@ -414,6 +409,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  	u64 event1;
>  	u64 event2;
>  	u32 status;
> +	u16 pwr_status;
>  	int ret;
>  
>  	mutex_lock(&tps->lock);
> @@ -433,6 +429,15 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  	}
>  	trace_tps6598x_status(status);
>  
> +	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE) {
> +		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
> +		if (ret < 0) {
> +			dev_err(tps->dev, "failed to read power status: %d\n", ret);
> +			goto err_clear_ints;
> +		}
> +		trace_tps6598x_power_status(pwr_status);
> +	}
> +
>  	/* Handle plug insert or removal */
>  	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT) {
>  		if (status & TPS_STATUS_PLUG_PRESENT) {
> @@ -497,8 +502,8 @@ static int tps6598x_psy_get_online(struct tps6598x *tps,
>  	if (ret < 0)
>  		return ret;
>  
> -	if ((pwr_status & TPS_POWER_STATUS_CONNECTION) &&
> -	    (pwr_status & TPS_POWER_STATUS_SOURCESINK)) {
> +	if (TPS_POWER_STATUS_CONNECTION(pwr_status) &&
> +	    TPS_POWER_STATUS_SOURCESINK(pwr_status)) {
>  		val->intval = 1;
>  	} else {
>  		val->intval = 0;
> diff --git a/drivers/usb/typec/tps6598x.h b/drivers/usb/typec/tps6598x.h
> index 621fb336c15d..9a34c020f3e5 100644
> --- a/drivers/usb/typec/tps6598x.h
> +++ b/drivers/usb/typec/tps6598x.h
> @@ -129,4 +129,23 @@
>  #define TPS_REG_INT_HARD_RESET				BIT(1)
>  #define TPS_REG_INT_PD_SOFT_RESET			BIT(0)
>  
> +/* TPS_REG_POWER_STATUS bits */
> +#define TPS_POWER_STATUS_CONNECTION(x)  TPS_FIELD_GET(BIT(0), (x))
> +#define TPS_POWER_STATUS_SOURCESINK(x)	TPS_FIELD_GET(BIT(1), (x))
> +#define TPS_POWER_STATUS_BC12_DET(x)	TPS_FIELD_GET(BIT(2), (x))
> +
> +#define TPS_POWER_STATUS_TYPEC_CURRENT_MASK GENMASK(3, 2)
> +#define TPS_POWER_STATUS_PWROPMODE(p)	    TPS_FIELD_GET(TPS_POWER_STATUS_TYPEC_CURRENT_MASK, (p))
> +#define TPS_POWER_STATUS_BC12_STATUS_MASK   GENMASK(6, 5)
> +#define TPS_POWER_STATUS_BC12_STATUS(p)	    TPS_FIELD_GET(TPS_POWER_STATUS_BC12_STATUS_MASK, (p))
> +
> +#define TPS_POWER_STATUS_TYPEC_CURRENT_USB     0
> +#define TPS_POWER_STATUS_TYPEC_CURRENT_1A5     1
> +#define TPS_POWER_STATUS_TYPEC_CURRENT_3A0     2
> +#define TPS_POWER_STATUS_TYPEC_CURRENT_PD      3
> +
> +#define TPS_POWER_STATUS_BC12_STATUS_SDP 0
> +#define TPS_POWER_STATUS_BC12_STATUS_CDP 2
> +#define TPS_POWER_STATUS_BC12_STATUS_DCP 3
> +
>  #endif /* __TPS6598X_H__ */
> diff --git a/drivers/usb/typec/tps6598x_trace.h b/drivers/usb/typec/tps6598x_trace.h
> index e0677b9c5c53..78a5a6ca337b 100644
> --- a/drivers/usb/typec/tps6598x_trace.h
> +++ b/drivers/usb/typec/tps6598x_trace.h
> @@ -134,6 +134,24 @@
>  		      { TPS_STATUS_HIGH_VOLAGE_WARNING,	"HIGH_VOLAGE_WARNING" }, \
>  		      { TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING, "HIGH_LOW_VOLTAGE_WARNING" })
>  
> +#define show_power_status_source_sink(power_status) \
> +	__print_symbolic(TPS_POWER_STATUS_SOURCESINK(power_status), \
> +		{ 1, "sink" }, \
> +		{ 0, "source" })
> +
> +#define show_power_status_typec_status(power_status) \
> +	__print_symbolic(TPS_POWER_STATUS_PWROPMODE(power_status), \
> +		{ TPS_POWER_STATUS_TYPEC_CURRENT_PD,  "pd" }, \
> +		{ TPS_POWER_STATUS_TYPEC_CURRENT_3A0, "3.0A" }, \
> +		{ TPS_POWER_STATUS_TYPEC_CURRENT_1A5, "1.5A" }, \
> +		{ TPS_POWER_STATUS_TYPEC_CURRENT_USB, "usb" })
> +
> +#define show_power_status_bc12_status(power_status) \
> +	__print_symbolic(TPS_POWER_STATUS_BC12_STATUS(power_status), \
> +		{ TPS_POWER_STATUS_BC12_STATUS_DCP, "dcp" }, \
> +		{ TPS_POWER_STATUS_BC12_STATUS_CDP, "cdp" }, \
> +		{ TPS_POWER_STATUS_BC12_STATUS_SDP, "sdp" })
> +
>  TRACE_EVENT(tps6598x_irq,
>  	    TP_PROTO(u64 event1,
>  		     u64 event2),
> @@ -181,6 +199,26 @@ TRACE_EVENT(tps6598x_status,
>  		    )
>  );
>  
> +TRACE_EVENT(tps6598x_power_status,
> +	    TP_PROTO(u16 power_status),
> +	    TP_ARGS(power_status),
> +
> +	    TP_STRUCT__entry(
> +			     __field(u16, power_status)
> +			     ),
> +
> +	    TP_fast_assign(
> +			   __entry->power_status = power_status;
> +			   ),
> +
> +	    TP_printk("conn: %d, pwr-role: %s, typec: %s, bc: %s",
> +		      !!TPS_POWER_STATUS_CONNECTION(__entry->power_status),
> +		      show_power_status_source_sink(__entry->power_status),
> +		      show_power_status_typec_status(__entry->power_status),
> +		      show_power_status_bc12_status(__entry->power_status)
> +		    )
> +);
> +
>  #endif /* _TPS6598X_TRACE_H_ */
>  
>  /* This part must be outside protection */
> -- 
> 2.30.0

thanks,

-- 
heikki
