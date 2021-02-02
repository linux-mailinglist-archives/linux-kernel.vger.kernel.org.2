Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252C730BA20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhBBIkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:40:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:16630 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232615AbhBBIjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:39:48 -0500
IronPort-SDR: Be285akiY7xZm8LIAWTkmeQtV/9DlAu2ulzCCjE656sGI7dhr0DfsBlDCApiYIPW+hMFPAAM0Y
 I7E/kS906oWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180895945"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="180895945"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 00:38:01 -0800
IronPort-SDR: TnXPoelUMJxQZXtpPVzvl2zGMEQqJ3O2NXLRrsvG9ENL51cfo2rsv5X23Ku/WJhIHDotq+hmYN
 /xrcbEItkCMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="479486332"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 02 Feb 2021 00:37:58 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Feb 2021 10:37:57 +0200
Date:   Tue, 2 Feb 2021 10:37:57 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: typec: tcpm: Add Callback to Usb
 Communication capable partner
Message-ID: <20210202083757.GE1433721@kuha.fi.intel.com>
References: <20210202003101.221145-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202003101.221145-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:30:59PM -0800, Badhri Jagan Sridharan wrote:
> The USB Communications Capable bit indicates if port
> partner is capable of communication over the USB data lines
> (e.g. D+/- or SS Tx/Rx). Notify the status of the bit to low
> level drivers to perform chip specific operation.
> For instance, low level driver enables USB switches on D+/D-
> lines to set up data path when the bit is set.
> 
> Refactored from patch initially authored by
> Kyle Tso <kyletso@google.com>
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since V1:
> - Removed partner_usb_comm_capable flag.
> - Fixed capable flag for SNK_NEGOTIATE_CAPABILITIES.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 13 +++++++++++++
>  include/linux/usb/tcpm.h      |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0afd8ef692e8..997a1a56c161 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3429,6 +3429,14 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
>  	memset(modep, 0, sizeof(*modep));
>  }
>  
> +static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, bool capable)
> +{
> +	tcpm_log(port, "Setting usb_comm capable %s", capable ? "true" : "false");
> +
> +	if (port->tcpc->set_partner_usb_comm_capable)
> +		port->tcpc->set_partner_usb_comm_capable(port->tcpc, capable);
> +}
> +
>  static void tcpm_reset_port(struct tcpm_port *port)
>  {
>  	int ret;
> @@ -3445,6 +3453,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	port->attached = false;
>  	port->pd_capable = false;
>  	port->pps_data.supported = false;
> +	tcpm_set_partner_usb_comm_capable(port, false);
>  
>  	/*
>  	 * First Rx ID should be 0; set this to a sentinel of -1 so that
> @@ -3785,6 +3794,8 @@ static void run_state_machine(struct tcpm_port *port)
>  			}
>  		} else {
>  			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> +			tcpm_set_partner_usb_comm_capable(port,
> +							  !!(port->sink_request & RDO_USB_COMM));
>  			tcpm_set_state(port, SRC_TRANSITION_SUPPLY,
>  				       PD_T_SRC_TRANSITION);
>  		}
> @@ -4004,6 +4015,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_NEGOTIATE_CAPABILITIES:
>  		port->pd_capable = true;
> +		tcpm_set_partner_usb_comm_capable(port,
> +						  !!(port->source_caps[0] & PDO_FIXED_USB_COMM));
>  		port->hard_reset_count = 0;
>  		ret = tcpm_pd_send_request(port);
>  		if (ret < 0) {
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 3af99f85e8b9..42fcfbe10590 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -108,6 +108,10 @@ enum tcpm_transmit_type {
>   *		is supported by TCPC, set this callback for TCPM to query
>   *		whether vbus is at VSAFE0V when needed.
>   *		Returns true when vbus is at VSAFE0V, false otherwise.
> + * @set_partner_usb_comm_capable:
> + *              Optional; The USB Communications Capable bit indicates if port
> + *              partner is capable of communication over the USB data lines
> + *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
>   */
>  struct tcpc_dev {
>  	struct fwnode_handle *fwnode;
> @@ -139,6 +143,7 @@ struct tcpc_dev {
>  	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
>  						 bool pps_active, u32 requested_vbus_voltage);
>  	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
> +	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
>  };
>  
>  struct tcpm_port;
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
