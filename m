Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361CB357CE0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhDHG7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:59:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:52426 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhDHG7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:59:18 -0400
IronPort-SDR: 1/b7Y6CI+6SqRUoOTbAV1wVKig6wOyMfnzOPxwx2/qEYTazwgCzZ2dsN1BJOnq/JCJOHrOJlYg
 mpBEhFEsrgvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="190270564"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="190270564"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 23:59:08 -0700
IronPort-SDR: kj9Tb6QhZy1SLWJoET68SwIQYUsaaPxM7j3wGY800bsiYkpacLXgUQDFk+Dn2iGTF8neownuk/
 pGeiw/3uxOYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="519736795"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Apr 2021 23:59:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Apr 2021 09:59:04 +0300
Date:   Thu, 8 Apr 2021 09:59:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2 2/6] usb: typec: tcpm: Address incorrect values of
 tcpm psy for pps supply
Message-ID: <YG6puFHNyeZJ8Aad@kuha.fi.intel.com>
References: <20210407200723.1914388-1-badhri@google.com>
 <20210407200723.1914388-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407200723.1914388-2-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:07:19PM -0700, Badhri Jagan Sridharan wrote:
> tcpm_pd_select_pps_apdo overwrites port->pps_data.min_volt,
> port->pps_data.max_volt, port->pps_data.max_curr even before
> port partner accepts the requests. This leaves incorrect values
> in current_limit and supply_voltage that get exported by
> "tcpm-source-psy-". Solving this problem by caching the request
> values in req_min_volt, req_max_volt, req_max_curr, req_out_volt,
> req_op_curr. min_volt, max_volt, max_curr gets updated once the
> partner accepts the request. current_limit, supply_voltage gets updated
> once local port's tcpm enters SNK_TRANSITION_SINK when the accepted
> current_limit and supply_voltage is enforced.
> 
> Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through power_supply")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since V1:
> * Moved to kerneldoc header as suggested by Greg KH.
> * Added reviewed by tags.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 88 +++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 4ea4b30ae885..b4a40099d7e9 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -268,12 +268,27 @@ struct pd_mode_data {
>  	struct typec_altmode_desc altmode_desc[ALTMODE_DISCOVERY_MAX];
>  };
>  
> +/*
> + * @min_volt: Actual min voltage at the local port
> + * @req_min_volt: Requested min voltage to the port partner
> + * @max_volt: Actual max voltage at the local port
> + * @req_max_volt: Requested max voltage to the port partner
> + * @max_curr: Actual max current at the local port
> + * @req_max_curr: Requested max current of the port partner
> + * @req_out_volt: Requested output voltage to the port partner
> + * @req_op_curr: Requested operating current to the port partner
> + * @supported: Parter has atleast one APDO hence supports PPS
> + * @active: PPS mode is active
> + */
>  struct pd_pps_data {
>  	u32 min_volt;
> +	u32 req_min_volt;
>  	u32 max_volt;
> +	u32 req_max_volt;
>  	u32 max_curr;
> -	u32 out_volt;
> -	u32 op_curr;
> +	u32 req_max_curr;
> +	u32 req_out_volt;
> +	u32 req_op_curr;
>  	bool supported;
>  	bool active;
>  };
> @@ -2498,8 +2513,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			break;
>  		case SNK_NEGOTIATE_PPS_CAPABILITIES:
>  			/* Revert data back from any requested PPS updates */
> -			port->pps_data.out_volt = port->supply_voltage;
> -			port->pps_data.op_curr = port->current_limit;
> +			port->pps_data.req_out_volt = port->supply_voltage;
> +			port->pps_data.req_op_curr = port->current_limit;
>  			port->pps_status = (type == PD_CTRL_WAIT ?
>  					    -EAGAIN : -EOPNOTSUPP);
>  
> @@ -2548,8 +2563,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			break;
>  		case SNK_NEGOTIATE_PPS_CAPABILITIES:
>  			port->pps_data.active = true;
> -			port->req_supply_voltage = port->pps_data.out_volt;
> -			port->req_current_limit = port->pps_data.op_curr;
> +			port->pps_data.min_volt = port->pps_data.req_min_volt;
> +			port->pps_data.max_volt = port->pps_data.req_max_volt;
> +			port->pps_data.max_curr = port->pps_data.req_max_curr;
> +			port->req_supply_voltage = port->pps_data.req_out_volt;
> +			port->req_current_limit = port->pps_data.req_op_curr;
>  			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
>  			break;
>  		case SOFT_RESET_SEND:
> @@ -3108,16 +3126,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  		src = port->source_caps[src_pdo];
>  		snk = port->snk_pdo[snk_pdo];
>  
> -		port->pps_data.min_volt = max(pdo_pps_apdo_min_voltage(src),
> -					      pdo_pps_apdo_min_voltage(snk));
> -		port->pps_data.max_volt = min(pdo_pps_apdo_max_voltage(src),
> -					      pdo_pps_apdo_max_voltage(snk));
> -		port->pps_data.max_curr = min_pps_apdo_current(src, snk);
> -		port->pps_data.out_volt = min(port->pps_data.max_volt,
> -					      max(port->pps_data.min_volt,
> -						  port->pps_data.out_volt));
> -		port->pps_data.op_curr = min(port->pps_data.max_curr,
> -					     port->pps_data.op_curr);
> +		port->pps_data.req_min_volt = max(pdo_pps_apdo_min_voltage(src),
> +						  pdo_pps_apdo_min_voltage(snk));
> +		port->pps_data.req_max_volt = min(pdo_pps_apdo_max_voltage(src),
> +						  pdo_pps_apdo_max_voltage(snk));
> +		port->pps_data.req_max_curr = min_pps_apdo_current(src, snk);
> +		port->pps_data.req_out_volt = min(port->pps_data.max_volt,
> +						  max(port->pps_data.min_volt,
> +						      port->pps_data.req_out_volt));
> +		port->pps_data.req_op_curr = min(port->pps_data.max_curr,
> +						 port->pps_data.req_op_curr);
>  		power_supply_changed(port->psy);
>  	}
>  
> @@ -3245,10 +3263,10 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
>  			tcpm_log(port, "Invalid APDO selected!");
>  			return -EINVAL;
>  		}
> -		max_mv = port->pps_data.max_volt;
> -		max_ma = port->pps_data.max_curr;
> -		out_mv = port->pps_data.out_volt;
> -		op_ma = port->pps_data.op_curr;
> +		max_mv = port->pps_data.req_max_volt;
> +		max_ma = port->pps_data.req_max_curr;
> +		out_mv = port->pps_data.req_out_volt;
> +		op_ma = port->pps_data.req_op_curr;
>  		break;
>  	default:
>  		tcpm_log(port, "Invalid PDO selected!");
> @@ -3295,8 +3313,8 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
>  	tcpm_log(port, "Requesting APDO %d: %u mV, %u mA",
>  		 src_pdo_index, out_mv, op_ma);
>  
> -	port->pps_data.op_curr = op_ma;
> -	port->pps_data.out_volt = out_mv;
> +	port->pps_data.req_op_curr = op_ma;
> +	port->pps_data.req_out_volt = out_mv;
>  
>  	return 0;
>  }
> @@ -5429,7 +5447,7 @@ static int tcpm_try_role(struct typec_port *p, int role)
>  	return ret;
>  }
>  
> -static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
> +static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 req_op_curr)
>  {
>  	unsigned int target_mw;
>  	int ret;
> @@ -5447,12 +5465,12 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
>  		goto port_unlock;
>  	}
>  
> -	if (op_curr > port->pps_data.max_curr) {
> +	if (req_op_curr > port->pps_data.max_curr) {
>  		ret = -EINVAL;
>  		goto port_unlock;
>  	}
>  
> -	target_mw = (op_curr * port->pps_data.out_volt) / 1000;
> +	target_mw = (req_op_curr * port->supply_voltage) / 1000;
>  	if (target_mw < port->operating_snk_mw) {
>  		ret = -EINVAL;
>  		goto port_unlock;
> @@ -5466,10 +5484,10 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
>  	}
>  
>  	/* Round down operating current to align with PPS valid steps */
> -	op_curr = op_curr - (op_curr % RDO_PROG_CURR_MA_STEP);
> +	req_op_curr = req_op_curr - (req_op_curr % RDO_PROG_CURR_MA_STEP);
>  
>  	reinit_completion(&port->pps_complete);
> -	port->pps_data.op_curr = op_curr;
> +	port->pps_data.req_op_curr = req_op_curr;
>  	port->pps_status = 0;
>  	port->pps_pending = true;
>  	mutex_unlock(&port->lock);
> @@ -5490,7 +5508,7 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
>  	return ret;
>  }
>  
> -static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
> +static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 req_out_volt)
>  {
>  	unsigned int target_mw;
>  	int ret;
> @@ -5508,13 +5526,13 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
>  		goto port_unlock;
>  	}
>  
> -	if (out_volt < port->pps_data.min_volt ||
> -	    out_volt > port->pps_data.max_volt) {
> +	if (req_out_volt < port->pps_data.min_volt ||
> +	    req_out_volt > port->pps_data.max_volt) {
>  		ret = -EINVAL;
>  		goto port_unlock;
>  	}
>  
> -	target_mw = (port->pps_data.op_curr * out_volt) / 1000;
> +	target_mw = (port->current_limit * req_out_volt) / 1000;
>  	if (target_mw < port->operating_snk_mw) {
>  		ret = -EINVAL;
>  		goto port_unlock;
> @@ -5528,10 +5546,10 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
>  	}
>  
>  	/* Round down output voltage to align with PPS valid steps */
> -	out_volt = out_volt - (out_volt % RDO_PROG_VOLT_MV_STEP);
> +	req_out_volt = req_out_volt - (req_out_volt % RDO_PROG_VOLT_MV_STEP);
>  
>  	reinit_completion(&port->pps_complete);
> -	port->pps_data.out_volt = out_volt;
> +	port->pps_data.req_out_volt = req_out_volt;
>  	port->pps_status = 0;
>  	port->pps_pending = true;
>  	mutex_unlock(&port->lock);
> @@ -5589,8 +5607,8 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
>  
>  	/* Trigger PPS request or move back to standard PDO contract */
>  	if (activate) {
> -		port->pps_data.out_volt = port->supply_voltage;
> -		port->pps_data.op_curr = port->current_limit;
> +		port->pps_data.req_out_volt = port->supply_voltage;
> +		port->pps_data.req_op_curr = port->current_limit;
>  	}
>  	mutex_unlock(&port->lock);
>  
> -- 
> 2.31.1.295.g9ea45b61b8-goog

-- 
heikki
