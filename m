Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231D933EAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhCQH4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:56:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:4772 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhCQH4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:56:08 -0400
IronPort-SDR: hT06F8oU2iWsNNCMv+RXMkpMxu8TidJ7pPloKVOOKBhxYL5y0f1vwdBF1RhM81A6fjdj1vqfgB
 vFvcfHGgMTFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209374137"
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; 
   d="scan'208";a="209374137"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 00:56:07 -0700
IronPort-SDR: mSgWDomlrrV6GH7Preaa18CmJgLxGH3sB+bdT41bhEXQhjAChRZWSnjyU3WV8wXBZbkbVvwfKv
 WoxYFtwPbg1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; 
   d="scan'208";a="511644820"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Mar 2021 00:56:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 17 Mar 2021 09:56:03 +0200
Date:   Wed, 17 Mar 2021 09:56:03 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] usb: typec: tcpm: Invoke power_supply_changed for
 tcpm-source-psy-
Message-ID: <YFG2E43hAW0q6CG1@kuha.fi.intel.com>
References: <20210316215657.387357-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316215657.387357-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:56:57PM -0700, Badhri Jagan Sridharan wrote:
> tcpm-source-psy- does not invoke power_supply_changed API when
> one of the published power supply property is changed.
> power_supply_changed needs to be called to notify
> userspace clients(uevents) and kernel clients.
> 
> Fixes: f2a8aa053c176("typec: tcpm: Represent source supply through
> power_supply")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 11d0c40bc47d..e8936ea17f80 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -945,6 +945,7 @@ static int tcpm_set_current_limit(struct tcpm_port *port, u32 max_ma, u32 mv)
>  
>  	port->supply_voltage = mv;
>  	port->current_limit = max_ma;
> +	power_supply_changed(port->psy);
>  
>  	if (port->tcpc->set_current_limit)
>  		ret = port->tcpc->set_current_limit(port->tcpc, max_ma, mv);
> @@ -2931,6 +2932,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>  
>  	port->pps_data.supported = false;
>  	port->usb_type = POWER_SUPPLY_USB_TYPE_PD;
> +	power_supply_changed(port->psy);
>  
>  	/*
>  	 * Select the source PDO providing the most power which has a
> @@ -2955,6 +2957,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>  				port->pps_data.supported = true;
>  				port->usb_type =
>  					POWER_SUPPLY_USB_TYPE_PD_PPS;
> +				power_supply_changed(port->psy);
>  			}
>  			continue;
>  		default:
> @@ -3112,6 +3115,7 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  						  port->pps_data.out_volt));
>  		port->pps_data.op_curr = min(port->pps_data.max_curr,
>  					     port->pps_data.op_curr);
> +		power_supply_changed(port->psy);
>  	}
>  
>  	return src_pdo;
> @@ -3347,6 +3351,7 @@ static int tcpm_set_charge(struct tcpm_port *port, bool charge)
>  			return ret;
>  	}
>  	port->vbus_charge = charge;
> +	power_supply_changed(port->psy);
>  	return 0;
>  }
>  
> @@ -3530,6 +3535,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	port->try_src_count = 0;
>  	port->try_snk_count = 0;
>  	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
> +	power_supply_changed(port->psy);
>  	port->nr_sink_caps = 0;
>  	port->sink_cap_done = false;
>  	if (port->tcpc->enable_frs)
> @@ -5957,7 +5963,7 @@ static int tcpm_psy_set_prop(struct power_supply *psy,
>  		ret = -EINVAL;
>  		break;
>  	}
> -
> +	power_supply_changed(port->psy);
>  	return ret;
>  }
>  
> @@ -6110,6 +6116,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	err = devm_tcpm_psy_register(port);
>  	if (err)
>  		goto out_role_sw_put;
> +	power_supply_changed(port->psy);
>  
>  	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
>  	if (IS_ERR(port->typec_port)) {
> -- 
> 2.31.0.rc2.261.g7f71774620-goog

-- 
heikki
