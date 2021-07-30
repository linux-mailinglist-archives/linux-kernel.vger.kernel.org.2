Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289753DBCAC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhG3P4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:56:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:43992 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231535AbhG3P4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:56:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="192718228"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="192718228"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 08:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="582142918"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Jul 2021 08:55:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Jul 2021 18:55:30 +0300
Date:   Fri, 30 Jul 2021 18:55:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: typec: tcpm: Support non-PD mode
Message-ID: <YQQg8lQrVNAeJ1zX@kuha.fi.intel.com>
References: <20210730124348.1986638-1-kyletso@google.com>
 <20210730124348.1986638-3-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730124348.1986638-3-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jul 30, 2021 at 08:43:48PM +0800, Kyle Tso kirjoitti:
> Even if the Type-C controller supports PD, it is doable to disable PD
> capabilities with the current state machine in TCPM. Without enabling RX
> in low-level drivers and with skipping the power negotiation, the port
> is eligible to be a non-PD Type-C port. Use new flags whose values are
> populated from the device tree to decide the port PD capability. Adding
> "pd-unsupported" property in device tree indicates that the port does
> not support PD. If PD is not supported, the device tree property
> "typec-power-opmode" shall be added to specify the advertised Rp value
> if the port supports SRC role.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v4:
> - Added Reviewed-by
> 
>  drivers/usb/typec/tcpm/tcpm.c | 87 +++++++++++++++++++++++++++--------
>  1 file changed, 68 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5b22a1c931a9..faea1bf9dce0 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -316,6 +316,7 @@ struct tcpm_port {
>  	struct typec_partner *partner;
>  
>  	enum typec_cc_status cc_req;
> +	enum typec_cc_status src_rp;	/* work only if pd_supported == false */
>  
>  	enum typec_cc_status cc1;
>  	enum typec_cc_status cc2;
> @@ -323,6 +324,7 @@ struct tcpm_port {
>  
>  	bool attached;
>  	bool connected;
> +	bool pd_supported;
>  	enum typec_port_type port_type;
>  
>  	/*
> @@ -815,6 +817,9 @@ static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port)
>  	int nr_pdo = port->nr_src_pdo;
>  	int i;
>  
> +	if (!port->pd_supported)
> +		return port->src_rp;
> +
>  	/*
>  	 * Search for first entry with matching voltage.
>  	 * It should report the maximum supported current.
> @@ -3568,9 +3573,11 @@ static int tcpm_src_attach(struct tcpm_port *port)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = port->tcpc->set_pd_rx(port->tcpc, true);
> -	if (ret < 0)
> -		goto out_disable_mux;
> +	if (port->pd_supported) {
> +		ret = port->tcpc->set_pd_rx(port->tcpc, true);
> +		if (ret < 0)
> +			goto out_disable_mux;
> +	}
>  
>  	/*
>  	 * USB Type-C specification, version 1.2,
> @@ -3600,7 +3607,8 @@ static int tcpm_src_attach(struct tcpm_port *port)
>  out_disable_vconn:
>  	tcpm_set_vconn(port, false);
>  out_disable_pd:
> -	port->tcpc->set_pd_rx(port->tcpc, false);
> +	if (port->pd_supported)
> +		port->tcpc->set_pd_rx(port->tcpc, false);
>  out_disable_mux:
>  	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
>  		     TYPEC_ORIENTATION_NONE);
> @@ -3804,6 +3812,20 @@ static enum typec_pwr_opmode tcpm_get_pwr_opmode(enum typec_cc_status cc)
>  	}
>  }
>  
> +static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
> +{
> +	switch (opmode) {
> +	case TYPEC_PWR_MODE_USB:
> +		return TYPEC_CC_RP_DEF;
> +	case TYPEC_PWR_MODE_1_5A:
> +		return TYPEC_CC_RP_1_5;
> +	case TYPEC_PWR_MODE_3_0A:
> +	case TYPEC_PWR_MODE_PD:
> +	default:
> +		return TYPEC_CC_RP_3_0;
> +	}
> +}
> +
>  static void run_state_machine(struct tcpm_port *port)
>  {
>  	int ret;
> @@ -3914,6 +3936,10 @@ static void run_state_machine(struct tcpm_port *port)
>  		if (port->ams == POWER_ROLE_SWAP ||
>  		    port->ams == FAST_ROLE_SWAP)
>  			tcpm_ams_finish(port);
> +		if (!port->pd_supported) {
> +			tcpm_set_state(port, SRC_READY, 0);
> +			break;
> +		}
>  		port->upcoming_state = SRC_SEND_CAPABILITIES;
>  		tcpm_ams_start(port, POWER_NEGOTIATION);
>  		break;
> @@ -4161,7 +4187,10 @@ static void run_state_machine(struct tcpm_port *port)
>  				current_lim = PD_P_SNK_STDBY_MW / 5;
>  			tcpm_set_current_limit(port, current_lim, 5000);
>  			tcpm_set_charge(port, true);
> -			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
> +			if (!port->pd_supported)
> +				tcpm_set_state(port, SNK_READY, 0);
> +			else
> +				tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
>  			break;
>  		}
>  		/*
> @@ -4389,7 +4418,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_set_vbus(port, true);
>  		if (port->ams == HARD_RESET)
>  			tcpm_ams_finish(port);
> -		port->tcpc->set_pd_rx(port->tcpc, true);
> +		if (port->pd_supported)
> +			port->tcpc->set_pd_rx(port->tcpc, true);
>  		tcpm_set_attached_state(port, true);
>  		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
>  		break;
> @@ -5898,6 +5928,7 @@ EXPORT_SYMBOL_GPL(tcpm_tcpc_reset);
>  static int tcpm_fw_get_caps(struct tcpm_port *port,
>  			    struct fwnode_handle *fwnode)
>  {
> +	const char *opmode_str;
>  	const char *cap_str;
>  	int ret;
>  	u32 mw, frs_current;
> @@ -5932,22 +5963,37 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  		return ret;
>  	port->typec_caps.type = ret;
>  	port->port_type = port->typec_caps.type;
> +	port->pd_supported = !fwnode_property_read_bool(fwnode, "pd-unsupported");
>  
>  	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
>  	if (port->port_type == TYPEC_PORT_SNK)
>  		goto sink;
>  
> -	/* Get source pdos */
> -	ret = fwnode_property_count_u32(fwnode, "source-pdos");
> -	if (ret <= 0)
> -		return -EINVAL;
> +	/* Get Source PDOs for the PD port or Source Rp value for the non-PD port */
> +	if (port->pd_supported) {
> +		ret = fwnode_property_count_u32(fwnode, "source-pdos");
> +		if (ret == 0)
> +			return -EINVAL;
> +		else if (ret < 0)
> +			return ret;
>  
> -	port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
> -	ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
> -					     port->src_pdo, port->nr_src_pdo);
> -	if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
> -					    port->nr_src_pdo))
> -		return -EINVAL;
> +		port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
> +		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
> +						     port->src_pdo, port->nr_src_pdo);
> +		if (ret)
> +			return ret;
> +		ret = tcpm_validate_caps(port, port->src_pdo, port->nr_src_pdo);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &opmode_str);
> +		if (ret)
> +			return ret;
> +		ret = typec_find_pwr_opmode(opmode_str);
> +		if (ret < 0)
> +			return ret;
> +		port->src_rp = tcpm_pwr_opmode_to_rp(ret);
> +	}
>  
>  	if (port->port_type == TYPEC_PORT_SRC)
>  		return 0;
> @@ -5961,6 +6007,11 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  	if (port->typec_caps.prefer_role < 0)
>  		return -EINVAL;
>  sink:
> +	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
> +
> +	if (!port->pd_supported)
> +		return 0;
> +
>  	/* Get sink pdos */
>  	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
>  	if (ret <= 0)
> @@ -5977,9 +6028,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  		return -EINVAL;
>  	port->operating_snk_mw = mw / 1000;
>  
> -	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
> -
> -	/* FRS can only be supported byb DRP ports */
> +	/* FRS can only be supported by DRP ports */
>  	if (port->port_type == TYPEC_PORT_DRP) {
>  		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
>  					       &frs_current);
> -- 
> 2.32.0.554.ge1b32706d8-goog

-- 
heikki
