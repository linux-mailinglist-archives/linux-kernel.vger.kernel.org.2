Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF453281F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbhCAPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:13:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:22354 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236969AbhCAPMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:12:12 -0500
IronPort-SDR: J9/03NAfZeVd3nUOTZShc+4xdIQZI9BX6Rah9IvTV/225qeiCrTxbsOySCl/4djjAkrRRu5GC6
 WwJ4HNMXlUtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186545846"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="186545846"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 07:10:25 -0800
IronPort-SDR: e5Pjd/26xA4xjiX5IB+kqG+KM+z9FM2kEdswq6AfXsIkbNBqZahaLrmYaAR/ipE1IR/DVDcP+G
 IfC25iVJ4Lfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="505098570"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Mar 2021 07:10:22 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Mar 2021 17:10:21 +0200
Date:   Mon, 1 Mar 2021 17:10:21 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/4] usb: typec: tps6598x: Add trace event for status
 register
Message-ID: <YD0D3QWKKK8gXLwu@kuha.fi.intel.com>
References: <cover.1613389531.git.agx@sigxcpu.org>
 <d24742be3c98382cbef17047f3eecf0f7d807f31.1613389531.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d24742be3c98382cbef17047f3eecf0f7d807f31.1613389531.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 12:46:43PM +0100, Guido Günther wrote:
