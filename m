Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB7357D06
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhDHHKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:10:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:53177 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhDHHKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:10:10 -0400
IronPort-SDR: /TuYMs7M8N6vpQOPqY4fuFWWEDLLexc19rC1JaD5paiYA69P6/TRe2Nr1U8McPvGmZqHWTQBp7
 D1ECadlVS6EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="190271869"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="190271869"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 00:10:00 -0700
IronPort-SDR: tOzBnoNL/0LBoJOg9L8l6xsFJKJqpnYabAsM///bAwpBQJ1gsLBVeT6wVPNgstK84sSswIJaIr
 WxJFFSnEVT5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="519741633"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2021 00:09:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Apr 2021 10:09:56 +0300
Date:   Thu, 8 Apr 2021 10:09:56 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2 3/6] usb: typec: tcpm: update power supply once
 partner accepts
Message-ID: <YG6sRLrseX7r930k@kuha.fi.intel.com>
References: <20210407200723.1914388-1-badhri@google.com>
 <20210407200723.1914388-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407200723.1914388-3-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:07:20PM -0700, Badhri Jagan Sridharan wrote:
> power_supply_changed needs to be called to notify clients
> after the partner accepts the requested values for the pps
> case.
> 
> Also, remove the redundant power_supply_changed at the end
> of the tcpm_reset_port as power_supply_changed is already
> called right after usb_type is changed.
> 
> Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through power_supply")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since V1:
> * Updated commit description to clarify Guenter Roeck's concern.
> * Added Reviewed-by tags
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index b4a40099d7e9..d1d03ee90d8f 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2568,6 +2568,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			port->pps_data.max_curr = port->pps_data.req_max_curr;
>  			port->req_supply_voltage = port->pps_data.req_out_volt;
>  			port->req_current_limit = port->pps_data.req_op_curr;
> +			power_supply_changed(port->psy);
>  			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
>  			break;
>  		case SOFT_RESET_SEND:
> @@ -3136,7 +3137,6 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  						      port->pps_data.req_out_volt));
>  		port->pps_data.req_op_curr = min(port->pps_data.max_curr,
>  						 port->pps_data.req_op_curr);
> -		power_supply_changed(port->psy);
>  	}
>  
>  	return src_pdo;
> @@ -3561,8 +3561,6 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	port->sink_cap_done = false;
>  	if (port->tcpc->enable_frs)
>  		port->tcpc->enable_frs(port->tcpc, false);
> -
> -	power_supply_changed(port->psy);
>  }
>  
>  static void tcpm_detach(struct tcpm_port *port)
> -- 
> 2.31.1.295.g9ea45b61b8-goog

-- 
heikki
