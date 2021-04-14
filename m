Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9CB35EEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349355AbhDNH4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:56:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:62599 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349369AbhDNH4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:56:21 -0400
IronPort-SDR: +deHAtUaJaK1MO3osg5Z8Dou3xVIBFXNSaElSU0S5kflyCkF54k4Udr3i6m4J3ErMgLPLCPAKg
 rvCXBmVRY1KA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="191404720"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="191404720"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 00:56:00 -0700
IronPort-SDR: hzpA/fJKL8ZI2fhKtZY3qmxoHNMgSckk4Xemp1v3QaKIUm/6+frEA7YcVu7/fvYGotqF00XN7H
 MWacDG6Ihnzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="521905592"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2021 00:55:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 14 Apr 2021 10:55:56 +0300
Date:   Wed, 14 Apr 2021 10:55:56 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v3 2/3] usb: typec: tcpm: Allow slow charging loops to
 comply to pSnkStby
Message-ID: <YHagDMwb2Z/hKZ11@kuha.fi.intel.com>
References: <20210414024000.4175263-1-badhri@google.com>
 <20210414024000.4175263-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414024000.4175263-2-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 07:39:59PM -0700, Badhri Jagan Sridharan wrote:
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since V2:
> * Refactored code based on Heikki's suggestion
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index aedc8bb9532a..2ad5e14a6867 100644
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
> @@ -4047,9 +4053,11 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_DISCOVERY:
>  		if (port->vbus_present) {
> -			tcpm_set_current_limit(port,
> -					       tcpm_get_current_limit(port),
> -					       5000);
> +			u32 current_lim = tcpm_get_current_limit(port);
> +
> +			if (port->slow_charger_loop || (current_lim > PD_P_SNK_STDBY_MW / 5))
> +				current_lim = PD_P_SNK_STDBY_MW / 5;
> +			tcpm_set_current_limit(port, current_lim, 5000);
>  			tcpm_set_charge(port, true);
>  			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
>  			break;
> @@ -4161,6 +4169,8 @@ static void run_state_machine(struct tcpm_port *port)
>  			port->pwr_opmode = TYPEC_PWR_MODE_PD;
>  		}
>  
> +		if (!port->pd_capable && port->slow_charger_loop)
> +			tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
>  		tcpm_swap_complete(port, 0);
>  		tcpm_typec_connect(port);
>  		mod_enable_frs_delayed_work(port, 0);
> @@ -5763,6 +5773,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
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