> This allows to trace status information which helps to debug problems
> with role switching, etc.
> 
> We don't use the generic FIELD_GET() to reduce the macro size since we
> otherwise trip up sparse.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tps6598x.c       | 26 ++++-----
>  drivers/usb/typec/tps6598x.h       | 68 +++++++++++++++++++++
>  drivers/usb/typec/tps6598x_trace.h | 94 ++++++++++++++++++++++++++++++
>  3 files changed, 173 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index bc34b35e909f..559aa175f948 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -37,13 +37,6 @@
>  #define TPS_REG_POWER_STATUS		0x3f
>  #define TPS_REG_RX_IDENTITY_SOP		0x48
>  
> -/* TPS_REG_STATUS bits */
> -#define TPS_STATUS_PLUG_PRESENT		BIT(0)
> -#define TPS_STATUS_ORIENTATION		BIT(4)
> -#define TPS_STATUS_PORTROLE(s)		(!!((s) & BIT(5)))
> -#define TPS_STATUS_DATAROLE(s)		(!!((s) & BIT(6)))
> -#define TPS_STATUS_VCONN(s)		(!!((s) & BIT(7)))
> -
>  /* TPS_REG_SYSTEM_CONF bits */
>  #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
>  
> @@ -258,9 +251,9 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  	}
>  
>  	typec_set_pwr_opmode(tps->port, mode);
> -	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
> -	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
> -	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), true);
> +	typec_set_pwr_role(tps->port, TPS_STATUS_TO_TYPEC_PORTROLE(status));
> +	typec_set_vconn_role(tps->port, TPS_STATUS_TO_TYPEC_VCONN(status));
> +	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), true);
>  
>  	tps->partner = typec_register_partner(tps->port, &desc);
>  	if (IS_ERR(tps->partner))
> @@ -280,9 +273,10 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>  		typec_unregister_partner(tps->partner);
>  	tps->partner = NULL;
>  	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
> -	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
> -	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
> -	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), false);
> +	typec_set_pwr_role(tps->port, TPS_STATUS_TO_TYPEC_PORTROLE(status));
> +	typec_set_vconn_role(tps->port, TPS_STATUS_TO_TYPEC_VCONN(status));
> +	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), false);
> +
>  	power_supply_changed(tps->psy);
>  }
>  
> @@ -366,7 +360,7 @@ static int tps6598x_dr_set(struct typec_port *port, enum typec_data_role role)
>  	if (ret)
>  		goto out_unlock;
>  
> -	if (role != TPS_STATUS_DATAROLE(status)) {
> +	if (role != TPS_STATUS_TO_TYPEC_DATAROLE(status)) {
>  		ret = -EPROTO;
>  		goto out_unlock;
>  	}
> @@ -396,7 +390,7 @@ static int tps6598x_pr_set(struct typec_port *port, enum typec_role role)
>  	if (ret)
>  		goto out_unlock;
>  
> -	if (role != TPS_STATUS_PORTROLE(status)) {
> +	if (role != TPS_STATUS_TO_TYPEC_PORTROLE(status)) {
>  		ret = -EPROTO;
>  		goto out_unlock;
>  	}
> @@ -437,6 +431,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  		dev_err(tps->dev, "%s: failed to read status\n", __func__);
>  		goto err_clear_ints;
>  	}
> +	trace_tps6598x_status(status);
>  
>  	/* Handle plug insert or removal */
>  	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT) {
> @@ -612,6 +607,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
>  	if (ret < 0)
>  		return ret;
> +	trace_tps6598x_status(status);
>  
>  	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
>  	if (ret < 0)
> diff --git a/drivers/usb/typec/tps6598x.h b/drivers/usb/typec/tps6598x.h
> index b83b8a6a1504..621fb336c15d 100644
> --- a/drivers/usb/typec/tps6598x.h
> +++ b/drivers/usb/typec/tps6598x.h
> @@ -12,6 +12,74 @@
>  #ifndef __TPS6598X_H__
>  #define __TPS6598X_H__
>  
> +#define TPS_FIELD_GET(_mask, _reg) ((typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)))
> +
> +/* TPS_REG_STATUS bits */
> +#define TPS_STATUS_PLUG_PRESENT		BIT(0)
> +#define TPS_STATUS_PLUG_UPSIDE_DOWN	BIT(4)
> +#define TPS_STATUS_PORTROLE		BIT(5)
> +#define TPS_STATUS_TO_TYPEC_PORTROLE(s) (!!((s) & TPS_STATUS_PORTROLE))
> +#define TPS_STATUS_DATAROLE		BIT(6)
> +#define TPS_STATUS_TO_TYPEC_DATAROLE(s)	(!!((s) & TPS_STATUS_DATAROLE))
> +#define TPS_STATUS_VCONN		BIT(7)
> +#define TPS_STATUS_TO_TYPEC_VCONN(s)	(!!((s) & TPS_STATUS_VCONN))
> +#define TPS_STATUS_OVERCURRENT		BIT(16)
> +#define TPS_STATUS_GOTO_MIN_ACTIVE	BIT(26)
> +#define TPS_STATUS_BIST			BIT(27)
> +#define TPS_STATUS_HIGH_VOLAGE_WARNING	BIT(28)
> +#define TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING BIT(29)
> +
> +#define TPS_STATUS_CONN_STATE_MASK		GENMASK(3, 1)
> +#define TPS_STATUS_CONN_STATE(x)		TPS_FIELD_GET(TPS_STATUS_CONN_STATE_MASK, (x))
> +#define TPS_STATUS_PP_5V0_SWITCH_MASK		GENMASK(9, 8)
> +#define TPS_STATUS_PP_5V0_SWITCH(x)		TPS_FIELD_GET(TPS_STATUS_PP_5V0_SWITCH_MASK, (x))
> +#define TPS_STATUS_PP_HV_SWITCH_MASK		GENMASK(11, 10)
> +#define TPS_STATUS_PP_HV_SWITCH(x)		TPS_FIELD_GET(TPS_STATUS_PP_HV_SWITCH_MASK, (x))
> +#define TPS_STATUS_PP_EXT_SWITCH_MASK		GENMASK(13, 12)
> +#define TPS_STATUS_PP_EXT_SWITCH(x)		TPS_FIELD_GET(TPS_STATUS_PP_EXT_SWITCH_MASK, (x))
> +#define TPS_STATUS_PP_CABLE_SWITCH_MASK		GENMASK(15, 14)
> +#define TPS_STATUS_PP_CABLE_SWITCH(x)		TPS_FIELD_GET(TPS_STATUS_PP_CABLE_SWITCH_MASK, (x))
> +#define TPS_STATUS_POWER_SOURCE_MASK		GENMASK(19, 18)
> +#define TPS_STATUS_POWER_SOURCE(x)		TPS_FIELD_GET(TPS_STATUS_POWER_SOURCE_MASK, (x))
> +#define TPS_STATUS_VBUS_STATUS_MASK		GENMASK(21, 20)
> +#define TPS_STATUS_VBUS_STATUS(x)		TPS_FIELD_GET(TPS_STATUS_VBUS_STATUS_MASK, (x))
> +#define TPS_STATUS_USB_HOST_PRESENT_MASK	GENMASK(23, 22)
> +#define TPS_STATUS_USB_HOST_PRESENT(x)		TPS_FIELD_GET(TPS_STATUS_USB_HOST_PRESENT_MASK, (x))
> +#define TPS_STATUS_LEGACY_MASK			GENMASK(25, 24)
> +#define TPS_STATUS_LEGACY(x)			TPS_FIELD_GET(TPS_STATUS_LEGACY_MASK, (x))
> +
> +#define TPS_STATUS_CONN_STATE_NO_CONN		0
> +#define TPS_STATUS_CONN_STATE_DISABLED		1
> +#define TPS_STATUS_CONN_STATE_AUDIO_CONN	2
> +#define TPS_STATUS_CONN_STATE_DEBUG_CONN	3
> +#define TPS_STATUS_CONN_STATE_NO_CONN_R_A	4
> +#define TPS_STATUS_CONN_STATE_RESERVED		5
> +#define TPS_STATUS_CONN_STATE_CONN_NO_R_A	6
> +#define TPS_STATUS_CONN_STATE_CONN_WITH_R_A	7
> +
> +#define TPS_STATUS_PP_SWITCH_STATE_DISABLED	0
> +#define TPS_STATUS_PP_SWITCH_STATE_FAULT	1
> +#define TPS_STATUS_PP_SWITCH_STATE_OUT		2
> +#define TPS_STATUS_PP_SWITCH_STATE_IN		3
> +
> +#define TPS_STATUS_POWER_SOURCE_UNKNOWN		0
> +#define TPS_STATUS_POWER_SOURCE_VIN_3P3		1
> +#define TPS_STATUS_POWER_SOURCE_DEAD_BAT	2
> +#define TPS_STATUS_POWER_SOURCE_VBUS		3
> +
> +#define TPS_STATUS_VBUS_STATUS_VSAFE0V		0
> +#define TPS_STATUS_VBUS_STATUS_VSAFE5V		1
> +#define TPS_STATUS_VBUS_STATUS_PD		2
> +#define TPS_STATUS_VBUS_STATUS_FAULT		3
> +
> +#define TPS_STATUS_USB_HOST_PRESENT_NO		0
> +#define TPS_STATUS_USB_HOST_PRESENT_PD_NO_USB	1
> +#define TPS_STATUS_USB_HOST_PRESENT_NO_PD	2
> +#define TPS_STATUS_USB_HOST_PRESENT_PD_USB	3
> +
> +#define TPS_STATUS_LEGACY_NO			0
> +#define TPS_STATUS_LEGACY_SINK			1
> +#define TPS_STATUS_LEGACY_SOURCE		2
>  
>  /* TPS_REG_INT_* bits */
>  #define TPS_REG_INT_USER_VID_ALT_MODE_OTHER_VDM		BIT_ULL(27+32)
> diff --git a/drivers/usb/typec/tps6598x_trace.h b/drivers/usb/typec/tps6598x_trace.h
> index 4ec96e3b2c3e..e0677b9c5c53 100644
> --- a/drivers/usb/typec/tps6598x_trace.h
> +++ b/drivers/usb/typec/tps6598x_trace.h
> @@ -67,6 +67,73 @@
>  		{ TPS_REG_INT_USER_VID_ALT_MODE_ATTN_VDM,	"USER_VID_ALT_MODE_ATTN_VDM" }, \
>  		{ TPS_REG_INT_USER_VID_ALT_MODE_OTHER_VDM,	"USER_VID_ALT_MODE_OTHER_VDM" })
>  
> +#define TPS6598X_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
> +						      TPS_STATUS_PP_5V0_SWITCH_MASK | \
> +						      TPS_STATUS_PP_HV_SWITCH_MASK | \
> +						      TPS_STATUS_PP_EXT_SWITCH_MASK | \
> +						      TPS_STATUS_PP_CABLE_SWITCH_MASK | \
> +						      TPS_STATUS_POWER_SOURCE_MASK | \
> +						      TPS_STATUS_VBUS_STATUS_MASK | \
> +						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
> +						      TPS_STATUS_LEGACY_MASK))
> +
> +#define show_status_conn_state(status) \
> +	__print_symbolic(TPS_STATUS_CONN_STATE((status)), \
> +		{ TPS_STATUS_CONN_STATE_CONN_WITH_R_A,	"conn-Ra"  }, \
> +		{ TPS_STATUS_CONN_STATE_CONN_NO_R_A,	"conn-no-Ra" }, \
> +		{ TPS_STATUS_CONN_STATE_NO_CONN_R_A,	"no-conn-Ra" },	\
> +		{ TPS_STATUS_CONN_STATE_DEBUG_CONN,	"debug"	 }, \
> +		{ TPS_STATUS_CONN_STATE_AUDIO_CONN,	"audio"	 }, \
> +		{ TPS_STATUS_CONN_STATE_DISABLED,	"disabled" }, \
> +		{ TPS_STATUS_CONN_STATE_NO_CONN,	"no-conn" })
> +
> +#define show_status_pp_switch_state(status) \
> +	__print_symbolic(status, \
> +		{ TPS_STATUS_PP_SWITCH_STATE_IN,	"in" }, \
> +		{ TPS_STATUS_PP_SWITCH_STATE_OUT,	"out" }, \
> +		{ TPS_STATUS_PP_SWITCH_STATE_FAULT,	"fault" }, \
> +		{ TPS_STATUS_PP_SWITCH_STATE_DISABLED,	"off" })
> +
> +#define show_status_power_sources(status) \
> +	__print_symbolic(TPS_STATUS_POWER_SOURCE(status), \
> +		{ TPS_STATUS_POWER_SOURCE_VBUS,		"vbus" }, \
> +		{ TPS_STATUS_POWER_SOURCE_VIN_3P3,	"vin-3p3" }, \
> +		{ TPS_STATUS_POWER_SOURCE_DEAD_BAT,	"dead-battery" }, \
> +		{ TPS_STATUS_POWER_SOURCE_UNKNOWN,	"unknown" })
> +
> +#define show_status_vbus_status(status) \
> +	__print_symbolic(TPS_STATUS_VBUS_STATUS(status), \
> +		{ TPS_STATUS_VBUS_STATUS_VSAFE0V,	"vSafe0V" }, \
> +		{ TPS_STATUS_VBUS_STATUS_VSAFE5V,	"vSafe5V" }, \
> +		{ TPS_STATUS_VBUS_STATUS_PD,		"pd" }, \
> +		{ TPS_STATUS_VBUS_STATUS_FAULT,		"fault" })
> +
> +#define show_status_usb_host_present(status) \
> +	__print_symbolic(TPS_STATUS_USB_HOST_PRESENT(status), \
> +		{ TPS_STATUS_USB_HOST_PRESENT_PD_USB,	 "pd-usb" }, \
> +		{ TPS_STATUS_USB_HOST_PRESENT_NO_PD,	 "no-pd" }, \
> +		{ TPS_STATUS_USB_HOST_PRESENT_PD_NO_USB, "pd-no-usb" }, \
> +		{ TPS_STATUS_USB_HOST_PRESENT_NO,	 "no" })
> +
> +#define show_status_legacy(status) \
> +	__print_symbolic(TPS_STATUS_LEGACY(status),	     \
> +		{ TPS_STATUS_LEGACY_SOURCE,		 "source" }, \
> +		{ TPS_STATUS_LEGACY_SINK,		 "sink" }, \
> +		{ TPS_STATUS_LEGACY_NO,			 "no" })
> +
> +#define show_status_flags(flags) \
> +	__print_flags((flags & TPS6598X_STATUS_FLAGS_MASK), "|", \
> +		      { TPS_STATUS_PLUG_PRESENT,	"PLUG_PRESENT" }, \
> +		      { TPS_STATUS_PLUG_UPSIDE_DOWN,	"UPSIDE_DOWN" }, \
> +		      { TPS_STATUS_PORTROLE,		"PORTROLE" }, \
> +		      { TPS_STATUS_DATAROLE,		"DATAROLE" }, \
> +		      { TPS_STATUS_VCONN,		"VCONN" }, \
> +		      { TPS_STATUS_OVERCURRENT,		"OVERCURRENT" }, \
> +		      { TPS_STATUS_GOTO_MIN_ACTIVE,	"GOTO_MIN_ACTIVE" }, \
> +		      { TPS_STATUS_BIST,		"BIST" }, \
> +		      { TPS_STATUS_HIGH_VOLAGE_WARNING,	"HIGH_VOLAGE_WARNING" }, \
> +		      { TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING, "HIGH_LOW_VOLTAGE_WARNING" })
> +
>  TRACE_EVENT(tps6598x_irq,
>  	    TP_PROTO(u64 event1,
>  		     u64 event2),
> @@ -87,6 +154,33 @@ TRACE_EVENT(tps6598x_irq,
>  		      show_irq_flags(__entry->event2))
>  );
>  
> +TRACE_EVENT(tps6598x_status,
> +	    TP_PROTO(u32 status),
> +	    TP_ARGS(status),
> +
> +	    TP_STRUCT__entry(
> +			     __field(u32, status)
> +			     ),
> +
> +	    TP_fast_assign(
> +			   __entry->status = status;
> +			   ),
> +
> +	    TP_printk("conn: %s, pp_5v0: %s, pp_hv: %s, pp_ext: %s, pp_cable: %s, "
> +		      "pwr-src: %s, vbus: %s, usb-host: %s, legacy: %s, flags: %s",
> +		      show_status_conn_state(__entry->status),
> +		      show_status_pp_switch_state(TPS_STATUS_PP_5V0_SWITCH(__entry->status)),
> +		      show_status_pp_switch_state(TPS_STATUS_PP_HV_SWITCH(__entry->status)),
> +		      show_status_pp_switch_state(TPS_STATUS_PP_EXT_SWITCH(__entry->status)),
> +		      show_status_pp_switch_state(TPS_STATUS_PP_CABLE_SWITCH(__entry->status)),
> +		      show_status_power_sources(__entry->status),
> +		      show_status_vbus_status(__entry->status),
> +		      show_status_usb_host_present(__entry->status),
> +		      show_status_legacy(__entry->status),
> +		      show_status_flags(__entry->status)
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
