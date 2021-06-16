Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8C3A9C50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhFPNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:44:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:61483 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233142AbhFPNom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:44:42 -0400
IronPort-SDR: Uor0M6sC97kxaA23DwiC3nOE0W0ppVgjfbG9ah8D5CooVZGYoPz93ecKvb25z81N1MriZqHYf+
 Tb6p6eeaP6+g==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="193297671"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="193297671"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 06:42:35 -0700
IronPort-SDR: vOT7Y/QOBw6Q2shaeW7IsVwrelqi1cckBIUPtOM58Vxn/+/SKAz2jAZDZ7ChtUKxWqsF2kSVri
 h8i91EWetdwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="554810325"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Jun 2021 06:42:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Jun 2021 16:42:31 +0300
Date:   Wed, 16 Jun 2021 16:42:31 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: tcpm: Relax disconnect threshold during
 power negotiation
Message-ID: <YMn/x631dHngLxFw@kuha.fi.intel.com>
References: <20210616090102.1897674-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616090102.1897674-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 05:01:02PM +0800, Kyle Tso wrote:
> If the voltage is being decreased in power negotiation, the Source will
> set the power supply to operate at the new voltage level before sending
> PS_RDY. Relax the threshold before sending Request Message so that it
> will not race with Source which begins to adjust the voltage right after
> it sends Accept Message (PPS) or tSrcTransition (25~35ms) after it sends
> Accept Message (non-PPS).
> 
> The real threshold will be set after Sink receives PS_RDY Message.
> 
> Fixes: f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
> Cc: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v3:
> - move the timing of setting threshold for Fixed RDO as I did for PPS in
>   v2, i.e. move it to tcpm_pd_send_request.
> - add Cc: tag for Badhri
> - update the commit message for the above changes
> 
> Changes in v2:
> - move the timing of setting threshold up to "before sending Request"
>   for PPS power negotiation so that it won't race with the Source.
> - PPS: if it fails to send the Request, fallback to previous threshold
> - PPS: if the Source doesn't respond Accept, fallback to previous
>   threshold
> - update the commit message for above changes
> 
>  drivers/usb/typec/tcpm/tcpm.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 197556038ba4..b1d310ab84c4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2604,6 +2604,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			} else {
>  				next_state = SNK_WAIT_CAPABILITIES;
>  			}
> +
> +			/* Threshold was relaxed before sending Request. Restore it back. */
> +			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> +							       port->pps_data.active,
> +							       port->supply_voltage);
>  			tcpm_set_state(port, next_state, 0);
>  			break;
>  		case SNK_NEGOTIATE_PPS_CAPABILITIES:
> @@ -2617,6 +2622,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			    port->send_discover)
>  				port->vdm_sm_running = true;
>  
> +			/* Threshold was relaxed before sending Request. Restore it back. */
> +			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> +							       port->pps_data.active,
> +							       port->supply_voltage);
> +
>  			tcpm_set_state(port, SNK_READY, 0);
>  			break;
>  		case DR_SWAP_SEND:
> @@ -3336,6 +3346,12 @@ static int tcpm_pd_send_request(struct tcpm_port *port)
>  	if (ret < 0)
>  		return ret;
>  
> +	/*
> +	 * Relax the threshold as voltage will be adjusted after Accept Message plus tSrcTransition.
> +	 * It is safer to modify the threshold here.
> +	 */
> +	tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
> +
>  	memset(&msg, 0, sizeof(msg));
>  	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
>  				  port->pwr_role,
> @@ -3433,6 +3449,9 @@ static int tcpm_pd_send_pps_request(struct tcpm_port *port)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Relax the threshold as voltage will be adjusted right after Accept Message. */
> +	tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
> +
>  	memset(&msg, 0, sizeof(msg));
>  	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
>  				  port->pwr_role,
> @@ -4196,6 +4215,10 @@ static void run_state_machine(struct tcpm_port *port)
>  		port->hard_reset_count = 0;
>  		ret = tcpm_pd_send_request(port);
>  		if (ret < 0) {
> +			/* Restore back to the original state */
> +			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> +							       port->pps_data.active,
> +							       port->supply_voltage);
>  			/* Let the Source send capabilities again. */
>  			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
>  		} else {
> @@ -4206,6 +4229,10 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SNK_NEGOTIATE_PPS_CAPABILITIES:
>  		ret = tcpm_pd_send_pps_request(port);
>  		if (ret < 0) {
> +			/* Restore back to the original state */
> +			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> +							       port->pps_data.active,
> +							       port->supply_voltage);
>  			port->pps_status = ret;
>  			/*
>  			 * If this was called due to updates to sink
> -- 
> 2.32.0.272.g935e593368-goog

-- 
heikki
