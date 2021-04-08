Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32DB357CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhDHGvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:51:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:4329 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhDHGvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:51:41 -0400
IronPort-SDR: KoJLlFAqIeCqG6ghoBvA10NO5I2AnHj1RbRVgt/lfLX8i3s7G+uNPdqTI7O6IIkgadCru5SZ58
 kMTFYOKXBFog==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="180605786"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="180605786"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 23:51:29 -0700
IronPort-SDR: MPX+KG9ocuizqBb9kk6LoMkdVNUmagVkqZcgVhaDx030blGTtOTzddVSPfS+ITaenqDe4jErXE
 f8nqV9iovL9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="519733880"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Apr 2021 23:51:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Apr 2021 09:51:25 +0300
Date:   Thu, 8 Apr 2021 09:51:25 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2 1/6] usb: typec: tcpm: Address incorrect values of
 tcpm psy for fixed supply
Message-ID: <YG6n7c2XpypLseWw@kuha.fi.intel.com>
References: <20210407200723.1914388-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407200723.1914388-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:07:18PM -0700, Badhri Jagan Sridharan wrote:
> tcpm_pd_build_request overwrites current_limit and supply_voltage
> even before port partner accepts the requests. This leaves stale
> values in current_limit and supply_voltage that get exported by
> "tcpm-source-psy-". Solving this problem by caching the request
> values of current limit/supply voltage in req_current_limit
> and req_supply_voltage. current_limit/supply_voltage gets updated
> once the port partner accepts the request.
> 
> Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through power_supply")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since V1:
> * Fixed typo as suggested by Guenter Roeck.
> * Added Reviewed-by tags.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ca1fc77697fc..4ea4b30ae885 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -389,7 +389,10 @@ struct tcpm_port {
>  	unsigned int operating_snk_mw;
>  	bool update_sink_caps;
>  
> -	/* Requested current / voltage */
> +	/* Requested current / voltage to the port partner */
> +	u32 req_current_limit;
> +	u32 req_supply_voltage;
> +	/* Actual current / voltage limit of the local port */
>  	u32 current_limit;
>  	u32 supply_voltage;
>  
> @@ -2435,8 +2438,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  		case SNK_TRANSITION_SINK:
>  			if (port->vbus_present) {
>  				tcpm_set_current_limit(port,
> -						       port->current_limit,
> -						       port->supply_voltage);
> +						       port->req_current_limit,
> +						       port->req_supply_voltage);
>  				port->explicit_contract = true;
>  				tcpm_set_auto_vbus_discharge_threshold(port,
>  								       TYPEC_PWR_MODE_PD,
> @@ -2545,8 +2548,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			break;
>  		case SNK_NEGOTIATE_PPS_CAPABILITIES:
>  			port->pps_data.active = true;
> -			port->supply_voltage = port->pps_data.out_volt;
> -			port->current_limit = port->pps_data.op_curr;
> +			port->req_supply_voltage = port->pps_data.out_volt;
> +			port->req_current_limit = port->pps_data.op_curr;
>  			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
>  			break;
>  		case SOFT_RESET_SEND:
> @@ -3195,8 +3198,8 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
>  			 flags & RDO_CAP_MISMATCH ? " [mismatch]" : "");
>  	}
>  
> -	port->current_limit = ma;
> -	port->supply_voltage = mv;
> +	port->req_current_limit = ma;
> +	port->req_supply_voltage = mv;
>  
>  	return 0;
>  }
> -- 
> 2.31.1.295.g9ea45b61b8-goog

-- 
heikki
