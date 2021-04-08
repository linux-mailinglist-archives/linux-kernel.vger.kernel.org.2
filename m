Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B906E357DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhDHIPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:15:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:58267 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhDHIPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:15:03 -0400
IronPort-SDR: F2Aw8UckAUdvEIjlLV9a9ptijGXVFmrrIl9QaYO1S8mRdLu+jsk6voffgUJmANZd8qj+U4SXzR
 WTarAffj8R0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="190282272"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="190282272"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 01:14:51 -0700
IronPort-SDR: u17QK3dbYDdv3YD21AwbvsHt3moRZAX13IaPNQsH177xWjg8kKQ/3GzoduKaGyAfWBNKdS12K0
 HN7gy1CSOiBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="519762410"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2021 01:14:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Apr 2021 11:14:47 +0300
Date:   Thu, 8 Apr 2021 11:14:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2 5/6] usb: typec: tcpm: Allow slow charging loops to
 comply to pSnkStby
Message-ID: <YG67d/YOuoBwK+bF@kuha.fi.intel.com>
References: <20210407200723.1914388-1-badhri@google.com>
 <20210407200723.1914388-5-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407200723.1914388-5-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:07:22PM -0700, Badhri Jagan Sridharan wrote:
> When a PD charger advertising Rp-3.0 is connected to a sink port, the
> sink port current limit would 3A, during SNK_DISCOVERY, till power
> negotiation starts. Once the negotiation starts the power limit needs
> to drop down to pSnkStby(500mA @ 5V) and to negotiated current limit
> once the explicit contract is in place. Not all charging loops can ramp
> up to 3A and drop down to 500mA within tSnkStdby which is 15ms. The port
> partner might hard reset if tSnkStdby is not met.
> 
> To solve this problem, this patch introduces slow-charger-loop which
> when set makes the port request PD_P_SNK_STDBY_MW upon entering
> SNK_DISCOVERY(instead of 3A or the 1.5A during SNK_DISCOVERY) and the
> actual currrent limit after RX of PD_CTRL_PSRDY for PD link or during
> SNK_READY for non-pd link.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 770b2edd9a04..b5bed6866a2b 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -459,6 +459,12 @@ struct tcpm_port {
>  	/* Auto vbus discharge status */
>  	bool auto_vbus_discharge_enabled;
>  
> +	/*
> +	 * When set, port requests PD_P_SNK_STDBY_MW upon entering SNK_DISCOVERY and
> +	 * the actual currrent limit after RX of PD_CTRL_PSRDY for PD link,
> +	 * SNK_READY for non-pd link.
> +	 */
> +	bool slow_charger_loop;
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *dentry;
>  	struct mutex logbuffer_lock;	/* log buffer access lock */
> @@ -4047,9 +4053,12 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_DISCOVERY:
>  		if (port->vbus_present) {
> -			tcpm_set_current_limit(port,
> -					       tcpm_get_current_limit(port),
> -					       5000);
> +			u32 current_lim = (!port->slow_charger_loop ||
> +					   (tcpm_get_current_limit(port) <=
> +					    PD_P_SNK_STDBY_MW / 5)) ?
> +				tcpm_get_current_limit(port) :
> +				PD_P_SNK_STDBY_MW / 5;

Here the use of the ternary operator is not appropriate. Please try to
clean that up somehow. Maybe something like this would be better?

                        u32 current_lim = tcpm_get_current_limit(port);

			if (port->slow_charger_loop || (current_lim < PD_P_SNK_STDBY_MW / 5))
				current_lim = PD_P_SNK_STDBY_MW / 5;

> +			tcpm_set_current_limit(port, current_lim, 5000);
>  			tcpm_set_charge(port, true);
>  			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
>  			break;
> @@ -4161,6 +4170,8 @@ static void run_state_machine(struct tcpm_port *port)
>  			port->pwr_opmode = TYPEC_PWR_MODE_PD;
>  		}
>  
> +		if (!port->pd_capable && port->slow_charger_loop)
> +			tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
>  		tcpm_swap_complete(port, 0);
>  		tcpm_typec_connect(port);
>  		mod_enable_frs_delayed_work(port, 0);
> @@ -5763,6 +5774,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  	port->typec_caps.type = ret;
>  	port->port_type = port->typec_caps.type;
>  
> +	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
>  	if (port->port_type == TYPEC_PORT_SNK)
>  		goto sink;
>  
> -- 
> 2.31.1.295.g9ea45b61b8-goog

thanks,

-- 
heikki
